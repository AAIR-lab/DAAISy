#!/usr/local/bin/python3
# encoding: utf-8

import copy
import importlib

from src.config import *
from src.query import ExecutePlan
from src.lattice import Model
from src.utils import state_to_set


class Agent:
    def __init__(self, domain, pred_type_mapping, agent_model_actions):
        self.agent_model = Model(pred_type_mapping, agent_model_actions)

        self.agent_model.print_model()

    def run_query(self, query, pal_tuple_dict, partial_check=False):
        """
        :param query:
        :param pal_tuple_dict:
        :return:
        """

        plan = ExecutePlan(self.agent_model, query['init_state'].state, query['plan'])
        is_executable_agent, possible_state, failure_index = plan.execute_plan(pal_tuple_dict)
        return is_executable_agent, failure_index, possible_state

