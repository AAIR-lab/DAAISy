#!/usr/local/bin/python3
# encoding: utf-8

import os
from enum import Enum, IntEnum

domains = ["blocksworld", "logistics", "parking", "satellite", "barman",
           "gripper", "miconic", "rovers", "termes", "freecell"]

domain_dir_gym = "../dependencies/pddlgym/pddl/"

VERBOSE = False

base_dir = os.getcwd()+"/"
domain_name = "temp_domain"

final_result_dir = base_dir+"results/temp/"
final_result_prefix = "final_result_aaai21"

TEMP_FOLDER = final_result_dir+"temp_files/"

Q_DOMAIN_FILE = TEMP_FOLDER+"querymodel_domain.pddl"
Q_PROBLEM_FILE = TEMP_FOLDER+"querymodel_problem.pddl"
Q_PLAN_FILE = TEMP_FOLDER+"querymodel_plan.pddl"
Q_RESULT_FILE = TEMP_FOLDER+"res.txt"
ALL_ACTION_FILE = TEMP_FOLDER+"action_list.txt"
temp_plan_file = TEMP_FOLDER+"querymodel_temp_plan.pddl"

init_state_count = 1
save_random_states = True

VAL_PATH = base_dir+"dependencies/VAL/validate"
FF_PATH = base_dir+"dependencies/FF/"
FD_PATH = base_dir+"dependencies/FD/"

# Set FF for ffPlanner
# Set FD for fdPlanner
PLANNER = "FF"

NUM_PER_DOMAIN = 10


class Location(IntEnum):
    PRECOND = 1
    EFFECTS = 2
    ALL = 3


class Literal(Enum):
    AN = -2
    NEG = -1
    ABS = 0
    POS = 1
    AP = 2
    NP = 3


num_random_states = 20
num_additional_states = 20

ignore_list = [[Literal.NEG, Literal.NEG], [Literal.POS, Literal.POS]]

pal_tuples_finalized = []
abs_actions_test = dict()
abs_preds_test = dict()


GEN_RESULT_FILE = TEMP_FOLDER + "gen_res.txt"
GEN_PLAN_FILE = TEMP_FOLDER + "gen_res.plan"
GEN_VAL_FILE = TEMP_FOLDER + "gen_res.val"
RANDOM_STATE_FOLDER = base_dir+"random_states/"
STORED_STATES_COUNT = 60
