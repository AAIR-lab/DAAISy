#!/usr/local/bin/python3
# encoding: utf-8

import glob
from src.utils.translate import pddl_parser
from src.utils.translate import pddl_fd as pddl
from src.config import Literal
from src.model_drift import PATuple

"""
    Computes set of valid modes for an agent's model using positive examples
"""

class ValidModesInference(object):

    def __init__(self, lifted_action_statepair_dict, predicates, actions):
        self.lifted_action_statepair_dict = lifted_action_statepair_dict
        self.predicates = predicates
        self.actions = actions

        self.predicate_presence_to_mode_tuples = dict()
        self.PATuple_predicate_presence_dict = dict()
        self.PAtuple_to_ModeTuple_set_dict = dict()
        self.initialize_predicate_presence_to_possible_mode_tuples()

    def initialize_predicate_presence_to_possible_mode_tuples(self):
        """
            A static map of set of observations to set of possible mode tuples (Pre mode, Eff mode) explained by the observations
            Observation = tuple of predicate presence (positive or negative) in s and s'
        """
        self.predicate_presence_order = [('p','p'), ('p','-p'), ('-p','p'),('-p','-p')]

        self.predicate_presence_to_mode_tuples[tuple([('p', 'p')])] = set([(Literal.POS, Literal.ABS), (Literal.ABS, Literal.POS), (Literal.ABS, Literal.ABS)])
        self.predicate_presence_to_mode_tuples[tuple([('p', 'p'),('-p','p')])] = set([(Literal.ABS, Literal.POS)])
        self.predicate_presence_to_mode_tuples[tuple([('p', 'p'),('-p','-p')])] = set([(Literal.ABS, Literal.ABS)])
        self.predicate_presence_to_mode_tuples[tuple([('p', '-p')])] = set([(Literal.POS, Literal.NEG), (Literal.ABS, Literal.NEG)])
        self.predicate_presence_to_mode_tuples[tuple([('p', '-p'),('-p', '-p')])] = set([(Literal.ABS, Literal.NEG)])
        self.predicate_presence_to_mode_tuples[tuple([('-p', 'p')])] = set([(Literal.NEG, Literal.POS), (Literal.ABS, Literal.POS)])
        self.predicate_presence_to_mode_tuples[tuple([('-p', '-p')])] = set([(Literal.NEG, Literal.ABS), (Literal.ABS, Literal.NEG), (Literal.ABS, Literal.ABS)])

    def get_predicates_from_state_with_predicate_name(self, state, predicate_name):
        """
            Get set of predicates from state that match the given predicate name
        """
        predicates = set()
        for predicate in state.literals:
            if predicate.name==predicate_name:
                predicates.add(predicate)
        return predicates

    def set_predicate_presence(self, set_predicates, action, presence_tuple):
        for predicate in set_predicates:
            PATupleObj = PATuple(predicate, action)
            if PATupleObj not in self.PATuple_predicate_presence_dict.keys():
                self.PATuple_predicate_presence_dict[PATupleObj] = set()
            self.PATuple_predicate_presence_dict[PATupleObj].add(presence_tuple)

    def compute_PAtuple_to_predicate_presence(self):
        """
            Computes a map of Predicate-Action Tuple to set of tuples of predicate presence in state and next state e.g. [('p','p'),('-p','p')] from observations
        """    
        for action, set_statepair in self.lifted_action_statepair_dict.items():
            for predicate_obj in self.predicates:
                predicate_name = predicate_obj.name
            
                for statepair in set_statepair:
                    state_predicates = self.get_predicates_from_state_with_predicate_name(statepair[0], predicate_name)
                    next_state_predicates = self.get_predicates_from_state_with_predicate_name(statepair[1], predicate_name)
                    
                    intersection_set_predicates = state_predicates.intersection(next_state_predicates)
                    left_outer_set_predicates = state_predicates - intersection_set_predicates
                    right_outer_set_predicates = next_state_predicates - intersection_set_predicates

                    # TO DO: case in intersection_set_predicates: can't find for (-p, -p)
                    self.set_predicate_presence(intersection_set_predicates, action, tuple(['p','p']))
                    self.set_predicate_presence(left_outer_set_predicates, action, tuple(['p','-p']))
                    self.set_predicate_presence(right_outer_set_predicates, action, tuple(['-p','p']))

        order = {t: i for i, t in enumerate(self.predicate_presence_order)}
        for PATuple in self.PATuple_predicate_presence_dict.keys():     
            ordered = sorted(list(self.PATuple_predicate_presence_dict[PATuple]), key=lambda x: order[x])
            self.PATuple_predicate_presence_dict[PATuple] = tuple(ordered)

    def compute_PAtuple_to_ModeTuple_set_dict(self):
        """
            Computes a map of Predicate-Action tuple to mode tuples i.e. (pre mode, eff mode)
        """
        for PATuple, predicate_presence in self.PATuple_predicate_presence_dict.items():
            self.PAtuple_to_ModeTuple_set_dict[PATuple] = dict()

            size = len(self.predicate_presence_to_mode_tuples[tuple(predicate_presence)])
            for mode_tuple in self.predicate_presence_to_mode_tuples[predicate_presence]: 
                self.PAtuple_to_ModeTuple_set_dict[PATuple][mode_tuple] =  1.0/size

    def transform_PAtuple(self, PAtuple):
        """
            Transform params in Predicate-Action tuple to ids separated by "|" (AIA's requirement)
        """
        action_name = PAtuple.action.name
        action = action_name
        param_to_id = dict()
        id_ = 0
        for param in PAtuple.action.parameters:
            param_to_id[param.name] = id_
            action+='|'+str(id_)
            id_ += 1
        predicate = PAtuple.predicate.name
        for arg in PAtuple.predicate.args:
            predicate+='|'+str(param_to_id[arg])       
        return PATuple(predicate, action_name)

    def transform_PAtuple_to_ModeTuple_set_dict(self):
        """
            Transform params in Predicate-Action tuple to ids separated by "|" (AIA's requirement)
        """
        transformed_PAtuple_to_ModeTuple_set_dict = dict()
        for PATuple, modepair_set in self.PAtuple_to_ModeTuple_set_dict.items():
            PATuple = self.transform_PAtuple(PATuple)
            transformed_PAtuple_to_ModeTuple_set_dict[PATuple] = modepair_set
        self.PAtuple_to_ModeTuple_set_dict = transformed_PAtuple_to_ModeTuple_set_dict

    def compute_valid_modes(self):
        self.compute_PAtuple_to_predicate_presence()   
        self.compute_PAtuple_to_ModeTuple_set_dict()
        self.transform_PAtuple_to_ModeTuple_set_dict()
