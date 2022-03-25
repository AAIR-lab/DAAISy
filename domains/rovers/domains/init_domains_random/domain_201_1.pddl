(define (domain Rover)
    (:requirements :typing)
    (:types rover waypoint store camera mode lander objective)
    
    (:predicates (at ?x - rover ?y - waypoint) 
                 (at_lander ?x - lander ?y - waypoint)
                 (can_traverse ?r - rover ?x - waypoint ?y - waypoint)
                 (equipped_for_soil_analysis ?r - rover)
                 (equipped_for_rock_analysis ?r - rover)
                 (equipped_for_imaging ?r - rover)
                 (empty ?s - store)
                 (have_rock_analysis ?r - rover ?w - waypoint)
                 (have_soil_analysis ?r - rover ?w - waypoint)
                 (full ?s - store)
                 (calibrated ?c - camera ?r - rover) 
                 (supports ?c - camera ?m - mode)
                 (available ?r - rover)
                 (visible ?w - waypoint ?p - waypoint)
                 (have_image ?r - rover ?o - objective ?m - mode)
                 (communicated_soil_data ?w - waypoint)
                 (communicated_rock_data ?w - waypoint)
                 (communicated_image_data ?o - objective ?m - mode)
                 (at_soil_sample ?w - waypoint)
                 (at_rock_sample ?w - waypoint)
                 (visible_from ?o - objective ?w - waypoint)
                 (store_of ?s - store ?r - rover)
                 (calibration_target ?i - camera ?o - objective)
                 (on_board ?i - camera ?r - rover)
                 (channel_free ?l - lander)
    )
    
    (:action navigate
        :parameters (?x - rover 
                     ?y - waypoint 
                     ?z - waypoint) 
        :precondition (and 
               (not (have_rock_analysis ?x ?z))
			(available ?x)
			(not (equipped_for_imaging ?x))
			(at ?x ?y)
			(have_soil_analysis ?x ?y)
			(not (at_soil_sample ?z))
			(communicated_rock_data ?z)
			(not (visible ?y ?z))
			(can_traverse ?x ?y ?z)
			(not (have_rock_analysis ?x ?y))
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (not (equipped_for_imaging ?x))
			(not (at ?x ?y))
			(have_soil_analysis ?x ?y)
			(not (at_soil_sample ?y))
			(communicated_rock_data ?z)
			(visible ?y ?z)
			(equipped_for_rock_analysis ?x)
			(at ?x ?z)
			(have_soil_analysis ?x ?z)
			(not (have_rock_analysis ?x ?y))
			(communicated_rock_data ?y)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(at ?x ?p)
			(empty ?s)
			(equipped_for_imaging ?x)
			(store_of ?s ?x)
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(communicated_rock_data ?p)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (empty ?s))
			(not (equipped_for_imaging ?x))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(have_soil_analysis ?x ?p)
			(equipped_for_rock_analysis ?x)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(equipped_for_soil_analysis ?x)
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (available ?x))
			(not (at ?x ?p))
			(not (full ?s))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(not (have_soil_analysis ?x ?p))
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(not (empty ?y))
			(equipped_for_soil_analysis ?x)
			(full ?y)
			
          )
        :effect (and 
               (not (full ?y))
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (equipped_for_rock_analysis ?r)
			(not (have_soil_analysis ?r ?w))
			(equipped_for_imaging ?r)
			(not (at ?r ?w))
			(on_board ?i ?r)
			(not (equipped_for_soil_analysis ?r))
			(visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
			(not (communicated_soil_data ?w))
			(communicated_rock_data ?w)
			(not (at_soil_sample ?w))
			(not (calibrated ?i ?r))
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(not (equipped_for_imaging ?r))
			(not (at_rock_sample ?w))
			(equipped_for_soil_analysis ?r)
			(not (visible_from ?t ?w))
			(communicated_rock_data ?w)
			(not (at_soil_sample ?w))
			
          )
    )  
    
    (:action take_image
         :parameters (?r - rover 
                      ?p - waypoint 
                      ?o - objective 
                      ?i - camera 
                      ?m - mode)
         :precondition (and 
               (supports ?i ?m)
			(have_image ?r ?o ?m)
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(at_rock_sample ?p)
			(visible_from ?o ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (supports ?i ?m)
			(not (communicated_image_data ?o ?m))
			(not (have_soil_analysis ?r ?p))
			(equipped_for_rock_analysis ?r)
			(not (have_image ?r ?o ?m))
			(equipped_for_imaging ?r)
			(not (have_rock_analysis ?r ?p))
			(visible_from ?o ?p)
			(calibrated ?i ?r)
			
          )
    )
    
    (:action communicate_soil_data
         :parameters (?r - rover 
                      ?l - lander 
                      ?p - waypoint 
                      ?x - waypoint 
                      ?y - waypoint)
         :precondition (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(visible ?p ?y)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(not (have_rock_analysis ?r ?y))
			(at_soil_sample ?x)
			(not (communicated_soil_data ?p))
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			
          )
          :effect (and 
               (not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (at ?r ?y))
			(have_soil_analysis ?r ?p)
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(visible ?x ?p)
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			
          )
    )
    
    (:action communicate_rock_data
         :parameters (?r - rover 
                      ?l - lander 
                      ?p - waypoint 
                      ?x - waypoint 
                      ?y - waypoint)
         :precondition (and 
               (equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (communicated_rock_data ?p))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?y))
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(have_rock_analysis ?r ?x)
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			
          )
          :effect (and 
               (visible ?y ?x)
			(communicated_rock_data ?x)
			(visible ?p ?x)
			(not (can_traverse ?r ?p ?y))
			(not (have_soil_analysis ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(at_rock_sample ?y)
			(at_rock_sample ?p)
			(communicated_rock_data ?p)
			(at_lander ?l ?y)
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
    )
    
    (:action communicate_image_data
         :parameters (?r - rover 
                      ?l - lander 
                      ?o - objective 
                      ?m - mode 
                      ?x - waypoint 
                      ?y - waypoint)
         :precondition (and 
               (channel_free ?l)
			(not (have_soil_analysis ?r ?x))
			(visible ?x ?y)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (available ?r))
			(not (visible_from ?o ?x))
			(not (at ?r ?x))
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(visible_from ?o ?y)
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (not (visible ?y ?x))
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(at_soil_sample ?y)
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(not (visible_from ?o ?y))
			(communicated_rock_data ?y)
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (have_rock_analysis ?r ?p), (have_soil_analysis ?r ?p), (have_rock_analysis ?r ?y), (at_rock_sample ?x), (communicated_soil_data ?y), (at_lander ?l ?x), (communicated_soil_data ?x), (channel_free ?l), (visible ?y ?p), (have_soil_analysis ?r ?p), (at_soil_sample ?x), (can_traverse ?r ?x ?y), (at_soil_sample ?y), (at ?r ?p), (communicated_rock_data ?y), (equipped_for_rock_analysis ?r), (at_rock_sample ?y), (communicated_rock_data ?x), (equipped_for_soil_analysis ?r), (at_rock_sample ?p), (communicated_soil_data ?y), (at ?r ?y), (have_rock_analysis ?r ?x), (visible ?p ?x), (communicated_soil_data ?p), (at_rock_sample ?p), (available ?r), (can_traverse ?r ?y ?x), (at_lander ?l ?y), (have_soil_analysis ?r ?x), (at ?r ?x), (can_traverse ?r ?y ?x), (have_rock_analysis ?r ?x), (equipped_for_imaging ?r), (visible ?y ?x), (at_soil_sample ?p), (have_soil_analysis ?r ?y), (can_traverse ?r ?x ?y), (at_rock_sample ?y), (can_traverse ?r ?p ?y), (can_traverse ?r ?x ?p), (can_traverse ?r ?p ?x), (visible ?y ?x), (visible ?x ?y), (communicated_rock_data ?p), (visible ?x ?p), (have_soil_analysis ?r ?y), (communicated_rock_data ?x), (have_rock_analysis ?r ?y), (at_soil_sample ?y), (visible ?y ?p), 
;; communicate_image_data action has changed: (at_soil_sample ?x), (at ?r ?y), (have_rock_analysis ?r ?x), (visible_from ?o ?y), (at ?r ?y), (have_image ?r ?o ?m), (at_soil_sample ?y), (at_lander ?l ?y), (visible_from ?o ?x), (at ?r ?x), (available ?r), (at_lander ?l ?x), (communicated_image_data ?o ?m), (communicated_soil_data ?x), (communicated_soil_data ?y), (have_soil_analysis ?r ?y), (visible ?y ?x), (have_soil_analysis ?r ?x), (available ?r), (at_soil_sample ?y), (at ?r ?x), (can_traverse ?r ?y ?x), (have_rock_analysis ?r ?y), (at_lander ?l ?y), (communicated_rock_data ?y), (communicated_rock_data ?y), (visible_from ?o ?y), (can_traverse ?r ?x ?y), (at_rock_sample ?x), (communicated_image_data ?o ?m), (visible ?x ?y), 
;; communicate_soil_data action has changed: (can_traverse ?r ?y ?p), (communicated_rock_data ?p), (can_traverse ?r ?x ?y), (communicated_rock_data ?x), (equipped_for_imaging ?r), (at ?r ?x), (available ?r), (at_soil_sample ?y), (at_rock_sample ?x), (visible ?y ?p), (visible ?x ?y), (visible ?x ?p), (have_soil_analysis ?r ?p), (have_rock_analysis ?r ?y), (have_soil_analysis ?r ?y), (at ?r ?y), (at_soil_sample ?p), (visible ?p ?y), (have_rock_analysis ?r ?x), (can_traverse ?r ?y ?x), (visible ?p ?x), (communicated_soil_data ?x), (have_rock_analysis ?r ?p), (at_soil_sample ?p), (have_soil_analysis ?r ?p), (communicated_soil_data ?p), (communicated_soil_data ?p), (communicated_rock_data ?x), (at_lander ?l ?p), (at_soil_sample ?x), (at_rock_sample ?y), (at ?r ?x), (communicated_rock_data ?p), (have_soil_analysis ?r ?x), (visible ?y ?p), (at_lander ?l ?x), (have_soil_analysis ?r ?x), (at_rock_sample ?x), (at ?r ?y), (at_rock_sample ?y), (at_lander ?l ?y), (at_soil_sample ?x), (visible ?x ?p), (equipped_for_soil_analysis ?r), 
;; navigate action has changed: (communicated_rock_data ?y), (have_soil_analysis ?x ?y), (have_soil_analysis ?x ?y), (at_soil_sample ?z), (communicated_rock_data ?z), (at_soil_sample ?y), (have_soil_analysis ?x ?z), (have_rock_analysis ?x ?z), (equipped_for_rock_analysis ?x), (communicated_rock_data ?z), (have_rock_analysis ?x ?y), (visible ?y ?z), (equipped_for_imaging ?x), (have_rock_analysis ?x ?y), (visible ?y ?z), (communicated_rock_data ?y), (equipped_for_imaging ?x), 
;; sample_rock action has changed: (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), (available ?x), (equipped_for_rock_analysis ?x), (store_of ?s ?x), (empty ?s), (have_rock_analysis ?x ?p), (have_rock_analysis ?x ?p), (have_soil_analysis ?x ?p), (at_soil_sample ?p), (full ?s), (at_rock_sample ?p), (equipped_for_imaging ?x), (at ?x ?p), (equipped_for_soil_analysis ?x), 
;; sample_soil action has changed: (at_rock_sample ?p), (full ?s), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (communicated_rock_data ?p), (available ?x), (communicated_soil_data ?p), (at_soil_sample ?p), (have_rock_analysis ?x ?p), (equipped_for_imaging ?x), (at_soil_sample ?p), 
;; calibrate action has changed: (at_soil_sample ?w), (equipped_for_soil_analysis ?r), (equipped_for_soil_analysis ?r), (at_rock_sample ?w), (have_rock_analysis ?r ?w), (calibrated ?i ?r), (at_soil_sample ?w), (have_soil_analysis ?r ?w), (visible_from ?t ?w), (calibration_target ?i ?t), (communicated_rock_data ?w), (at ?r ?w), (equipped_for_rock_analysis ?r), (calibration_target ?i ?t), (communicated_rock_data ?w), (communicated_soil_data ?w), (equipped_for_imaging ?r), (calibrated ?i ?r), 
;; take_image action has changed: (equipped_for_rock_analysis ?r), (supports ?i ?m), (equipped_for_imaging ?r), (calibrated ?i ?r), (have_image ?r ?o ?m), (at_rock_sample ?p), (have_soil_analysis ?r ?p), (have_rock_analysis ?r ?p), (have_image ?r ?o ?m), (communicated_image_data ?o ?m), (visible_from ?o ?p), 
;; drop action has changed: (equipped_for_soil_analysis ?x), (empty ?y), (empty ?y), 
;; Last_reduced_capability_num_dropped_pals: None
