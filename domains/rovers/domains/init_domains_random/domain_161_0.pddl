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
               (not (at_rock_sample ?z))
			(not (have_rock_analysis ?x ?z))
			(available ?x)
			(visible ?z ?y)
			(not (at_rock_sample ?y))
			(not (have_soil_analysis ?x ?y))
			(not (communicated_soil_data ?z))
			(communicated_soil_data ?y)
			(visible ?y ?z)
			(not (can_traverse ?x ?y ?z))
			(have_rock_analysis ?x ?y)
			(not (communicated_rock_data ?y))
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (not (have_rock_analysis ?x ?z))
			(available ?x)
			(not (at ?x ?y))
			(not (at_soil_sample ?z))
			(not (communicated_soil_data ?z))
			(not (visible ?y ?z))
			(at ?x ?z)
			(not (have_soil_analysis ?x ?z))
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(at ?x ?p)
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			
          )
        :effect (and 
               (not (available ?x))
			(equipped_for_imaging ?x)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
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
			(empty ?s)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (available ?x))
			(empty ?s)
			(not (equipped_for_soil_analysis ?x))
			(communicated_rock_data ?p)
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (equipped_for_soil_analysis ?x)
			(not (full ?y))
			(not (equipped_for_imaging ?x))
			
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
               (calibration_target ?i ?t)
			(equipped_for_rock_analysis ?r)
			(visible_from ?t ?w)
			(have_rock_analysis ?r ?w)
			(communicated_soil_data ?w)
			(not (communicated_rock_data ?w))
			(not (calibrated ?i ?r))
			
          )
         :effect (and 
               (not (calibration_target ?i ?t))
			(at ?r ?w)
			(at_rock_sample ?w)
			(not (visible_from ?t ?w))
			(not (have_rock_analysis ?r ?w))
			(at_soil_sample ?w)
			
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
			(not (have_soil_analysis ?r ?p))
			(on_board ?i ?r)
			(not (have_rock_analysis ?r ?p))
			(visible_from ?o ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (not (equipped_for_rock_analysis ?r))
			(have_image ?r ?o ?m)
			(not (at_rock_sample ?p))
			(visible_from ?o ?p)
			(not (calibrated ?i ?r))
			
          )
    )
    
    (:action communicate_soil_data
         :parameters (?r - rover 
                      ?l - lander 
                      ?p - waypoint 
                      ?x - waypoint 
                      ?y - waypoint)
         :precondition (and 
               (equipped_for_imaging ?r)
			(not (have_soil_analysis ?r ?x))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(at_lander ?l ?x)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?y)
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
			
          )
          :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(visible ?p ?y)
			(not (visible ?x ?y))
			(have_soil_analysis ?r ?p)
			(not (at_rock_sample ?p))
			(not (at ?r ?x))
			(not (at_lander ?l ?y))
			(not (have_rock_analysis ?r ?y))
			(not (at_soil_sample ?x))
			(not (at_lander ?l ?p))
			(can_traverse ?r ?p ?x)
			
          )
    )
    
    (:action communicate_rock_data
         :parameters (?r - rover 
                      ?l - lander 
                      ?p - waypoint 
                      ?x - waypoint 
                      ?y - waypoint)
         :precondition (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(not (visible ?p ?y))
			(visible ?x ?y)
			(can_traverse ?r ?x ?y)
			(available ?r)
			(not (at_rock_sample ?p))
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(not (communicated_soil_data ?x))
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			
          )
          :effect (and 
               (equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(not (at_soil_sample ?p))
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(visible ?x ?p)
			(not (can_traverse ?r ?y ?x))
			
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
			(visible ?y ?x)
			(have_image ?r ?o ?m)
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (at ?r ?y))
			(available ?r)
			(at_rock_sample ?y)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (communicated_soil_data ?x))
			(not (have_rock_analysis ?r ?x))
			(equipped_for_rock_analysis ?r)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			
          )
         :effect (and 
               (not (equipped_for_imaging ?r))
			(not (have_soil_analysis ?r ?x))
			(at ?r ?y)
			(not (available ?r))
			(at_rock_sample ?y)
			(not (at ?r ?x))
			(not (at_lander ?l ?y))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(visible_from ?o ?y)
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; communicate_image_data action has changed: (have_rock_analysis ?r ?y), (at ?r ?x), (at_lander ?l ?x), (communicated_soil_data ?x), (have_soil_analysis ?r ?x), (have_rock_analysis ?r ?x), (can_traverse ?r ?y ?x), (equipped_for_imaging ?r), (at ?r ?x), (at_lander ?l ?y), (communicated_soil_data ?x), (at ?r ?y), (at_rock_sample ?x), (communicated_rock_data ?y), (at_soil_sample ?x), (equipped_for_rock_analysis ?r), (communicated_image_data ?o ?m), (visible_from ?o ?y), (available ?r), (at ?r ?y), (at_rock_sample ?y), (at_rock_sample ?y), (visible ?y ?x), 
;; sample_soil action has changed: (have_soil_analysis ?x ?p), (at_rock_sample ?p), (communicated_soil_data ?p), (have_rock_analysis ?x ?p), (store_of ?s ?x), (communicated_soil_data ?p), (have_soil_analysis ?x ?p), (communicated_rock_data ?p), (empty ?s), (empty ?s), (available ?x), (equipped_for_soil_analysis ?x), (full ?s), (available ?x), (equipped_for_imaging ?x), (at_rock_sample ?p), 
;; communicate_soil_data action has changed: (can_traverse ?r ?p ?x), (at ?r ?x), (have_rock_analysis ?r ?y), (can_traverse ?r ?x ?y), (at_soil_sample ?x), (visible ?x ?y), (at_rock_sample ?x), (at_soil_sample ?y), (at ?r ?y), (have_soil_analysis ?r ?p), (available ?r), (communicated_soil_data ?p), (at_rock_sample ?y), (at_rock_sample ?p), (have_soil_analysis ?r ?x), (communicated_soil_data ?y), (equipped_for_soil_analysis ?r), (visible ?y ?p), (at ?r ?p), (can_traverse ?r ?y ?x), (at_lander ?l ?x), (channel_free ?l), (have_soil_analysis ?r ?x), (at_lander ?l ?p), (communicated_rock_data ?p), (at_lander ?l ?y), (equipped_for_imaging ?r), (have_soil_analysis ?r ?y), (visible ?y ?x), (channel_free ?l), (equipped_for_imaging ?r), (visible ?p ?y), (at_soil_sample ?p), (at_lander ?l ?y), 
;; calibrate action has changed: (at ?r ?w), (at ?r ?w), (communicated_rock_data ?w), (communicated_soil_data ?w), (calibrated ?i ?r), (have_rock_analysis ?r ?w), (at_rock_sample ?w), (visible_from ?t ?w), (have_rock_analysis ?r ?w), (equipped_for_rock_analysis ?r), (calibration_target ?i ?t), (on_board ?i ?r), (calibrated ?i ?r), (equipped_for_imaging ?r), (at_soil_sample ?w), 
;; navigate action has changed: (communicated_soil_data ?y), (at_rock_sample ?y), (have_rock_analysis ?x ?y), (have_soil_analysis ?x ?y), (equipped_for_soil_analysis ?x), (visible ?y ?z), (at_rock_sample ?z), (visible ?z ?y), (at_soil_sample ?z), (communicated_soil_data ?z), (available ?x), (communicated_rock_data ?y), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?z), (communicated_soil_data ?z), (have_rock_analysis ?x ?z), (can_traverse ?x ?y ?z), (at ?x ?y), (have_soil_analysis ?x ?z), 
;; communicate_rock_data action has changed: (can_traverse ?r ?x ?y), (equipped_for_imaging ?r), (visible ?p ?y), (have_soil_analysis ?r ?p), (communicated_soil_data ?p), (can_traverse ?r ?x ?y), (communicated_soil_data ?x), (visible ?p ?x), (communicated_rock_data ?p), (have_soil_analysis ?r ?x), (have_soil_analysis ?r ?x), (can_traverse ?r ?y ?x), (equipped_for_soil_analysis ?r), (communicated_rock_data ?x), (have_rock_analysis ?r ?y), (equipped_for_rock_analysis ?r), (at ?r ?x), (equipped_for_imaging ?r), (communicated_soil_data ?x), (at_soil_sample ?p), (at_rock_sample ?p), (communicated_rock_data ?p), (at_soil_sample ?x), (can_traverse ?r ?x ?p), (at ?r ?x), (visible ?y ?x), (can_traverse ?r ?y ?p), (communicated_rock_data ?x), (at_lander ?l ?x), (communicated_soil_data ?y), (visible ?x ?p), 
;; drop action has changed: (store_of ?y ?x), (equipped_for_soil_analysis ?x), (empty ?y), (full ?y), (equipped_for_imaging ?x), 
;; sample_rock action has changed: (available ?x), (communicated_rock_data ?p), (at_rock_sample ?p), (equipped_for_soil_analysis ?x), (full ?s), (have_rock_analysis ?x ?p), (available ?x), (store_of ?s ?x), (empty ?s), (communicated_rock_data ?p), (equipped_for_soil_analysis ?x), 
;; take_image action has changed: (equipped_for_imaging ?r), (at_rock_sample ?p), (visible_from ?o ?p), (equipped_for_rock_analysis ?r), (communicated_image_data ?o ?m), (have_soil_analysis ?r ?p), (have_rock_analysis ?r ?p), 
;; Last_reduced_capability_num_dropped_pals: None

