#!/usr/local/bin/python3
# encoding: utf-8

import random
import copy
import math
import time
from itertools import product
import sys
from src.config import *
from src.utils.translate import pddl_parser
import config

seed = int(time.time())
random.seed(seed)
print("Using {} as random seed..".format(seed))

INFO_STRING = ""

def parse_pre(pre):
    """
        parses action pre to predicate list string
    """
    # TO DO: negative precond
    string = ""
    if pre.parts:
        for atom in pre.parts:
            string += "("+atom.predicate
            string_ = ""
            for key in atom.key[1:]:
                key = str(key)
                key = key.replace("(","")
                key = key.replace(")","")
                key = key.replace(",","")
                key = key.replace("'","")
                string_ += key
            if string_!="":
                string += " "
            string += string_
            string += ")\n\t\t"    
    else:
        string += "("+pre.predicate
        string_ = ""
        for key in pre.key[1:]:
            key = str(key)
            key = key.replace("(","")
            key = key.replace(")","")
            key = key.replace(",","")
            key = key.replace("'","")
            string_ += key
        if string_!="":
            string += " "
        string += string_
        string += ")\n\t\t"  
    return string

def parse_eff(eff_list):
    """
        parses action eff to predicate list string
    """
    string = ""
    for eff in eff_list:
        negated = eff.literal.negated
        if negated:
            string += "(not "
        string += "("
        string += eff.literal.predicate
        string_ = ""
        for key in eff.literal.key[1:]:
            key = str(key)
            key = key.replace("(","")
            key = key.replace(")","")
            key = key.replace(",","")
            key = key.replace("'","")
            string_ += key
        if string_!="":
            string += " "
        string += string_+")"
        if negated:
            string += ")"   
        string += "\n\t\t"
    return string

def find_relevant_predicates_for_action(action, predicates):
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

def get_all_predicate_args(action, predicates):
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

def parse_domain(domain_path):
    fd_domain = pddl_parser.pddl_file.parse_pddl_file("domain", domain_path)
    domain_name, domain_requirements, types, type_dict, constants, \
        predicates, predicate_dict, functions, actions, axioms = pddl_parser.parsing_functions.parse_domain_pddl(fd_domain)

    action_relevant_predicates = dict()
    action_relevant_predicates_args = dict()
    PAL_list = list()
    action_to_PALs = dict()
    num_total_pals = 0
    for action in actions:
        action_relevant_predicates[action] = find_relevant_predicates_for_action(action, predicates)
        action_relevant_predicates_args[action] = get_all_predicate_args(action, action_relevant_predicates[action])
        num_total_pals += len(action_relevant_predicates_args[action])*2 
        for predicate in action_relevant_predicates_args[action]:
            PAL_list.append((predicate, action.name, Location.PRECOND))
            PAL_list.append((predicate, action.name, Location.EFFECTS))
            if action not in action_to_PALs:
                action_to_PALs[action] = list()
            action_to_PALs[action].append((predicate, action.name, Location.PRECOND))
            action_to_PALs[action].append((predicate, action.name, Location.EFFECTS))

    action_to_pre_eff_string = dict()
    PA_to_ModeTuple_dict = dict()
    for action in actions:
        action_to_pre_eff_string[action.name] = dict()
        action_to_pre_eff_string[action.name]["pre"] = parse_pre(action.precondition)
        action_to_pre_eff_string[action.name]["eff"] = parse_eff(action.effects)
        for PAL in action_to_PALs[action]:
            if "(not "+PAL[0]+")" in action_to_pre_eff_string[action.name]["pre"]:
                pre = Literal.NEG
            elif PAL[0] in action_to_pre_eff_string[action.name]["pre"]:
                pre = Literal.POS
            else:
                pre = Literal.ABS
            if "(not "+PAL[0]+")" in action_to_pre_eff_string[action.name]["eff"]:
                eff = Literal.NEG
            elif PAL[0] in action_to_pre_eff_string[action.name]["eff"]:
                eff = Literal.POS
            else:
                eff = Literal.ABS
            PA_to_ModeTuple_dict[(PAL[0],PAL[1])] = (pre, eff)

    # Add pal-tuples if pre mode is +/-
    PAL_list_increased_applicability = list()
    for PAL in PAL_list:
        if PAL[2]==Location.PRECOND:
            mode_tuple = PA_to_ModeTuple_dict[(PAL[0],PAL[1])]
            if mode_tuple[0]==Literal.POS or mode_tuple[0]==Literal.NEG:
                PAL_list_increased_applicability.append(PAL)
        # else:
        #     mode_tuple = PA_to_ModeTuple_dict[(PAL[0],PAL[1])]
        #     if mode_tuple[1]==Literal.NEG:
        #         PAL_list_increased_applicability.append(PAL)
    num_total_pals_increased_applicability = len(PAL_list_increased_applicability)-len(actions)
    return actions, predicates, PAL_list, PAL_list_increased_applicability, PA_to_ModeTuple_dict, num_total_pals, num_total_pals_increased_applicability, action_relevant_predicates_args

def get_INFO_STRING(sampled_PALs, num_incorrect_pals):
    action_to_PAL_changed = dict()
    INFO_STRING = "\n"
    for PAL in sampled_PALs:
        predicate = PAL[0]
        action = PAL[1]
        if action not in action_to_PAL_changed:
            action_to_PAL_changed[action] = list()
        action_to_PAL_changed[action].append(PAL)
    for action_name, PALs in action_to_PAL_changed.items():
        INFO_STRING += ";; "+str(action_name)+" action has changed: "
        for PAL in PALs:
            INFO_STRING += str(PAL[0])+", "
        INFO_STRING += "\n"
    return INFO_STRING

def get_random_model(actions, predicates, PAL_list, PA_to_ModeTuple_dict, count):
    """
    randomly samples a pal-tuple (location could be precondition or effect) and 
    changes its mode ensuring that (+,+) and (-,-) are not possible (pre,eff) modes.
    This is ensured for pal-tuples with l=pre by selecting - or ABS in pre if eff is +, and 
    selecting + or ABS in pre if eff is - and similarly for pal-tuples with l=eff.
    """
    sampled = random.sample(PAL_list, count)
    empty_flag = False

    list_ = list()
    new_PA_to_ModeTuple_dict = copy.deepcopy(PA_to_ModeTuple_dict)
    for PAL in PAL_list:
        if PAL in sampled:
            possibilities = [Literal.POS, Literal.NEG, Literal.ABS]
            current_pre_mode = new_PA_to_ModeTuple_dict[(PAL[0],PAL[1])][0]
            current_eff_mode = new_PA_to_ModeTuple_dict[(PAL[0],PAL[1])][1]
            if PAL[2]==Location.PRECOND:
                possibilities.remove(current_pre_mode)
                if current_eff_mode in [Literal.POS,Literal.NEG]:
                    if current_eff_mode in possibilities:
                        possibilities.remove(current_eff_mode)
                selected_mode = random.choice(possibilities)
                new_PA_to_ModeTuple_dict[(PAL[0],PAL[1])] = (selected_mode, current_eff_mode)
            else:
                possibilities.remove(current_eff_mode)
                if current_pre_mode in [Literal.POS,Literal.NEG]:
                    if current_pre_mode in possibilities:
                        possibilities.remove(current_pre_mode)
                selected_mode = random.choice(possibilities)
                new_PA_to_ModeTuple_dict[(PAL[0],PAL[1])] = (current_pre_mode, selected_mode)

    new_action_to_pre_eff_string = dict()
    for PA, ModeTuple in new_PA_to_ModeTuple_dict.items():
        pre_predicate_string = ""
        eff_predicate_string = ""
        if ModeTuple[0]==Literal.POS:
            pre_predicate_string += PA[0]+"\n\t\t\t"
        elif ModeTuple[0]==Literal.NEG:
            pre_predicate_string += "(not "+PA[0]+")\n\t\t\t"
        if ModeTuple[1]==Literal.POS:
            eff_predicate_string += PA[0]+"\n\t\t\t"
        elif ModeTuple[1]==Literal.NEG:
            eff_predicate_string += "(not "+PA[0]+")\n\t\t\t"
        if PA[1] not in new_action_to_pre_eff_string:
            new_action_to_pre_eff_string[PA[1]] = dict()
            new_action_to_pre_eff_string[PA[1]]["pre"] = ""
            new_action_to_pre_eff_string[PA[1]]["eff"] = ""
        new_action_to_pre_eff_string[PA[1]]["pre"] += pre_predicate_string
        new_action_to_pre_eff_string[PA[1]]["eff"] += eff_predicate_string
    for action_name, predicate_string_dict in new_action_to_pre_eff_string.items():
        if predicate_string_dict["pre"]=="" or predicate_string_dict["eff"]=="":
            empty_flag = True
            break
    return new_action_to_pre_eff_string, new_PA_to_ModeTuple_dict, sampled, empty_flag

def get_random_increased_applicability_model(actions, predicates, PAL_list, PA_to_ModeTuple_dict, PAL_list_pre_present, count):
    """
    i.e. when drifted model's functionality has reduced/init model has increased applicability.
    changes mode of the sampled pal-tuples (l=pre) with +/- mode to ABS and 
    sampled pal-tuples (l=eff) with mode - to ABS.
    """
    sampled = random.sample(PAL_list_pre_present, count)
    empty_flag = False

    list_ = list()
    new_PA_to_ModeTuple_dict = copy.deepcopy(PA_to_ModeTuple_dict)
    for PAL in PAL_list:
        if PAL in sampled:
            current_pre_mode = new_PA_to_ModeTuple_dict[(PAL[0],PAL[1])][0]
            current_eff_mode = new_PA_to_ModeTuple_dict[(PAL[0],PAL[1])][1]
            if PAL[2]==Location.PRECOND:
                selected_mode = Literal.ABS
                new_PA_to_ModeTuple_dict[(PAL[0],PAL[1])] = (selected_mode, current_eff_mode)
            else:
                selected_mode = Literal.ABS
                new_PA_to_ModeTuple_dict[(PAL[0],PAL[1])] = (current_pre_mode, selected_mode)

    new_action_to_pre_eff_string = dict()
    for PA, ModeTuple in new_PA_to_ModeTuple_dict.items():
        pre_predicate_string = ""
        eff_predicate_string = ""
        if ModeTuple[0]==Literal.POS:
            pre_predicate_string += PA[0]+"\n\t\t\t"
        elif ModeTuple[0]==Literal.NEG:
            pre_predicate_string += "(not "+PA[0]+")\n\t\t\t"
        if ModeTuple[1]==Literal.POS:
            eff_predicate_string += PA[0]+"\n\t\t\t"
        elif ModeTuple[1]==Literal.NEG:
            eff_predicate_string += "(not "+PA[0]+")\n\t\t\t"
        if PA[1] not in new_action_to_pre_eff_string:
            new_action_to_pre_eff_string[PA[1]] = dict()
            new_action_to_pre_eff_string[PA[1]]["pre"] = ""
            new_action_to_pre_eff_string[PA[1]]["eff"] = ""
        new_action_to_pre_eff_string[PA[1]]["pre"] += pre_predicate_string
        new_action_to_pre_eff_string[PA[1]]["eff"] += eff_predicate_string
    for action_name, predicate_string_dict in new_action_to_pre_eff_string.items():
        if predicate_string_dict["pre"]=="" or predicate_string_dict["eff"]=="":
            empty_flag = True
            break
    return new_action_to_pre_eff_string, new_PA_to_ModeTuple_dict, sampled, empty_flag

def initialize_dirs(init_domains_random_dir, init_domains_increased_applicability_dir, init_domains_both_dir, domain_to_total_pals, domain_name, generate_init_domains_type, num_pals, num_files_each_pal, interval):
    init_domain_files = list()
    num_incorrect_pals_list = list()
    flag_init_domains_type_list = list()
    last_reduced_capability_num_dropped_pals = None
    if generate_init_domains_type == 0:
        if not os.path.exists(init_domains_random_dir):
            os.mkdir(init_domains_random_dir)    
        interval = math.floor(domain_to_total_pals[domain_name]/num_pals)
        for i in range(1,domain_to_total_pals[domain_name],interval):
            for j in range(num_files_each_pal):
                num_incorrect_pals_list.append(i)
                init_domain_files.append(init_domains_random_dir+"domain_"+str(i)+"_"+str(j)+".pddl")   
                flag_init_domains_type_list.append(flag_init_domains_type)
    elif generate_init_domains_type == 1:
        if not os.path.exists(init_domains_increased_applicability_dir):
            os.mkdir(init_domains_increased_applicability_dir)
        interval = 1
        for i in range(1,domain_to_total_pals_increased_applicability[domain_name], interval):
            for j in range(num_files_each_pal):
                num_incorrect_pals_list.append(i)
                init_domain_files.append(init_domains_increased_applicability_dir+"domain_"+str(i)+"_"+str(j)+".pddl")   
                flag_init_domains_type_list.append(flag_init_domains_type)
    else:
        if not os.path.exists(init_domains_both_dir):
            os.mkdir(init_domains_both_dir)
        for i in range(1,domain_to_total_pals[domain_name],interval):
            if i < domain_to_total_pals_increased_applicability[domain_name]:
                for j in range(int(num_files_each_pal/2)):
                    num_incorrect_pals_list.append(i)
                    init_domain_files.append(init_domains_both_dir+"domain_"+str(i)+"_"+str(j)+".pddl")   
                    flag_init_domains_type_list.append(0)
                for j in range(int(num_files_each_pal/2),int(num_files_each_pal)):
                    num_incorrect_pals_list.append(i)
                    init_domain_files.append(init_domains_both_dir+"domain_"+str(i)+"_"+str(j)+".pddl")   
                    flag_init_domains_type_list.append(1)
                last_reduced_capability_num_dropped_pals = i
            else:
                for j in range(num_files_each_pal):
                    num_incorrect_pals_list.append(i)
                    init_domain_files.append(init_domains_both_dir+"domain_"+str(i)+"_"+str(j)+".pddl")   
                    flag_init_domains_type_list.append(0)
    return init_domain_files, num_incorrect_pals_list, flag_init_domains_type_list, last_reduced_capability_num_dropped_pals

if __name__=="__main__":
    '''
        Generates init domains with domainname_#PALsdropped_#file.pddl filename format
    '''
    domains = config.domains
    flag_init_domains_type_dict = config.flag_init_domains_type_dict
    flag_init_domains_type = config.flag_init_domains_type
    num_affected_pals = config.num_affected_pals
    domain_to_num_files_each_pal = config.domain_to_num_files_each_pal
    domain_to_total_pals = config.domain_to_total_pals
    domain_to_total_pals_increased_applicability = config.domain_to_total_pals_increased_applicability
    domains_mix_intervals = config.domains_mix_intervals

    for domain_name in domains:
        num_files_each_pal = domain_to_num_files_each_pal[domain_name]
        init_domains_random_dir = "domains/"+domain_name+"/domains/init_domains_random/"
        init_domains_increased_applicability_dir = "domains/"+domain_name+"/domains/init_domains_increased_applicability/"
        init_domains_both_dir = "domains/"+domain_name+"/domains/init_domains_mix/"
        domain_path = "domains/"+domain_name+"/domains/domain.pddl"
        domain_template_path = "domains/"+domain_name+"/domains/domain_template.pddl"  
        problem_path = "domains/"+domain_name+"/instances/instances/instance-1.pddl"
     
        actions, predicates, PAL_list, PAL_list_increased_applicability, PA_to_ModeTuple_dict, \
            num_total_pals, num_total_pals_increased_applicability, _ = parse_domain(domain_path) # parse IPC domain
        domain_to_total_pals[domain_name] = num_total_pals
        domain_to_total_pals_increased_applicability[domain_name] = num_total_pals_increased_applicability
        
        init_domain_files, num_incorrect_pals_list, flag_init_domains_type_list, last_reduced_capability_num_dropped_pals = initialize_dirs(init_domains_random_dir, init_domains_increased_applicability_dir, init_domains_both_dir, domain_to_total_pals, domain_name, flag_init_domains_type, num_affected_pals, num_files_each_pal, domains_mix_intervals[domain_name])
        print(init_domain_files)
        for i in range(len(init_domain_files)):  
            init_domain_file = init_domain_files[i]   
            num_incorrect_pals = num_incorrect_pals_list[i]
            flag_init_domains_type_ = flag_init_domains_type_list[i]
            print("Generating ",flag_init_domains_type_dict[flag_init_domains_type_])
            print("\nInit domain file: "+init_domain_file)
            print("Num incorrect PALs:",num_incorrect_pals)
 
            empty_flag = True
            while empty_flag:
                if flag_init_domains_type_ == 0:
                    new_action_to_pre_eff_string, new_PA_to_ModeTuple_dict, sampled_PALs, empty_flag = get_random_model(actions, predicates, PAL_list, PA_to_ModeTuple_dict, num_incorrect_pals)
                elif flag_init_domains_type_ == 1:
                    new_action_to_pre_eff_string, new_PA_to_ModeTuple_dict, sampled_PALs, empty_flag = get_random_increased_applicability_model(actions, predicates, PAL_list, PA_to_ModeTuple_dict, PAL_list_increased_applicability, num_incorrect_pals)

            INFO_STRING = get_INFO_STRING(sampled_PALs, num_incorrect_pals)
            INFO_STRING += ";; Last_reduced_capability_num_dropped_pals: "+str(last_reduced_capability_num_dropped_pals)+"\n"
            with open(domain_template_path, 'r') as f:
                template_domain_string = f.read()
            for action_name in new_action_to_pre_eff_string.keys():
                pre = "%"+action_name.upper()+" PRECONDITION%"
                eff = "%"+action_name.upper()+" EFFECTS%"
                template_domain_string = template_domain_string.replace(pre, new_action_to_pre_eff_string[action_name]["pre"])
                template_domain_string = template_domain_string.replace(eff, new_action_to_pre_eff_string[action_name]["eff"])  
            template_domain_string = template_domain_string.replace("%INFO_STRING%", INFO_STRING)  
            with open(init_domain_file, "w") as f:
                f.write(template_domain_string)

    for domain_name in domain_to_total_pals.keys():
        print("\nDomain:",domain_name)
        print("Total #PALs in IPC domain:",domain_to_total_pals[domain_name])
        print("Total #PALs that can be dropped from preconditions to generate increased applicability init domains:",domain_to_total_pals_increased_applicability[domain_name])