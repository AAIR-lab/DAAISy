#!/usr/local/bin/python3
# encoding: utf-8

import os
import numpy as np
import time
import csv 
import math

from src.lattice import *
from itertools import product
from src.utils import parse_files
from src.agent import Agent
from src.model_drift import plot
from src.model_drift import PATuple
from src.model_drift import ObservationGenerator
from src.model_drift import ValidModesInference
from src.model_drift import AgentInterrogationInterface
from src.utils.translate import pddl_parser
from src import generate_random_states
from src.config import *
import generate_random_init_domains
import config

class ModelEstimator(object):

    def __init__(self, base_dir, domain_name, drifted_domain_file, start_time, flag_init_domains_type, flag_approach):
        self.domain_name = domain_name
        self.drifted_domain_file = drifted_domain_file
        self.example_dir = base_dir+"domains/"+self.domain_name+"/"
        self.domains_dir = self.example_dir+"domains/"
        self.observation_dir = self.example_dir+"observations/" 
        self.observation_dir_drifted = self.observation_dir+"observations_drifted/"
        self.problem_dir_drifted = self.example_dir+"instances/instances/"     
        self.problem_file = "instance-1.pddl"
        self.result_dir = base_dir+"results/"
        self.plot_dir = self.result_dir+self.domain_name+"/" 
        if not os.path.exists(self.plot_dir):
            os.makedirs(self.plot_dir)
        if not os.path.exists(self.observation_dir):
            os.makedirs(self.observation_dir)
        if not os.path.exists(self.observation_dir_drifted):
            os.makedirs(self.observation_dir_drifted)
        if not os.path.exists(final_result_dir):
            os.makedirs(final_result_dir)
        if not os.path.exists(TEMP_FOLDER):
            os.makedirs(TEMP_FOLDER)
        self.start_time = start_time

        self.csvfile = open(self.plot_dir+str(domain_name)+str(start_time)+"_"+str(flag_init_domains_type)+'.csv', 'w')  
        csvwriter = csv.writer(self.csvfile) 
        fields = ["init_domain", "#TotalPALs", "(#)InitPALsIncorrect", "(#)PAsDropped", "(#)PALsDropped_noObs", "(#)FinalAvgPALsIncorrect", \
        "#TotalActions","(#)InitActionsIncorrect","(#)ActionsObserved", "(#)CompleteActionsDropped","(#)FinalActionsIncorrect", \
        "InitAccuracy", "FinalAccuracy", "#UniqueQueriesAIA", "Final#UniqueQueries", "#ValidModels"]
        csvwriter.writerow(fields) 

        self.predicates = list()
        self.actions = list()
        self.action_to_statepair_set_dict = dict()
        self.lifted_action_to_relevant_parameterized_statepair_set_dict = dict()
        self.type_to_objects = dict()
        self.num_total_pals = None
        self.PAtuple_to_ModeTuple_set_dict = dict()
        self.action_to_relevant_predicate_args = dict()
        self.total_scratch = None
        self.unique_scratch = None
        self.failed_scratch = None
        self.repeated_scratch = None
        self.valid_models_scratch = None
        self.total = None
        self.unique = None
        self.failed = None
        self.repeated = None
        self.valid_models = None

        self.data = dict()    
        self.data["marked_changed_actions"] = set()
        self.data["query_info"] = list()
        self.data["flag_init_domains_type"] = flag_init_domains_type
        self.data["flag_approach"] = flag_approach
        
        self.results = dict()
        self.results["initial_accuracy"] = list()
        self.results["final_avg_accuracy"] = list()
        self.results["queries_scratch"] = None
        self.results["queries"] = list()

    def read_model(self, domains_dir, domain_file):
        """
            Return model and PAtuple to ModeTuple map
        """
        print("\nReading model from ",domain_file)
        action_parameters, pred_type_mapping, agent_model_actions, abstract_model_actions, \
                objects, types, init_state, domain_name = parse_files.generate_ds(domains_dir+domain_file, self.problem_dir_drifted+self.problem_file)
        agent = Agent(domain_name, pred_type_mapping, agent_model_actions)
        model = agent.agent_model
        model_PAtuple_to_ModeTuple_dict = dict()
        for action, predicate_modepair_dict in model.actions.items():
            for predicate, modepair in predicate_modepair_dict.items():
                PAtuple = PATuple(predicate, action)
                model_PAtuple_to_ModeTuple_dict[PAtuple] = tuple(modepair)
        return model, model_PAtuple_to_ModeTuple_dict

    def get_all_predicate_args(self, action, predicates):
        type_to_param_list = dict()
        for arg in action.parameters:
            if arg.type_name not in type_to_param_list.keys():
                type_to_param_list[arg.type_name] = list()
            type_to_param_list[arg.type_name].append(arg.name)

        predicates_params = set()
        for predicate in predicates:
            pred_param_list_list = list()
            for arg in predicate.arguments:
                pred_param_list_list.append(type_to_param_list[arg.type_name]) 
            sequences = list(product(*pred_param_list_list))
            valid_sequences = [s for s in sequences if len(s) == len(set(s))]
            for item in valid_sequences:
                string = ""
                for arg in item:
                    arg = str(arg).replace(",","")
                    arg = str(arg).replace("'","")
                    arg = str(arg).replace("(","")
                    arg = str(arg).replace(")","")
                    string += " "+arg
                predicates_params.add("("+predicate.name+string+")")
        return predicates_params

    def find_relevant_predicates_for_action(self, action, predicates):
        action_types = set()
        for type_ in action.type_map.values():
            action_types.add(type_)
        relevant_predicates = set()
        for predicate in predicates:
            relevant = True
            for arg in predicate.arguments:
                if arg.type_name not in action_types:
                    relevant = False
                    break
            if relevant:
                relevant_predicates.add(predicate)
        return relevant_predicates

    def generate_observations_for_drifted_model(self, max_obs):
        """
            Generate observations for drifted model
        """
        obs_generator = ObservationGenerator(self.example_dir, self.domains_dir, self.data)
        print("Generating observations from ",self.drifted_domain_file)   
        self.action_to_statepair_set_dict, self.lifted_action_to_relevant_parameterized_statepair_set_dict, \
            self.type_to_objects, self.predicates, self.actions, self.data = obs_generator.generate_optimal_observations(self.drifted_domain_file, self.problem_dir_drifted, self.observation_dir_drifted, None, max_obs)

    def learn_drifted_model_from_scratch(self):
        """ 
            Learn drifted model using just querying
        """
        print("Learning drifted model ",drifted_domain_file, " from scratch")   
        interrogation = AgentInterrogationInterface(self.domains_dir+self.drifted_domain_file, self.problem_dir_drifted+self.problem_file)
        self.total_scratch, self.unique_scratch, self.failed_scratch, self.repeated_scratch, self.valid_models_scratch = interrogation.learn_model_from_scratch()
        self.results["queries_scratch"] = self.unique_scratch
        self.data["drifted_valid_models"] = self.valid_models_scratch
    
    def generate_observations_for_init_model(self, init_domain_file, domains_dir_init, problem_dir_init, observation_dir_init):
        """ 
            Generate observations for init model
        """
        obs_generator = ObservationGenerator(self.example_dir, self.domains_dir, self.data)
        self.data = obs_generator.generate_observations(domains_dir_init, init_domain_file, self.problem_dir_drifted)  
        if self.data["flag_approach"]==1 or self.data["flag_approach"]==2:
            print("Generating negative examples..")
            self.data = obs_generator.get_negative_examples(domains_dir_init, init_domain_file, problem_dir_init, observation_dir_init)

    def learn_drifted_model_with_knowledge(self, init_model, init_PAtuple_to_ModeTuple_dict):
        """
            Learn drifted model using examples and querying
        """
        # Compute PAtuple to set of possible ModeTuples for drifted model
        print("Computing possible modes from observations for ",self.drifted_domain_file)   
        valid_modes_inference = ValidModesInference(self.lifted_action_to_relevant_parameterized_statepair_set_dict, self.predicates, self.actions)
        valid_modes_inference.compute_valid_modes()
        self.PAtuple_to_ModeTuple_set_dict = valid_modes_inference.PAtuple_to_ModeTuple_set_dict
        
        # Learn drifted model with AIA
        agent_interrogation = AgentInterrogationInterface(self.domains_dir+self.drifted_domain_file, self.problem_dir_drifted+self.problem_file)
        self.data = agent_interrogation.compute_abstract_model(init_model, self.PAtuple_to_ModeTuple_set_dict, init_PAtuple_to_ModeTuple_dict, self.data)
        print("Learning drifted model with AIA")
        if len(self.data["PALtuples_dropped"])>0 or len(self.data["marked_changed_actions"])>0:     
            self.total, self.unique, self.failed, self.repeated, self.valid_models, iaa_main = agent_interrogation.learn_model_with_prior()
        else:
            self.total, self.unique, self.failed, self.repeated, self.valid_models = 0, 0, 0, 0, [init_model]
        # print(iaa_main.pal_tuple_dict)

    def analyze_difference(self, init_PAtuple_modepair_dict, PAtuple_to_ModeTuple_set_dict):
        print("Keys in Init domain but not in learned Drifted domain:")
        for key in init_PAtuple_modepair_dict.keys():
            if key not in PAtuple_to_ModeTuple_set_dict.keys():
                print("\t",key)
        print("Keys in learned Drifted domain but not in Init domain:")
        for key in PAtuple_to_ModeTuple_set_dict.keys():
            if key not in init_PAtuple_modepair_dict.keys():
                print("\t",key)
        print("PATuples learned in Init model:",len(init_PAtuple_modepair_dict))
        print("PATuples learned in Drifted model:",len(PAtuple_to_ModeTuple_set_dict))

    def get_model_difference(self, model1, model2, flag_print=True):
        """
            Get difference between two models
        """
        pals_diff_count = 0
        pals_diff_set = set()
        for action in model1.actions:
            for pred in model1.actions[action]:
                if model1.actions[action][pred][0]!=model2.actions[action][pred][0]:
                    pals_diff_set.add((action,pred,Location.PRECOND))
                    pals_diff_count += 1
                if model1.actions[action][pred][1]!=model2.actions[action][pred][1]:
                    pals_diff_set.add((action,pred,Location.EFFECTS))
                    pals_diff_count += 1
            for pred in model2.actions[action]:
                if pred not in model1.actions[action]:
                    if model2.actions[action][pred][0]!=Literal.ABS:
                        pals_diff_set.add((action,pred,Location.PRECOND))
                        pals_diff_count += 1
                    if model2.actions[action][pred][1]!=Literal.ABS:
                        pals_diff_set.add((action,pred,Location.EFFECTS))
                        pals_diff_count += 1
        actions_diff_set = set()
        for pal in pals_diff_set:
            actions_diff_set.add(pal[0])
        actions_diff_count = len(actions_diff_set)
        if flag_print:
            for tup in pals_diff_set:
                print(tup)
            print("Number PALs different :",pals_diff_count,"/",self.num_total_pals)
        return pals_diff_count, pals_diff_set, actions_diff_count, actions_diff_set
                  
    def print_analysis(self, init_domain_file, init_model, drifted_model):
        init_domain_filename = init_domain_file.split("/")[-1].split(".")[0]
        print("\nDiff betn init and drifted models:")
        initial_num_pals_drifted, initial_pals_drifted_set, initial_num_actions_drifted, initial_actions_drifted_set = self.get_model_difference(init_model, drifted_model)
        initial_accuracy = (self.num_total_pals-initial_num_pals_drifted)/self.num_total_pals

        print("\n PALs dropped:")
        for pal in self.data["PALtuples_dropped"]:
            print(pal)

        print("\nDiff betn drifted and learnt models:")
        final_avg_num_pals_incorrect = 0.0
        final_avg_num_actions_incorrect = 0.0
        for learned_model in self.valid_models:
            incorrect_pals, incorrect_pals_set, incorrect_actions, incorrect_actions_set = self.get_model_difference(drifted_model, learned_model, True)
            final_avg_num_pals_incorrect += incorrect_pals
            final_avg_num_actions_incorrect += incorrect_actions
        final_avg_num_pals_incorrect = final_avg_num_pals_incorrect/len(self.valid_models)
        final_avg_num_actions_incorrect = final_avg_num_actions_incorrect/len(self.valid_models)
        final_avg_accuracy = (self.num_total_pals-final_avg_num_pals_incorrect)/self.num_total_pals

        print("Initial model estimate accuracy:",initial_accuracy)
        print("Final model estimate accuracy:",final_avg_accuracy)

        print("\ntotal queries: AIA:",self.total_scratch, ", ours:",self.total)
        print("unique queries: AIA:",self.unique_scratch, ", ours:",self.unique)
        print("failed queries: AIA:",self.failed_scratch, "failed:",self.failed)
        print("repeated queries: AIA:",self.repeated_scratch, "repeated:",self.repeated)

        self.results["initial_accuracy"].append(initial_accuracy)
        self.results["final_avg_accuracy"].append(final_avg_accuracy)  
        self.results["queries"].append(self.unique)

        csvwriter = csv.writer(self.csvfile) 
        #["init_domain", "#TotalPALs", "(#)InitPALsIncorrect", "(#)PAsDropped", "(#)PALsDropped_noObs", "(#)FinalAvgPALsIncorrect", 
        # "#TotalActions","(#)InitActionsIncorrect","(#)ActionsObserved", "(#)CompleteActionsDropped","(#)FinalActionsIncorrect", 
        # "InitAccuracy", "FinalAccuracy", "#UniqueQueriesAIA", "Final#UniqueQueries", "#ValidModels"]
        csvwriter.writerow([init_domain_filename, self.num_total_pals, "("+str(initial_num_pals_drifted)+") "+str(initial_pals_drifted_set), "("+str(len(self.data["PALtuples_dropped"]))+") "+str(self.data["PALtuples_dropped"]), "("+str(len(self.data["PALtuples_dropped_no_obs"]))+") "+str(self.data["PALtuples_dropped_no_obs"]), "("+str(final_avg_num_pals_incorrect)+") "+str(incorrect_pals_set), \
        len(self.actions), "("+str(initial_num_actions_drifted)+") "+str(initial_actions_drifted_set), "("+str(len(self.actions)-len(self.data["actions_with_no_obs"]))+") "+str(set(self.actions)-set(self.data["actions_with_no_obs"])),  "("+str(len(self.data["marked_changed_actions"]))+") "+str(self.data["marked_changed_actions"]), "("+str(final_avg_num_actions_incorrect)+") "+str(incorrect_pals_set), \
        initial_accuracy, final_avg_accuracy, self.unique_scratch, self.unique, len(self.valid_models)])
        
        with open(self.plot_dir+str(self.domain_name)+str(self.start_time)+"_"+str(flag_init_domains_type)+'.txt', 'a') as f:
            string = "\n\n\n"+str(init_domain_filename)+":\n"
            for tup in self.data["query_info"]:
                string += "Initial state: "+str(tup[0])+"\n\n"
                string += "Plan: "+str(tup[1])+"\n\nModels:\n"
                for v in tup[2]:
                    for action, predicates in v.actions.items():
                        string += str(action)+str(predicates)+"\n"
                    string+= "\n"
            f.write(string) 
        f.close()

def get_init_dirs(base_dir, domain_to_total_pals, domain_name, generate_init_domains_type, num_pals, num_files_each_pal, interval):
    example_dir = base_dir+"domains/"+domain_name+"/"
    domains_dir_init = example_dir+"domains/"
    init_domains_random_dir = domains_dir_init+"init_domains_random/"
    init_domains_increased_applicability_dir = domains_dir_init+"init_domains_increased_applicability/"
    init_domains_mix_dir = domains_dir_init+"init_domains_mix/"

    init_problem_random_dir = example_dir+"instances/init_instances_random/"
    init_problem_increased_applicability_dir = example_dir+"instances/init_instances_increased_applicability/"
    init_problem_mix_dir = example_dir+"instances/init_instances_mix/"
    init_observation_random_dir = example_dir+"observations/init_observations_random/"
    init_observation_increased_applicability_dir = example_dir+"observations/init_observations_increased_applicability/"
    init_observation_mix_dir = example_dir+"observations/init_observations_mix/"

    if generate_init_domains_type == 0:   
        if not os.path.exists(init_problem_random_dir):
            os.makedirs(init_problem_random_dir)
        if not os.path.exists(init_observation_random_dir):
            os.makedirs(init_observation_random_dir)
    elif generate_init_domains_type == 1:   
        if not os.path.exists(init_problem_increased_applicability_dir):
            os.makedirs(init_problem_increased_applicability_dir)
        if not os.path.exists(init_observation_increased_applicability_dir):
            os.makedirs(init_observation_increased_applicability_dir)
    elif generate_init_domains_type == 2:   
        if not os.path.exists(init_problem_mix_dir):    
            os.makedirs(init_problem_mix_dir)
        if not os.path.exists(init_observation_mix_dir):
            os.makedirs(init_observation_mix_dir)

    init_domains_dir, init_problems_dir, init_observations_dir = None, None, None
    init_domain_files = list()
    num_incorrect_pals_list = list()
    flag_init_domains_type_list = list()
    last_reduced_capability_num_dropped_pals = None
    if generate_init_domains_type == 0:   
        init_domains_dir = init_domains_random_dir
        init_problems_dir = init_problem_random_dir
        init_observations_dir = init_observation_random_dir
        interval = math.floor(domain_to_total_pals[domain_name]/num_pals)
        for i in range(1,domain_to_total_pals[domain_name],interval):
            num_incorrect_pals_list.append(i)
            for j in range(num_files_each_pal):
                init_domain_files.append("domain_"+str(i)+"_"+str(j)+".pddl")   
                flag_init_domains_type_list.append(flag_init_domains_type)
    elif generate_init_domains_type == 1:
        init_domains_dir = init_domains_increased_applicability_dir
        init_problems_dir = init_problem_increased_applicability_dir
        init_observations_dir = init_observation_increased_applicability_dir
        interval = 1
        for i in range(1,domain_to_total_pals_increased_applicability[domain_name], interval):
            num_incorrect_pals_list.append(i)
            for j in range(num_files_each_pal):
                num_incorrect_pals_list.append(i)
                init_domain_files.append("domain_"+str(i)+"_"+str(j)+".pddl")   
                flag_init_domains_type_list.append(flag_init_domains_type)
    else:
        init_domains_dir = init_domains_mix_dir
        init_problems_dir = init_problem_mix_dir
        init_observations_dir = init_observation_mix_dir
        for i in range(1,domain_to_total_pals[domain_name],interval):
            num_incorrect_pals_list.append(i)
            if i < domain_to_total_pals_increased_applicability[domain_name]:
                for j in range(int(num_files_each_pal/2)):
                    init_domain_files.append("domain_"+str(i)+"_"+str(j)+".pddl")   
                    flag_init_domains_type_list.append(0)
                for j in range(int(num_files_each_pal/2),int(num_files_each_pal)):
                    init_domain_files.append("domain_"+str(i)+"_"+str(j)+".pddl")   
                    flag_init_domains_type_list.append(1)
                last_reduced_capability_num_dropped_pals = i
            else:
                for j in range(num_files_each_pal):
                    init_domain_files.append("domain_"+str(i)+"_"+str(j)+".pddl")   
                    flag_init_domains_type_list.append(0)
    return init_domains_dir, init_problems_dir, init_observations_dir, init_domain_files, num_incorrect_pals_list, flag_init_domains_type_list, last_reduced_capability_num_dropped_pals

def set_paths_generate_random_states(domain_name):
    base_dir = os.getcwd()+"/"  
    domains_path = base_dir+"domains/"+domain_name+"/"
    domain_file = "domain_init.pddl"
    problem_dir = domains_path+"instances"
    random_state_folder = base_dir+"random_states/"
    gen_result_file = domains_path+"gen_res.txt"
    generate_random_states.main(domain_name, domains_path, domain_file, problem_dir, random_state_folder, gen_result_file)

def learn_model_with_increasing_observations():
    domains = config.domains
    drifted_domain_file = config.drifted_domain_file  
    flag_init_domains_type = config.flag_init_domains_type
    flag_approach = config.flag_approach
    num_affected_pals = config.num_affected_pals
    domain_to_num_files_each_pal = config.domain_to_num_files_each_pal
    domain_to_total_pals = config.domain_to_total_pals
    domain_to_total_pals_increased_applicability = config.domain_to_total_pals_increased_applicability
    domains_mix_intervals = config.domains_mix_intervals
    domain_to_num_sas = config.domain_to_num_sas 

    base_dir = os.getcwd()+"/"
    start_time = time.time()
    for domain_name in domains:
        final_results = dict()
        for num_obs in range(1,domain_to_num_sas[domain_name],2):
            num_files_each_pal = domain_to_num_files_each_pal[domain_name]
            final_results[num_obs] = dict()
            final_results[num_obs]["initial_model_accuracy"] = list()
            final_results[num_obs]["final_model_accuracy"] = list()
            final_results[num_obs]["queries_scratch"] = list()
            final_results[num_obs]["queries"] = list()
            final_results[num_obs]["acc_std_dev"] = list()
            final_results[num_obs]["queries_std_dev"] = list()
            
            estimator = ModelEstimator(base_dir, domain_name, drifted_domain_file, start_time, flag_init_domains_type, flag_approach) 
            estimator.compute_total_number_pal() 
            domain_to_total_pals[domain_name] = estimator.num_total_pals
            print(domain_to_total_pals[domain_name])
            drifted_model, drifted_PAtuple_to_ModeTuple_dict = estimator.read_model(estimator.domains_dir, drifted_domain_file)  
            estimator.generate_observations_for_drifted_model(num_obs)
            estimator.learn_drifted_model_from_scratch()

            domains_dir_init, problem_dir_init, observation_dir_init, init_domain_files, num_incorrect_pals_list, _, _ = \
                get_init_dirs(base_dir, domain_to_total_pals, domain_name, flag_init_domains_type, num_affected_pals, num_files_each_pal, domains_mix_intervals[domain_name])
            init_domain_files = ["domain_201_0.pddl"]
        
            for init_domain_file in init_domain_files:
                init_model, init_PAtuple_to_ModeTuple_dict = estimator.read_model(domains_dir_init, init_domain_file)
                estimator.analyze_difference(init_PAtuple_to_ModeTuple_dict, drifted_PAtuple_to_ModeTuple_dict)
                estimator.generate_observations_for_init_model(init_domain_file, domains_dir_init, problem_dir_init, observation_dir_init)
                estimator.learn_drifted_model_with_knowledge(init_model, init_PAtuple_to_ModeTuple_dict)
                estimator.print_analysis(init_domain_file, init_model, drifted_model)
            
            i = 0
            num_files_each_pal = len(init_domain_files)
            final_results[num_obs]["initial_model_accuracy"].append(np.sum(estimator.results["initial_accuracy"][i:i+num_files_each_pal])/num_files_each_pal)
            final_results[num_obs]["final_model_accuracy"].append(np.sum(estimator.results["final_avg_accuracy"][i:i+num_files_each_pal])/num_files_each_pal)
            final_results[num_obs]["queries_scratch"].append(estimator.results["queries_scratch"])
            final_results[num_obs]["queries"].append(np.sum(estimator.results["queries"][i:i+num_files_each_pal])/num_files_each_pal)
            final_results[num_obs]["acc_std_dev"].append(np.std(estimator.results["final_avg_accuracy"][i:i+num_files_each_pal]))
            final_results[num_obs]["queries_std_dev"].append(np.std(estimator.results["queries"][i:i+num_files_each_pal])/num_files_each_pal)        
        plot.plot_for_increasing_observations(final_results, estimator.plot_dir+"Observations_experiment_"+str(start_time)+"_"+str(flag_approach)+".png", domain_name +" (#Pals = "+str(domain_to_total_pals[domain_name])+", drift = 50%)")
        for num_obs,item in final_results.items():
            print(num_obs,":",item)
    print("All experiments took ",str(time.time()-start_time)," s")

if __name__=="__main__":
    domains = config.domains
    drifted_domain_file = config.drifted_domain_file  
    flag_init_domains_type = config.flag_init_domains_type
    flag_approach = config.flag_approach
    num_affected_pals = config.num_affected_pals
    domain_to_num_files_each_pal = config.domain_to_num_files_each_pal
    domain_to_total_pals = config.domain_to_total_pals
    domain_to_total_pals_increased_applicability = config.domain_to_total_pals_increased_applicability
    domains_mix_intervals = config.domains_mix_intervals
    domain_to_num_sas = config.domain_to_num_sas 

    base_dir = os.getcwd()+"/"
    start_time = time.time()
    for domain_name in domains:
        if config.regenerate_random_states:
            set_paths_generate_random_states(domain_name)

        num_files_each_pal = domain_to_num_files_each_pal[domain_name]
        final_results = dict()
        final_results["num_pals_incorrect"] = list()
        final_results["initial_model_accuracy"] = list()
        final_results["final_model_accuracy"] = list()
        final_results["acc_std_dev"] = list()
        final_results["queries_scratch"] = list()
        final_results["queries"] = list()
        final_results["queries_std_dev"] = list()
        
        estimator = ModelEstimator(base_dir, domain_name, drifted_domain_file, start_time, flag_init_domains_type, flag_approach) 
        estimator.actions, estimator.predicates, _, _, _, \
            estimator.num_total_pals, num_total_pals_increased_applicability, estimator.action_to_relevant_predicate_args = generate_random_init_domains.parse_domain(estimator.domains_dir+estimator.drifted_domain_file)
        domain_to_total_pals[domain_name] = estimator.num_total_pals
        domain_to_total_pals_increased_applicability[domain_name] = num_total_pals_increased_applicability
        final_results["domain_to_total_pals"] = domain_to_total_pals[domain_name]

        print("Total PALs in the domain:",domain_to_total_pals[domain_name])
        drifted_model, drifted_PAtuple_to_ModeTuple_dict = estimator.read_model(estimator.domains_dir, drifted_domain_file)  
        estimator.generate_observations_for_drifted_model(domain_to_num_sas[domain_name])
        estimator.learn_drifted_model_from_scratch()

        domains_dir_init, problem_dir_init, observation_dir_init, init_domain_files, num_incorrect_pals_list, _, _ = \
            get_init_dirs(base_dir, domain_to_total_pals, domain_name, flag_init_domains_type, num_affected_pals, num_files_each_pal, domains_mix_intervals[domain_name])
        final_results["num_pals_incorrect"] = num_incorrect_pals_list
       
        for init_domain_file in init_domain_files:
            init_model, init_PAtuple_to_ModeTuple_dict = estimator.read_model(domains_dir_init, init_domain_file)
            estimator.analyze_difference(init_PAtuple_to_ModeTuple_dict, drifted_PAtuple_to_ModeTuple_dict)
            # Generate observations for init domain to compare with the observations of drifted domain
            estimator.generate_observations_for_init_model(init_domain_file, domains_dir_init, problem_dir_init, observation_dir_init)
            # Use inferences and query the drifted agent to learn its updated domain 
            estimator.learn_drifted_model_with_knowledge(init_model, init_PAtuple_to_ModeTuple_dict)
            estimator.print_analysis(init_domain_file, init_model, drifted_model)
        
        i = 0
        for k in range(len(num_incorrect_pals_list)):
            final_results["initial_model_accuracy"].append(np.sum(estimator.results["initial_accuracy"][i:i+num_files_each_pal])/num_files_each_pal)
            final_results["final_model_accuracy"].append(np.sum(estimator.results["final_avg_accuracy"][i:i+num_files_each_pal])/num_files_each_pal)
            final_results["acc_std_dev"].append(np.std(estimator.results["final_avg_accuracy"][i:i+num_files_each_pal]))
            final_results["queries_scratch"].append(estimator.results["queries_scratch"])
            final_results["queries"].append(np.sum(estimator.results["queries"][i:i+num_files_each_pal])/num_files_each_pal)
            final_results["queries_std_dev"].append(np.std(estimator.results["queries"][i:i+num_files_each_pal])/num_files_each_pal)
            i += num_files_each_pal
        plot.plot_1(final_results, estimator.plot_dir+"plot"+str(start_time)+"_"+str(flag_init_domains_type)+".png", domain_name +" (#Pals = "+str(domain_to_total_pals[domain_name])+",#Obs = "+str(domain_to_num_sas[domain_name])+")")
    print("All experiments took ",str(time.time()-start_time)," s")

