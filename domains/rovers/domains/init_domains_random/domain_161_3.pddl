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
               (equipped_for_imaging ?x)
			(at ?x ?y)
			(not (communicated_soil_data ?z))
			(not (communicated_rock_data ?z))
			(not (communicated_soil_data ?y))
			(visible ?y ?z)
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			(not (have_soil_analysis ?x ?z))
			(have_rock_analysis ?x ?y)
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (at_rock_sample ?z)
			(not (have_rock_analysis ?x ?z))
			(not (equipped_for_imaging ?x))
			(not (can_traverse ?x ?z ?y))
			(at ?x ?y)
			(at_soil_sample ?z)
			(communicated_soil_data ?z)
			(not (visible ?y ?z))
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			(communicated_rock_data ?y)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(empty ?s)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (available ?x)
			(not (empty ?s))
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(at ?x ?p)
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(have_soil_analysis ?x ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (at ?x ?p))
			(not (full ?s))
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (store_of ?y ?x))
			(empty ?y)
			(not (equipped_for_rock_analysis ?x))
			(not (equipped_for_soil_analysis ?x))
			
          )
        :effect (and 
               (empty ?y)
			(equipped_for_soil_analysis ?x)
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
			(not (available ?r))
			(at ?r ?w)
			(on_board ?i ?r)
			(not (at_rock_sample ?w))
			(not (equipped_for_soil_analysis ?r))
			(visible_from ?t ?w)
			(not (communicated_rock_data ?w))
			
          )
         :effect (and 
               (not (equipped_for_rock_analysis ?r))
			(not (have_soil_analysis ?r ?w))
			(not (at ?r ?w))
			(not (on_board ?i ?r))
			(at_rock_sample ?w)
			(not (equipped_for_soil_analysis ?r))
			(not (visible_from ?t ?w))
			(communicated_soil_data ?w)
			(calibrated ?i ?r)
			
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
			(equipped_for_rock_analysis ?r)
			(not (available ?r))
			(equipped_for_soil_analysis ?r)
			(on_board ?i ?r)
			(visible_from ?o ?p)
			(not (calibrated ?i ?r))
			(at ?r ?p)
			
          )
          :effect (and 
               (supports ?i ?m)
			(not (communicated_image_data ?o ?m))
			(available ?r)
			(have_image ?r ?o ?m)
			(not (on_board ?i ?r))
			(not (have_rock_analysis ?r ?p))
			(not (visible_from ?o ?p))
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
               (channel_free ?l)
			(not (at_rock_sample ?x))
			(available ?r)
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?y)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?y))
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
			(visible ?y ?p)
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(not (communicated_rock_data ?x))
			(not (can_traverse ?r ?p ?y))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(communicated_rock_data ?p)
			(communicated_soil_data ?x)
			(communicated_soil_data ?y)
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(not (visible ?y ?p))
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
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
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(visible ?p ?y)
			(visible ?x ?y)
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (available ?r))
			(communicated_rock_data ?p)
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(can_traverse ?r ?x ?p)
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?p))
			(at_rock_sample ?p)
			(communicated_rock_data ?p)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?x))
			(can_traverse ?r ?x ?p)
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(visible ?y ?p)
			(can_traverse ?r ?y ?x)
			
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
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(available ?r)
			(visible_from ?o ?x)
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(at_soil_sample ?y)
			(not (at_soil_sample ?x))
			(communicated_soil_data ?y)
			(not (visible_from ?o ?y))
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (not (have_image ?r ?o ?m))
			(have_soil_analysis ?r ?y)
			(can_traverse ?r ?x ?y)
			(available ?r)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?x)
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (visible ?y ?p), (at_rock_sample ?p), (have_soil_analysis ?r ?p), (have_soil_analysis ?r ?x), (at ?r ?p), (equipped_for_soil_analysis ?r), (can_traverse ?r ?x ?p), (visible ?y ?x), (at_soil_sample ?x), (equipped_for_soil_analysis ?r), (at_lander ?l ?x), (visible ?p ?y), (equipped_for_rock_analysis ?r), (at ?r ?p), (can_traverse ?r ?x ?y), (available ?r), (visible ?x ?p), (at ?r ?x), (communicated_rock_data ?x), (at_lander ?l ?y), (visible ?y ?x), (communicated_rock_data ?p), (can_traverse ?r ?x ?p), (at_soil_sample ?x), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?y), (communicated_rock_data ?y), (at_lander ?l ?p), (equipped_for_imaging ?r), (communicated_soil_data ?p), (have_soil_analysis ?r ?x), 
;; communicate_image_data action has changed: (equipped_for_rock_analysis ?r), (at ?r ?y), (at_lander ?l ?y), (communicated_soil_data ?y), (at_lander ?l ?x), (visible_from ?o ?x), (at ?r ?x), (have_rock_analysis ?r ?y), (at_soil_sample ?x), (have_soil_analysis ?r ?y), (have_soil_analysis ?r ?y), (can_traverse ?r ?y ?x), (available ?r), (at_soil_sample ?y), (equipped_for_soil_analysis ?r), (visible_from ?o ?y), (at_soil_sample ?x), (have_soil_analysis ?r ?x), (have_image ?r ?o ?m), (communicated_image_data ?o ?m), (visible_from ?o ?y), (can_traverse ?r ?x ?y), (equipped_for_imaging ?r), 
;; sample_soil action has changed: (at ?x ?p), (available ?x), (at_soil_sample ?p), (full ?s), (at_rock_sample ?p), (available ?x), (equipped_for_soil_analysis ?x), (store_of ?s ?x), (at_rock_sample ?p), (have_rock_analysis ?x ?p), (communicated_soil_data ?p), (store_of ?s ?x), (have_soil_analysis ?x ?p), 
;; navigate action has changed: (can_traverse ?x ?z ?y), (available ?x), (communicated_soil_data ?z), (equipped_for_imaging ?x), (at_soil_sample ?z), (have_soil_analysis ?x ?z), (equipped_for_rock_analysis ?x), (communicated_rock_data ?y), (communicated_soil_data ?z), (can_traverse ?x ?y ?z), (visible ?y ?z), (equipped_for_imaging ?x), (communicated_soil_data ?y), (have_rock_analysis ?x ?y), (communicated_rock_data ?y), (communicated_rock_data ?z), (at_rock_sample ?z), (at ?x ?y), (have_rock_analysis ?x ?z), 
;; sample_rock action has changed: (empty ?s), (communicated_soil_data ?p), (available ?x), (at_soil_sample ?p), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (store_of ?s ?x), (have_soil_analysis ?x ?p), (at_rock_sample ?p), (full ?s), (have_rock_analysis ?x ?p), (equipped_for_imaging ?x), (at ?x ?p), (at_soil_sample ?p), (have_soil_analysis ?x ?p), 
;; communicate_soil_data action has changed: (communicated_soil_data ?p), (can_traverse ?r ?p ?x), (at_lander ?l ?p), (have_soil_analysis ?r ?p), (have_soil_analysis ?r ?p), (communicated_rock_data ?p), (can_traverse ?r ?y ?x), (communicated_rock_data ?x), (communicated_soil_data ?y), (visible ?y ?x), (visible ?x ?y), (communicated_rock_data ?y), (at_soil_sample ?y), (have_soil_analysis ?r ?y), (have_rock_analysis ?r ?y), (equipped_for_rock_analysis ?r), (communicated_soil_data ?y), (available ?r), (equipped_for_imaging ?r), (communicated_soil_data ?p), (can_traverse ?r ?p ?y), (communicated_soil_data ?x), (communicated_rock_data ?y), (can_traverse ?r ?x ?y), (visible ?y ?p), (at_rock_sample ?x), (at ?r ?x), (at ?r ?y), (visible ?y ?p), 
;; take_image action has changed: (available ?r), (equipped_for_rock_analysis ?r), (equipped_for_imaging ?r), (communicated_image_data ?o ?m), (on_board ?i ?r), (supports ?i ?m), (have_rock_analysis ?r ?p), (calibrated ?i ?r), (equipped_for_soil_analysis ?r), (communicated_image_data ?o ?m), (available ?r), (visible_from ?o ?p), 
;; calibrate action has changed: (equipped_for_imaging ?r), (equipped_for_soil_analysis ?r), (communicated_rock_data ?w), (communicated_soil_data ?w), (at_rock_sample ?w), (equipped_for_rock_analysis ?r), (at_rock_sample ?w), (visible_from ?t ?w), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?w), (available ?r), (on_board ?i ?r), (at ?r ?w), 
;; drop action has changed: (store_of ?y ?x), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (empty ?y), (equipped_for_soil_analysis ?x), (full ?y), 
;; Last_reduced_capability_num_dropped_pals: None

