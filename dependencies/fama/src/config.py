#! /usr/bin/env python2
import os 

DOMAIN = "blocks_rash"
ROOT_PATH = os.getcwd()+"/dependencies/"
PROJECT_PATH = ROOT_PATH+"fama"

COUNTER = 140

OUTPUT_PATH = PROJECT_PATH + "/output/" + DOMAIN
PROBLEM_DIR = "/tests"
PLAN_DIR = "/plans"
OBSERVATIONS_DIR = "/observations"
VAL_PATH = ROOT_PATH + "VAL"
VAL_OUT=OUTPUT_PATH+"/val.log"

# PLANNER_PATH = PROJECT_PATH + "/util/FF-v2.3"
# PLANNER_NAME = "ff"
# OUTPUT_FILENAME = OUTPUT_PATH+"/sas_plan"
# PLANNER_PARAMS = "-S 1 -Q -o "+OUTPUT_FILENAME

PLANNER_PATH = ROOT_PATH + "madagascar"
PLANNER_NAME = "M"
OUTPUT_FILENAME = OUTPUT_PATH+"/sas_plan"
PLANNER_PARAMS = "-S 1 -Q -o "+OUTPUT_FILENAME

# PLANNER_PATH = ROOT_PATH + "/downward"
# PLANNER_NAME = "fast-downward.py"
# OUTPUT_FILENAME = OUTPUT_PATH+"/sas_plan"
# PLANNER_PARAMS = " --alias seq-sat-lama-2011 "+OUTPUT_FILENAME

# Diferent compiler modes
INPUT_PLANS = 0
INPUT_STEPS = 1
INPUT_LENPLAN = 2
INPUT_MINIMUM = 3

