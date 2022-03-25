#!/usr/local/bin/python3
# encoding: utf-8

import copy
from itertools import product

from src.config import *
from src.utils import *
from src.agent import Agent
from src.utils import parse_files
from src.interrogation import AgentInterrogation
from src.lattice.model_pddl import Model
from src.model_drift.pa_tuple import PATuple

class AgentInterrogationInterface(object):

    def __init__(self, domain_file_path, problem_file_path):
        self.domain_file_path = domain_file_path
        self.problem_file_path = problem_file_path
        
        self.abstract_model = None
        self.abstract_predicates = None 
        self.data = None

    def get_inferred_pals(self, init_model, PAtuple_to_ModeTuple_set_dict):
        """
            pal_tuples_fixed has PALs with one valid mode
            pal_tuples_set_modes has restricted set of modes for each PAL
        """
        abstract_predicates_inferred, abstract_model_actions_inferred = dict(), dict()
        PALtuples_inferred, PALtuples_mode_inferred = list(), list()
        PATuple_to_valid_ModeTuple_set_dict = dict()

        for PATuple, modepair_set in PAtuple_to_ModeTuple_set_dict.items():
            action_name, predicate = PATuple.action, PATuple.predicate
            
            pre, eff = set(), set()
            for modepair in modepair_set:
                pre.add(modepair[0])
                eff.add(modepair[1])

            PATuple_to_valid_ModeTuple_set_dict[tuple([action_name, predicate])] = modepair_set

            if len(pre)==1 or len(eff)==1:           
                abstract_predicates_inferred[predicate] = 0
                abstract_model_actions_inferred[action_name] = dict()

                if len(pre)==1 and len(eff)==1:
                    abstract_model_actions_inferred[action_name][predicate] = list(modepair)
                    PALtuples_inferred.append(tuple([action_name, predicate, Location.PRECOND]))
                    PALtuples_inferred.append(tuple([action_name, predicate, Location.EFFECTS]))
                    PALtuples_mode_inferred.append(tuple([action_name, predicate, Location.PRECOND, modepair[0]]))
                    PALtuples_mode_inferred.append(tuple([action_name, predicate, Location.EFFECTS, modepair[1]]))
                elif len(pre)==1:
                    init_modepair = init_model.actions[action_name][predicate]
                    abstract_model_actions_inferred[action_name][predicate] = [modepair[0], init_modepair[1]]
                    PALtuples_inferred.append(tuple([action_name, predicate, Location.PRECOND]))
                    PALtuples_mode_inferred.append(tuple([action_name, predicate, Location.PRECOND, modepair[0]]))
                else:
                    init_modepair = init_model.actions[action_name][predicate]
                    abstract_model_actions_inferred[action_name][predicate] = [init_modepair[0], modepair[1]]
                    PALtuples_inferred.append(tuple([action_name, predicate, Location.EFFECTS]))
                    PALtuples_mode_inferred.append(tuple([action_name, predicate, Location.EFFECTS, modepair[1]]))
        
        return abstract_predicates_inferred, abstract_model_actions_inferred, PALtuples_inferred, PALtuples_mode_inferred, PATuple_to_valid_ModeTuple_set_dict 

    def get_certainly_changed_pals(self, init_model, PAtuple_to_ModeTuple_set_dict):
        """
            PALs in init model that inconsistent with new observations
        """
        PALtuples_changed = list()
        for action, predicate_modepair_dict in init_model.actions.items():
            for predicate, init_modepair in predicate_modepair_dict.items():
                init_modepair = tuple(list(init_modepair))
                init_PATuple = PATuple(predicate, action)

                if init_PATuple in PAtuple_to_ModeTuple_set_dict.keys():
                    drifted_modepairs = PAtuple_to_ModeTuple_set_dict[init_PATuple]

                    if init_modepair not in drifted_modepairs:
                        # PALs that have certainly changed
                        # atleast one of pre and eff changed, dropping/marking just pre PATuple
                        PALtuples_changed.append(tuple([action, predicate, Location.PRECOND]))
                        # PALtuples_changed.append(tuple([action, predicate, Location.EFFECTS]))
        return PALtuples_changed

    def get_model_with_dropped_and_fixed_palms(self, init_model, abstract_model_actions_fixed, PALtuples_dropped, PALtuples_dropped_no_obs):
        abstract_predicates = dict()
        abstract_model_actions = dict()

        # first, copy mode tuples for each PA in initial estimate of model
        for action, predicate_modepair_dict in init_model.actions.items():
            abstract_model_actions[action] = dict()
            for predicate, init_modepair in predicate_modepair_dict.items():
                abstract_predicates[predicate] = 0
                abstract_model_actions[action][predicate] = init_modepair

        # second, set mode tuple for certainly changed PA whose actions are observed
        for PAL in PALtuples_dropped:
            action, predicate = PAL[0], PAL[1]
            init_mode_eff = init_model.actions[action][predicate][1]
            abstract_model_actions[action][predicate] = [Literal.ABS, init_mode_eff]

        # third, set mode tuple for certainly changed PA whose actions are observed
        for PAL in PALtuples_dropped_no_obs:
            action, predicate = PAL[0], PAL[1]
            init_mode_eff = init_model.actions[action][predicate][1]
            abstract_model_actions[action][predicate] = [Literal.ABS, Literal.ABS]

        # finally, set mode tuple for certainly inferred PA
        for action, predicate_modepair_dict in abstract_model_actions_fixed.items():
            for predicate, modepair in predicate_modepair_dict.items():
                abstract_predicates[predicate] = 0
                abstract_model_actions[action][predicate] = modepair

        abstract_model = Model(abstract_predicates, abstract_model_actions)
        return abstract_model, abstract_predicates

    def get_pals_for_action(self, pals, action):
        pal_set = set()
        for pal in pals:
            if pal[0]==action:
                pal_set.add(pal)
        return pal_set

    def compute_abstract_model(self, init_model, PAtuple_to_ModeTuple_set_dict, init_PAtuple_to_ModeTuple_dict, data):        
        all_pals = set()
        for PAtuple in init_PAtuple_to_ModeTuple_dict.keys():
            all_pals.add(tuple([PAtuple.action, PAtuple.predicate, Location.PRECOND]))
            all_pals.add(tuple([PAtuple.action, PAtuple.predicate, Location.EFFECTS]))

        # from negative examples i.e. PALs corresponding to marked actions found by comparing optimal obs of init and drifte models
        marked_pals_no_obs = set()
        marked_pals_obs = set()
        for action in data["marked_changed_actions"]:
            if action in data["actions_with_no_obs"]:
                marked_pals_no_obs = marked_pals_no_obs.union(self.get_pals_for_action(all_pals, action))
            else:
                marked_pals_obs = marked_pals_obs.union(self.get_pals_for_action(all_pals, action))

        # from positive examples i.e. available observations
        abstract_predicates_inferred, abstract_model_actions_inferred, PALtuples_inferred, PALtuples_mode_inferred, PATuple_to_valid_ModeTuple_set_dict = self.get_inferred_pals(init_model, PAtuple_to_ModeTuple_set_dict)     
        PALtuples_changed = self.get_certainly_changed_pals(init_model, PAtuple_to_ModeTuple_set_dict)

        PALtuples_dropped = set(PALtuples_changed).union(marked_pals_obs) - set(PALtuples_inferred)
        PALtuples_dropped_no_obs = marked_pals_no_obs - set(PALtuples_dropped) - set(PALtuples_inferred)
        PALtuples_fixed = all_pals.union(set(PALtuples_inferred)) - set(PALtuples_dropped) - set(PALtuples_dropped_no_obs)
        self.abstract_model, self.abstract_predicates = self.get_model_with_dropped_and_fixed_palms(init_model, abstract_model_actions_inferred, PALtuples_dropped, PALtuples_dropped_no_obs)
 
        self.data = data
        self.data["PALtuples_fixed"] = PALtuples_fixed  
        self.data["PALtuples_dropped"] = PALtuples_dropped
        self.data["PALtuples_dropped_no_obs"] = PALtuples_dropped_no_obs
        self.data["PATuple_to_valid_ModeTuple_set_dict"] = PATuple_to_valid_ModeTuple_set_dict

        print("\n PALs dropped:")
        for PALtuple in PALtuples_dropped:
            print(PALtuple)
        return self.data

    def learn_model_from_scratch(self):
        # Run AIA baseline/Learn model from scratch  
        print("============================= Learning model from scratch (",self.domain_file_path,") ==============================")
        action_parameters, pred_type_mapping, agent_model_actions, abstract_model_actions, \
                objects, types, init_state, domain_name = parse_files.generate_ds(self.domain_file_path, self.problem_file_path)
        agent = Agent(domain_name, pred_type_mapping, agent_model_actions)
        abstract_predicates = dict()
        abstract_model = Model(abstract_predicates, abstract_model_actions)
        iaa_main = AgentInterrogation(agent, abstract_model, objects, domain_name, abstract_predicates, pred_type_mapping, action_parameters, types)
        total, unique, failed, repeated, init_running_time, data_dict, pal_tuple_count, pal_tuple_order, valid_models, _ = iaa_main.agent_interrogation_algo()

        return total, unique, failed, repeated, valid_models

    def learn_model_with_prior(self):
        action_parameters, pred_type_mapping, agent_model_actions, abstract_model_actions, \
                objects, types, init_state, domain_name = parse_files.generate_ds(self.domain_file_path, self.problem_file_path)
        agent = Agent(domain_name, pred_type_mapping, agent_model_actions)
        iaa_main = AgentInterrogation(agent, self.abstract_model, objects, domain_name, self.abstract_predicates, pred_type_mapping, action_parameters, types)    

        # Provide knowledge of pal_tuples_fixed, pal_tuples_set_modes, PALrank, PALorder to AIA
        print("Running AIA..")
        self.data["query_info"].clear()
        total, unique, failed, repeated, running_time, data_dict, pal_tuple_count, pal_tuple_order, valid_models, self.data = iaa_main.agent_interrogation_algo(self.data)
        return total, unique, failed, repeated, valid_models, iaa_main
