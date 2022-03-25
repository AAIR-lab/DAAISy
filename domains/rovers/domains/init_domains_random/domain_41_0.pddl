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
               (available ?x)
			(not (equipped_for_imaging ?x))
			(not (at ?x ?y))
			(not (have_soil_analysis ?x ?y))
			(at ?x ?z)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (at ?x ?p))
			(empty ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(not (store_of ?s ?x))
			(have_soil_analysis ?x ?p)
			(not (communicated_rock_data ?p))
			
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
			(not (have_soil_analysis ?x ?p))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(not (equipped_for_soil_analysis ?x))
			(full ?y)
			
          )
        :effect (and 
               (equipped_for_rock_analysis ?x)
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
			(not (at ?r ?w))
			(on_board ?i ?r)
			(at_rock_sample ?w)
			(visible_from ?t ?w)
			(communicated_rock_data ?w)
			
          )
         :effect (and 
               (not (on_board ?i ?r))
			(visible_from ?t ?w)
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
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(visible_from ?o ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (have_image ?r ?o ?m)
			(not (at_rock_sample ?p))
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
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at_rock_sample ?y))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(not (at_lander ?l ?y))
			(not (communicated_soil_data ?x))
			(at_lander ?l ?p)
			
          )
          :effect (and 
               (not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (communicated_soil_data ?x))
			(not (at_lander ?l ?p))
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
			(not (at ?r ?p))
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			
          )
          :effect (and 
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
			(visible ?x ?y)
			(have_soil_analysis ?r ?y)
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(have_rock_analysis ?r ?y)
			(not (communicated_rock_data ?y))
			
          )
         :effect (and 
               (not (at_lander ?l ?y))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?x)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_image_data action has changed: (have_rock_analysis ?r ?y), (available ?r), (at_soil_sample ?x), (at_lander ?l ?y), (have_rock_analysis ?r ?x), (at_lander ?l ?y), (have_soil_analysis ?r ?y), (communicated_rock_data ?y), 
;; communicate_soil_data action has changed: (communicated_soil_data ?x), (at_lander ?l ?y), (communicated_rock_data ?p), (at ?r ?y), (communicated_soil_data ?x), (at_lander ?l ?p), (at_lander ?l ?p), (can_traverse ?r ?x ?y), (at_rock_sample ?y), (visible ?x ?y), 
;; sample_soil action has changed: (at ?x ?p), (communicated_rock_data ?p), (store_of ?s ?x), (at_soil_sample ?p), 
;; drop action has changed: (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), (empty ?y), 
;; take_image action has changed: (visible_from ?o ?p), (communicated_image_data ?o ?m), (at_rock_sample ?p), 
;; calibrate action has changed: (at ?r ?w), (at_rock_sample ?w), (visible_from ?t ?w), (communicated_rock_data ?w), (on_board ?i ?r), 
;; communicate_rock_data action has changed: (communicated_soil_data ?y), (at ?r ?p), (can_traverse ?r ?x ?p), (at_lander ?l ?x), 
;; navigate action has changed: (available ?x), (equipped_for_imaging ?x), (have_soil_analysis ?x ?y), 
;; sample_rock action has changed: (have_soil_analysis ?x ?p), 
;; Last_reduced_capability_num_dropped_pals: None

