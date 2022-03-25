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
			(visible ?z ?y)
			(not (at_soil_sample ?z))
			(not (communicated_rock_data ?z))
			(not (visible ?y ?z))
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (available ?x)
			(equipped_for_imaging ?x)
			(at_rock_sample ?y)
			(not (can_traverse ?x ?z ?y))
			(not (at ?x ?y))
			(at_soil_sample ?z)
			(at_soil_sample ?y)
			(communicated_soil_data ?z)
			(communicated_soil_data ?y)
			(equipped_for_rock_analysis ?x)
			(can_traverse ?x ?y ?z)
			(not (at ?x ?z))
			(not (have_soil_analysis ?x ?z))
			(not (communicated_rock_data ?y))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(empty ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (available ?x))
			(not (empty ?s))
			(at_rock_sample ?p)
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (available ?x)
			(at ?x ?p)
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(full ?s)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(communicated_rock_data ?p)
			
          )
        :effect (and 
               (not (available ?x))
			(full ?s)
			(store_of ?s ?x)
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (store_of ?y ?x))
			(full ?y)
			
          )
        :effect (and 
               (equipped_for_rock_analysis ?x)
			(not (full ?y))
			(not (equipped_for_imaging ?x))
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (not (calibration_target ?i ?t))
			(equipped_for_imaging ?r)
			(not (at ?r ?w))
			(not (on_board ?i ?r))
			(not (at_rock_sample ?w))
			(visible_from ?t ?w)
			(communicated_soil_data ?w)
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(have_soil_analysis ?r ?w)
			(available ?r)
			(at ?r ?w)
			(not (on_board ?i ?r))
			(not (at_rock_sample ?w))
			(not (visible_from ?t ?w))
			(have_rock_analysis ?r ?w)
			(not (communicated_rock_data ?w))
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
			(communicated_image_data ?o ?m)
			(not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(equipped_for_soil_analysis ?r)
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(at_rock_sample ?p)
			
          )
          :effect (and 
               (communicated_image_data ?o ?m)
			(have_soil_analysis ?r ?p)
			(have_image ?r ?o ?m)
			(have_rock_analysis ?r ?p)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(communicated_soil_data ?p)
			(not (at ?r ?p))
			
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
			(not (have_soil_analysis ?r ?x))
			(visible ?p ?y)
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_soil_sample ?p)
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(equipped_for_soil_analysis ?r)
			(communicated_soil_data ?x)
			(communicated_soil_data ?y)
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(not (visible ?p ?x))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (at ?r ?p))
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(can_traverse ?r ?y ?p)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
			(not (visible ?x ?p))
			
          )
    )
    
    (:action communicate_rock_data
         :parameters (?r - rover 
                      ?l - lander 
                      ?p - waypoint 
                      ?x - waypoint 
                      ?y - waypoint)
         :precondition (and 
               (not (channel_free ?l))
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(not (visible ?p ?x))
			(at_rock_sample ?x)
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_rock_sample ?p)
			(at_lander ?l ?y)
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(not (communicated_soil_data ?p))
			(not (visible ?y ?p))
			(not (communicated_rock_data ?y))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(have_soil_analysis ?r ?x)
			(visible ?p ?y)
			(not (can_traverse ?r ?p ?y))
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(at_rock_sample ?y)
			(at ?r ?x)
			(at_lander ?l ?x)
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(can_traverse ?r ?x ?p)
			(at_lander ?l ?p)
			(not (equipped_for_rock_analysis ?r))
			(visible ?y ?p)
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			
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
			(not (equipped_for_imaging ?r))
			(have_image ?r ?o ?m)
			(have_soil_analysis ?r ?x)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (at ?r ?y))
			(available ?r)
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			(communicated_rock_data ?y)
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (not (equipped_for_imaging ?r))
			(not (communicated_rock_data ?x))
			(at_rock_sample ?x)
			(not (can_traverse ?r ?x ?y))
			(not (at_rock_sample ?y))
			(visible_from ?o ?x)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(communicated_soil_data ?y)
			(not (equipped_for_rock_analysis ?r))
			(communicated_rock_data ?y)
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; take_image action has changed: (equipped_for_rock_analysis ?r), (at_soil_sample ?p), (calibrated ?i ?r), (calibrated ?i ?r), (communicated_image_data ?o ?m), (at_rock_sample ?p), (at ?r ?p), (have_soil_analysis ?r ?p), (at ?r ?p), (at_rock_sample ?p), (visible_from ?o ?p), (available ?r), (have_rock_analysis ?r ?p), (communicated_soil_data ?p), (equipped_for_soil_analysis ?r), (communicated_image_data ?o ?m), 
;; communicate_soil_data action has changed: (can_traverse ?r ?x ?y), (have_soil_analysis ?r ?x), (at ?r ?y), (at_rock_sample ?x), (at ?r ?y), (visible ?y ?x), (equipped_for_rock_analysis ?r), (at_soil_sample ?p), (can_traverse ?r ?x ?y), (visible ?x ?y), (communicated_rock_data ?p), (have_soil_analysis ?r ?y), (communicated_soil_data ?x), (at_lander ?l ?p), (have_soil_analysis ?r ?p), (equipped_for_soil_analysis ?r), (at_soil_sample ?x), (visible ?x ?y), (visible ?x ?p), (have_soil_analysis ?r ?x), (can_traverse ?r ?y ?x), (at_lander ?l ?x), (communicated_soil_data ?y), (have_rock_analysis ?r ?x), (equipped_for_soil_analysis ?r), (can_traverse ?r ?y ?p), (at ?r ?p), (visible ?p ?x), (can_traverse ?r ?p ?x), (visible ?p ?y), 
;; sample_soil action has changed: (at_soil_sample ?p), (at_rock_sample ?p), (available ?x), (communicated_soil_data ?p), (have_soil_analysis ?x ?p), (available ?x), (have_rock_analysis ?x ?p), (have_rock_analysis ?x ?p), (at_rock_sample ?p), (equipped_for_soil_analysis ?x), (have_soil_analysis ?x ?p), (full ?s), (at ?x ?p), 
;; sample_rock action has changed: (equipped_for_imaging ?x), (full ?s), (empty ?s), (store_of ?s ?x), (equipped_for_soil_analysis ?x), (empty ?s), (communicated_soil_data ?p), (equipped_for_rock_analysis ?x), (available ?x), (available ?x), (equipped_for_soil_analysis ?x), (communicated_rock_data ?p), 
;; communicate_rock_data action has changed: (equipped_for_soil_analysis ?r), (communicated_rock_data ?p), (at_lander ?l ?p), (at ?r ?p), (at_soil_sample ?y), (at ?r ?x), (can_traverse ?r ?y ?x), (can_traverse ?r ?x ?p), (communicated_soil_data ?y), (have_soil_analysis ?r ?p), (have_soil_analysis ?r ?y), (at_soil_sample ?y), (equipped_for_rock_analysis ?r), (communicated_rock_data ?y), (visible ?y ?p), (have_soil_analysis ?r ?x), (can_traverse ?r ?x ?y), (have_rock_analysis ?r ?y), (at ?r ?x), (channel_free ?l), (equipped_for_soil_analysis ?r), (visible ?y ?x), (visible ?p ?y), (have_soil_analysis ?r ?p), (can_traverse ?r ?p ?y), (at_rock_sample ?p), (at_lander ?l ?x), (communicated_rock_data ?y), (communicated_soil_data ?p), (can_traverse ?r ?p ?x), (communicated_soil_data ?x), (visible ?p ?x), (at_soil_sample ?x), (visible ?x ?y), (visible ?y ?p), (at_rock_sample ?x), (channel_free ?l), (can_traverse ?r ?x ?y), (at_rock_sample ?y), (have_soil_analysis ?r ?x), 
;; calibrate action has changed: (have_soil_analysis ?r ?w), (communicated_soil_data ?w), (at ?r ?w), (available ?r), (calibrated ?i ?r), (at_rock_sample ?w), (visible_from ?t ?w), (calibration_target ?i ?t), (at_rock_sample ?w), (at ?r ?w), (have_rock_analysis ?r ?w), (communicated_rock_data ?w), (on_board ?i ?r), (at_soil_sample ?w), (on_board ?i ?r), (calibration_target ?i ?t), 
;; navigate action has changed: (equipped_for_imaging ?x), (can_traverse ?x ?y ?z), (communicated_soil_data ?z), (at ?x ?z), (communicated_rock_data ?z), (communicated_rock_data ?y), (at_rock_sample ?y), (equipped_for_rock_analysis ?x), (at_soil_sample ?z), (visible ?y ?z), (at ?x ?z), (equipped_for_soil_analysis ?x), (available ?x), (visible ?z ?y), (have_rock_analysis ?x ?z), (at_soil_sample ?z), (at_soil_sample ?y), (at ?x ?y), (can_traverse ?x ?z ?y), (have_soil_analysis ?x ?z), (communicated_soil_data ?y), 
;; communicate_image_data action has changed: (at_rock_sample ?x), (equipped_for_rock_analysis ?r), (communicated_rock_data ?y), (have_rock_analysis ?r ?y), (can_traverse ?r ?x ?y), (equipped_for_imaging ?r), (have_soil_analysis ?r ?x), (visible_from ?o ?x), (communicated_image_data ?o ?m), (equipped_for_soil_analysis ?r), (at_lander ?l ?x), (at ?r ?y), (equipped_for_soil_analysis ?r), (at_soil_sample ?y), (communicated_rock_data ?x), (communicated_image_data ?o ?m), (at_rock_sample ?x), (equipped_for_rock_analysis ?r), (visible_from ?o ?y), (at_soil_sample ?y), (at_lander ?l ?y), (visible_from ?o ?x), (communicated_rock_data ?y), (at_soil_sample ?x), (at_rock_sample ?y), (communicated_soil_data ?x), (equipped_for_imaging ?r), (at_lander ?l ?x), (communicated_soil_data ?y), 
;; drop action has changed: (store_of ?y ?x), (empty ?y), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), 
;; Last_reduced_capability_num_dropped_pals: None
