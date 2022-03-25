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
               (at_rock_sample ?z)
			(have_rock_analysis ?x ?z)
			(available ?x)
			(visible ?z ?y)
			(equipped_for_imaging ?x)
			(at_rock_sample ?y)
			(not (have_soil_analysis ?x ?y))
			(not (communicated_soil_data ?z))
			(can_traverse ?x ?y ?z)
			(not (have_rock_analysis ?x ?y))
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (available ?x)
			(not (visible ?z ?y))
			(not (at_rock_sample ?y))
			(not (at ?x ?y))
			(have_soil_analysis ?x ?y)
			(not (at ?x ?z))
			(communicated_rock_data ?y)
			(not (equipped_for_soil_analysis ?x))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (at ?x ?p))
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
			(not (equipped_for_imaging ?x))
			(at_rock_sample ?p)
			(have_soil_analysis ?x ?p)
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (at ?x ?p)
			(empty ?s)
			(not (store_of ?s ?x))
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
			(store_of ?y ?x)
			(not (empty ?y))
			(full ?y)
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (store_of ?y ?x)
			(not (equipped_for_rock_analysis ?x))
			(not (equipped_for_soil_analysis ?x))
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
			(not (have_soil_analysis ?r ?w))
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(not (at_rock_sample ?w))
			(not (communicated_soil_data ?w))
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (equipped_for_rock_analysis ?r)
			(have_soil_analysis ?r ?w)
			(equipped_for_imaging ?r)
			(at_rock_sample ?w)
			(not (have_rock_analysis ?r ?w))
			(not (communicated_soil_data ?w))
			(not (communicated_rock_data ?w))
			(not (at_soil_sample ?w))
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
			(not (have_soil_analysis ?r ?p))
			(not (have_image ?r ?o ?m))
			(calibration_target ?i ?o)
			(not (on_board ?i ?r))
			(not (have_rock_analysis ?r ?p))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (visible_from ?o ?p))
			(calibrated ?i ?r)
			(not (at ?r ?p))
			
          )
          :effect (and 
               (supports ?i ?m)
			(not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(have_image ?r ?o ?m)
			(not (calibration_target ?i ?o))
			(not (equipped_for_soil_analysis ?r))
			(have_rock_analysis ?r ?p)
			(at_soil_sample ?p)
			(communicated_soil_data ?p)
			(communicated_rock_data ?p)
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
               (not (channel_free ?l))
			(not (equipped_for_imaging ?r))
			(not (visible ?p ?x))
			(visible ?p ?y)
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?p ?y))
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(available ?r)
			(at_soil_sample ?p)
			(not (at_lander ?l ?y))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(not (can_traverse ?r ?x ?p))
			(at_lander ?l ?p)
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (not (channel_free ?l))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(equipped_for_soil_analysis ?r)
			(can_traverse ?r ?x ?p)
			(not (communicated_soil_data ?p))
			
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
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(at ?r ?y)
			(available ?r)
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (communicated_soil_data ?x))
			(communicated_soil_data ?y)
			(not (at_lander ?l ?p))
			(equipped_for_rock_analysis ?r)
			
          )
          :effect (and 
               (not (visible ?p ?x))
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at_rock_sample ?y))
			(not (at_rock_sample ?p))
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(at_lander ?l ?p)
			(equipped_for_rock_analysis ?r)
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
			(visible ?y ?x)
			(not (have_image ?r ?o ?m))
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(not (have_soil_analysis ?r ?y))
			(not (available ?r))
			(not (at_rock_sample ?y))
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (equipped_for_soil_analysis ?r))
			(not (communicated_soil_data ?x))
			(visible_from ?o ?y)
			(can_traverse ?r ?y ?x)
			
          )
         :effect (and 
               (not (equipped_for_imaging ?r))
			(not (have_soil_analysis ?r ?x))
			(visible_from ?o ?x)
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (have_rock_analysis ?r ?p), (channel_free ?l), (communicated_soil_data ?y), (available ?r), (communicated_soil_data ?x), (at_rock_sample ?p), (equipped_for_imaging ?r), (at_soil_sample ?x), (at_rock_sample ?x), (visible ?x ?y), (at ?r ?y), (communicated_soil_data ?y), (can_traverse ?r ?y ?x), (visible ?p ?x), (at_lander ?l ?p), (can_traverse ?r ?x ?p), (equipped_for_rock_analysis ?r), (at_soil_sample ?p), (at ?r ?p), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?y), (have_soil_analysis ?r ?p), (can_traverse ?r ?y ?p), (at_rock_sample ?x), (at_lander ?l ?y), (can_traverse ?r ?x ?y), (visible ?p ?y), (at_lander ?l ?y), (communicated_soil_data ?x), (at_rock_sample ?y), (at_rock_sample ?y), (at_lander ?l ?p), (communicated_rock_data ?y), (visible ?y ?p), (equipped_for_rock_analysis ?r), (can_traverse ?r ?y ?p), 
;; communicate_soil_data action has changed: (have_soil_analysis ?r ?x), (can_traverse ?r ?p ?y), (can_traverse ?r ?x ?p), (communicated_rock_data ?p), (channel_free ?l), (visible ?x ?y), (at ?r ?y), (at_soil_sample ?p), (have_soil_analysis ?r ?y), (communicated_soil_data ?p), (can_traverse ?r ?y ?p), (at ?r ?x), (communicated_soil_data ?x), (at_lander ?l ?p), (at_rock_sample ?x), (at_soil_sample ?y), (at_lander ?l ?y), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?p), (visible ?p ?x), (at_rock_sample ?x), (at ?r ?y), (at_soil_sample ?p), (communicated_rock_data ?x), (communicated_rock_data ?y), (visible ?p ?y), (at ?r ?x), (can_traverse ?r ?x ?p), (have_soil_analysis ?r ?y), (equipped_for_imaging ?r), (channel_free ?l), 
;; sample_rock action has changed: (store_of ?s ?x), (communicated_soil_data ?p), (at_rock_sample ?p), (empty ?s), (communicated_rock_data ?p), (full ?s), (equipped_for_soil_analysis ?x), (store_of ?s ?x), (equipped_for_imaging ?x), (have_soil_analysis ?x ?p), (at ?x ?p), (have_rock_analysis ?x ?p), (have_rock_analysis ?x ?p), 
;; take_image action has changed: (visible_from ?o ?p), (equipped_for_imaging ?r), (have_soil_analysis ?r ?p), (at_soil_sample ?p), (equipped_for_soil_analysis ?r), (communicated_image_data ?o ?m), (have_rock_analysis ?r ?p), (at_soil_sample ?p), (available ?r), (have_image ?r ?o ?m), (have_rock_analysis ?r ?p), (calibration_target ?i ?o), (communicated_rock_data ?p), (at_rock_sample ?p), (at ?r ?p), (on_board ?i ?r), (supports ?i ?m), (communicated_soil_data ?p), (calibration_target ?i ?o), (equipped_for_rock_analysis ?r), 
;; communicate_image_data action has changed: (have_soil_analysis ?r ?x), (equipped_for_imaging ?r), (at_rock_sample ?y), (have_image ?r ?o ?m), (communicated_rock_data ?x), (visible_from ?o ?x), (communicated_soil_data ?x), (available ?r), (visible_from ?o ?y), (visible ?y ?x), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?x), (communicated_image_data ?o ?m), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?y), 
;; drop action has changed: (available ?x), (empty ?y), (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), (store_of ?y ?x), (equipped_for_imaging ?x), (empty ?y), (equipped_for_imaging ?x), 
;; navigate action has changed: (at_rock_sample ?y), (visible ?z ?y), (at ?x ?z), (have_soil_analysis ?x ?y), (have_rock_analysis ?x ?z), (at_rock_sample ?z), (have_soil_analysis ?x ?y), (communicated_rock_data ?y), (visible ?z ?y), (visible ?y ?z), (equipped_for_imaging ?x), (communicated_rock_data ?y), (at ?x ?y), (have_rock_analysis ?x ?y), (communicated_soil_data ?z), (available ?x), (at_rock_sample ?y), (equipped_for_soil_analysis ?x), 
;; calibrate action has changed: (visible_from ?t ?w), (have_rock_analysis ?r ?w), (calibrated ?i ?r), (communicated_rock_data ?w), (communicated_soil_data ?w), (communicated_soil_data ?w), (at_soil_sample ?w), (at ?r ?w), (have_soil_analysis ?r ?w), (equipped_for_imaging ?r), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?w), (at_rock_sample ?w), (at_rock_sample ?w), (equipped_for_imaging ?r), 
;; sample_soil action has changed: (equipped_for_rock_analysis ?x), (at ?x ?p), (store_of ?s ?x), (equipped_for_imaging ?x), (at_rock_sample ?p), 
;; Last_reduced_capability_num_dropped_pals: None

