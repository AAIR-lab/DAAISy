"""
For computing plans using madagascar, state trajectories using VAL, and observation files
"""

import os, glob
from dependencies.fama.src import planning, pddl, pddl_parser

N_HORIZON = 10

# Can be set/overrided by calling set_paths function and 
# providing the domain name, base directory, and example directory
DOMAIN = None
BASE_DIR = None
EXAMPLE_DIR = None
MADAGASCAR_PATH = None
DOMAIN_PATH = None
PROBLEM_DIR = None
PLAN_DIR = None
LOGFILE_PATH = None
OBSERVATIONS_DIR = None
VAL_OUT_PATH = None

def create_fd_task(domain_filename,problem_filename):
    # Creating a FD task with the domain and the problem file
    fd_domain = pddl_parser.pddl_file.parse_pddl_file("domain", domain_filename)
    fd_problem = pddl_parser.pddl_file.parse_pddl_file("task", problem_filename)
    fd_task = pddl_parser.pddl_file.parsing_functions.parse_task(fd_domain, fd_problem)

    # Modifying domain and problem when planning for horizon
    if N_HORIZON > 0:
        fd_task.types.append(pddl.pddl_types.Type("step", "None"))
        fd_task.predicates.append(pddl.predicates.Predicate("current", [pddl.pddl_types.TypedObject("?i", "step")]))
        fd_task.predicates.append(pddl.predicates.Predicate("inext", [pddl.pddl_types.TypedObject("?i1", "step"), pddl.pddl_types.TypedObject("?i2", "step")]))

        for a in fd_task.actions:
            params = []
            params += [pddl.pddl_types.TypedObject("?i1", "step")]
            params += [pddl.pddl_types.TypedObject("?i2", "step")]
        
            pre = []
            pre += [pddl.conditions.Atom("current", ["?i1"])]
            pre += [pddl.conditions.Atom("inext", ["?i1", "?i2"])]
        
            a.effects += [pddl.effects.Effect(params, pddl.conditions.Conjunction(pre), pddl.conditions.NegatedAtom("current", ["?i1"]))]
            a.effects += [pddl.effects.Effect(params, pddl.conditions.Conjunction(pre), pddl.conditions.Atom("current", ["?i2"]))]
            
        for i in range(1, N_HORIZON + 1):
            fd_task.objects.append(pddl.pddl_types.TypedObject("i" + str(i), "step"))

        for i in range(2, N_HORIZON+1):
            fd_task.init.append(pddl.conditions.Atom("inext", ["i" + str(i-1), "i" + str(i)]))
            
        fd_task.init.append(pddl.conditions.Atom("current", ["i1"]))   
        fd_task.goal = pddl.conditions.Conjunction([pddl.conditions.Atom("current", ["i"+str(N_HORIZON)])])
    return fd_task

def generate_obs(plan,states,fd_task,observation_file):
    fdomain=open(observation_file,"w")
    for i in range(0,len(plan.actions)):
        if i==0:
            # HEAD
            fdomain.write("(solution \n")
            fdomain.write("(:objects ")
            str_out = ""
            for o in set(fd_task.objects):
                str_out = str_out + str(o).replace(":"," - ") + " "
            str_out = str_out + ")\n"
            states[0].filter_literals_byName(["inext","current"])
            str_out = str_out +"(:init " + str(states[i]) + ")\n\n"
            fdomain.write(str_out)

        # BODY
        states[i].filter_literals_byName(["inext","current"])
        fdomain.write("(:observations " + str(states[i])+")\n\n")
        fdomain.write("(:action "+str(plan.actions[i])+")\n\n")
    
        if i==(len(plan.actions)-1):
            # TAIL
            str_out = ""
            states[-1].filter_literals_byName(["inext","current"])
            str_out = str_out +"(:goal " + str(states[i+1]) + "))\n"
            fdomain.write(str_out)      
            fdomain.close()

def set_paths(domain_name, domain_file, base_dir, example_dir, observation_dir):
    global DOMAIN, BASE_DIR, EXAMPLE_DIR, MADAGASCAR_PATH, DOMAIN_PATH, PROBLEM_DIR, PLAN_DIR, LOGFILE_PATH, OBSERVATIONS_DIR, VAL_OUT_PATH
    DOMAIN = domain_name
    BASE_DIR = base_dir
    EXAMPLE_DIR = example_dir
    OBSERVATIONS_DIR = observation_dir

    MADAGASCAR_PATH = BASE_DIR+"dependencies/madagascar/M"
    DOMAIN_PATH = EXAMPLE_DIR+domain_file
    PROBLEM_DIR = EXAMPLE_DIR+"instances/"
    PLAN_DIR = EXAMPLE_DIR+"plans/"
    LOGFILE_PATH = EXAMPLE_DIR+"madagascar_output.txt"
    VAL_OUT_PATH = EXAMPLE_DIR+"val.log"

    if not os.path.exists(PLAN_DIR):
        os.mkdir(PLAN_DIR)
    if not os.path.exists(OBSERVATIONS_DIR):
        os.mkdir(OBSERVATIONS_DIR)

def compute_plans_and_observations(domain_name, domain_file, base_dir, example_dir, observation_dir):
    set_paths(domain_name, domain_file, base_dir, example_dir, observation_dir)

    if os.path.exists(LOGFILE_PATH):
        os.remove(LOGFILE_PATH)
    if os.path.exists(VAL_OUT_PATH):
        os.remove(VAL_OUT_PATH)

    print("EXAMPLE_DIR: ",example_dir)
    problem_files = glob.glob(PROBLEM_DIR+"*")
    for problem_path in problem_files:
        # find a plan
        plan_file = PLAN_DIR+"plan-"+problem_path.split("-")[1].split(".")[0] + ".txt"
        command = MADAGASCAR_PATH+" "+DOMAIN_PATH+" "+problem_path+" -W -S 1 -Q -o "+plan_file+" > "+LOGFILE_PATH
        # print("Planning..")
        os.system(command)

        plan = planning.Plan([])
        plan.read_plan(plan_file)

        # compute state trajectory
        # print("Computing state trajectory..")
        states = planning.VAL_computation_state_trajectory(DOMAIN_PATH, problem_path, plan_file, VAL_OUT_PATH)

        # create fd_task
        fd_task = create_fd_task(DOMAIN_PATH,problem_path)

        # generate observations i.e. state and action sequence
        observation_file = OBSERVATIONS_DIR+"/observation-"+ problem_path.split("-")[1].split(".")[0] +".txt"
        generate_obs(plan,states,fd_task,observation_file)


if __name__=="__main__":
    domain = "blocks_rash"
    base_dir = os.getcwd()+"/"
    example_dir = BASE_DIR+"dependencies/fama/output/"+domain+"/"
    observation_dir = example_dir+"observations/"
    compute_plans_and_observations(domain, base_dir, example_dir, observation_dir)
