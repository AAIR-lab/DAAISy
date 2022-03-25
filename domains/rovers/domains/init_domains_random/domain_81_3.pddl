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
			(available ?x)
			(not (visible ?z ?y))
			(equipped_for_imaging ?x)
			(at ?x ?y)
			(have_soil_analysis ?x ?y)
			(at_soil_sample ?y)
			(communicated_soil_data ?z)
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(not (have_rock_analysis ?x ?y))
			
          )
          :effect (and 
               (at_rock_sample ?z)
			(not (can_traverse ?x ?z ?y))
			(at_soil_sample ?z)
			(at ?x ?z)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(full ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(store_of ?s ?x)
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (full ?s)
			(store_of ?s ?x)
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(have_soil_analysis ?x ?p)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (available ?x))
			(store_of ?y ?x)
			(full ?y)
			
          )
        :effect (and 
               (empty ?y)
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
			(not (equipped_for_rock_analysis ?r))
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(on_board ?i ?r)
			(visible_from ?t ?w)
			(not (communicated_rock_data ?w))
			
          )
         :effect (and 
               (equipped_for_rock_analysis ?r)
			(available ?r)
			(at_rock_sample ?w)
			(at_soil_sample ?w)
			(not (calibrated ?i ?r))
			
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
			(not (equipped_for_soil_analysis ?r))
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(visible_from ?o ?p)
			(not (communicated_rock_data ?p))
			(at ?r ?p)
			
          )
          :effect (and 
               (have_image ?r ?o ?m)
			(communicated_soil_data ?p)
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
			(visible ?p ?x)
			(not (visible ?p ?y))
			(visible ?x ?y)
			(not (at ?r ?p))
			(at ?r ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(at_soil_sample ?y)
			(not (at_lander ?l ?p))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(not (have_soil_analysis ?r ?x))
			(not (available ?r))
			(at_soil_sample ?p)
			(not (communicated_rock_data ?p))
			(at_lander ?l ?x)
			(not (at_soil_sample ?y))
			(not (have_rock_analysis ?r ?p))
			(not (at_lander ?l ?p))
			(visible ?x ?p)
			
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
			(not (visible ?y ?x))
			(visible ?p ?x)
			(not (visible ?x ?y))
			(available ?r)
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(have_rock_analysis ?r ?p)
			(at_lander ?l ?p)
			
          )
          :effect (and 
               (visible ?y ?x)
			(visible ?p ?y)
			(not (have_soil_analysis ?r ?y))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(at_lander ?l ?x)
			
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
			(have_image ?r ?o ?m)
			(have_soil_analysis ?r ?x)
			(not (visible ?x ?y))
			(not (available ?r))
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(not (communicated_soil_data ?y))
			(equipped_for_rock_analysis ?r)
			
          )
         :effect (and 
               (available ?r)
			(not (at_rock_sample ?y))
			(not (visible_from ?o ?x))
			(communicated_soil_data ?y)
			(not (equipped_for_rock_analysis ?r))
			(can_traverse ?r ?y ?x)
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (visible ?p ?x), (at ?r ?x), (at_lander ?l ?y), (visible ?y ?x), (have_soil_analysis ?r ?y), (at_soil_sample ?p), (visible ?y ?x), (at_lander ?l ?x), (visible ?p ?y), (at_lander ?l ?p), (at_rock_sample ?y), (visible ?x ?y), 
;; communicate_image_data action has changed: (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?x), (visible ?x ?y), (communicated_soil_data ?y), (equipped_for_rock_analysis ?r), (at_rock_sample ?y), (communicated_soil_data ?y), (available ?r), (equipped_for_rock_analysis ?r), (available ?r), (at_lander ?l ?y), (visible_from ?o ?x), (communicated_image_data ?o ?m), 
;; communicate_soil_data action has changed: (visible ?x ?p), (have_soil_analysis ?r ?x), (communicated_soil_data ?p), (at_lander ?l ?p), (at_soil_sample ?p), (can_traverse ?r ?y ?p), (available ?r), (at ?r ?p), (have_rock_analysis ?r ?p), (visible ?p ?y), (at ?r ?y), (communicated_rock_data ?p), (at_soil_sample ?y), (at_soil_sample ?y), (equipped_for_imaging ?r), (visible ?p ?x), (at_lander ?l ?p), (channel_free ?l), (at_lander ?l ?x), (at_soil_sample ?p), 
;; calibrate action has changed: (at_rock_sample ?w), (at_soil_sample ?w), (equipped_for_rock_analysis ?r), (equipped_for_rock_analysis ?r), (calibrated ?i ?r), (communicated_rock_data ?w), (available ?r), 
;; sample_rock action has changed: (empty ?s), (equipped_for_soil_analysis ?x), (store_of ?s ?x), (have_rock_analysis ?x ?p), (have_soil_analysis ?x ?p), (empty ?s), 
;; sample_soil action has changed: (empty ?s), (full ?s), (have_soil_analysis ?x ?p), (equipped_for_soil_analysis ?x), (store_of ?s ?x), (equipped_for_soil_analysis ?x), (at_soil_sample ?p), 
;; take_image action has changed: (equipped_for_soil_analysis ?r), (calibrated ?i ?r), (communicated_soil_data ?p), (communicated_rock_data ?p), 
;; navigate action has changed: (have_rock_analysis ?x ?y), (at_rock_sample ?z), (equipped_for_imaging ?x), (at_rock_sample ?z), (at_soil_sample ?z), (visible ?z ?y), (can_traverse ?x ?z ?y), (have_soil_analysis ?x ?y), (at ?x ?y), (communicated_soil_data ?z), (at_soil_sample ?y), 
;; drop action has changed: (available ?x), 
;; Last_reduced_capability_num_dropped_pals: None

