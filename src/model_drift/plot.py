#!/usr/local/bin/python3
# encoding: utf-8

import csv
import os
import math
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from fileinput import filename
from collections import OrderedDict


def plot_1(results, file, title, x_axis_enforce_markings=True): 
    SMALL_SIZE = 9
    MEDIUM_SIZE = 35
    BIGGER_SIZE = 45
    plt.rc('font', size=MEDIUM_SIZE)          # controls default text sizes
    plt.rc('axes', titlesize=MEDIUM_SIZE)     # fontsize of the axes title
    plt.rc('axes', labelsize=MEDIUM_SIZE)     # fontsize of the x and y labels
    plt.rc('xtick', labelsize=MEDIUM_SIZE)    # fontsize of the tick labels
    plt.rc('ytick', labelsize=MEDIUM_SIZE)    # fontsize of the tick labels
    plt.rc('legend', fontsize=25)             # legend fontsize
    plt.rc('figure', titlesize=BIGGER_SIZE)
    plt.rc('font.sans-serif')

    fig, ax1 = plt.subplots(figsize=(12, 6.5))
    x = [i/int(results["domain_to_total_pals"]) for i in results["num_pals_incorrect"]]
  
    l1 = ax1.plot(x, results["queries_scratch"], color="1", label="Number of Queries by AIA")[0]
    l2 = ax1.plot(x, results["queries"], color="tab:blue", label="Number of Queries by DAAISy",linewidth=2.5)[0] #blue
    plt.fill_between(x, np.array(results["queries"])-np.array(results["queries_std_dev"]), np.array(results["queries"])+np.array(results["queries_std_dev"]), alpha = 0.20, color="tab:blue") #blue

    ax2 = ax1.twinx()
    l3 = ax2.plot(x, results["initial_model_accuracy"], color="tab:gray", label="Accuracy of initial model", linestyle="dashdot",linewidth=2.5)[0]   #gray
    l4 = ax2.plot(x, results["final_model_accuracy"], color="tab:green", label="Accuracy of model computed by DAAISy", linestyle="dashdot",linewidth=2.5)[0]   #green
    plt.fill_between(x, np.array(results["final_model_accuracy"])-np.array(results["acc_std_dev"]), np.array(results["final_model_accuracy"])+np.array(results["acc_std_dev"]), alpha = 0.20, color="tab:green") #green
    plt.fill_between(x, np.array(results["final_model_accuracy"]), np.array(results["initial_model_accuracy"]), alpha = 0.20, color="#884EA0")

    if x_axis_enforce_markings:
        plt.xticks(np.arange(0.0, 1.2, 0.2))
    plt.yticks(np.arange(0.0, 1.05, 0.2))

    plt.title(title[0].capitalize()+title[1:])
    plt.tight_layout()
    plt.savefig(file, bbox_inches='tight', pad_inches = 0)

def write_csv_results_increasing_observations(results, file):
    results_to_plot = dict()
    x = [int(float(key)) for key in results.keys()]
    results_to_plot["queries_scratch"] = [results[num_obs]['queries_scratch'][0] for num_obs in x]
    results_to_plot["queries"] = [results[num_obs]['queries'][0] for num_obs in x]
    results_to_plot["initial_model_accuracy"] = [results[num_obs]["initial_model_accuracy"][0] for num_obs in x]
    results_to_plot["final_model_accuracy"] = [results[num_obs]["final_model_accuracy"][0] for num_obs in x]
    results_to_plot["queries_std_dev"] = [results[num_obs]["queries_std_dev"][0] for num_obs in x]
    results_to_plot["acc_std_dev"] = [results[num_obs]["acc_std_dev"][0] for num_obs in x]

    csvfile = open(file+'.csv', 'w')  
    csvwriter = csv.writer(csvfile) 
    fields = ["num_obs", "queries_scratch", "queries", "initial_model_accuracy","final_model_accuracy","queries_std_dev","acc_std_dev"]
    csvwriter.writerow(fields) 
    rows = list(zip(x,results_to_plot["queries_scratch"],results_to_plot["queries"],results_to_plot["initial_model_accuracy"],results_to_plot["final_model_accuracy"],results_to_plot["queries_std_dev"],results_to_plot["acc_std_dev"]))
    for row in rows:
        csvwriter.writerow(row) 
    return x, results_to_plot

def read_csv_results_increasing_observations(csv_file):
    df = pd.read_csv(csv_file)
    results_to_plot = dict()
    x = df["num_obs"].to_list()
    results_to_plot["queries_scratch"] = df["queries_scratch"].to_list()
    results_to_plot["queries"] = df["queries"].to_list()
    results_to_plot["initial_model_accuracy"] = df["initial_model_accuracy"].to_list()
    results_to_plot["final_model_accuracy"] = df["final_model_accuracy"].to_list()
    results_to_plot["queries_std_dev"] = df["queries_std_dev"].to_list()
    results_to_plot["acc_std_dev"] = df["acc_std_dev"].to_list()
    return x, results_to_plot

def plot_for_increasing_observations(results, file_name, title): 
    SMALL_SIZE = 9
    MEDIUM_SIZE = 16
    BIGGER_SIZE = 18
    plt.rc('font', size=MEDIUM_SIZE)          # controls default text sizes
    plt.rc('axes', titlesize=MEDIUM_SIZE)     # fontsize of the axes title
    plt.rc('axes', labelsize=MEDIUM_SIZE)     # fontsize of the x and y labels
    plt.rc('xtick', labelsize=MEDIUM_SIZE)    # fontsize of the tick labels
    plt.rc('ytick', labelsize=MEDIUM_SIZE)    # fontsize of the tick labels
    plt.rc('legend', fontsize=20)             # legend fontsize
    plt.rc('figure', titlesize=BIGGER_SIZE)
    plt.rc('font.sans-serif')

    fig, ax1 = plt.subplots()
    if results==None:
        x, results_to_plot = read_csv_results_increasing_observations(file_name+".csv")
    else:
        x, results_to_plot = write_csv_results_increasing_observations(results, file_name+".csv")
  
    l1 = ax1.plot(x, results_to_plot["queries_scratch"], color="1", label="Number of Queries by AIA")[0]
    l2 = ax1.plot(x, results_to_plot["queries"], color="tab:blue", label="Number of Queries by DAAISy")[0] #blue
    plt.fill_between(x, np.array(results_to_plot["queries"])-np.array(results_to_plot["queries_std_dev"]), np.array(results_to_plot["queries"])+np.array(results_to_plot["queries_std_dev"]), alpha = 0.20, color="tab:blue") #blue

    ax2 = ax1.twinx()
    l3 = ax2.plot(x, results_to_plot["initial_model_accuracy"], color="tab:gray", label="Accuracy of initial model", linestyle="dashdot")[0]   #gray
    l4 = ax2.plot(x, results_to_plot["final_model_accuracy"], color="tab:green", label="Accuracy of model computed by DAAISy", linestyle="dashdot")[0]   #green
    plt.fill_between(x, np.array(results_to_plot["final_model_accuracy"])-np.array(results_to_plot["acc_std_dev"]), np.array(results_to_plot["final_model_accuracy"])+np.array(results_to_plot["acc_std_dev"]), alpha = 0.20, color="tab:green") #green
    plt.fill_between(x, np.array(results_to_plot["final_model_accuracy"]), np.array(results_to_plot["initial_model_accuracy"]), alpha = 0.20, color="#884EA0")
    plt.yticks(np.arange(0.0, 1.05, 0.1))

    plt.title(title[0].capitalize()+title[1:])
    plt.tight_layout()
    plt.savefig(file_name+".png", bbox_inches='tight', pad_inches = 0)

def plot_legend(results, file, title):
    SMALL_SIZE = 9
    MEDIUM_SIZE = 12
    BIGGER_SIZE = 18
    plt.rc('font', size=MEDIUM_SIZE)          # controls default text sizes
    plt.rc('axes', titlesize=MEDIUM_SIZE+2)   # fontsize of the axes title
    plt.rc('axes', labelsize=SMALL_SIZE)      # fontsize of the x and y labels
    plt.rc('xtick', labelsize=MEDIUM_SIZE)    # fontsize of the tick labels
    plt.rc('ytick', labelsize=MEDIUM_SIZE)    # fontsize of the tick labels
    plt.rc('legend', fontsize=12)             # legend fontsize
    plt.rc('figure', titlesize=BIGGER_SIZE)
    plt.rc('font.sans-serif')

    fig, ax1 = plt.subplots(figsize=(10,5))
    x = results["num_pals_incorrect"]
 
    l1 = ax1.plot(x, results["queries_scratch"], color="tab:red", label="Number of Queries by AIA")[0]
    l2 = ax1.plot(x, results["queries"], color="tab:blue", label="Number of Queries by DAAISy")[0]
    plt.fill_between(x, np.array(results["queries"])-np.array(results["queries_std_dev"]), np.array(results["queries"])+np.array(results["queries_std_dev"]), alpha = 0.20, color="tab:blue") #blue
    plt.xlabel("Amount of drift")
    plt.ylabel("Number of queries")

    ax2 = ax1.twinx()
    l3 = ax2.plot(x, results["initial_model_accuracy"], color="tab:gray", label="Accuracy of initial model", linestyle="dashdot")[0]   #gray
    l4 = ax2.plot(x, results["final_model_accuracy"], color="tab:green", label="Accuracy of model computed by DAAISy", linestyle="dashdot")[0]   #green
    plt.fill_between(x, np.array(results["final_model_accuracy"])-np.array(results["acc_std_dev"]), np.array(results["final_model_accuracy"])+np.array(results["acc_std_dev"]), alpha = 0.20, color="tab:green") #green
    l5 = plt.fill_between(x, np.array(results["final_model_accuracy"]), np.array(results["initial_model_accuracy"]), alpha = 0.20, color="#884EA0")
    plt.ylabel("Accuracy of model")

    lines = [l1, l2, l5, l3, l4]
    legends = ["Number of queries by AIA","Number of queries by DAAISy","Accuracy gained by DAAISy", "Accuracy of initial model", "Accuracy of model computed by DAAISy"] 
    plt.legend(lines, legends, bbox_to_anchor=(0.0, 1.0, 1.0, 1.0), loc=3, ncol=2, mode="expand", borderaxespad=0.5)
    plt.gca().set_axis_off()
    plt.tight_layout()
    plt.savefig(file)

def get_init_domain_files(domain_name, generate_init_domains_type, interval):
    init_domain_files = list()
    num_incorrect_pals_list = list()
    if generate_init_domains_type == 0:   
        interval = math.floor(domain_to_total_pals[domain_name]/num_pals)
        for i in range(1,domain_to_total_pals[domain_name],interval):
            num_incorrect_pals_list.append(i)
            for j in range(num_files_each_pal):
                init_domain_files.append("domain_"+str(i)+"_"+str(j)+".pddl")   
    elif generate_init_domains_type == 1:
        interval = 1
        for i in range(1,domain_to_total_pals_increased_applicability[domain_name], interval):
            num_incorrect_pals_list.append(i)
            for j in range(num_files_each_pal):
                # num_incorrect_pals_list.append(i)
                init_domain_files.append("domain_"+str(i)+"_"+str(j)+".pddl")   
    else:
        for i in range(1,domain_to_total_pals[domain_name],interval):
            num_incorrect_pals_list.append(i)
            if i < domain_to_total_pals_increased_applicability[domain_name]:
                for j in range(int(num_files_each_pal/2)):
                    init_domain_files.append("domain_"+str(i)+"_"+str(j)+".pddl")   
                for j in range(int(num_files_each_pal/2),int(num_files_each_pal)):
                    init_domain_files.append("domain_"+str(i)+"_"+str(j)+".pddl")   
                last_reduced_capability_num_dropped_pals = i
            else:
                for j in range(num_files_each_pal):
                    init_domain_files.append("domain_"+str(i)+"_"+str(j)+".pddl")   
    return num_incorrect_pals_list

def read_for_reduced(df, domain_to_total_pals, domain_name, num_incorrect_pals_list, n, num_files_each_pal):
    final_results = dict()
    final_results["num_pals_incorrect"] = list()
    final_results["initial_model_accuracy"] = list()
    final_results["final_model_accuracy_inc"] = list()
    final_results["final_model_accuracy_red"] = list()
    final_results["queries_scratch"] = list()
    final_results["queries"] = list()

    results = dict()
    results["initial_accuracy"] = df["InitAccuracy"].tolist()[:n*num_files_each_pal]
    results["final_avg_accuracy"] = df["FinalAccuracy"].tolist()[:n*num_files_each_pal]
    results["queries_scratch"] = df["#UniqueQueriesAIA"].tolist()[:n]
    results["queries"] = df["Final#UniqueQueries"].tolist()[:n*num_files_each_pal]
    
    final_results["domain_to_total_pals"] = domain_to_total_pals[domain_name]
    final_results["num_pals_incorrect"] = num_incorrect_pals_list[:n]
    i = 0
    for k in range(len(num_incorrect_pals_list[:n])):
        final_results["initial_model_accuracy"].append(np.sum(results["initial_accuracy"][i:i+num_files_each_pal])/num_files_each_pal)
        final_results["final_model_accuracy_inc"].append(np.sum(results["final_avg_accuracy"][i:i+int(num_files_each_pal/2)])/(num_files_each_pal/2))
        final_results["final_model_accuracy_red"].append(np.sum(results["final_avg_accuracy"][i+int(num_files_each_pal/2):i+num_files_each_pal])/(num_files_each_pal/2))
        final_results["queries_scratch"] = results["queries_scratch"]
        final_results["queries"].append(np.sum(results["queries"][i:i+num_files_each_pal])/num_files_each_pal)
        i += num_files_each_pal
    return final_results

def read(df, npals, domain_name, num_incorrect_pals_list, num_files_each_pal):
    final_results = dict()
    final_results["num_pals_incorrect"] = list()
    final_results["initial_model_accuracy"] = list()
    final_results["final_model_accuracy"] = list()
    final_results["acc_std_dev"] = list()
    final_results["queries_std_dev"] = list()
    final_results["queries_scratch"] = list()
    final_results["queries"] = list()

    results = dict()
    results["initial_accuracy"] = df["InitAccuracy"].tolist()
    results["final_avg_accuracy"] = df["FinalAccuracy"].tolist()
    results["queries_scratch"] = df["#UniqueQueriesAIA"].tolist()
    results["queries"] = df["Final#UniqueQueries"].tolist()
    
    final_results["domain_to_total_pals"] = npals
    final_results["num_pals_incorrect"] = num_incorrect_pals_list
    i = 0
    for k in range(len(num_incorrect_pals_list)):
        final_results["initial_model_accuracy"].append(np.sum(results["initial_accuracy"][i:i+num_files_each_pal])/num_files_each_pal)
        final_results["final_model_accuracy"].append(np.sum(results["final_avg_accuracy"][i:i+int(num_files_each_pal)])/(num_files_each_pal))
        final_results["acc_std_dev"].append(np.std(results["final_avg_accuracy"][i:i+int(num_files_each_pal)]))
        final_results["queries_scratch"].append(results["queries_scratch"][i:i+num_files_each_pal][0])
        final_results["queries"].append(np.sum(results["queries"][i:i+num_files_each_pal])/num_files_each_pal)
        final_results["queries_std_dev"].append(np.std(results["queries"][i:i+num_files_each_pal])/num_files_each_pal)
        i += num_files_each_pal
    return final_results

if __name__=="__main__":
    domains = ["satellite","rovers","blocksworld","miconic","gripper","termes"]
    filename = {"satellite":"satellite1643143805.6418498_0",\
            "rovers": "rovers1643142163.6327097_0",\
            "blocksworld": "blocksworld1643134731.9598577_0",\
            "miconic": "miconic1643139738.103667_0",\
            "gripper": "gripper1643137067.3590012_0",\
            "termes": "termes1643148544.1542282_0"}

    for domain_name in domains:
        name = filename[domain_name]
        generate_init_domains_type = int(name.split("_")[1])

        csv_file = os.getcwd()+"/results/"+str(domain_name)+"/"+name
        domain_to_total_pals = {'blocksworld': 52, 'gripper': 20, 'miconic': 36, 'satellite': 50, 'parking': 72, 'rovers': 402, 'termes':134}
        # domain_to_total_pals_increased_applicability = {'blocksworld': 14, 'gripper':7, 'miconic':8, 'satellite': 13, 'rovers':43, 'parking':19, 'termes':33} #len(PAL_list_increased_applicability)-len(actions)
        domain_to_total_pals_increased_applicability = {'blocksworld': 5, 'gripper':3, 'miconic':5, 'satellite': 9, 'rovers':36, 'parking':19, 'termes':26, 'freecell':81, 'logistics':25} #len(PAL_list_increased_applicability)-len(actions)
        domains_mix_intervals = {'blocksworld': 2, 'gripper':1, 'miconic':1, 'satellite': 2, 'rovers':4, 'parking':2, 'termes':4}
        npals = domain_to_total_pals[domain_name]
        domain_to_num_sas = {'blocksworld': 10, 'gripper':10, 'miconic':10, 'satellite': 10, 'rovers':10, 'termes':10}
        domain_to_num_files_each_pal = {"blocksworld":6,"gripper":6,"miconic":6,"satellite":6,"rovers":6,"termes":2} # 6 for all, 2 for freecell and termes

        num_files_each_pal = domain_to_num_files_each_pal[domain_name]
        num_pals = 20
        n = 15
        plot_for_reduced = False

        num_incorrect_pals_list = get_init_domain_files(domain_name, generate_init_domains_type, domains_mix_intervals[domain_name])

        if domain_name in ['satellite','parking','rovers','termes']:
            fields = ["init_domain", "#TotalPALs", "(#)InitPALsIncorrect", "(#)PAsDropped", "(#)PALsDropped_noObs", "(#)FinalAvgPALsIncorrect", \
            "#TotalActions","(#)InitActionsIncorrect","(#)ActionsObserved", "(#)CompleteActionsDropped","(#)FinalActionsIncorrect", \
            "InitAccuracy", "FinalAccuracy", "#UniqueQueriesAIA", "Final#UniqueQueries", "#ValidModels"]
        
        if domain_name in ["blocksworld","miconic"]:
            fields = ["init_domain", "#TotalPALs", "(#)InitPALsIncorrect", "(#)PAsDropped", "(#)PALsDropped_noObs", "(#)FinalAvgPALsIncorrect", \
            "#TotalActions","(#)InitActionsIncorrect","(#)ActionsObserved", "(#)MarkedChangedActions","(#)FinalActionsIncorrect", \
            "InitAccuracy", "FinalAccuracy", "#UniqueQueriesAIA", "Final#UniqueQueries", "#ValidModels"]
            
        if domain_name in ["gripper"]:
            fields = ["init_domain", "#TotalPALs", "(#)InitPALsIncorrect",  "(#)PALsDropped_noObs", "(#)FinalAvgPALsIncorrect", \
                "#TotalActions","(#)InitActionsIncorrect","(#)ActionsObserved", "(#)MarkedChangedActions","(#)FinalActionsIncorrect", \
                "InitAccuracy", "FinalAccuracy", "#UniqueQueriesAIA", "Final#UniqueQueries", "#ValidModels"]

        fields = ["init_domain", "#TotalPALs", "(#)InitPALsIncorrect", "(#)PAsDropped", "(#)PALsDropped_noObs", "(#)FinalAvgPALsIncorrect", \
            "#TotalActions","(#)InitActionsIncorrect","(#)ActionsObserved", "(#)CompleteActionsDropped","(#)FinalActionsIncorrect", \
            "InitAccuracy", "FinalAccuracy", "#UniqueQueriesAIA", "Final#UniqueQueries", "#ValidModels"]
        
        df = pd.read_csv(csv_file+".csv", usecols=fields)
        if plot_for_reduced==False:
            final_results = read(df, npals, domain_name, num_incorrect_pals_list, num_files_each_pal) 
        else:
            final_results = read_for_reduced(df, domain_to_total_pals, domain_name, num_incorrect_pals_list, n, num_files_each_pal)
        
        final_results["domain_to_total_pals"] = domain_to_total_pals[domain_name]
        x_axis_enforce_markings = True
        if generate_init_domains_type==1:
            x_axis_enforce_markings = False
        plot_1(final_results, csv_file+".png", domain_name[0].capitalize()+domain_name[1:]+" (#Pals = "+str(domain_to_total_pals[domain_name])+")",x_axis_enforce_markings)
