#!/bin/bash
declare -a arr=("termes")

ulimit -t 1000

mkdir performance
for i in {1..50}
do

for d in "${arr[@]}"
do
   ../src/experimenter_new.py -s ../output/$d/ 100 0 -m learned_model_$i.pddl -t observations/observation -c $i >> performance/termes_aaai21.csv

done

done
