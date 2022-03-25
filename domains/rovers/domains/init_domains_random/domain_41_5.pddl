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
			(visible ?z ?y)
			(at ?x ?y)
			(visible ?y ?z)
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			
          )
          :effect (and 
               (not (at ?x ?y))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?y))
			(at ?x ?z)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (at ?x ?p))
			(empty ?s)
			(full ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			
          )
        :effect (and 
               (at ?x ?p)
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(not (full ?s))
			(not (at_soil_sample ?p))
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			
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
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(have_soil_analysis ?x ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(not (at_rock_sample ?p))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(full ?y)
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (equipped_for_soil_analysis ?x)
			(full ?y)
			
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
			(not (equipped_for_soil_analysis ?r))
			(visible_from ?t ?w)
			(not (communicated_soil_data ?w))
			
          )
         :effect (and 
               (not (available ?r))
			(communicated_rock_data ?w)
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
			(not (communicated_image_data ?o ?m))
			(not (have_image ?r ?o ?m))
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(visible_from ?o ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (have_image ?r ?o ?m)
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
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(communicated_soil_data ?y)
			
          )
          :effect (and 
               (available ?r)
			(have_rock_analysis ?r ?y)
			(communicated_soil_data ?y)
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
			(visible ?y ?x)
			(visible ?x ?y)
			(available ?r)
			(at_rock_sample ?y)
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?p)
			(not (can_traverse ?r ?y ?x))
			
          )
          :effect (and 
               (communicated_rock_data ?p)
			(not (equipped_for_soil_analysis ?r))
			(not (communicated_soil_data ?p))
			
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
			(visible ?x ?y)
			(available ?r)
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(at_lander ?l ?y)
			(equipped_for_soil_analysis ?r)
			(not (communicated_soil_data ?x))
			(not (have_rock_analysis ?r ?x))
			
          )
         :effect (and 
               (not (at ?r ?x))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_image_data action has changed: (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?x), (at ?r ?x), (visible_from ?o ?x), (communicated_soil_data ?x), 
;; sample_soil action has changed: (full ?s), (equipped_for_soil_analysis ?x), (communicated_soil_data ?p), (at ?x ?p), (full ?s), (at ?x ?p), (equipped_for_imaging ?x), (communicated_soil_data ?p), 
;; communicate_soil_data action has changed: (available ?r), (communicated_soil_data ?y), (communicated_soil_data ?y), (have_rock_analysis ?r ?y), 
;; sample_rock action has changed: (at_rock_sample ?p), (available ?x), (have_soil_analysis ?x ?p), (at_soil_sample ?p), 
;; drop action has changed: (equipped_for_soil_analysis ?x), (full ?y), (empty ?y), (equipped_for_imaging ?x), 
;; navigate action has changed: (equipped_for_rock_analysis ?x), (visible ?z ?y), (at_soil_sample ?y), (communicated_soil_data ?y), 
;; communicate_rock_data action has changed: (at_rock_sample ?y), (visible ?y ?x), (communicated_soil_data ?p), (can_traverse ?r ?y ?x), (equipped_for_soil_analysis ?r), 
;; take_image action has changed: (communicated_image_data ?o ?m), (have_image ?r ?o ?m), 
;; calibrate action has changed: (on_board ?i ?r), (equipped_for_soil_analysis ?r), (available ?r), (communicated_soil_data ?w), (communicated_rock_data ?w), 
;; Last_reduced_capability_num_dropped_pals: None

