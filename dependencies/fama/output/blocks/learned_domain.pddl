(define (domain blocks)
 (:requirements :strips :typing)
 (:types object - None block - object step - None )
 (:constants a -  block b -  block c -  block d -  block e -  block f -  block g -  block i1 -  step i2 -  step i3 -  step i4 -  step)
 (:predicates (action_applied) (add_clear_pick-up_var1) (add_clear_put-down_var1) (add_clear_stack_var1) (add_clear_stack_var2) (add_clear_unstack_var1) (add_clear_unstack_var2) (add_handempty_pick-up) (add_handempty_put-down) (add_handempty_stack) (add_handempty_unstack) (add_holding_pick-up_var1) (add_holding_put-down_var1) (add_holding_stack_var1) (add_holding_stack_var2) (add_holding_unstack_var1) (add_holding_unstack_var2) (add_on_stack_var1_var1) (add_on_stack_var1_var2) (add_on_stack_var2_var1) (add_on_stack_var2_var2) (add_on_unstack_var1_var1) (add_on_unstack_var1_var2) (add_on_unstack_var2_var1) (add_on_unstack_var2_var2) (add_ontable_pick-up_var1) (add_ontable_put-down_var1) (add_ontable_stack_var1) (add_ontable_stack_var2) (add_ontable_unstack_var1) (add_ontable_unstack_var2) (clear ?o1 - object) (current ?i - step) (del_clear_pick-up_var1) (del_clear_put-down_var1) (del_clear_stack_var1) (del_clear_stack_var2) (del_clear_unstack_var1) (del_clear_unstack_var2) (del_handempty_pick-up) (del_handempty_put-down) (del_handempty_stack) (del_handempty_unstack) (del_holding_pick-up_var1) (del_holding_put-down_var1) (del_holding_stack_var1) (del_holding_stack_var2) (del_holding_unstack_var1) (del_holding_unstack_var2) (del_on_stack_var1_var1) (del_on_stack_var1_var2) (del_on_stack_var2_var1) (del_on_stack_var2_var2) (del_on_unstack_var1_var1) (del_on_unstack_var1_var2) (del_on_unstack_var2_var1) (del_on_unstack_var2_var2) (del_ontable_pick-up_var1) (del_ontable_put-down_var1) (del_ontable_stack_var1) (del_ontable_stack_var2) (del_ontable_unstack_var1) (del_ontable_unstack_var2) (handempty) (holding ?o1 - object) (inext ?i1 - step ?i2 - step) (modeProg) (on ?o1 - block ?o2 - block) (ontable ?o1 - object) (plan-pick-up ?i - step ?o1 - block) (plan-put-down ?i - step ?o1 - block) (plan-stack ?i - step ?o1 - block ?o2 - block) (plan-unstack ?i - step ?o1 - block ?o2 - block) (pre_clear_pick-up_var1) (pre_clear_put-down_var1) (pre_clear_stack_var1) (pre_clear_stack_var2) (pre_clear_unstack_var1) (pre_clear_unstack_var2) (pre_handempty_pick-up) (pre_handempty_put-down) (pre_handempty_stack) (pre_handempty_unstack) (pre_holding_pick-up_var1) (pre_holding_put-down_var1) (pre_holding_stack_var1) (pre_holding_stack_var2) (pre_holding_unstack_var1) (pre_holding_unstack_var2) (pre_on_stack_var1_var1) (pre_on_stack_var1_var2) (pre_on_stack_var2_var1) (pre_on_stack_var2_var2) (pre_on_unstack_var1_var1) (pre_on_unstack_var1_var2) (pre_on_unstack_var2_var1) (pre_on_unstack_var2_var2) (pre_ontable_pick-up_var1) (pre_ontable_put-down_var1) (pre_ontable_stack_var1) (pre_ontable_stack_var2) (pre_ontable_unstack_var1) (pre_ontable_unstack_var2) (test1) (test10) (test100) (test101) (test102) (test103) (test104) (test105) (test106) (test107) (test108) (test109) (test11) (test110) (test111) (test112) (test113) (test114) (test115) (test116) (test117) (test118) (test119) (test12) (test120) (test121) (test122) (test123) (test124) (test125) (test126) (test127) (test128) (test129) (test13) (test130) (test131) (test132) (test133) (test134) (test135) (test136) (test137) (test138) (test139) (test14) (test140) (test141) (test142) (test143) (test144) (test145) (test146) (test147) (test148) (test149) (test15) (test150) (test151) (test16) (test17) (test18) (test19) (test2) (test20) (test21) (test22) (test23) (test24) (test25) (test26) (test27) (test28) (test29) (test3) (test30) (test31) (test32) (test33) (test34) (test35) (test36) (test37) (test38) (test39) (test4) (test40) (test41) (test42) (test43) (test44) (test45) (test46) (test47) (test48) (test49) (test5) (test50) (test51) (test52) (test53) (test54) (test55) (test56) (test57) (test58) (test59) (test6) (test60) (test61) (test62) (test63) (test64) (test65) (test66) (test67) (test68) (test69) (test7) (test70) (test71) (test72) (test73) (test74) (test75) (test76) (test77) (test78) (test79) (test8) (test80) (test81) (test82) (test83) (test84) (test85) (test86) (test87) (test88) (test89) (test9) (test90) (test91) (test92) (test93) (test94) (test95) (test96) (test97) (test98) (test99))

 (:action pick-up
   :parameters (?o1 - block ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(or (not (pre_ontable_pick-up_var1 ))(ontable ?o1))(or (not (pre_clear_pick-up_var1 ))(clear ?o1))(or (not (pre_handempty_pick-up ))(handempty ))(or (not (pre_holding_pick-up_var1 ))(holding ?o1))(current ?i1)(inext ?i1 ?i2)(plan-pick-up ?i1 ?o1))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)(when (and (del_ontable_pick-up_var1 ))(not (ontable ?o1)))(when (and (add_ontable_pick-up_var1 ))(ontable ?o1))(when (and (del_clear_pick-up_var1 ))(not (clear ?o1)))(when (and (add_clear_pick-up_var1 ))(clear ?o1))(when (and (del_handempty_pick-up ))(not (handempty )))(when (and (add_handempty_pick-up ))(handempty ))(when (and (del_holding_pick-up_var1 ))(not (holding ?o1)))(when (and (add_holding_pick-up_var1 ))(holding ?o1))))

 (:action put-down
   :parameters (?o1 - block ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(or (not (pre_ontable_put-down_var1 ))(ontable ?o1))(or (not (pre_clear_put-down_var1 ))(clear ?o1))(or (not (pre_handempty_put-down ))(handempty ))(or (not (pre_holding_put-down_var1 ))(holding ?o1))(current ?i1)(inext ?i1 ?i2)(plan-put-down ?i1 ?o1))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)(when (and (del_ontable_put-down_var1 ))(not (ontable ?o1)))(when (and (add_ontable_put-down_var1 ))(ontable ?o1))(when (and (del_clear_put-down_var1 ))(not (clear ?o1)))(when (and (add_clear_put-down_var1 ))(clear ?o1))(when (and (del_handempty_put-down ))(not (handempty )))(when (and (add_handempty_put-down ))(handempty ))(when (and (del_holding_put-down_var1 ))(not (holding ?o1)))(when (and (add_holding_put-down_var1 ))(holding ?o1))))

 (:action stack
   :parameters (?o1 - block ?o2 - block ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(or (not (pre_on_stack_var1_var1 ))(on ?o1 ?o1))(or (not (pre_on_stack_var1_var2 ))(on ?o1 ?o2))(or (not (pre_on_stack_var2_var1 ))(on ?o2 ?o1))(or (not (pre_on_stack_var2_var2 ))(on ?o2 ?o2))(or (not (pre_ontable_stack_var1 ))(ontable ?o1))(or (not (pre_ontable_stack_var2 ))(ontable ?o2))(or (not (pre_clear_stack_var1 ))(clear ?o1))(or (not (pre_clear_stack_var2 ))(clear ?o2))(or (not (pre_handempty_stack ))(handempty ))(or (not (pre_holding_stack_var1 ))(holding ?o1))(or (not (pre_holding_stack_var2 ))(holding ?o2))(current ?i1)(inext ?i1 ?i2)(plan-stack ?i1 ?o1 ?o2))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)(when (and (del_on_stack_var1_var1 ))(not (on ?o1 ?o1)))(when (and (add_on_stack_var1_var1 ))(on ?o1 ?o1))(when (and (del_on_stack_var1_var2 ))(not (on ?o1 ?o2)))(when (and (add_on_stack_var1_var2 ))(on ?o1 ?o2))(when (and (del_on_stack_var2_var1 ))(not (on ?o2 ?o1)))(when (and (add_on_stack_var2_var1 ))(on ?o2 ?o1))(when (and (del_on_stack_var2_var2 ))(not (on ?o2 ?o2)))(when (and (add_on_stack_var2_var2 ))(on ?o2 ?o2))(when (and (del_ontable_stack_var1 ))(not (ontable ?o1)))(when (and (add_ontable_stack_var1 ))(ontable ?o1))(when (and (del_ontable_stack_var2 ))(not (ontable ?o2)))(when (and (add_ontable_stack_var2 ))(ontable ?o2))(when (and (del_clear_stack_var1 ))(not (clear ?o1)))(when (and (add_clear_stack_var1 ))(clear ?o1))(when (and (del_clear_stack_var2 ))(not (clear ?o2)))(when (and (add_clear_stack_var2 ))(clear ?o2))(when (and (del_handempty_stack ))(not (handempty )))(when (and (add_handempty_stack ))(handempty ))(when (and (del_holding_stack_var1 ))(not (holding ?o1)))(when (and (add_holding_stack_var1 ))(holding ?o1))(when (and (del_holding_stack_var2 ))(not (holding ?o2)))(when (and (add_holding_stack_var2 ))(holding ?o2))))

 (:action unstack
   :parameters (?o1 - block ?o2 - block ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(or (not (pre_on_unstack_var1_var1 ))(on ?o1 ?o1))(or (not (pre_on_unstack_var1_var2 ))(on ?o1 ?o2))(or (not (pre_on_unstack_var2_var1 ))(on ?o2 ?o1))(or (not (pre_on_unstack_var2_var2 ))(on ?o2 ?o2))(or (not (pre_ontable_unstack_var1 ))(ontable ?o1))(or (not (pre_ontable_unstack_var2 ))(ontable ?o2))(or (not (pre_clear_unstack_var1 ))(clear ?o1))(or (not (pre_clear_unstack_var2 ))(clear ?o2))(or (not (pre_handempty_unstack ))(handempty ))(or (not (pre_holding_unstack_var1 ))(holding ?o1))(or (not (pre_holding_unstack_var2 ))(holding ?o2))(current ?i1)(inext ?i1 ?i2)(plan-unstack ?i1 ?o1 ?o2))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)(when (and (del_on_unstack_var1_var1 ))(not (on ?o1 ?o1)))(when (and (add_on_unstack_var1_var1 ))(on ?o1 ?o1))(when (and (del_on_unstack_var1_var2 ))(not (on ?o1 ?o2)))(when (and (add_on_unstack_var1_var2 ))(on ?o1 ?o2))(when (and (del_on_unstack_var2_var1 ))(not (on ?o2 ?o1)))(when (and (add_on_unstack_var2_var1 ))(on ?o2 ?o1))(when (and (del_on_unstack_var2_var2 ))(not (on ?o2 ?o2)))(when (and (add_on_unstack_var2_var2 ))(on ?o2 ?o2))(when (and (del_ontable_unstack_var1 ))(not (ontable ?o1)))(when (and (add_ontable_unstack_var1 ))(ontable ?o1))(when (and (del_ontable_unstack_var2 ))(not (ontable ?o2)))(when (and (add_ontable_unstack_var2 ))(ontable ?o2))(when (and (del_clear_unstack_var1 ))(not (clear ?o1)))(when (and (add_clear_unstack_var1 ))(clear ?o1))(when (and (del_clear_unstack_var2 ))(not (clear ?o2)))(when (and (add_clear_unstack_var2 ))(clear ?o2))(when (and (del_handempty_unstack ))(not (handempty )))(when (and (add_handempty_unstack ))(handempty ))(when (and (del_holding_unstack_var1 ))(not (holding ?o1)))(when (and (add_holding_unstack_var1 ))(holding ?o1))(when (and (del_holding_unstack_var2 ))(not (holding ?o2)))(when (and (add_holding_unstack_var2 ))(holding ?o2))))

 (:action program_pre_ontable_pick-up_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_ontable_pick-up_var1 ))(not (del_ontable_pick-up_var1 ))(not (add_ontable_pick-up_var1 )))
   :effect (and (pre_ontable_pick-up_var1 )))

 (:action program_eff_ontable_pick-up_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_ontable_pick-up_var1 ))(not (add_ontable_pick-up_var1 )))
   :effect (and (when (pre_ontable_pick-up_var1 )(del_ontable_pick-up_var1 ))(when (not (pre_ontable_pick-up_var1 ))(add_ontable_pick-up_var1 ))))

 (:action program_pre_clear_pick-up_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_pick-up_var1 ))(not (del_clear_pick-up_var1 ))(not (add_clear_pick-up_var1 )))
   :effect (and (pre_clear_pick-up_var1 )))

 (:action program_eff_clear_pick-up_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_pick-up_var1 ))(not (add_clear_pick-up_var1 )))
   :effect (and (when (pre_clear_pick-up_var1 )(del_clear_pick-up_var1 ))(when (not (pre_clear_pick-up_var1 ))(add_clear_pick-up_var1 ))))

 (:action program_pre_handempty_pick-up
   :parameters ()
   :precondition (and (modeProg )(not (pre_handempty_pick-up ))(not (del_handempty_pick-up ))(not (add_handempty_pick-up )))
   :effect (and (pre_handempty_pick-up )))

 (:action program_eff_handempty_pick-up
   :parameters ()
   :precondition (and (modeProg )(not (del_handempty_pick-up ))(not (add_handempty_pick-up )))
   :effect (and (when (pre_handempty_pick-up )(del_handempty_pick-up ))(when (not (pre_handempty_pick-up ))(add_handempty_pick-up ))))

 (:action program_pre_holding_pick-up_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_holding_pick-up_var1 ))(not (del_holding_pick-up_var1 ))(not (add_holding_pick-up_var1 )))
   :effect (and (pre_holding_pick-up_var1 )))

 (:action program_eff_holding_pick-up_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_holding_pick-up_var1 ))(not (add_holding_pick-up_var1 )))
   :effect (and (when (pre_holding_pick-up_var1 )(del_holding_pick-up_var1 ))(when (not (pre_holding_pick-up_var1 ))(add_holding_pick-up_var1 ))))

 (:action program_pre_ontable_put-down_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_ontable_put-down_var1 ))(not (del_ontable_put-down_var1 ))(not (add_ontable_put-down_var1 )))
   :effect (and (pre_ontable_put-down_var1 )))

 (:action program_eff_ontable_put-down_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_ontable_put-down_var1 ))(not (add_ontable_put-down_var1 )))
   :effect (and (when (pre_ontable_put-down_var1 )(del_ontable_put-down_var1 ))(when (not (pre_ontable_put-down_var1 ))(add_ontable_put-down_var1 ))))

 (:action program_pre_clear_put-down_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_put-down_var1 ))(not (del_clear_put-down_var1 ))(not (add_clear_put-down_var1 )))
   :effect (and (pre_clear_put-down_var1 )))

 (:action program_eff_clear_put-down_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_put-down_var1 ))(not (add_clear_put-down_var1 )))
   :effect (and (when (pre_clear_put-down_var1 )(del_clear_put-down_var1 ))(when (not (pre_clear_put-down_var1 ))(add_clear_put-down_var1 ))))

 (:action program_pre_handempty_put-down
   :parameters ()
   :precondition (and (modeProg )(not (pre_handempty_put-down ))(not (del_handempty_put-down ))(not (add_handempty_put-down )))
   :effect (and (pre_handempty_put-down )))

 (:action program_eff_handempty_put-down
   :parameters ()
   :precondition (and (modeProg )(not (del_handempty_put-down ))(not (add_handempty_put-down )))
   :effect (and (when (pre_handempty_put-down )(del_handempty_put-down ))(when (not (pre_handempty_put-down ))(add_handempty_put-down ))))

 (:action program_pre_holding_put-down_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_holding_put-down_var1 ))(not (del_holding_put-down_var1 ))(not (add_holding_put-down_var1 )))
   :effect (and (pre_holding_put-down_var1 )))

 (:action program_eff_holding_put-down_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_holding_put-down_var1 ))(not (add_holding_put-down_var1 )))
   :effect (and (when (pre_holding_put-down_var1 )(del_holding_put-down_var1 ))(when (not (pre_holding_put-down_var1 ))(add_holding_put-down_var1 ))))

 (:action program_pre_on_stack_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_stack_var1_var1 ))(not (del_on_stack_var1_var1 ))(not (add_on_stack_var1_var1 )))
   :effect (and (pre_on_stack_var1_var1 )))

 (:action program_eff_on_stack_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_stack_var1_var1 ))(not (add_on_stack_var1_var1 )))
   :effect (and (when (pre_on_stack_var1_var1 )(del_on_stack_var1_var1 ))(when (not (pre_on_stack_var1_var1 ))(add_on_stack_var1_var1 ))))

 (:action program_pre_on_stack_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_stack_var1_var2 ))(not (del_on_stack_var1_var2 ))(not (add_on_stack_var1_var2 )))
   :effect (and (pre_on_stack_var1_var2 )))

 (:action program_eff_on_stack_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_on_stack_var1_var2 ))(not (add_on_stack_var1_var2 )))
   :effect (and (when (pre_on_stack_var1_var2 )(del_on_stack_var1_var2 ))(when (not (pre_on_stack_var1_var2 ))(add_on_stack_var1_var2 ))))

 (:action program_pre_on_stack_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_stack_var2_var1 ))(not (del_on_stack_var2_var1 ))(not (add_on_stack_var2_var1 )))
   :effect (and (pre_on_stack_var2_var1 )))

 (:action program_eff_on_stack_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_stack_var2_var1 ))(not (add_on_stack_var2_var1 )))
   :effect (and (when (pre_on_stack_var2_var1 )(del_on_stack_var2_var1 ))(when (not (pre_on_stack_var2_var1 ))(add_on_stack_var2_var1 ))))

 (:action program_pre_on_stack_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_stack_var2_var2 ))(not (del_on_stack_var2_var2 ))(not (add_on_stack_var2_var2 )))
   :effect (and (pre_on_stack_var2_var2 )))

 (:action program_eff_on_stack_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_on_stack_var2_var2 ))(not (add_on_stack_var2_var2 )))
   :effect (and (when (pre_on_stack_var2_var2 )(del_on_stack_var2_var2 ))(when (not (pre_on_stack_var2_var2 ))(add_on_stack_var2_var2 ))))

 (:action program_pre_ontable_stack_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_ontable_stack_var1 ))(not (del_ontable_stack_var1 ))(not (add_ontable_stack_var1 )))
   :effect (and (pre_ontable_stack_var1 )))

 (:action program_eff_ontable_stack_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_ontable_stack_var1 ))(not (add_ontable_stack_var1 )))
   :effect (and (when (pre_ontable_stack_var1 )(del_ontable_stack_var1 ))(when (not (pre_ontable_stack_var1 ))(add_ontable_stack_var1 ))))

 (:action program_pre_ontable_stack_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_ontable_stack_var2 ))(not (del_ontable_stack_var2 ))(not (add_ontable_stack_var2 )))
   :effect (and (pre_ontable_stack_var2 )))

 (:action program_eff_ontable_stack_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_ontable_stack_var2 ))(not (add_ontable_stack_var2 )))
   :effect (and (when (pre_ontable_stack_var2 )(del_ontable_stack_var2 ))(when (not (pre_ontable_stack_var2 ))(add_ontable_stack_var2 ))))

 (:action program_pre_clear_stack_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_stack_var1 ))(not (del_clear_stack_var1 ))(not (add_clear_stack_var1 )))
   :effect (and (pre_clear_stack_var1 )))

 (:action program_eff_clear_stack_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_stack_var1 ))(not (add_clear_stack_var1 )))
   :effect (and (when (pre_clear_stack_var1 )(del_clear_stack_var1 ))(when (not (pre_clear_stack_var1 ))(add_clear_stack_var1 ))))

 (:action program_pre_clear_stack_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_stack_var2 ))(not (del_clear_stack_var2 ))(not (add_clear_stack_var2 )))
   :effect (and (pre_clear_stack_var2 )))

 (:action program_eff_clear_stack_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_stack_var2 ))(not (add_clear_stack_var2 )))
   :effect (and (when (pre_clear_stack_var2 )(del_clear_stack_var2 ))(when (not (pre_clear_stack_var2 ))(add_clear_stack_var2 ))))

 (:action program_pre_handempty_stack
   :parameters ()
   :precondition (and (modeProg )(not (pre_handempty_stack ))(not (del_handempty_stack ))(not (add_handempty_stack )))
   :effect (and (pre_handempty_stack )))

 (:action program_eff_handempty_stack
   :parameters ()
   :precondition (and (modeProg )(not (del_handempty_stack ))(not (add_handempty_stack )))
   :effect (and (when (pre_handempty_stack )(del_handempty_stack ))(when (not (pre_handempty_stack ))(add_handempty_stack ))))

 (:action program_pre_holding_stack_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_holding_stack_var1 ))(not (del_holding_stack_var1 ))(not (add_holding_stack_var1 )))
   :effect (and (pre_holding_stack_var1 )))

 (:action program_eff_holding_stack_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_holding_stack_var1 ))(not (add_holding_stack_var1 )))
   :effect (and (when (pre_holding_stack_var1 )(del_holding_stack_var1 ))(when (not (pre_holding_stack_var1 ))(add_holding_stack_var1 ))))

 (:action program_pre_holding_stack_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_holding_stack_var2 ))(not (del_holding_stack_var2 ))(not (add_holding_stack_var2 )))
   :effect (and (pre_holding_stack_var2 )))

 (:action program_eff_holding_stack_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_holding_stack_var2 ))(not (add_holding_stack_var2 )))
   :effect (and (when (pre_holding_stack_var2 )(del_holding_stack_var2 ))(when (not (pre_holding_stack_var2 ))(add_holding_stack_var2 ))))

 (:action program_pre_on_unstack_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_unstack_var1_var1 ))(not (del_on_unstack_var1_var1 ))(not (add_on_unstack_var1_var1 )))
   :effect (and (pre_on_unstack_var1_var1 )))

 (:action program_eff_on_unstack_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_unstack_var1_var1 ))(not (add_on_unstack_var1_var1 )))
   :effect (and (when (pre_on_unstack_var1_var1 )(del_on_unstack_var1_var1 ))(when (not (pre_on_unstack_var1_var1 ))(add_on_unstack_var1_var1 ))))

 (:action program_pre_on_unstack_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_unstack_var1_var2 ))(not (del_on_unstack_var1_var2 ))(not (add_on_unstack_var1_var2 )))
   :effect (and (pre_on_unstack_var1_var2 )))

 (:action program_eff_on_unstack_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_on_unstack_var1_var2 ))(not (add_on_unstack_var1_var2 )))
   :effect (and (when (pre_on_unstack_var1_var2 )(del_on_unstack_var1_var2 ))(when (not (pre_on_unstack_var1_var2 ))(add_on_unstack_var1_var2 ))))

 (:action program_pre_on_unstack_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_unstack_var2_var1 ))(not (del_on_unstack_var2_var1 ))(not (add_on_unstack_var2_var1 )))
   :effect (and (pre_on_unstack_var2_var1 )))

 (:action program_eff_on_unstack_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_unstack_var2_var1 ))(not (add_on_unstack_var2_var1 )))
   :effect (and (when (pre_on_unstack_var2_var1 )(del_on_unstack_var2_var1 ))(when (not (pre_on_unstack_var2_var1 ))(add_on_unstack_var2_var1 ))))

 (:action program_pre_on_unstack_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_unstack_var2_var2 ))(not (del_on_unstack_var2_var2 ))(not (add_on_unstack_var2_var2 )))
   :effect (and (pre_on_unstack_var2_var2 )))

 (:action program_eff_on_unstack_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_on_unstack_var2_var2 ))(not (add_on_unstack_var2_var2 )))
   :effect (and (when (pre_on_unstack_var2_var2 )(del_on_unstack_var2_var2 ))(when (not (pre_on_unstack_var2_var2 ))(add_on_unstack_var2_var2 ))))

 (:action program_pre_ontable_unstack_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_ontable_unstack_var1 ))(not (del_ontable_unstack_var1 ))(not (add_ontable_unstack_var1 )))
   :effect (and (pre_ontable_unstack_var1 )))

 (:action program_eff_ontable_unstack_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_ontable_unstack_var1 ))(not (add_ontable_unstack_var1 )))
   :effect (and (when (pre_ontable_unstack_var1 )(del_ontable_unstack_var1 ))(when (not (pre_ontable_unstack_var1 ))(add_ontable_unstack_var1 ))))

 (:action program_pre_ontable_unstack_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_ontable_unstack_var2 ))(not (del_ontable_unstack_var2 ))(not (add_ontable_unstack_var2 )))
   :effect (and (pre_ontable_unstack_var2 )))

 (:action program_eff_ontable_unstack_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_ontable_unstack_var2 ))(not (add_ontable_unstack_var2 )))
   :effect (and (when (pre_ontable_unstack_var2 )(del_ontable_unstack_var2 ))(when (not (pre_ontable_unstack_var2 ))(add_ontable_unstack_var2 ))))

 (:action program_pre_clear_unstack_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_unstack_var1 ))(not (del_clear_unstack_var1 ))(not (add_clear_unstack_var1 )))
   :effect (and (pre_clear_unstack_var1 )))

 (:action program_eff_clear_unstack_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_unstack_var1 ))(not (add_clear_unstack_var1 )))
   :effect (and (when (pre_clear_unstack_var1 )(del_clear_unstack_var1 ))(when (not (pre_clear_unstack_var1 ))(add_clear_unstack_var1 ))))

 (:action program_pre_clear_unstack_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_unstack_var2 ))(not (del_clear_unstack_var2 ))(not (add_clear_unstack_var2 )))
   :effect (and (pre_clear_unstack_var2 )))

 (:action program_eff_clear_unstack_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_unstack_var2 ))(not (add_clear_unstack_var2 )))
   :effect (and (when (pre_clear_unstack_var2 )(del_clear_unstack_var2 ))(when (not (pre_clear_unstack_var2 ))(add_clear_unstack_var2 ))))

 (:action program_pre_handempty_unstack
   :parameters ()
   :precondition (and (modeProg )(not (pre_handempty_unstack ))(not (del_handempty_unstack ))(not (add_handempty_unstack )))
   :effect (and (pre_handempty_unstack )))

 (:action program_eff_handempty_unstack
   :parameters ()
   :precondition (and (modeProg )(not (del_handempty_unstack ))(not (add_handempty_unstack )))
   :effect (and (when (pre_handempty_unstack )(del_handempty_unstack ))(when (not (pre_handempty_unstack ))(add_handempty_unstack ))))

 (:action program_pre_holding_unstack_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_holding_unstack_var1 ))(not (del_holding_unstack_var1 ))(not (add_holding_unstack_var1 )))
   :effect (and (pre_holding_unstack_var1 )))

 (:action program_eff_holding_unstack_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_holding_unstack_var1 ))(not (add_holding_unstack_var1 )))
   :effect (and (when (pre_holding_unstack_var1 )(del_holding_unstack_var1 ))(when (not (pre_holding_unstack_var1 ))(add_holding_unstack_var1 ))))

 (:action program_pre_holding_unstack_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_holding_unstack_var2 ))(not (del_holding_unstack_var2 ))(not (add_holding_unstack_var2 )))
   :effect (and (pre_holding_unstack_var2 )))

 (:action program_eff_holding_unstack_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_holding_unstack_var2 ))(not (add_holding_unstack_var2 )))
   :effect (and (when (pre_holding_unstack_var2 )(del_holding_unstack_var2 ))(when (not (pre_holding_unstack_var2 ))(add_holding_unstack_var2 ))))

 (:action validate_1
   :parameters ()
   :precondition (and (modeProg ))
   :effect (and (not (modeProg ))(current i1)(clear d)(clear f)(handempty )(not (on a a))(not (on a b))(on a c)(not (on a d))(not (on a e))(not (on a f))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on c f))(on d a)(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on e a))(on e b)(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(on f e)(not (on f f))(ontable b)(ontable c)(plan-unstack i1 f e)(plan-stack i2 f d)(plan-unstack i3 e b)(test1 )(not (action_applied ))))

 (:action validate_2
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear b)(clear f)(not (handempty ))(holding e)(not (on a a))(not (on a b))(on a c)(not (on a d))(not (on a e))(not (on a f))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on c f))(on d a)(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on f a))(not (on f b))(not (on f c))(on f d)(not (on f e))(not (on f f))(ontable b)(ontable c)(test1 ))
   :effect (and (not (plan-unstack i1 f e))(not (plan-stack i2 f d))(not (plan-unstack i3 e b))(current i1)(not (current i4))(plan-put-down i1 e)(plan-unstack i2 f d)(plan-put-down i3 f)(test2 )(not (test1 ))(not (action_applied ))))

 (:action validate_3
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear b)(clear d)(clear e)(clear f)(handempty )(not (on a a))(not (on a b))(on a c)(not (on a d))(not (on a e))(not (on a f))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on c f))(on d a)(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(not (on f e))(not (on f f))(ontable b)(ontable c)(ontable e)(ontable f)(test2 ))
   :effect (and (not (plan-put-down i1 e))(not (plan-unstack i2 f d))(not (plan-put-down i3 f))(current i1)(not (current i4))(plan-unstack i1 d a)(plan-put-down i2 d)(plan-pick-up i3 f)(test3 )(not (test2 ))(not (action_applied ))))

 (:action validate_4
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(clear d)(clear e)(not (handempty ))(holding f)(not (on a a))(not (on a b))(on a c)(not (on a d))(not (on a e))(not (on a f))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on c f))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(not (on f e))(not (on f f))(ontable b)(ontable c)(ontable d)(ontable e)(test3 ))
   :effect (and (not (plan-unstack i1 d a))(not (plan-put-down i2 d))(not (plan-pick-up i3 f))(current i1)(not (current i4))(plan-stack i1 f d)(plan-unstack i2 a c)(plan-put-down i3 a)(test4 )(not (test3 ))(not (action_applied ))))

 (:action validate_5
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(clear c)(clear e)(clear f)(handempty )(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on c f))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on f a))(not (on f b))(not (on f c))(on f d)(not (on f e))(not (on f f))(ontable a)(ontable b)(ontable c)(ontable d)(ontable e)(test4 ))
   :effect (and (not (plan-stack i1 f d))(not (plan-unstack i2 a c))(not (plan-put-down i3 a))(current i1)(not (current i4))(plan-pick-up i1 e)(plan-stack i2 e f)(plan-pick-up i3 a)(test5 )(not (test4 ))(not (action_applied ))))

 (:action validate_6
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear b)(clear c)(clear e)(not (handempty ))(holding a)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on c f))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(on e f)(not (on f a))(not (on f b))(not (on f c))(on f d)(not (on f e))(not (on f f))(ontable b)(ontable c)(ontable d)(test5 ))
   :effect (and (not (plan-pick-up i1 e))(not (plan-stack i2 e f))(not (plan-pick-up i3 a))(current i1)(not (current i4))(plan-stack i1 a e)(plan-pick-up i2 b)(plan-stack i3 b a)(test6 )(not (test5 ))(not (action_applied ))))

 (:action validate_7
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear b)(clear c)(handempty )(not (on a a))(not (on a b))(not (on a c))(not (on a d))(on a e)(not (on a f))(on b a)(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on c f))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(on e f)(not (on f a))(not (on f b))(not (on f c))(on f d)(not (on f e))(not (on f f))(ontable c)(ontable d)(test6 ))
   :effect (and (not (plan-stack i1 a e))(not (plan-pick-up i2 b))(not (plan-stack i3 b a))(current i1)(not (current i4))(not (on a e))(not (on e f))(not (on f d))(not (on b a))(clear a)(clear d)(ontable b)(ontable a)(plan-pick-up i1 b)(plan-stack i2 b a)(plan-pick-up i3 c)(test7 )(not (test6 ))(not (action_applied ))))

 (:action validate_8
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear b)(clear d)(not (handempty ))(holding c)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(on b a)(not (on b b))(not (on b c))(not (on b d))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(ontable a)(ontable d)(test7 ))
   :effect (and (not (plan-pick-up i1 b))(not (plan-stack i2 b a))(not (plan-pick-up i3 c))(current i1)(not (current i4))(plan-stack i1 c b)(plan-pick-up i2 d)(plan-stack i3 d c)(test8 )(not (test7 ))(not (action_applied ))))

 (:action validate_9
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear d)(handempty )(not (on a a))(not (on a b))(not (on a c))(not (on a d))(on b a)(not (on b b))(not (on b c))(not (on b d))(not (on c a))(on c b)(not (on c c))(not (on c d))(not (on d a))(not (on d b))(on d c)(not (on d d))(ontable a)(test8 ))
   :effect (and (not (plan-stack i1 c b))(not (plan-pick-up i2 d))(not (plan-stack i3 d c))(current i1)(not (current i4))(not (on d c))(not (clear d))(not (on b a))(not (on c b))(not (ontable a))(ontable d)(on a d)(clear b)(on b c)(on c a)(plan-unstack i1 b c)(plan-put-down i2 b)(plan-unstack i3 c a)(test9 )(not (test8 ))(not (action_applied ))))

 (:action validate_10
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(not (handempty ))(holding c)(not (on a a))(not (on a b))(not (on a c))(on a d)(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(ontable b)(ontable d)(test9 ))
   :effect (and (not (plan-unstack i1 b c))(not (plan-put-down i2 b))(not (plan-unstack i3 c a))(current i1)(not (current i4))(plan-put-down i1 c)(plan-unstack i2 a d)(plan-stack i3 a b)(test10 )(not (test9 ))(not (action_applied ))))

 (:action validate_11
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear c)(clear d)(handempty )(not (on a a))(on a b)(not (on a c))(not (on a d))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(ontable b)(ontable c)(ontable d)(test10 ))
   :effect (and (not (plan-put-down i1 c))(not (plan-unstack i2 a d))(not (plan-stack i3 a b))(current i1)(not (current i4))(plan-pick-up i1 c)(plan-stack i2 c a)(plan-pick-up i3 d)(test11 )(not (test10 ))(not (action_applied ))))

 (:action validate_12
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear c)(not (handempty ))(holding d)(not (on a a))(on a b)(not (on a c))(not (on a d))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(on c a)(not (on c b))(not (on c c))(not (on c d))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(ontable b)(test11 ))
   :effect (and (not (plan-pick-up i1 c))(not (plan-stack i2 c a))(not (plan-pick-up i3 d))(current i1)(not (current i4))(not (holding d))(not (on a b))(not (on c a))(clear d)(ontable a)(on c b)(ontable d)(handempty )(clear a)(plan-unstack i1 c b)(plan-stack i2 c d)(plan-pick-up i3 b)(test12 )(not (test11 ))(not (action_applied ))))

 (:action validate_13
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear c)(not (handempty ))(holding b)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on c a))(not (on c b))(not (on c c))(on c d)(not (on d a))(not (on d b))(not (on d c))(not (on d d))(ontable a)(ontable d)(test12 ))
   :effect (and (not (plan-unstack i1 c b))(not (plan-stack i2 c d))(not (plan-pick-up i3 b))(current i1)(not (current i4))(plan-stack i1 b c)(plan-pick-up i2 a)(plan-stack i3 a b)(test13 )(not (test12 ))(not (action_applied ))))

 (:action validate_14
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(handempty )(not (on a a))(on a b)(not (on a c))(not (on a d))(not (on b a))(not (on b b))(on b c)(not (on b d))(not (on c a))(not (on c b))(not (on c c))(on c d)(not (on d a))(not (on d b))(not (on d c))(not (on d d))(ontable d)(test13 ))
   :effect (and (not (plan-stack i1 b c))(not (plan-pick-up i2 a))(not (plan-stack i3 a b))(current i1)(not (current i4))(not (on c d))(not (on a b))(not (on b c))(not (clear a))(clear d)(ontable a)(on b a)(clear c)(on e b)(on c e)(plan-unstack i1 c e)(plan-put-down i2 c)(plan-pick-up i3 d)(test14 )(not (test13 ))(not (action_applied ))))

 (:action validate_15
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear c)(clear e)(not (handempty ))(holding d)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(on b a)(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on e a))(on e b)(not (on e c))(not (on e d))(not (on e e))(ontable a)(ontable c)(test14 ))
   :effect (and (not (plan-unstack i1 c e))(not (plan-put-down i2 c))(not (plan-pick-up i3 d))(current i1)(not (current i4))(plan-stack i1 d c)(plan-unstack i2 e b)(plan-put-down i3 e)(test15 )(not (test14 ))(not (action_applied ))))

 (:action validate_16
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear b)(clear d)(clear e)(handempty )(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(on b a)(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on d a))(not (on d b))(on d c)(not (on d d))(not (on d e))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(ontable a)(ontable c)(ontable e)(test15 ))
   :effect (and (not (plan-stack i1 d c))(not (plan-unstack i2 e b))(not (plan-put-down i3 e))(current i1)(not (current i4))(plan-unstack i1 b a)(plan-stack i2 b d)(plan-pick-up i3 e)(test16 )(not (test15 ))(not (action_applied ))))

 (:action validate_17
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(not (handempty ))(holding e)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on b a))(not (on b b))(not (on b c))(on b d)(not (on b e))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on d a))(not (on d b))(on d c)(not (on d d))(not (on d e))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(ontable a)(ontable c)(test16 ))
   :effect (and (not (plan-unstack i1 b a))(not (plan-stack i2 b d))(not (plan-pick-up i3 e))(current i1)(not (current i4))(plan-stack i1 e b)(plan-pick-up i2 a)(plan-stack i3 a e)(test17 )(not (test16 ))(not (action_applied ))))

 (:action validate_18
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(handempty )(not (on a a))(not (on a b))(not (on a c))(not (on a d))(on a e)(not (on b a))(not (on b b))(not (on b c))(on b d)(not (on b e))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on d a))(not (on d b))(on d c)(not (on d d))(not (on d e))(not (on e a))(on e b)(not (on e c))(not (on e d))(not (on e e))(ontable c)(test17 ))
   :effect (and (not (plan-stack i1 e b))(not (plan-pick-up i2 a))(not (plan-stack i3 a e))(current i1)(not (current i4))(not (on b d))(not (on d c))(not (clear a))(not (on a e))(not (on e b))(clear e)(on a d)(on b a)(ontable d)(clear b)(clear c)(ontable e)(plan-unstack i1 b a)(plan-put-down i2 b)(plan-unstack i3 a d)(test18 )(not (test17 ))(not (action_applied ))))

 (:action validate_19
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear b)(clear c)(clear d)(clear e)(not (handempty ))(holding a)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(ontable b)(ontable c)(ontable d)(ontable e)(test18 ))
   :effect (and (not (plan-unstack i1 b a))(not (plan-put-down i2 b))(not (plan-unstack i3 a d))(current i1)(not (current i4))(plan-stack i1 a e)(plan-pick-up i2 b)(plan-stack i3 b a)(test19 )(not (test18 ))(not (action_applied ))))

 (:action validate_20
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear b)(clear c)(clear d)(handempty )(not (on a a))(not (on a b))(not (on a c))(not (on a d))(on a e)(on b a)(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(ontable c)(ontable d)(ontable e)(test19 ))
   :effect (and (not (plan-stack i1 a e))(not (plan-pick-up i2 b))(not (plan-stack i3 b a))(current i1)(not (current i4))(plan-pick-up i1 c)(plan-stack i2 c b)(plan-pick-up i3 d)(test20 )(not (test19 ))(not (action_applied ))))

 (:action validate_21
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear c)(not (handempty ))(holding d)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(on a e)(on b a)(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on c a))(on c b)(not (on c c))(not (on c d))(not (on c e))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(ontable e)(test20 ))
   :effect (and (not (plan-pick-up i1 c))(not (plan-stack i2 c b))(not (plan-pick-up i3 d))(current i1)(not (current i4))(not (holding d))(not (on c b))(not (on b a))(not (on a e))(not (clear c))(not (ontable e))(on d e)(clear d)(handempty )(ontable b)(on a b)(on e c)(on c a)(plan-unstack i1 d e)(plan-put-down i2 d)(plan-unstack i3 e c)(test21 )(not (test20 ))(not (action_applied ))))

 (:action validate_22
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear c)(clear d)(not (handempty ))(holding e)(not (on a a))(on a b)(not (on a c))(not (on a d))(not (on a e))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(on c a)(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(ontable b)(ontable d)(test21 ))
   :effect (and (not (plan-unstack i1 d e))(not (plan-put-down i2 d))(not (plan-unstack i3 e c))(current i1)(not (current i4))(plan-put-down i1 e)(plan-unstack i2 c a)(plan-put-down i3 c)(test22 )(not (test21 ))(not (action_applied ))))

 (:action validate_23
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear c)(clear d)(clear e)(handempty )(not (on a a))(on a b)(not (on a c))(not (on a d))(not (on a e))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(ontable b)(ontable c)(ontable d)(ontable e)(test22 ))
   :effect (and (not (plan-put-down i1 e))(not (plan-unstack i2 c a))(not (plan-put-down i3 c))(current i1)(not (current i4))(plan-unstack i1 a b)(plan-put-down i2 a)(plan-pick-up i3 e)(test23 )(not (test22 ))(not (action_applied ))))

 (:action validate_24
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(clear c)(clear d)(not (handempty ))(holding e)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(ontable a)(ontable b)(ontable c)(ontable d)(test23 ))
   :effect (and (not (plan-unstack i1 a b))(not (plan-put-down i2 a))(not (plan-pick-up i3 e))(current i1)(not (current i4))(plan-stack i1 e a)(plan-pick-up i2 b)(plan-stack i3 b e)(test24 )(not (test23 ))(not (action_applied ))))

 (:action validate_25
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear b)(clear c)(clear d)(handempty )(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(on b e)(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(on e a)(not (on e b))(not (on e c))(not (on e d))(not (on e e))(ontable a)(ontable c)(ontable d)(test24 ))
   :effect (and (not (plan-stack i1 e a))(not (plan-pick-up i2 b))(not (plan-stack i3 b e))(current i1)(not (current i4))(plan-pick-up i1 c)(plan-stack i2 c b)(plan-pick-up i3 d)(test25 )(not (test24 ))(not (action_applied ))))

 (:action validate_26
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear c)(not (handempty ))(holding d)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(on b e)(not (on c a))(on c b)(not (on c c))(not (on c d))(not (on c e))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(on e a)(not (on e b))(not (on e c))(not (on e d))(not (on e e))(ontable a)(test25 ))
   :effect (and (not (plan-pick-up i1 c))(not (plan-stack i2 c b))(not (plan-pick-up i3 d))(current i1)(not (current i4))(not (holding d))(not (on b e))(not (on e a))(not (on c b))(not (ontable a))(clear a)(clear d)(ontable b)(clear e)(ontable d)(ontable c)(clear b)(handempty )(ontable f)(ontable e)(on a f)(plan-unstack i1 a f)(plan-stack i2 a d)(plan-pick-up i3 b)(test26 )(not (test25 ))(not (action_applied ))))

 (:action validate_27
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear c)(clear e)(clear f)(not (handempty ))(holding b)(not (on a a))(not (on a b))(not (on a c))(on a d)(not (on a e))(not (on a f))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on c f))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(not (on f e))(not (on f f))(ontable c)(ontable d)(ontable e)(ontable f)(test26 ))
   :effect (and (not (plan-unstack i1 a f))(not (plan-stack i2 a d))(not (plan-pick-up i3 b))(current i1)(not (current i4))(plan-stack i1 b a)(plan-pick-up i2 c)(plan-stack i3 c b)(test27 )(not (test26 ))(not (action_applied ))))

 (:action validate_28
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear c)(clear e)(clear f)(handempty )(not (on a a))(not (on a b))(not (on a c))(on a d)(not (on a e))(not (on a f))(on b a)(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on c a))(on c b)(not (on c c))(not (on c d))(not (on c e))(not (on c f))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(not (on f e))(not (on f f))(ontable d)(ontable e)(ontable f)(test27 ))
   :effect (and (not (plan-stack i1 b a))(not (plan-pick-up i2 c))(not (plan-stack i3 c b))(current i1)(not (current i4))(plan-pick-up i1 f)(plan-stack i2 f c)(plan-pick-up i3 e)(test28 )(not (test27 ))(not (action_applied ))))

 (:action validate_29
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear f)(not (handempty ))(holding e)(not (on a a))(not (on a b))(not (on a c))(on a d)(not (on a e))(not (on a f))(on b a)(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on c a))(on c b)(not (on c c))(not (on c d))(not (on c e))(not (on c f))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on f a))(not (on f b))(on f c)(not (on f d))(not (on f e))(not (on f f))(ontable d)(test28 ))
   :effect (and (not (plan-pick-up i1 f))(not (plan-stack i2 f c))(not (plan-pick-up i3 e))(current i1)(not (current i4))(not (on c b))(not (holding e))(not (on b a))(not (on f c))(not (ontable d))(not (clear f))(handempty )(on d b)(ontable c)(on e c)(on b f)(clear a)(on f e)(plan-unstack i1 a d)(plan-put-down i2 a)(plan-unstack i3 d b)(test29 )(not (test28 ))(not (action_applied ))))

 (:action validate_30
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(not (handempty ))(holding d)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(on b f)(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on c f))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on e a))(not (on e b))(on e c)(not (on e d))(not (on e e))(not (on e f))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(on f e)(not (on f f))(ontable a)(ontable c)(test29 ))
   :effect (and (not (plan-unstack i1 a d))(not (plan-put-down i2 a))(not (plan-unstack i3 d b))(current i1)(not (current i4))(plan-put-down i1 d)(plan-unstack i2 b f)(plan-put-down i3 b)(test30 )(not (test29 ))(not (action_applied ))))

 (:action validate_31
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(clear d)(clear f)(handempty )(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on c f))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on e a))(not (on e b))(on e c)(not (on e d))(not (on e e))(not (on e f))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(on f e)(not (on f f))(ontable a)(ontable b)(ontable c)(ontable d)(test30 ))
   :effect (and (not (plan-put-down i1 d))(not (plan-unstack i2 b f))(not (plan-put-down i3 b))(current i1)(not (current i4))(plan-unstack i1 f e)(plan-put-down i2 f)(plan-unstack i3 e c)(test31 )(not (test30 ))(not (action_applied ))))

 (:action validate_32
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(clear c)(clear d)(clear f)(not (handempty ))(holding e)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on c f))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(not (on f e))(not (on f f))(ontable a)(ontable b)(ontable c)(ontable d)(ontable f)(test31 ))
   :effect (and (not (plan-unstack i1 f e))(not (plan-put-down i2 f))(not (plan-unstack i3 e c))(current i1)(not (current i4))(plan-put-down i1 e)(plan-pick-up i2 c)(plan-stack i3 c d)(test32 )(not (test31 ))(not (action_applied ))))

 (:action validate_33
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(clear c)(clear e)(clear f)(handempty )(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on c a))(not (on c b))(not (on c c))(on c d)(not (on c e))(not (on c f))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(not (on f e))(not (on f f))(ontable a)(ontable b)(ontable d)(ontable e)(ontable f)(test32 ))
   :effect (and (not (plan-put-down i1 e))(not (plan-pick-up i2 c))(not (plan-stack i3 c d))(current i1)(not (current i4))(plan-pick-up i1 b)(plan-stack i2 b c)(plan-pick-up i3 a)(test33 )(not (test32 ))(not (action_applied ))))

 (:action validate_34
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear b)(clear e)(clear f)(not (handempty ))(holding a)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on b a))(not (on b b))(on b c)(not (on b d))(not (on b e))(not (on b f))(not (on c a))(not (on c b))(not (on c c))(on c d)(not (on c e))(not (on c f))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(not (on f e))(not (on f f))(ontable d)(ontable e)(ontable f)(test33 ))
   :effect (and (not (plan-pick-up i1 b))(not (plan-stack i2 b c))(not (plan-pick-up i3 a))(current i1)(not (current i4))(plan-stack i1 a b)(plan-pick-up i2 f)(plan-stack i3 f a)(test34 )(not (test33 ))(not (action_applied ))))

 (:action validate_35
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear e)(clear f)(handempty )(not (on a a))(on a b)(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on b a))(not (on b b))(on b c)(not (on b d))(not (on b e))(not (on b f))(not (on c a))(not (on c b))(not (on c c))(on c d)(not (on c e))(not (on c f))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(not (on e f))(on f a)(not (on f b))(not (on f c))(not (on f d))(not (on f e))(not (on f f))(ontable d)(ontable e)(test34 ))
   :effect (and (not (plan-stack i1 a b))(not (plan-pick-up i2 f))(not (plan-stack i3 f a))(current i1)(not (current i4))(not (on f a))(not (ontable e))(not (on a b))(not (on b c))(not (clear f))(on a f)(on e g)(on f c)(on g b)(on b a)(plan-unstack i1 e g)(plan-put-down i2 e)(plan-unstack i3 g b)(test35 )(not (test34 ))(not (action_applied ))))

 (:action validate_36
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear b)(clear e)(not (handempty ))(holding g)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(on a f)(not (on a g))(on b a)(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on b g))(not (on c a))(not (on c b))(not (on c c))(on c d)(not (on c e))(not (on c f))(not (on c g))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on d g))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on e g))(not (on f a))(not (on f b))(on f c)(not (on f d))(not (on f e))(not (on f f))(not (on f g))(not (on g a))(not (on g b))(not (on g c))(not (on g d))(not (on g e))(not (on g f))(not (on g g))(ontable d)(ontable e)(test35 ))
   :effect (and (not (plan-unstack i1 e g))(not (plan-put-down i2 e))(not (plan-unstack i3 g b))(current i1)(not (current i4))(plan-put-down i1 g)(plan-unstack i2 b a)(plan-put-down i3 b)(test36 )(not (test35 ))(not (action_applied ))))

 (:action validate_37
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(clear e)(clear g)(handempty )(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(on a f)(not (on a g))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on b g))(not (on c a))(not (on c b))(not (on c c))(on c d)(not (on c e))(not (on c f))(not (on c g))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on d g))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on e g))(not (on f a))(not (on f b))(on f c)(not (on f d))(not (on f e))(not (on f f))(not (on f g))(not (on g a))(not (on g b))(not (on g c))(not (on g d))(not (on g e))(not (on g f))(not (on g g))(ontable b)(ontable d)(ontable e)(ontable g)(test36 ))
   :effect (and (not (plan-put-down i1 g))(not (plan-unstack i2 b a))(not (plan-put-down i3 b))(current i1)(not (current i4))(plan-unstack i1 a f)(plan-put-down i2 a)(plan-unstack i3 f c)(test37 )(not (test36 ))(not (action_applied ))))

 (:action validate_38
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(clear c)(clear e)(clear g)(not (handempty ))(holding f)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on a g))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on b g))(not (on c a))(not (on c b))(not (on c c))(on c d)(not (on c e))(not (on c f))(not (on c g))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on d g))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on e g))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(not (on f e))(not (on f f))(not (on f g))(not (on g a))(not (on g b))(not (on g c))(not (on g d))(not (on g e))(not (on g f))(not (on g g))(ontable a)(ontable b)(ontable d)(ontable e)(ontable g)(test37 ))
   :effect (and (not (plan-unstack i1 a f))(not (plan-put-down i2 a))(not (plan-unstack i3 f c))(current i1)(not (current i4))(plan-stack i1 f e)(plan-unstack i2 c d)(plan-stack i3 c f)(test38 )(not (test37 ))(not (action_applied ))))

 (:action validate_39
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(clear c)(clear d)(clear g)(handempty )(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on a g))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on b g))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(on c f)(not (on c g))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on d g))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on e g))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(on f e)(not (on f f))(not (on f g))(not (on g a))(not (on g b))(not (on g c))(not (on g d))(not (on g e))(not (on g f))(not (on g g))(ontable a)(ontable b)(ontable d)(ontable e)(ontable g)(test38 ))
   :effect (and (not (plan-stack i1 f e))(not (plan-unstack i2 c d))(not (plan-stack i3 c f))(current i1)(not (current i4))(plan-pick-up i1 b)(plan-stack i2 b c)(plan-pick-up i3 d)(test39 )(not (test38 ))(not (action_applied ))))

 (:action validate_40
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(clear g)(not (handempty ))(holding d)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on a g))(not (on b a))(not (on b b))(on b c)(not (on b d))(not (on b e))(not (on b f))(not (on b g))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(on c f)(not (on c g))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on d g))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on e g))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(on f e)(not (on f f))(not (on f g))(not (on g a))(not (on g b))(not (on g c))(not (on g d))(not (on g e))(not (on g f))(not (on g g))(ontable a)(ontable e)(ontable g)(test39 ))
   :effect (and (not (plan-pick-up i1 b))(not (plan-stack i2 b c))(not (plan-pick-up i3 d))(current i1)(not (current i4))(plan-stack i1 d b)(plan-pick-up i2 g)(plan-stack i3 g d)(test40 )(not (test39 ))(not (action_applied ))))

 (:action validate_41
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear g)(handempty )(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on a g))(not (on b a))(not (on b b))(on b c)(not (on b d))(not (on b e))(not (on b f))(not (on b g))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(on c f)(not (on c g))(not (on d a))(on d b)(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on d g))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on e g))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(on f e)(not (on f f))(not (on f g))(not (on g a))(not (on g b))(not (on g c))(on g d)(not (on g e))(not (on g f))(not (on g g))(ontable a)(ontable e)(test40 ))
   :effect (and (not (plan-stack i1 d b))(not (plan-pick-up i2 g))(not (plan-stack i3 g d))(current i1)(not (current i4))(not (clear g))(not (on b c))(not (on f e))(not (ontable a))(not (on g d))(not (on c f))(not (ontable e))(on b e)(on e f)(ontable g)(on c d)(clear c)(ontable f)(on a g)(plan-unstack i1 a g)(plan-put-down i2 a)(plan-unstack i3 c d)(test41 )(not (test40 ))(not (action_applied ))))

 (:action validate_42
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear d)(clear g)(not (handempty ))(holding c)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on a g))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(on b e)(not (on b f))(not (on b g))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on c f))(not (on c g))(not (on d a))(on d b)(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on d g))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(on e f)(not (on e g))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(not (on f e))(not (on f f))(not (on f g))(not (on g a))(not (on g b))(not (on g c))(not (on g d))(not (on g e))(not (on g f))(not (on g g))(ontable a)(ontable f)(ontable g)(test41 ))
   :effect (and (not (plan-unstack i1 a g))(not (plan-put-down i2 a))(not (plan-unstack i3 c d))(current i1)(not (current i4))(plan-put-down i1 c)(plan-unstack i2 d b)(plan-put-down i3 d)(test42 )(not (test41 ))(not (action_applied ))))

 (:action validate_43
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(clear c)(clear d)(clear g)(handempty )(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on a g))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(on b e)(not (on b f))(not (on b g))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on c f))(not (on c g))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on d g))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(on e f)(not (on e g))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(not (on f e))(not (on f f))(not (on f g))(not (on g a))(not (on g b))(not (on g c))(not (on g d))(not (on g e))(not (on g f))(not (on g g))(ontable a)(ontable c)(ontable d)(ontable f)(ontable g)(test42 ))
   :effect (and (not (plan-put-down i1 c))(not (plan-unstack i2 d b))(not (plan-put-down i3 d))(current i1)(not (current i4))(plan-pick-up i1 c)(plan-stack i2 c d)(plan-pick-up i3 g)(test43 )(not (test42 ))(not (action_applied ))))

 (:action validate_44
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(clear c)(not (handempty ))(holding g)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on a g))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(on b e)(not (on b f))(not (on b g))(not (on c a))(not (on c b))(not (on c c))(on c d)(not (on c e))(not (on c f))(not (on c g))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on d g))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(on e f)(not (on e g))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(not (on f e))(not (on f f))(not (on f g))(not (on g a))(not (on g b))(not (on g c))(not (on g d))(not (on g e))(not (on g f))(not (on g g))(ontable a)(ontable d)(ontable f)(test43 ))
   :effect (and (not (plan-pick-up i1 c))(not (plan-stack i2 c d))(not (plan-pick-up i3 g))(current i1)(not (current i4))(plan-stack i1 g c)(plan-unstack i2 b e)(plan-put-down i3 b)(test44 )(not (test43 ))(not (action_applied ))))

 (:action validate_45
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(clear e)(clear g)(handempty )(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on a g))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on b g))(not (on c a))(not (on c b))(not (on c c))(on c d)(not (on c e))(not (on c f))(not (on c g))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on d g))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(on e f)(not (on e g))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(not (on f e))(not (on f f))(not (on f g))(not (on g a))(not (on g b))(on g c)(not (on g d))(not (on g e))(not (on g f))(not (on g g))(ontable a)(ontable b)(ontable d)(ontable f)(test44 ))
   :effect (and (not (plan-stack i1 g c))(not (plan-unstack i2 b e))(not (plan-put-down i3 b))(current i1)(not (current i4))(plan-unstack i1 e f)(plan-put-down i2 e)(plan-pick-up i3 f)(test45 )(not (test44 ))(not (action_applied ))))

 (:action validate_46
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(clear e)(clear g)(not (handempty ))(holding f)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on a g))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on b g))(not (on c a))(not (on c b))(not (on c c))(on c d)(not (on c e))(not (on c f))(not (on c g))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on d g))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on e g))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(not (on f e))(not (on f f))(not (on f g))(not (on g a))(not (on g b))(on g c)(not (on g d))(not (on g e))(not (on g f))(not (on g g))(ontable a)(ontable b)(ontable d)(ontable e)(test45 ))
   :effect (and (not (plan-unstack i1 e f))(not (plan-put-down i2 e))(not (plan-pick-up i3 f))(current i1)(not (current i4))(plan-stack i1 f g)(plan-pick-up i2 b)(plan-stack i3 b f)(test46 )(not (test45 ))(not (action_applied ))))

 (:action validate_47
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(clear e)(handempty )(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on a g))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(on b f)(not (on b g))(not (on c a))(not (on c b))(not (on c c))(on c d)(not (on c e))(not (on c f))(not (on c g))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on d g))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on e g))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(not (on f e))(not (on f f))(on f g)(not (on g a))(not (on g b))(on g c)(not (on g d))(not (on g e))(not (on g f))(not (on g g))(ontable a)(ontable d)(ontable e)(test46 ))
   :effect (and (not (plan-stack i1 f g))(not (plan-pick-up i2 b))(not (plan-stack i3 b f))(current i1)(not (current i4))(plan-pick-up i1 e)(plan-stack i2 e b)(plan-pick-up i3 a)(test47 )(not (test46 ))(not (action_applied ))))

 (:action validate_48
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear e)(not (handempty ))(holding a)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on a g))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(on b f)(not (on b g))(not (on c a))(not (on c b))(not (on c c))(on c d)(not (on c e))(not (on c f))(not (on c g))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on d g))(not (on e a))(on e b)(not (on e c))(not (on e d))(not (on e e))(not (on e f))(not (on e g))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(not (on f e))(not (on f f))(on f g)(not (on g a))(not (on g b))(on g c)(not (on g d))(not (on g e))(not (on g f))(not (on g g))(ontable d)(test47 ))
   :effect (and (not (plan-pick-up i1 e))(not (plan-stack i2 e b))(not (plan-pick-up i3 a))(current i1)(not (current i4))(not (clear e))(not (holding a))(not (on c d))(not (on g c))(not (on b f))(not (on e b))(not (on f g))(on b c)(on a d)(on g e)(clear b)(on e f)(handempty )(ontable f)(clear a)(on c g)(plan-unstack i1 b c)(plan-put-down i2 b)(plan-unstack i3 a d)(test48 )(not (test47 ))(not (action_applied ))))

 (:action validate_49
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear b)(clear c)(clear d)(not (handempty ))(holding a)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on a g))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on b g))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on c f))(on c g)(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on d g))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(on e f)(not (on e g))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(not (on f e))(not (on f f))(not (on f g))(not (on g a))(not (on g b))(not (on g c))(not (on g d))(on g e)(not (on g f))(not (on g g))(ontable b)(ontable d)(ontable f)(test48 ))
   :effect (and (not (plan-unstack i1 b c))(not (plan-put-down i2 b))(not (plan-unstack i3 a d))(current i1)(not (current i4))(plan-put-down i1 a)(plan-unstack i2 c g)(plan-put-down i3 c)(test49 )(not (test48 ))(not (action_applied ))))

 (:action validate_50
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(clear c)(clear d)(clear g)(handempty )(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on a g))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on b g))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on c f))(not (on c g))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on d g))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(on e f)(not (on e g))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(not (on f e))(not (on f f))(not (on f g))(not (on g a))(not (on g b))(not (on g c))(not (on g d))(on g e)(not (on g f))(not (on g g))(ontable a)(ontable b)(ontable c)(ontable d)(ontable f)(test49 ))
   :effect (and (not (plan-put-down i1 a))(not (plan-unstack i2 c g))(not (plan-put-down i3 c))(current i1)(not (current i4))(plan-unstack i1 g e)(plan-put-down i2 g)(plan-pick-up i3 c)(test50 )(not (test49 ))(not (action_applied ))))

 (:action validate_51
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(clear a)(clear b)(clear d)(clear e)(clear g)(not (handempty ))(holding c)(not (on a a))(not (on a b))(not (on a c))(not (on a d))(not (on a e))(not (on a f))(not (on a g))(not (on b a))(not (on b b))(not (on b c))(not (on b d))(not (on b e))(not (on b f))(not (on b g))(not (on c a))(not (on c b))(not (on c c))(not (on c d))(not (on c e))(not (on c f))(not (on c g))(not (on d a))(not (on d b))(not (on d c))(not (on d d))(not (on d e))(not (on d f))(not (on d g))(not (on e a))(not (on e b))(not (on e c))(not (on e d))(not (on e e))(on e f)(not (on e g))(not (on f a))(not (on f b))(not (on f c))(not (on f d))(not (on f e))(not (on f f))(not (on f g))(not (on g a))(not (on g b))(not (on g c))(not (on g d))(not (on g e))(not (on g f))(not (on g g))(ontable a)(ontable b)(ontable d)(ontable f)(ontable g)(test50 ))
   :effect (and (not (plan-unstack i1 g e))(not (plan-put-down i2 g))(not (plan-pick-up i3 c))(current i1)(not (current i4))(not (test50 ))(test51 )))

)