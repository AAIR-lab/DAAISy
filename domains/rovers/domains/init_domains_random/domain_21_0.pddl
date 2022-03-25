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
               (available ?x)
			(at ?x ?y)
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			
          )
          :effect (and 
               (can_traverse ?x ?z ?y)
			(not (at ?x ?y))
			(visible ?y ?z)
			(at ?x ?z)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(empty ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(not (at_soil_sample ?p))
			(have_soil_analysis ?x ?p)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(empty ?s)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(not (at_rock_sample ?p))
			(communicated_soil_data ?p)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
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
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(on_board ?i ?r)
			(visible_from ?t ?w)
			
          )
         :effect (and 
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
			(not (have_image ?r ?o ?m))
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(visible_from ?o ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (have_image ?r ?o ?m)
			(not (on_board ?i ?r))
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
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(have_soil_analysis ?r ?p)
			(at ?r ?x)
			(at_lander ?l ?y)
			
          )
          :effect (and 
               (have_soil_analysis ?r ?x)
			(at ?r ?y)
			(not (communicated_rock_data ?p))
			(communicated_soil_data ?x)
			(communicated_soil_data ?p)
			
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
			(visible ?x ?y)
			(available ?r)
			(at ?r ?x)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(equipped_for_soil_analysis ?r)
			(have_rock_analysis ?r ?p)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (communicated_rock_data ?p)
			
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
               (not (channel_free ?l))
			(have_image ?r ?o ?m)
			(visible ?x ?y)
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_soil_sample ?y)
			(equipped_for_rock_analysis ?r)
			(communicated_image_data ?o ?m)
			
          )
         :effect (and 
               (available ?r)
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (equipped_for_soil_analysis ?r), (can_traverse ?r ?y ?p), (can_traverse ?r ?p ?x), 
;; communicate_image_data action has changed: (at_soil_sample ?y), (equipped_for_rock_analysis ?r), (channel_free ?l), (available ?r), (communicated_image_data ?o ?m), (communicated_image_data ?o ?m), 
;; navigate action has changed: (can_traverse ?x ?z ?y), (visible ?y ?z), 
;; communicate_soil_data action has changed: (at ?r ?y), (communicated_rock_data ?p), (have_soil_analysis ?r ?x), (at_rock_sample ?x), (available ?r), (communicated_soil_data ?x), 
;; take_image action has changed: (have_image ?r ?o ?m), (on_board ?i ?r), (communicated_soil_data ?p), 
;; sample_rock action has changed: (communicated_soil_data ?p), 
;; Last_reduced_capability_num_dropped_pals: None

