(define (domain logistics)
 (:requirements :strips :typing)
 (:types object - None truck - vehicle airplane - vehicle package - physobj vehicle - physobj airport - place location - place city - object place - object physobj - object step - None )
 (:constants apn1 -  airplane apt1 -  airport apt2 -  airport cit1 -  city cit2 -  city i1 -  step i2 -  step i3 -  step i4 -  step obj11 -  package obj12 -  package obj13 -  package obj21 -  package obj22 -  package obj23 -  package pos1 -  location pos2 -  location tru1 -  truck tru2 -  truck)
 (:predicates (action_applied) (add_at_load-airplane_var1_var3) (add_at_load-truck_var1_var3) (add_at_unload-airplane_var1_var3) (add_at_unload-truck_var1_var3) (add_in-city_drive-truck_var2_var4) (add_in-city_drive-truck_var3_var4) (add_in_load-airplane_var1_var2) (add_in_load-truck_var1_var2) (add_in_unload-airplane_var1_var2) (add_in_unload-truck_var1_var2) (at ?o1 - physobj ?o2 - place) (current ?i - step) (del_at_load-airplane_var1_var3) (del_at_load-truck_var1_var3) (del_at_unload-airplane_var1_var3) (del_at_unload-truck_var1_var3) (del_in-city_drive-truck_var2_var4) (del_in-city_drive-truck_var3_var4) (del_in_load-airplane_var1_var2) (del_in_load-truck_var1_var2) (del_in_unload-airplane_var1_var2) (del_in_unload-truck_var1_var2) (in ?o1 - package ?o2 - vehicle) (in-city ?o1 - place ?o2 - city) (inext ?i1 - step ?i2 - step) (modeProg) (plan-drive-truck ?i - step ?o1 - truck ?o2 - place ?o3 - place ?city - city) (plan-fly-airplane ?i - step ?o1 - airplane ?o2 - airport ?o3 - airport) (plan-load-airplane ?i - step ?o1 - package ?o2 - airplane ?o3 - place) (plan-load-truck ?i - step ?o1 - package ?o2 - truck ?o3 - place) (plan-unload-airplane ?i - step ?o1 - package ?o2 - airplane ?o3 - place) (plan-unload-truck ?i - step ?o1 - package ?o2 - truck ?o3 - place) (pre_at_load-airplane_var1_var3) (pre_at_load-truck_var1_var3) (pre_at_unload-airplane_var1_var3) (pre_at_unload-truck_var1_var3) (pre_in-city_drive-truck_var2_var4) (pre_in-city_drive-truck_var3_var4) (pre_in_load-airplane_var1_var2) (pre_in_load-truck_var1_var2) (pre_in_unload-airplane_var1_var2) (pre_in_unload-truck_var1_var2) (test1) (test10) (test11) (test12) (test13) (test14) (test15) (test16) (test17) (test18) (test19) (test2) (test20) (test21) (test22) (test23) (test24) (test25) (test26) (test27) (test28) (test29) (test3) (test30) (test31) (test32) (test33) (test34) (test35) (test36) (test37) (test38) (test39) (test4) (test40) (test41) (test42) (test43) (test44) (test45) (test46) (test47) (test48) (test49) (test5) (test50) (test51) (test52) (test53) (test54) (test55) (test56) (test57) (test58) (test59) (test6) (test60) (test61) (test62) (test63) (test64) (test7) (test8) (test9))

 (:action load-truck
   :parameters (?o1 - package ?o2 - truck ?o3 - place ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(or (not (pre_at_load-truck_var1_var3 ))(at ?o1 ?o3))(or (not (pre_in_load-truck_var1_var2 ))(in ?o1 ?o2))(current ?i1)(inext ?i1 ?i2)(plan-load-truck ?i1 ?o1 ?o2 ?o3))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)(when (and (del_at_load-truck_var1_var3 ))(not (at ?o1 ?o3)))(when (and (add_at_load-truck_var1_var3 ))(at ?o1 ?o3))(when (and (del_in_load-truck_var1_var2 ))(not (in ?o1 ?o2)))(when (and (add_in_load-truck_var1_var2 ))(in ?o1 ?o2))))

 (:action load-airplane
   :parameters (?o1 - package ?o2 - airplane ?o3 - place ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(or (not (pre_at_load-airplane_var1_var3 ))(at ?o1 ?o3))(or (not (pre_in_load-airplane_var1_var2 ))(in ?o1 ?o2))(current ?i1)(inext ?i1 ?i2)(plan-load-airplane ?i1 ?o1 ?o2 ?o3))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)(when (and (del_at_load-airplane_var1_var3 ))(not (at ?o1 ?o3)))(when (and (add_at_load-airplane_var1_var3 ))(at ?o1 ?o3))(when (and (del_in_load-airplane_var1_var2 ))(not (in ?o1 ?o2)))(when (and (add_in_load-airplane_var1_var2 ))(in ?o1 ?o2))))

 (:action unload-truck
   :parameters (?o1 - package ?o2 - truck ?o3 - place ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(or (not (pre_at_unload-truck_var1_var3 ))(at ?o1 ?o3))(or (not (pre_in_unload-truck_var1_var2 ))(in ?o1 ?o2))(current ?i1)(inext ?i1 ?i2)(plan-unload-truck ?i1 ?o1 ?o2 ?o3))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)(when (and (del_at_unload-truck_var1_var3 ))(not (at ?o1 ?o3)))(when (and (add_at_unload-truck_var1_var3 ))(at ?o1 ?o3))(when (and (del_in_unload-truck_var1_var2 ))(not (in ?o1 ?o2)))(when (and (add_in_unload-truck_var1_var2 ))(in ?o1 ?o2))))

 (:action unload-airplane
   :parameters (?o1 - package ?o2 - airplane ?o3 - place ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(or (not (pre_at_unload-airplane_var1_var3 ))(at ?o1 ?o3))(or (not (pre_in_unload-airplane_var1_var2 ))(in ?o1 ?o2))(current ?i1)(inext ?i1 ?i2)(plan-unload-airplane ?i1 ?o1 ?o2 ?o3))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)(when (and (del_at_unload-airplane_var1_var3 ))(not (at ?o1 ?o3)))(when (and (add_at_unload-airplane_var1_var3 ))(at ?o1 ?o3))(when (and (del_in_unload-airplane_var1_var2 ))(not (in ?o1 ?o2)))(when (and (add_in_unload-airplane_var1_var2 ))(in ?o1 ?o2))))

 (:action drive-truck
   :parameters (?o1 - truck ?o2 - place ?o3 - place ?o4 - city ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(or (not (pre_in-city_drive-truck_var2_var4 ))(in-city ?o2 ?o4))(or (not (pre_in-city_drive-truck_var3_var4 ))(in-city ?o3 ?o4))(current ?i1)(inext ?i1 ?i2)(plan-drive-truck ?i1 ?o1 ?o2 ?o3 ?o4))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)(when (and (del_in-city_drive-truck_var2_var4 ))(not (in-city ?o2 ?o4)))(when (and (add_in-city_drive-truck_var2_var4 ))(in-city ?o2 ?o4))(when (and (del_in-city_drive-truck_var3_var4 ))(not (in-city ?o3 ?o4)))(when (and (add_in-city_drive-truck_var3_var4 ))(in-city ?o3 ?o4))))

 (:action fly-airplane
   :parameters (?o1 - airplane ?o2 - airport ?o3 - airport ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(current ?i1)(inext ?i1 ?i2)(plan-fly-airplane ?i1 ?o1 ?o2 ?o3))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)))

 (:action program_pre_at_load-truck_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_at_load-truck_var1_var3 ))(not (del_at_load-truck_var1_var3 ))(not (add_at_load-truck_var1_var3 )))
   :effect (and (pre_at_load-truck_var1_var3 )))

 (:action program_eff_at_load-truck_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_at_load-truck_var1_var3 ))(not (add_at_load-truck_var1_var3 )))
   :effect (and (when (pre_at_load-truck_var1_var3 )(del_at_load-truck_var1_var3 ))(when (not (pre_at_load-truck_var1_var3 ))(add_at_load-truck_var1_var3 ))))

 (:action program_pre_in_load-truck_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_in_load-truck_var1_var2 ))(not (del_in_load-truck_var1_var2 ))(not (add_in_load-truck_var1_var2 )))
   :effect (and (pre_in_load-truck_var1_var2 )))

 (:action program_eff_in_load-truck_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_in_load-truck_var1_var2 ))(not (add_in_load-truck_var1_var2 )))
   :effect (and (when (pre_in_load-truck_var1_var2 )(del_in_load-truck_var1_var2 ))(when (not (pre_in_load-truck_var1_var2 ))(add_in_load-truck_var1_var2 ))))

 (:action program_pre_at_load-airplane_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_at_load-airplane_var1_var3 ))(not (del_at_load-airplane_var1_var3 ))(not (add_at_load-airplane_var1_var3 )))
   :effect (and (pre_at_load-airplane_var1_var3 )))

 (:action program_eff_at_load-airplane_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_at_load-airplane_var1_var3 ))(not (add_at_load-airplane_var1_var3 )))
   :effect (and (when (pre_at_load-airplane_var1_var3 )(del_at_load-airplane_var1_var3 ))(when (not (pre_at_load-airplane_var1_var3 ))(add_at_load-airplane_var1_var3 ))))

 (:action program_pre_in_load-airplane_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_in_load-airplane_var1_var2 ))(not (del_in_load-airplane_var1_var2 ))(not (add_in_load-airplane_var1_var2 )))
   :effect (and (pre_in_load-airplane_var1_var2 )))

 (:action program_eff_in_load-airplane_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_in_load-airplane_var1_var2 ))(not (add_in_load-airplane_var1_var2 )))
   :effect (and (when (pre_in_load-airplane_var1_var2 )(del_in_load-airplane_var1_var2 ))(when (not (pre_in_load-airplane_var1_var2 ))(add_in_load-airplane_var1_var2 ))))

 (:action program_pre_at_unload-truck_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_at_unload-truck_var1_var3 ))(not (del_at_unload-truck_var1_var3 ))(not (add_at_unload-truck_var1_var3 )))
   :effect (and (pre_at_unload-truck_var1_var3 )))

 (:action program_eff_at_unload-truck_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_at_unload-truck_var1_var3 ))(not (add_at_unload-truck_var1_var3 )))
   :effect (and (when (pre_at_unload-truck_var1_var3 )(del_at_unload-truck_var1_var3 ))(when (not (pre_at_unload-truck_var1_var3 ))(add_at_unload-truck_var1_var3 ))))

 (:action program_pre_in_unload-truck_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_in_unload-truck_var1_var2 ))(not (del_in_unload-truck_var1_var2 ))(not (add_in_unload-truck_var1_var2 )))
   :effect (and (pre_in_unload-truck_var1_var2 )))

 (:action program_eff_in_unload-truck_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_in_unload-truck_var1_var2 ))(not (add_in_unload-truck_var1_var2 )))
   :effect (and (when (pre_in_unload-truck_var1_var2 )(del_in_unload-truck_var1_var2 ))(when (not (pre_in_unload-truck_var1_var2 ))(add_in_unload-truck_var1_var2 ))))

 (:action program_pre_at_unload-airplane_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_at_unload-airplane_var1_var3 ))(not (del_at_unload-airplane_var1_var3 ))(not (add_at_unload-airplane_var1_var3 )))
   :effect (and (pre_at_unload-airplane_var1_var3 )))

 (:action program_eff_at_unload-airplane_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_at_unload-airplane_var1_var3 ))(not (add_at_unload-airplane_var1_var3 )))
   :effect (and (when (pre_at_unload-airplane_var1_var3 )(del_at_unload-airplane_var1_var3 ))(when (not (pre_at_unload-airplane_var1_var3 ))(add_at_unload-airplane_var1_var3 ))))

 (:action program_pre_in_unload-airplane_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_in_unload-airplane_var1_var2 ))(not (del_in_unload-airplane_var1_var2 ))(not (add_in_unload-airplane_var1_var2 )))
   :effect (and (pre_in_unload-airplane_var1_var2 )))

 (:action program_eff_in_unload-airplane_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_in_unload-airplane_var1_var2 ))(not (add_in_unload-airplane_var1_var2 )))
   :effect (and (when (pre_in_unload-airplane_var1_var2 )(del_in_unload-airplane_var1_var2 ))(when (not (pre_in_unload-airplane_var1_var2 ))(add_in_unload-airplane_var1_var2 ))))

 (:action program_pre_in-city_drive-truck_var2_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_in-city_drive-truck_var2_var4 ))(not (del_in-city_drive-truck_var2_var4 ))(not (add_in-city_drive-truck_var2_var4 )))
   :effect (and (pre_in-city_drive-truck_var2_var4 )))

 (:action program_eff_in-city_drive-truck_var2_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_in-city_drive-truck_var2_var4 ))(not (add_in-city_drive-truck_var2_var4 )))
   :effect (and (when (pre_in-city_drive-truck_var2_var4 )(del_in-city_drive-truck_var2_var4 ))(when (not (pre_in-city_drive-truck_var2_var4 ))(add_in-city_drive-truck_var2_var4 ))))

 (:action program_pre_in-city_drive-truck_var3_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_in-city_drive-truck_var3_var4 ))(not (del_in-city_drive-truck_var3_var4 ))(not (add_in-city_drive-truck_var3_var4 )))
   :effect (and (pre_in-city_drive-truck_var3_var4 )))

 (:action program_eff_in-city_drive-truck_var3_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_in-city_drive-truck_var3_var4 ))(not (add_in-city_drive-truck_var3_var4 )))
   :effect (and (when (pre_in-city_drive-truck_var3_var4 )(del_in-city_drive-truck_var3_var4 ))(when (not (pre_in-city_drive-truck_var3_var4 ))(add_in-city_drive-truck_var3_var4 ))))

 (:action validate_1
   :parameters ()
   :precondition (and (modeProg ))
   :effect (and (not (modeProg ))(current i1)(at apn1 apt2)(at obj11 pos1)(at obj12 pos1)(at obj13 pos1)(at obj21 pos2)(at obj22 pos2)(at obj23 pos2)(at tru1 pos1)(at tru2 pos2)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(plan-load-truck i1 obj23 tru2 pos2)(plan-load-truck i2 obj21 tru2 pos2)(plan-drive-truck i3 tru2 pos2 apt2 cit2)(test1 )(not (action_applied ))))

 (:action validate_2
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt2)(at obj11 pos1)(at obj12 pos1)(at obj13 pos1)(at obj22 pos2)(at tru1 pos1)(at tru2 apt2)(in obj21 tru2)(in obj23 tru2)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test1 ))
   :effect (and (not (plan-load-truck i1 obj23 tru2 pos2))(not (plan-load-truck i2 obj21 tru2 pos2))(not (plan-drive-truck i3 tru2 pos2 apt2 cit2))(current i1)(not (current i4))(plan-unload-truck i1 obj23 tru2 apt2)(plan-unload-truck i2 obj21 tru2 apt2)(plan-load-airplane i3 obj23 apn1 apt2)(test2 )(not (test1 ))(not (action_applied ))))

 (:action validate_3
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt2)(at obj11 pos1)(at obj12 pos1)(at obj13 pos1)(at obj21 apt2)(at obj22 pos2)(at tru1 pos1)(at tru2 apt2)(in obj23 apn1)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test2 ))
   :effect (and (not (plan-unload-truck i1 obj23 tru2 apt2))(not (plan-unload-truck i2 obj21 tru2 apt2))(not (plan-load-airplane i3 obj23 apn1 apt2))(current i1)(not (current i4))(plan-load-airplane i1 obj21 apn1 apt2)(plan-fly-airplane i2 apn1 apt2 apt1)(plan-unload-airplane i3 obj23 apn1 apt1)(test3 )(not (test2 ))(not (action_applied ))))

 (:action validate_4
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt1)(at obj11 pos1)(at obj12 pos1)(at obj13 pos1)(at obj22 pos2)(at obj23 apt1)(at tru1 pos1)(at tru2 apt2)(in obj21 apn1)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test3 ))
   :effect (and (not (plan-load-airplane i1 obj21 apn1 apt2))(not (plan-fly-airplane i2 apn1 apt2 apt1))(not (plan-unload-airplane i3 obj23 apn1 apt1))(current i1)(not (current i4))(plan-unload-airplane i1 obj21 apn1 apt1)(plan-load-truck i2 obj11 tru1 pos1)(plan-load-truck i3 obj13 tru1 pos1)(test4 )(not (test3 ))(not (action_applied ))))

 (:action validate_5
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt1)(at obj12 pos1)(at obj21 apt1)(at obj22 pos2)(at obj23 apt1)(at tru1 pos1)(at tru2 apt2)(in obj11 tru1)(in obj13 tru1)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test4 ))
   :effect (and (not (plan-unload-airplane i1 obj21 apn1 apt1))(not (plan-load-truck i2 obj11 tru1 pos1))(not (plan-load-truck i3 obj13 tru1 pos1))(current i1)(not (current i4))(plan-drive-truck i1 tru1 pos1 apt1 cit1)(plan-load-truck i2 obj23 tru1 apt1)(plan-load-truck i3 obj21 tru1 apt1)(test5 )(not (test4 ))(not (action_applied ))))

 (:action validate_6
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt1)(at obj12 pos1)(at obj22 pos2)(at tru1 apt1)(at tru2 apt2)(in obj11 tru1)(in obj13 tru1)(in obj21 tru1)(in obj23 tru1)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test5 ))
   :effect (and (not (plan-drive-truck i1 tru1 pos1 apt1 cit1))(not (plan-load-truck i2 obj23 tru1 apt1))(not (plan-load-truck i3 obj21 tru1 apt1))(current i1)(not (current i4))(plan-unload-truck i1 obj11 tru1 apt1)(plan-unload-truck i2 obj13 tru1 apt1)(plan-drive-truck i3 tru1 apt1 pos1 cit1)(test6 )(not (test5 ))(not (action_applied ))))

 (:action validate_7
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt1)(at obj11 apt1)(at obj12 pos1)(at obj13 apt1)(at obj22 pos2)(at tru1 pos1)(at tru2 apt2)(in obj21 tru1)(in obj23 tru1)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test6 ))
   :effect (and (not (plan-unload-truck i1 obj11 tru1 apt1))(not (plan-unload-truck i2 obj13 tru1 apt1))(not (plan-drive-truck i3 tru1 apt1 pos1 cit1))(current i1)(not (current i4))(not (in obj21 tru1))(not (at tru2 apt2))(not (in obj23 tru1))(not (at obj11 apt1))(not (at obj13 apt1))(at obj13 pos1)(at tru2 pos2)(at obj23 pos2)(at obj11 pos1)(at obj21 pos2)(plan-load-truck i1 obj11 tru1 pos1)(plan-drive-truck i2 tru1 pos1 apt1 cit1)(plan-unload-truck i3 obj11 tru1 apt1)(test7 )(not (test6 ))(not (action_applied ))))

 (:action validate_8
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt1)(at obj11 apt1)(at obj12 pos1)(at obj13 pos1)(at obj21 pos2)(at obj22 pos2)(at obj23 pos2)(at tru1 apt1)(at tru2 pos2)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test7 ))
   :effect (and (not (plan-load-truck i1 obj11 tru1 pos1))(not (plan-drive-truck i2 tru1 pos1 apt1 cit1))(not (plan-unload-truck i3 obj11 tru1 apt1))(current i1)(not (current i4))(plan-load-truck i1 obj21 tru2 pos2)(plan-load-airplane i2 obj11 apn1 apt1)(plan-fly-airplane i3 apn1 apt1 apt2)(test8 )(not (test7 ))(not (action_applied ))))

 (:action validate_9
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt2)(at obj12 pos1)(at obj13 pos1)(at obj22 pos2)(at obj23 pos2)(at tru1 apt1)(at tru2 pos2)(in obj11 apn1)(in obj21 tru2)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test8 ))
   :effect (and (not (plan-load-truck i1 obj21 tru2 pos2))(not (plan-load-airplane i2 obj11 apn1 apt1))(not (plan-fly-airplane i3 apn1 apt1 apt2))(current i1)(not (current i4))(plan-unload-airplane i1 obj11 apn1 apt2)(plan-drive-truck i2 tru2 pos2 apt2 cit2)(plan-unload-truck i3 obj21 tru2 apt2)(test9 )(not (test8 ))(not (action_applied ))))

 (:action validate_10
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt2)(at obj11 apt2)(at obj12 pos1)(at obj13 pos1)(at obj21 apt2)(at obj22 pos2)(at obj23 pos2)(at tru1 apt1)(at tru2 apt2)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test9 ))
   :effect (and (not (plan-unload-airplane i1 obj11 apn1 apt2))(not (plan-drive-truck i2 tru2 pos2 apt2 cit2))(not (plan-unload-truck i3 obj21 tru2 apt2))(current i1)(not (current i4))(plan-load-airplane i1 obj21 apn1 apt2)(plan-fly-airplane i2 apn1 apt2 apt1)(plan-load-truck i3 obj11 tru2 apt2)(test10 )(not (test9 ))(not (action_applied ))))

 (:action validate_11
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt1)(at obj12 pos1)(at obj13 pos1)(at obj22 pos2)(at obj23 pos2)(at tru1 apt1)(at tru2 apt2)(in obj11 tru2)(in obj21 apn1)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test10 ))
   :effect (and (not (plan-load-airplane i1 obj21 apn1 apt2))(not (plan-fly-airplane i2 apn1 apt2 apt1))(not (plan-load-truck i3 obj11 tru2 apt2))(current i1)(not (current i4))(plan-drive-truck i1 tru2 apt2 pos2 cit2)(plan-unload-airplane i2 obj21 apn1 apt1)(plan-unload-truck i3 obj11 tru2 pos2)(test11 )(not (test10 ))(not (action_applied ))))

 (:action validate_12
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt1)(at obj11 pos2)(at obj12 pos1)(at obj13 pos1)(at obj21 apt1)(at obj22 pos2)(at obj23 pos2)(at tru1 apt1)(at tru2 pos2)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test11 ))
   :effect (and (not (plan-drive-truck i1 tru2 apt2 pos2 cit2))(not (plan-unload-airplane i2 obj21 apn1 apt1))(not (plan-unload-truck i3 obj11 tru2 pos2))(current i1)(not (current i4))(not (at obj21 apt1))(not (at tru1 apt1))(not (at obj11 pos2))(at obj11 pos1)(at obj21 pos2)(at tru1 pos1)(plan-load-truck i1 obj12 tru1 pos1)(plan-load-truck i2 obj11 tru1 pos1)(plan-load-truck i3 obj22 tru2 pos2)(test12 )(not (test11 ))(not (action_applied ))))

 (:action validate_13
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt1)(at obj13 pos1)(at obj21 pos2)(at obj23 pos2)(at tru1 pos1)(at tru2 pos2)(in obj11 tru1)(in obj12 tru1)(in obj22 tru2)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test12 ))
   :effect (and (not (plan-load-truck i1 obj12 tru1 pos1))(not (plan-load-truck i2 obj11 tru1 pos1))(not (plan-load-truck i3 obj22 tru2 pos2))(current i1)(not (current i4))(plan-load-truck i1 obj13 tru1 pos1)(plan-drive-truck i2 tru1 pos1 apt1 cit1)(plan-unload-truck i3 obj12 tru1 apt1)(test13 )(not (test12 ))(not (action_applied ))))

 (:action validate_14
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt1)(at obj12 apt1)(at obj21 pos2)(at obj23 pos2)(at tru1 apt1)(at tru2 pos2)(in obj11 tru1)(in obj13 tru1)(in obj22 tru2)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test13 ))
   :effect (and (not (plan-load-truck i1 obj13 tru1 pos1))(not (plan-drive-truck i2 tru1 pos1 apt1 cit1))(not (plan-unload-truck i3 obj12 tru1 apt1))(current i1)(not (current i4))(plan-unload-truck i1 obj11 tru1 apt1)(plan-load-airplane i2 obj12 apn1 apt1)(plan-load-airplane i3 obj11 apn1 apt1)(test14 )(not (test13 ))(not (action_applied ))))

 (:action validate_15
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt1)(at obj21 pos2)(at obj23 pos2)(at tru1 apt1)(at tru2 pos2)(in obj11 apn1)(in obj12 apn1)(in obj13 tru1)(in obj22 tru2)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test14 ))
   :effect (and (not (plan-unload-truck i1 obj11 tru1 apt1))(not (plan-load-airplane i2 obj12 apn1 apt1))(not (plan-load-airplane i3 obj11 apn1 apt1))(current i1)(not (current i4))(plan-unload-truck i1 obj13 tru1 apt1)(plan-load-truck i2 obj23 tru2 pos2)(plan-load-airplane i3 obj13 apn1 apt1)(test15 )(not (test14 ))(not (action_applied ))))

 (:action validate_16
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt1)(at obj21 pos2)(at tru1 apt1)(at tru2 pos2)(in obj11 apn1)(in obj12 apn1)(in obj13 apn1)(in obj22 tru2)(in obj23 tru2)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test15 ))
   :effect (and (not (plan-unload-truck i1 obj13 tru1 apt1))(not (plan-load-truck i2 obj23 tru2 pos2))(not (plan-load-airplane i3 obj13 apn1 apt1))(current i1)(not (current i4))(plan-fly-airplane i1 apn1 apt1 apt2)(plan-unload-airplane i2 obj12 apn1 apt2)(plan-unload-airplane i3 obj11 apn1 apt2)(test16 )(not (test15 ))(not (action_applied ))))

 (:action validate_17
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt2)(at obj11 apt2)(at obj12 apt2)(at obj21 pos2)(at tru1 apt1)(at tru2 pos2)(in obj13 apn1)(in obj22 tru2)(in obj23 tru2)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test16 ))
   :effect (and (not (plan-fly-airplane i1 apn1 apt1 apt2))(not (plan-unload-airplane i2 obj12 apn1 apt2))(not (plan-unload-airplane i3 obj11 apn1 apt2))(current i1)(not (current i4))(plan-unload-airplane i1 obj13 apn1 apt2)(plan-drive-truck i2 tru2 pos2 apt2 cit2)(plan-unload-truck i3 obj22 tru2 apt2)(test17 )(not (test16 ))(not (action_applied ))))

 (:action validate_18
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt2)(at obj11 apt2)(at obj12 apt2)(at obj13 apt2)(at obj21 pos2)(at obj22 apt2)(at tru1 apt1)(at tru2 apt2)(in obj23 tru2)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test17 ))
   :effect (and (not (plan-unload-airplane i1 obj13 apn1 apt2))(not (plan-drive-truck i2 tru2 pos2 apt2 cit2))(not (plan-unload-truck i3 obj22 tru2 apt2))(current i1)(not (current i4))(plan-load-airplane i1 obj22 apn1 apt2)(plan-fly-airplane i2 apn1 apt2 apt1)(plan-load-truck i3 obj12 tru2 apt2)(test18 )(not (test17 ))(not (action_applied ))))

 (:action validate_19
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt1)(at obj11 apt2)(at obj13 apt2)(at obj21 pos2)(at tru1 apt1)(at tru2 apt2)(in obj12 tru2)(in obj22 apn1)(in obj23 tru2)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test18 ))
   :effect (and (not (plan-load-airplane i1 obj22 apn1 apt2))(not (plan-fly-airplane i2 apn1 apt2 apt1))(not (plan-load-truck i3 obj12 tru2 apt2))(current i1)(not (current i4))(plan-load-truck i1 obj11 tru2 apt2)(plan-unload-truck i2 obj23 tru2 apt2)(plan-drive-truck i3 tru2 apt2 pos2 cit2)(test19 )(not (test18 ))(not (action_applied ))))

 (:action validate_20
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt1)(at obj13 apt2)(at obj21 pos2)(at obj23 apt2)(at tru1 apt1)(at tru2 pos2)(in obj11 tru2)(in obj12 tru2)(in obj22 apn1)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test19 ))
   :effect (and (not (plan-load-truck i1 obj11 tru2 apt2))(not (plan-unload-truck i2 obj23 tru2 apt2))(not (plan-drive-truck i3 tru2 apt2 pos2 cit2))(current i1)(not (current i4))(plan-unload-airplane i1 obj22 apn1 apt1)(plan-unload-truck i2 obj12 tru2 pos2)(plan-unload-truck i3 obj11 tru2 pos2)(test20 )(not (test19 ))(not (action_applied ))))

 (:action validate_21
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt1)(at obj11 pos2)(at obj12 pos2)(at obj13 apt2)(at obj21 pos2)(at obj22 apt1)(at obj23 apt2)(at tru1 apt1)(at tru2 pos2)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test20 ))
   :effect (and (not (plan-unload-airplane i1 obj22 apn1 apt1))(not (plan-unload-truck i2 obj12 tru2 pos2))(not (plan-unload-truck i3 obj11 tru2 pos2))(current i1)(not (current i4))(not (at obj23 apt2))(not (at tru1 apt1))(not (at obj12 pos2))(not (at obj11 pos2))(not (at obj22 apt1))(not (at obj13 apt2))(at obj23 pos2)(at obj13 pos1)(at tru1 pos1)(at obj12 pos1)(at obj22 pos2)(at obj11 pos1)(plan-load-truck i1 obj23 tru2 pos2)(plan-load-truck i2 obj22 tru2 pos2)(plan-load-truck i3 obj21 tru2 pos2)(test21 )(not (test20 ))(not (action_applied ))))

 (:action validate_22
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(at apn1 apt1)(at obj11 pos1)(at obj12 pos1)(at obj13 pos1)(at tru1 pos1)(at tru2 pos2)(in obj21 tru2)(in obj22 tru2)(in obj23 tru2)(in-city apt1 cit1)(in-city apt2 cit2)(in-city pos1 cit1)(in-city pos2 cit2)(test21 ))
   :effect (and (not (plan-load-truck i1 obj23 tru2 pos2))(not (plan-load-truck i2 obj22 tru2 pos2))(not (plan-load-truck i3 obj21 tru2 pos2))(current i1)(not (current i4))(not (test21 ))(test22 )))

)