#!/usr/local/bin/python3
# encoding: utf-8

import os
import copy
import glob
import random
import re
from itertools import product
import pickle
import math

from dependencies.fama.src import planning
from src.utils.translate import pddl_parser
from src.utils.translate import pddl_fd as pddl
from src.utils import *

class ObservationGenerator(object):

    def __init__(self, example_dir, domains_dir, data):
        self.example_dir = example_dir
        self.domains_dir = domains_dir
        self.data = data
        self.actions = None

    def parse_atom_to_literal(self, atom):
        if not isinstance(atom, pddl.f_expression.FunctionAssignment) and atom.predicate!="=":    
            name_ = atom.predicate
            args_ = list()
            for arg in atom.args:
                args_.append(str(arg))
            return planning.Literal(name_,args_)
        return atom

    def apply_action(self, state, action):
        next_state = copy.deepcopy(state)
        for effect in action.effects:
            atom = effect.literal
            literal = self.parse_atom_to_literal(atom)
            if atom.negated == True:
                positive_literal = copy.deepcopy(literal)
                positive_literal.negated = False
                next_state.delLiteral(positive_literal)
            else:
                next_state.addLiteral(literal)
        return next_state

    def get_init_state(self, fd_domain, fd_task):
        init_state=planning.State([])
        for l in fd_task.init:
            if l.predicate!="=":
                init_state.addLiteral(self.parse_atom_to_literal(l))
        return init_state

    def get_type_to_objects(self, fd_task, type_to_objects=None):
        if not type_to_objects:
            type_to_objects = dict()
        for item in fd_task.objects:
            if item.type_name not in type_to_objects.keys():
                type_to_objects[item.type_name] = set()
            type_to_objects[item.type_name].add(item.name)
        return type_to_objects
    
    def get_objs_params_maps(self, objs, params):
        """
            Get objs to params map and params to objs map
        """
        param_to_obj, obj_to_param = dict(), dict()
        for i in range(len(params)):
            typed_obj = copy.deepcopy(params[i])
            param_to_obj[typed_obj.name] = objs[i]
            obj_to_param[objs[i]] = typed_obj.name
        return param_to_obj, obj_to_param

    def replace_parameters_in_action(self, action_to_be_modified, param_to_param):
        """
            Replaces params with objs or objs with params i.e. converts grounded_action to lifted_action or other way around
        """
        action = copy.deepcopy(action_to_be_modified)

        parameters = list()
        for param in action.parameters:
            param.name = param_to_param[param.name]
            parameters.append(param)
        action.parameters = parameters
        effects = list()
        for eff in action.effects:
            args = list()
            for arg in eff.literal.args:
                args.append(param_to_param[arg])
            eff.literal.args = tuple(args)
            effects.append(eff)
        action.effects = effects
        precondition = list()
        if len(action.precondition.parts)>0:
            for pre in action.precondition.parts:
                args = list()
                for arg in pre.args:
                    args.append(param_to_param[arg])
                pre.args = tuple(args)
                precondition.append(pre)
        else:
            pre = action.precondition
            args = list()
            for arg in pre.args:
                args.append(param_to_param[arg])
            pre.args = tuple(args)
            precondition.append(pre)
        action.precondition = precondition
        return action

    def get_relevant_parameterized_predicates_set(self, state, obj_to_param):
        """ 
            Get predicates in a state relevant for the action i.e. predicates whose arguments are definitely in the action's arguments
        """
        relevant_state = copy.deepcopy(state)
        relevant_literals = list()
        for literal in state.literals:
            relevant_flag = True
            for arg in literal.args:
                if arg not in obj_to_param.keys():
                    relevant_flag = False
                    break
            if relevant_flag:
                parameterized_literal = copy.deepcopy(literal)
                args = list()
                for obj in parameterized_literal.args:
                    args.append(obj_to_param[obj])
                parameterized_literal.args = args
                relevant_literals.append(parameterized_literal)
        relevant_state.literals = relevant_literals
        return relevant_state

    def get_subplans(self, plan):
        subplans = set()
        for i in range(len(plan)):
            for j in range(i,len(plan)):
                subplans.add(tuple(plan[i:j+1]))
        return subplans

    def generate_optimal_observations(self, domain_file, problem_dir, observation_dir, problem_file=None, max_obs=math.inf):
        """ 
        given a problem file, generates an optimal plan and
        returns actions to state-nextstate map, lifted action to relevant state-nextstate, all optimal plans and their subplans
        """
        domain_path = self.domains_dir+domain_file

        problem_paths = list()
        if problem_file:
            problem_paths = [problem_dir+problem_file]
        else:
            problem_paths = sorted(glob.glob(problem_dir+"*.pddl"),key = lambda x : float(re.findall("(\d+)",x)[0]))

        fd_domain = pddl_parser.pddl_file.parse_pddl_file("domain", domain_path)
        domain_name, domain_requirements, types, type_dict, constants, \
            predicates, predicate_dict, functions, self.actions, axioms = pddl_parser.parsing_functions.parse_domain_pddl(fd_domain)

        action_to_statepair_set_dict = dict()
        lifted_action_to_relevant_parameterized_statepair_set_dict = dict()
        problem_optimal_plan_to_optimal_subplans = dict() 
        type_to_objects = dict()
        i = 0
        for problem_path in problem_paths:
            problem_id = problem_path.split("/")[-1].split("-")[1].split(".")[0]
            observation_file = observation_dir+"plan-"+str(problem_id)

            action_parameters, pred_type_mapping, agent_model_actions, abstract_model_actions, \
                    objects, types, init_state, domain_name = parse_files.generate_ds(domain_path, problem_path)
            
            fd_problem = pddl_parser.pddl_file.parse_pddl_file("task", problem_path)
            fd_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problem)
            type_to_objects = self.get_type_to_objects(fd_task, type_to_objects)

            print("Attempting to generate plan for ",problem_path)
            if not os.path.exists(observation_file):
                os.chdir(self.example_dir+"../../dependencies/FD/")
                cmd = "./fast-downward.py "
                cmd+= "--search-time-limit 60 "
                cmd+= "--plan-file "+observation_file+" "+domain_path+" "+problem_path+" --search 'astar(lmcut())' > "+observation_dir+"output.txt"
                print(cmd)
                os.system(cmd)
                print("Generated optimal plan from ",domain_path," and\n ",problem_path)
            else:
                print("Observation file already exists for ",problem_path)

            init_state = self.get_init_state(fd_domain, fd_task)
            state = copy.deepcopy(init_state)   
            if os.path.exists(observation_file):
                optimal_plan = list()  
                for line in open(observation_file,"r"):
                    if ";" not in line:
                        line = line.replace("(","")
                        line = line.replace(")","")
                        action_name = line.split(" ")[0]
                        objs = line.replace("\n","").split(" ")[1:]

                        lifted_action = None
                        for action_obj in self.actions:
                            if action_obj.name==action_name:
                                lifted_action = action_obj
                        params = lifted_action.parameters

                        param_to_obj, obj_to_param = self.get_objs_params_maps(objs, params)
                        
                        action = self.replace_parameters_in_action(lifted_action, param_to_obj)
                        next_state = self.apply_action(state, action)

                        if action_name not in action_to_statepair_set_dict.keys():
                            action_to_statepair_set_dict[action_name] = dict()
                        if action not in action_to_statepair_set_dict[action_name].keys():
                            action_to_statepair_set_dict[action_name][action] = set()
                        action_to_statepair_set_dict[action_name][action].add(tuple([state, next_state]))

                        optimal_plan.append((state, action, next_state))

                        relevant_parameterized_state = self.get_relevant_parameterized_predicates_set(state, obj_to_param)
                        relevant_parameterized_next_state = self.get_relevant_parameterized_predicates_set(next_state, obj_to_param)

                        if lifted_action not in lifted_action_to_relevant_parameterized_statepair_set_dict:
                            lifted_action_to_relevant_parameterized_statepair_set_dict[lifted_action] = set()
                        lifted_action_to_relevant_parameterized_statepair_set_dict[lifted_action].add(tuple([relevant_parameterized_state, relevant_parameterized_next_state]))

                        state = copy.deepcopy(next_state)
                        i += 1
                    if i == max_obs:
                        break
                problem_optimal_plan_to_optimal_subplans[(problem_id, tuple(optimal_plan))] = self.get_subplans(optimal_plan)
            if i == max_obs:
                    break

        actions_with_no_obs = set()
        for action in self.actions:
            action_name = action.name
            if action_name not in action_to_statepair_set_dict.keys():
                actions_with_no_obs.add(action_name)
        self.data["actions_with_no_obs"] = actions_with_no_obs

        i = 0
        string = "Total number of actions:"+str(len(self.actions))+"\n"
        string += "Total number of actions in observations:\n"
        for action, statepair_set in action_to_statepair_set_dict.items():
            string += str(i)+")"+str(action)+":"+str(len(statepair_set))+" states\n"
            i += 1
        with open(observation_dir+"number_actions.txt","w") as f:
            f.write(string)
        self.data["action_to_statepair_set"] = action_to_statepair_set_dict 
        self.data["type_to_objects"] = type_to_objects
        self.data["problem_optimal_plan_to_optimal_subplans"] = problem_optimal_plan_to_optimal_subplans
        return action_to_statepair_set_dict, lifted_action_to_relevant_parameterized_statepair_set_dict, type_to_objects, predicates, self.actions, self.data

    ######################## Observation tree for init model ###################################

    def generate_observations(self, init_domains_dir, init_domain_file, problem_dir):
        """
        generates a tree with state as nodes and actions as edges for diversity in actions
        returns action to state-nextstate map
        """
        num_obs = 20
        init_domain_path = init_domains_dir+init_domain_file
        problem_files = sorted(glob.glob(problem_dir+"*.pddl"))
    
        fd_domain = pddl_parser.pddl_file.parse_pddl_file("domain", init_domain_path)
        domain_name, domain_requirements, types, type_dict, constants, \
            predicates, predicate_dict, functions, self.actions, axioms = pddl_parser.parsing_functions.parse_domain_pddl(fd_domain)

        grounded_action_statepairset_dict = dict()
        for i in range(len(problem_files)):
            problem_path = problem_files[i]
            action_parameters, pred_type_mapping, agent_model_actions, abstract_model_actions, \
                    objects, types, init_state, domain_name = parse_files.generate_ds(init_domain_path, problem_path)   
            fd_problem = pddl_parser.pddl_file.parse_pddl_file("task", problem_path)
            fd_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problem)
            type_to_objects = self.get_type_to_objects(fd_task)

            init_state = self.get_init_state(fd_domain, fd_task)
            grounded_actions = self.get_concrete_actions(init_domain_path, problem_path, self.actions, type_to_objects)
            grounded_action_statepairset_dict = self.get_action_statepairset_dict(grounded_action_statepairset_dict, init_state, grounded_actions, num_obs)
        self.data["action_to_statepair_set_init"] = grounded_action_statepairset_dict
        action_name_to_action = dict()
        for action in self.actions:
            action_name_to_action[action.name] = action
        self.data["action_name_to_action"] = action_name_to_action
        return self.data

    def generate_problem_for_init_model(self, init_state, goal_state, problem_file, init_problem_path):
        string = ""
        for line in open(problem_file, 'r'):    
            if "init" in line or "INIT" in line:
                break
            string += line
        init_string = ""
        for literal in init_state.literals:
            init_string += "("+literal.name+" "+" ".join(literal.args)+")"
        goal_string = ""
        for literal in goal_state.literals:
            goal_string += "("+literal.name+" "+" ".join(literal.args)+")"
        string += "\n(:INIT "+init_string+")"
        string += "\n(:goal (AND "+goal_string+"))\n)"
        with open(init_problem_path, "w") as f:
            f.write(string)  
        f.close()

    def get_state_action_next_state_from_observation_file(self, init_observation_file, init_state):
        init_plan = list()  
        state = copy.deepcopy(init_state)  
        for line in open(init_observation_file,"r"):
            if ";" not in line:
                line = line.replace("(","")
                line = line.replace(")","")
                action_name = line.split(" ")[0]
                objs = line.replace("\n","").split(" ")[1:]

                lifted_action = None
                for action_obj in self.actions:
                    if action_obj.name==action_name:
                        lifted_action = action_obj
                params = lifted_action.parameters

                param_to_obj, obj_to_param = self.get_objs_params_maps(objs, params)
                
                action = self.replace_parameters_in_action(lifted_action, param_to_obj)
                next_state = self.apply_action(state, action)

                init_plan.append((state, action, next_state))
                state = copy.deepcopy(next_state)
        return init_plan

    def get_negative_examples(self, domains_dir, init_domain_file, init_problem_dir, init_observation_dir):
        """
            gives problem solved by drifted model to the init model and find plan
            computes a map of plans found by drifted model to plans found by init model for the same problems
        """
        init_domain_id = init_domain_file.split(".")[0]
        init_domain_path = domains_dir+init_domain_file
        self.data["drifted_plan_to_init_plan_same_length"] = dict()
        self.data["drifted_plan_to_init_plan_shorter_length"] = dict()

        if not os.path.exists(init_problem_dir+init_domain_id+"/"):
            os.makedirs(init_problem_dir+init_domain_id+"/")
        if not os.path.exists(init_observation_dir+init_domain_id+"/"):
            os.makedirs(init_observation_dir+init_domain_id+"/")
        if not os.path.exists(init_observation_dir+init_domain_id+"/less_or_same_length_plans_pickle_"+str(len(self.data["problem_optimal_plan_to_optimal_subplans"]))+".obj"):
            for tup in self.data["problem_optimal_plan_to_optimal_subplans"]:
                problem_id = tup[0]
                optimal_plan = tup[1]
                problem_file = self.example_dir+"instances/instances/instance-"+str(problem_id)+".pddl"
                subplan_id = 1
                for subplan in self.data["problem_optimal_plan_to_optimal_subplans"][tup]: 
                    init_problem_file = init_problem_dir+init_domain_id+"/instance-"+str(problem_id)+"-"+str(subplan_id)+".pddl" 
                    init_state, goal_state = subplan[0][0], subplan[-1][2]
                    self.generate_problem_for_init_model(init_state, goal_state, problem_file, init_problem_file)

                    init_observation_file = init_observation_dir+init_domain_id+"/plan-"+str(problem_id)+"-"+str(subplan_id) 
                    os.chdir(self.example_dir+"../../dependencies/FD/") 
                    cmd = "./fast-downward.py "
                    cmd += "--search-time-limit 60 "
                    cmd += "--plan-file "+init_observation_file+" "+init_domain_path+" "+init_problem_file+" --search 'astar(lmcut())' > "+init_observation_dir+"output.txt"
                    os.system(cmd)

                    if os.path.exists(init_observation_file):
                        print("Generated optimal plan from ",init_domain_path," and\n ",init_problem_file)            
                        init_plan = self.get_state_action_next_state_from_observation_file(init_observation_file, init_state)
                        if len(init_plan) == len(subplan):
                            self.data["drifted_plan_to_init_plan_same_length"][(subplan_id, subplan)] = init_plan
                        elif len(init_plan) < len(subplan):
                            self.data["drifted_plan_to_init_plan_shorter_length"][(subplan_id, subplan)] = init_plan
                    subplan_id += 1

            f = open(init_observation_dir+init_domain_id+"/less_or_same_length_plans_pickle.obj","wb")
            pickle.dump((self.data["drifted_plan_to_init_plan_same_length"],self.data["drifted_plan_to_init_plan_shorter_length"]), f)
            f.close()
        else:
            file = open(init_observation_dir+init_domain_id+"/less_or_same_length_plans_pickle.obj","rb")
            object_file = pickle.load(file)
            self.data["drifted_plan_to_init_plan_same_length"] = object_file[0]
            self.data["drifted_plan_to_init_plan_shorter_length"] = object_file[1]
            file.close()


        plan_id_to_length_drifted_init_tuple = dict()
        plan_id_drifted_plan_to_init_plan_shorter_length = dict()
        marked_changed_actions = set()
        marked_changed_action_effect = set()
        marked_possibly_unchanged_actions = set()
        for tup, init_plan in self.data["drifted_plan_to_init_plan_shorter_length"].items():
            subplan_id, drifted_plan = tup[0], tup[1]
            plan_id_to_length_drifted_init_tuple[subplan_id] = (len(drifted_plan),len(init_plan))
            drifted_action_sequence, init_action_sequence = list(), list()
            for tup in drifted_plan:
                drifted_action_sequence.append(tup[1].name)
            for tup in init_plan:
                init_action_sequence.append(tup[1].name)
            plan_id_drifted_plan_to_init_plan_shorter_length[(subplan_id, tuple(drifted_action_sequence))] = tuple(init_action_sequence)
            for i in range(len(drifted_plan)):
                if i < len(init_plan)-1:
                    if init_plan[i][1].name==drifted_plan[i][1].name:
                        if init_plan[i][2]==drifted_plan[i][2]:
                            marked_possibly_unchanged_actions.add(init_plan[i][1].name)
                        else:
                            marked_changed_actions.add(init_plan[i][1].name)
                            marked_changed_action_effect.add(init_plan[i][1].name)
                    else:
                        # get first changed actions in the plans
                        marked_changed_actions.add(init_plan[i][1].name)
                        break
                else:
                    break

        self.data["marked_changed_actions"] = marked_changed_actions    
        if len(marked_changed_actions)>0:
            print("yay") 
        return self.data

    def get_concrete_actions(self, domain_path, problem_path, actions, type_to_objects):
        concrete_actions = list()
        action_to_arg_combi = dict()
        for action in actions:
            action_name = action.name
            type_list = list()
            for arg in action.parameters:
                type_list.append(arg.type_name)
            obj_list_list = list()
            for type_ in type_list:
                obj_list_list.append(list(type_to_objects[type_]))
            arg_combinations = list(product(*obj_list_list))
            action_to_arg_combi[action_name] = dict()
            action_to_arg_combi[action_name] = arg_combinations

        for action in actions:
            arg_combi = action_to_arg_combi[action.name]
            operator = action.name
            for arg_combi in action_to_arg_combi[operator]:
                concrete_action = copy.deepcopy(action)
                param_to_obj = dict()
                i = 0
                for param in concrete_action.parameters:
                    param_to_obj[param.name] = arg_combi[i]
                    i += 1
                concrete_action = self.replace_parameters(concrete_action,param_to_obj)
                concrete_actions.append(concrete_action)
        return concrete_actions

    def replace_parameters(self, concrete_action, param_to_obj):
        parameters = list()
        for param in concrete_action.parameters:
            param.name = param_to_obj[param.name]
            parameters.append(param)
        concrete_action.parameters = parameters
        effects = list()
        for eff in concrete_action.effects:
            args = list()
            for arg in eff.literal.args:
                args.append(param_to_obj[arg])
            eff.literal.args = tuple(args)
            effects.append(eff)
        concrete_action.effects = effects
        precondition = list()
        if len(concrete_action.precondition.parts)>0:
            for pre in concrete_action.precondition.parts:
                args = list()
                for arg in pre.args:
                    args.append(param_to_obj[arg])
                pre.args = tuple(args)
                precondition.append(pre)
        else:
            pre = concrete_action.precondition
            args = list()
            for arg in pre.args:
                args.append(param_to_obj[arg])
            pre.args = tuple(args)
            precondition.append(pre)
        concrete_action.precondition = precondition
        return concrete_action

    def is_executable(self, state, action):
        precondition_literals = list()
        for atom in action.precondition:
            literal = self.parse_atom_to_literal(atom)
            if state.findLiteral(literal)==-1:
                return False
        return True

    def get_action_statepairset_dict(self, action_statepairset_dict, init_state, actions, num_obs):
        """
            computes a map of grounded actions to set of state and next state pairs
        """
        queue = list()
        queue.append(init_state)

        completed = False
        count = 0
        while len(queue)>0 and count<num_obs:
            state = queue.pop(0)
            for action in actions:
                if self.is_executable(state, action):  
                    next_state = self.apply_action(state, action)
                    action_name = action.name
                    if action_name not in action_statepairset_dict.keys():
                        action_statepairset_dict[action_name] = dict()
                    if action not in action_statepairset_dict[action_name].keys():
                        action_statepairset_dict[action_name][action] = set()
                    tup = tuple([state, next_state])
                    if tup not in action_statepairset_dict[action_name][action]:
                        action_statepairset_dict[action_name][action].add(tup)
                        queue.append(next_state)
                        count += 1
                if count==num_obs:
                    completed = True
                    break
            if completed:
                break
        return action_statepairset_dict
