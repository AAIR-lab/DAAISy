#! /usr/bin/env python
import glob, os, sys, copy, itertools, math, time
import pddl, pddl_parser
import fdtask_to_pddl
import numpy as np
import model_evaluator
import config

# **************************************#
# MAIN
# **************************************#

try:
    # print("Command: ", sys.argv)
    if "-s" in sys.argv:
        check_static_predicates = "-s "
        sys.argv.remove("-s")
    else:
        check_static_predicates = ""


    if "-t" in sys.argv:
        index = sys.argv.index("-t")
        trace_prefix = sys.argv[index+1]
        sys.argv.remove("-t")
        sys.argv.remove(trace_prefix)
    else:
        trace_prefix = "trace"

    if "-l" in sys.argv:
        index = sys.argv.index("-l")
        trace_min = int(sys.argv[index+1])
        trace_max = int(sys.argv[index+2])
        sys.argv.pop(index)
        sys.argv.pop(index)
        sys.argv.pop(index)
    else:
        trace_min = None

    if "-m" in sys.argv:
        index = sys.argv.index("-m")
        model_file = sys.argv[index+1]
        sys.argv.remove("-m")
        sys.argv.remove(model_file)
    else:
        model_file = "learned_domain.pddl"

    if "-c" in sys.argv:
        index = sys.argv.index("-c")
        cnt = int(sys.argv[index+1])
        sys.argv.pop(index)
        sys.argv.pop(index)
    else:
        cnt = 0

    domain_folder_name  = sys.argv[1]
    action_observability = sys.argv[2]
    state_observability = sys.argv[3]

    
except:
    print "Usage:"
    print sys.argv[0] + "[-s] <domain folder> <action observability (0-100)> <state observability (0-100)>"
    print("Error")
    sys.exit(-1)

try:
    os.stat(config.OUTPUT_PATH+"/models")
except:
    os.mkdir(config.OUTPUT_PATH+"/models")

LEARNED_DOMAIN_PATH = config.OUTPUT_PATH+"/learned_domain.pddl"
# outdir = "results/" + s + "-"+ d + "/"
# cmd = "mkdir " + outdir
# print("\n\nExecuting... " + cmd)
# os.system(cmd)

cmd = config.PROJECT_PATH + "/src/compiler_new.py " + check_static_predicates + domain_folder_name + " " + action_observability + " " + state_observability + " -ct " + str(cnt) + " -t " + trace_prefix + " -m " + model_file
if trace_min != None:
    cmd += " -l {} {}".format(trace_min, trace_max)
# print("\n\nExecuting... " + cmd)

tic = time.time()
os.system(cmd)
toc = time.time()

processing_time = toc - tic

# try:
# print(LEARNED_DOMAIN_PATH)
# print(domain_folder_name+"domain.pddl")
domain_name, best_evaluation, best_matches = model_evaluator.evaluate(config.OUTPUT_PATH+"/models/"+model_file,
                                                                              domain_folder_name+"/domain.pddl", True)
print(" , ".join(
[domain_name] + [str(cnt)] + [str(round(processing_time/cnt,2))]+ [str(round(e, 2)) for e in best_evaluation]) + ", {}".format(round(processing_time,2)))
# except:
#     print("No solution found")



sys.exit(0)
