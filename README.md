# Differential Assessment of AI System (DAAISy)

This repository contains the code for the paper:

Differential Assessment of Black-Box AI Agents.<br/>
[Rashmeet Kaur Nayyar](https://rashmeetnayyar.com)\*, 
[Pulkit Verma](https://pulkitverma.net)\*, and 
[Siddharth Srivastava](http://siddharthsrivastava.net/). <br/>
36th AAAI Conference on Artificial Intelligence, 2022. <br/>

[Paper](https://aair-lab.github.io/Publications/nvs_aaai22.pdf) | [Extended Version](https://arxiv.org/pdf/2203.13236.pdf) | [Talk](https://slideslive.com/38976997/differential-assessment-of-blackbox-ai-systems) | [Slides](https://pulkitverma.net/assets/pdf/nvs_aaai22/nvs_aaai22_slides.pdf) | [Poster](https://pulkitverma.net/assets/pdf/nvs_aaai22/nvs_aaai22_poster.pdf)

<br />

## Directory Structure

```
|-- dependencies/
|   |-- fama/
|   |-- FD/
|   |-- FF/
|   |-- madagascar/
|   |-- VAL/
|-- domains/
|   |-- domain_name/
|   |   |-- domains/
|   |   |-- instances/
|   |   |-- observations/
|-- random_states/
|-- results/
|-- src/
|   |-- agent.py
|   |-- config.py
|   |-- generate_random_states.py
|   |-- model_drift/
|   |-- interrogation/
|   |-- lattice/
|   |-- query/
|   |-- utils/
|-- README.md
|-- config.py
|-- learn_model.py
|-- generate_random_init_domains.py
```

- dependencies/: This directory includes the external software used to run the code. This includes fama, FF, FD, madagascar, and  VAL. 
  - fama: https://github.com/sjimenezgithub/strips-learning/
  - FF: https://fai.cs.uni-saarland.de/hoffmann/ff/FF-v2.3.tgz
  - FD: https://github.com/aibasel/downward
  - madagascar: https://users.aalto.fi/~rintanj1/jussi/software.html
  - VAL: https://github.com/KCL-Planning/VAL

- domains/ (Directory that stores domain, instance, and observation files) 
  - domain_name/
    - domains/
      - domain.pddl (domain file for that domain), 
    - instances/ (directory containing the problem files for that domain),
    - observations/ (directory containing the plans for that domain generated using the instances)

- random_states/: This directory stores the set of states in serialized form. For each domain, there is a .pkl file containing 60 states approximately.

- src/: This directory contains the source code for DAAISy and AIA.
- src/interrogation/aia.py has code for both DAAISy and AIA.
- src/model_drift/: This directory contains the source code for DAAISy. It contains the following files:
  - agent_interrogation_interface: Interface between identification of affected pal-tuples and identification of their modes. 
  - generate_observations: Generates observations for drifted model and init models.
  - infer_valid_modes: Identifies valid modes for each pa-tuple.
  - pa_tuple: Class for pa-tuple.
  - plot: Plots results.

- results/: This directory has domain-specific results in the form of csv files and plots.

<br />

## Instructions to run the code

Input: You need the IPC domain.pddl (within domains/), domain_template.pddl (within domains/), instance (within instances/instances/) files as input.
Here, IPC domain is used as drifted model and simply used to generate a set of init domains randomly. The algorithm does not take IPC domain as input but only the init domains.

1. Install the required software using setup.sh. You might need to give sudo permissions to install some of them.
```
./setup.sh
```

2. Set configuration in config.py. (Optional) <br /> Use the current parameters set in the config file to reproduce results in the paper. The parameters are:
- domain_name: the domain name, 
- drifted_domain_file: the filename for IPC domain,
- domain_to_num_files_each_pal: the number of init domain files you want to generate for each number of affected pal-tuples,
- num_affected_pals: the number of affected pal-tuples to consider,
- regenerate_random_states: True if you want to regenerate the set of random states for the domain,
- flag_init_domains_type: 0 for "randomly generated init domains", 1 for "only increased applicability init domains", and 2 for "both types of domain generation",
- domain_to_num_sas: number of s-a-s observations to use.

3. Generate random initial domains. (Optional)<br /> 
Use current init domain files to reproduce results in the paper. 
To randomly generate new initial domains using the IPC domain with increasing number of pal-tuples dropped (filename format is domainname_#PALsdropped_#file.pddl), run the following command.
```
python3 generate_random_init_domains.py
```

4. Input instance file for generating observations for drifted domain. (Optional)<br /> 
Use the current instance files and the corresponding generated observations to reproduce results in the paper. 
To run with new observations, replace the contents of the instances/instances/ directory with the instances you want, delete contents of observations/ directory, and set the domain_to_num_sas variable in config.py to the number of s-a-s observations you want to use (should be <= the number of s-a-s in the plan generated by the instance).

5. Run learn_model.py to learn the drifted model. You'll find the plots generated inside the results/ directory.
```
python3 learn_model.py
```

<br />

## Common Installation Issues

FF:
   
 - Please install flex and bison for FF to compile.

 - On newer versions of gcc (tested on gcc 10.2.0) please make the following changes:
    - main.c:150 : Comment out the gbracket_count definition
       ```
       int gbracket_count; --> /* int gbracket_count; */
       ```
     - relax.c:111 : Define lcurrent_goals as static
       ```
       State lcurrent_goals; --> static State lcurrent_goals;
       ```
     - search.c:110 : Define lcurrent_goals as static
       ```
       State lcurrent_goals; --> static State lcurrent_goals;
       ```
    

<br />

Please note that this is research code and not yet ready for public delivery,
hence most parts are not documented.

In case of any queries, please contact [verma.pulkit@asu.edu](mailto:verma.pulkit@asu.edu),
or [rmnayyar@asu.edu](mailto:rmnayyar@asu.edu).

<br />

# Citation
```
@inproceedings{nayyar_2022_differential,
    author = {Nayyar, Rashmeet Kaur and Verma, Pulkit and Srivastava, Siddharth},
    title = {{Differential Assessment of Black-Box AI Agents}},
    booktitle = {Thirty-Sixth AAAI Conference on Artificial Intelligence (AAAI-22)},
    year={2022}
}
```
