#!/usr/local/bin/python3
# encoding: utf-8

import copy

from src.config import *


def state_to_set(state):
    """
        set representation of state: {'above|f0|f1', 'lift_at|f0'} 
    """
    state_set = []
    for p, v in state.items():
        if isinstance(v, (list, tuple)) and len(v) > 0:
            for i in range(0, len(v)):
                items = v[i]
                t_init_state = p
                if isinstance(items, str):
                    t_init_state += "|" + items
                else:
                    for _i in items:
                        t_init_state += "|" + _i
                state_set.append(t_init_state)
        else:
            state_set.append(p)
    return set(state_set)


def set_to_state(state_set):
    """
        state representation: {'destin': [(...)], 'lift_at': [(...), (...)]}
    """
    state = {}
    for p in state_set:
        pred_params = (p.split("|")[1:])
        pred_name = p.split("|")[0]
        if pred_name in state.keys():
            state[pred_name].append(tuple(pred_params))
        else:
            state[pred_name] = [tuple(pred_params), ]
    return state


def union_states(state1, state2):
    joint_state = copy.deepcopy(state1)
    for key, val in state2.items():
        if key not in joint_state.keys():
            joint_state[key] = val
        else:
            for v in val:
                if v not in joint_state[key]:
                    joint_state[key].append(v)

    return joint_state


def map_pred_action_param(pred, action):
    """
    :param pred: Pred in format ontable|c
    :param action: Action in format pickup|c
    :return: pred in format ontable|0
    """
    action_name = action.split("|")[0]
    action_params = action.split('|')[1:]
    pred_params = pred.split("|")[1:]
    pred_name = pred.split("|")[0]
    for param in pred_params:
        if param in action_params:
            indx = action_params.index(param)
            if indx != -1:
                pred_name += "|" + str(indx)
        else:
            return None, None

    if pred.count("|") != pred_name.count("|"):
        return None, None

    return action_name, pred_name


def instantiate_pred_with_action(pred, action):
    """
    :param pred: Pred in format ontable|0
    :param action: Action in format pickup|c
    :return: pred in format ontable|c
    """
    action_params = action.split('|')[1:]
    pred_params = pred.split("|")[1:]
    pred_name = pred.split("|")[0]
    for param in pred_params:
        try:
            if int(param) < len(action_params):
                pred_name += "|" + str(action_params[int(param)])
            else:
                return None
        except IndexError:
            return None
        except TypeError:
            return None
    return pred_name


def get_model_difference(model1, model2, pal_tuple_dict):
    # model1 is agent model
    diff = 0
    diff_set = set()
    for action in model1.actions:
        for pred in model1.actions[action].keys():
            for loc in [Location.PRECOND, Location.EFFECTS]:
                try:
                    if not pal_tuple_dict[(action, pred, loc)]:
                        # print("Not learnt PALM: ", action, pred, loc)
                        diff_set.add((action, pred, loc))
                        diff += 1
                    elif model1.actions[action][pred][loc - 1] != model2.actions[action][pred][loc - 1]: #LOCATION.PRECOND = 1 therefore loc-1 is used to use the right index
                        diff += 1
                        # print("Incorrect PALM: ", action, pred, loc)
                        diff_set.add((action, pred, loc))
                        # print("In Agent: ", model1.actions[action][pred][loc - 1])
                        # print("In Model: ", model2.actions[action][pred][loc - 1])
                        # print("")
                except:
                    print("Here")

    print("\n Incorrect PALM:")
    for tup in diff_set:
        print(tup)
    return diff / len(pal_tuple_dict)


def get_next_predicate(all_predicates, abs_predicates):
    new_preds = set(all_predicates) - set(abs_predicates)
    if len(new_preds) == 0:
        return None
    else:
        return new_preds.pop()
