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
               (not (at_rock_sample ?y))
			(not (can_traverse ?x ?z ?y))
			(at ?x ?y)
			(communicated_soil_data ?z)
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			
          )
          :effect (and 
               (have_rock_analysis ?x ?z)
			(visible ?z ?y)
			(at_rock_sample ?y)
			(at ?x ?y)
			(not (have_soil_analysis ?x ?y))
			(not (communicated_soil_data ?z))
			(at ?x ?z)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(empty ?s)
			(not (full ?s))
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(at_rock_sample ?p)
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
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
			(full ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (have_soil_analysis ?x ?p))
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (available ?x)
			(empty ?s)
			(full ?s)
			(not (at_soil_sample ?p))
			(communicated_soil_data ?p)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (full ?y)
			
          )
        :effect (and 
               (store_of ?y ?x)
			(empty ?y)
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
               (calibration_target ?i ?t)
			(have_soil_analysis ?r ?w)
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(on_board ?i ?r)
			(visible_from ?t ?w)
			(communicated_rock_data ?w)
			(at_soil_sample ?w)
			
          )
         :effect (and 
               (have_soil_analysis ?r ?w)
			(not (at ?r ?w))
			(visible_from ?t ?w)
			
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
			(equipped_for_imaging ?r)
			(not (on_board ?i ?r))
			(visible_from ?o ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (communicated_image_data ?o ?m)
			(equipped_for_rock_analysis ?r)
			(have_image ?r ?o ?m)
			(calibration_target ?i ?o)
			(not (have_rock_analysis ?r ?p))
			(visible_from ?o ?p)
			(not (calibrated ?i ?r))
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
			(communicated_rock_data ?x)
			(visible ?x ?y)
			(have_soil_analysis ?r ?p)
			(at_rock_sample ?y)
			(not (at_rock_sample ?p))
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(not (can_traverse ?r ?x ?p))
			(have_rock_analysis ?r ?x)
			(at_lander ?l ?p)
			(not (equipped_for_rock_analysis ?r))
			
          )
          :effect (and 
               (channel_free ?l)
			(at ?r ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at ?r ?x)
			(can_traverse ?r ?y ?p)
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			
          )
    )
    
    (:action communicate_rock_data
         :parameters (?r - rover 
                      ?l - lander 
                      ?p - waypoint 
                      ?x - waypoint 
                      ?y - waypoint)
         :precondition (and 
               (have_soil_analysis ?r ?x)
			(not (visible ?p ?x))
			(visible ?x ?y)
			(available ?r)
			(not (at_soil_sample ?p))
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(visible ?x ?p)
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (not (have_soil_analysis ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (available ?r))
			(not (at_rock_sample ?p))
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(not (equipped_for_soil_analysis ?r))
			(communicated_soil_data ?x)
			(not (have_rock_analysis ?r ?x))
			(not (visible ?x ?p))
			
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
               (equipped_for_imaging ?r)
			(have_image ?r ?o ?m)
			(communicated_rock_data ?x)
			(visible ?x ?y)
			(available ?r)
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			(not (communicated_rock_data ?y))
			
          )
         :effect (and 
               (not (equipped_for_imaging ?r))
			(not (visible ?x ?y))
			(not (visible_from ?o ?x))
			(have_rock_analysis ?r ?y)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_soil_data action has changed: (equipped_for_rock_analysis ?r), (at_rock_sample ?y), (communicated_rock_data ?x), (equipped_for_rock_analysis ?r), (available ?r), (at ?r ?y), (at_rock_sample ?p), (have_rock_analysis ?r ?x), (have_soil_analysis ?r ?p), (at_lander ?l ?p), (equipped_for_soil_analysis ?r), (communicated_soil_data ?x), (available ?r), (have_rock_analysis ?r ?p), (can_traverse ?r ?x ?p), (can_traverse ?r ?y ?p), (at_soil_sample ?y), (at ?r ?x), (channel_free ?l), (at ?r ?x), 
;; communicate_rock_data action has changed: (at_soil_sample ?p), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?x), (visible ?x ?p), (at ?r ?x), (at ?r ?x), (communicated_rock_data ?y), (available ?r), (have_soil_analysis ?r ?y), (communicated_soil_data ?x), (at_rock_sample ?p), (visible ?p ?x), (can_traverse ?r ?y ?p), (communicated_rock_data ?p), (at_lander ?l ?y), (visible ?x ?p), (at_lander ?l ?x), (have_rock_analysis ?r ?x), (channel_free ?l), (can_traverse ?r ?x ?y), (communicated_soil_data ?y), 
;; navigate action has changed: (at_rock_sample ?y), (communicated_soil_data ?z), (can_traverse ?x ?z ?y), (at_rock_sample ?y), (communicated_soil_data ?z), (have_rock_analysis ?x ?z), (available ?x), (at ?x ?y), (visible ?z ?y), (have_soil_analysis ?x ?y), 
;; sample_rock action has changed: (at_rock_sample ?p), (available ?x), (empty ?s), (have_soil_analysis ?x ?p), (communicated_soil_data ?p), (full ?s), (at_soil_sample ?p), (at_soil_sample ?p), 
;; drop action has changed: (equipped_for_imaging ?x), (store_of ?y ?x), (store_of ?y ?x), 
;; take_image action has changed: (equipped_for_rock_analysis ?r), (communicated_image_data ?o ?m), (at ?r ?p), (on_board ?i ?r), (visible_from ?o ?p), (calibration_target ?i ?o), (communicated_image_data ?o ?m), (have_rock_analysis ?r ?p), (have_soil_analysis ?r ?p), 
;; calibrate action has changed: (calibrated ?i ?r), (have_soil_analysis ?r ?w), (at_soil_sample ?w), (visible_from ?t ?w), (at ?r ?w), (communicated_rock_data ?w), (have_soil_analysis ?r ?w), 
;; communicate_image_data action has changed: (at_soil_sample ?y), (visible_from ?o ?x), (have_rock_analysis ?r ?y), (channel_free ?l), (equipped_for_imaging ?r), (equipped_for_imaging ?r), (communicated_rock_data ?y), (communicated_rock_data ?x), (visible ?x ?y), (have_rock_analysis ?r ?x), (at_lander ?l ?y), (communicated_soil_data ?y), 
;; sample_soil action has changed: (full ?s), (equipped_for_soil_analysis ?x), (store_of ?s ?x), (have_soil_analysis ?x ?p), (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?p), (at_rock_sample ?p), (at_soil_sample ?p), (communicated_rock_data ?p), (equipped_for_rock_analysis ?x), (communicated_soil_data ?p), 
;; Last_reduced_capability_num_dropped_pals: None

