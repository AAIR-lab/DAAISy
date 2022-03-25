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
			(available ?x)
			(not (at_rock_sample ?y))
			(not (have_soil_analysis ?x ?y))
			(at_soil_sample ?z)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?z))
			(communicated_rock_data ?z)
			(communicated_soil_data ?y)
			(visible ?y ?z)
			(equipped_for_rock_analysis ?x)
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			(have_soil_analysis ?x ?z)
			
          )
          :effect (and 
               (have_rock_analysis ?x ?z)
			(available ?x)
			(not (visible ?z ?y))
			(not (equipped_for_imaging ?x))
			(not (at_rock_sample ?y))
			(not (at ?x ?y))
			(not (at_soil_sample ?z))
			(communicated_rock_data ?z)
			(not (at ?x ?z))
			(not (have_soil_analysis ?x ?z))
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(empty ?s)
			(full ?s)
			(store_of ?s ?x)
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (available ?x))
			(not (at ?x ?p))
			(empty ?s)
			(not (at_soil_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(not (have_soil_analysis ?x ?p))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (not (empty ?s))
			(not (equipped_for_imaging ?x))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(not (communicated_rock_data ?p))
			(not (equipped_for_rock_analysis ?x))
			
          )
        :effect (and 
               (available ?x)
			(not (full ?s))
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(equipped_for_soil_analysis ?x)
			(not (full ?y))
			(not (equipped_for_imaging ?x))
			
          )
        :effect (and 
               (not (store_of ?y ?x))
			(empty ?y)
			(equipped_for_rock_analysis ?x)
			(not (equipped_for_soil_analysis ?x))
			(equipped_for_imaging ?x)
			
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
			(not (have_soil_analysis ?r ?w))
			(not (available ?r))
			(at ?r ?w)
			(on_board ?i ?r)
			(not (at_rock_sample ?w))
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
			(not (communicated_soil_data ?w))
			
          )
         :effect (and 
               (not (equipped_for_rock_analysis ?r))
			(have_soil_analysis ?r ?w)
			(not (equipped_for_imaging ?r))
			(not (on_board ?i ?r))
			(at_rock_sample ?w)
			(not (have_rock_analysis ?r ?w))
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
			(not (equipped_for_soil_analysis ?r))
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(communicated_rock_data ?p)
			(calibrated ?i ?r)
			(not (at ?r ?p))
			
          )
          :effect (and 
               (supports ?i ?m)
			(communicated_image_data ?o ?m)
			(have_soil_analysis ?r ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (have_image ?r ?o ?m))
			(calibration_target ?i ?o)
			(not (equipped_for_soil_analysis ?r))
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(have_rock_analysis ?r ?p)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (visible_from ?o ?p))
			(communicated_rock_data ?p)
			(calibrated ?i ?r)
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
               (visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(not (visible ?p ?y))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(visible ?x ?p)
			
          )
          :effect (and 
               (channel_free ?l)
			(not (have_soil_analysis ?r ?x))
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(at_rock_sample ?p)
			(at ?r ?x)
			(communicated_rock_data ?p)
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(not (visible ?x ?p))
			(can_traverse ?r ?y ?x)
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
               (not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(not (have_soil_analysis ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(not (at_lander ?l ?y))
			(have_rock_analysis ?r ?y)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (at_rock_sample ?x))
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(not (at_lander ?l ?y))
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(not (communicated_soil_data ?y))
			(at_lander ?l ?p)
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
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
			(not (equipped_for_imaging ?r))
			(have_image ?r ?o ?m)
			(not (have_soil_analysis ?r ?x))
			(not (at_rock_sample ?x))
			(not (at ?r ?y))
			(available ?r)
			(at_rock_sample ?y)
			(visible_from ?o ?x)
			(equipped_for_soil_analysis ?r)
			(not (visible_from ?o ?y))
			(equipped_for_rock_analysis ?r)
			(not (communicated_rock_data ?y))
			
          )
         :effect (and 
               (not (equipped_for_imaging ?r))
			(communicated_rock_data ?x)
			(visible ?x ?y)
			(not (available ?r))
			(at_rock_sample ?y)
			(not (visible_from ?o ?x))
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?y))
			(not (have_rock_analysis ?r ?x))
			(can_traverse ?r ?y ?x)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (have_soil_analysis ?r ?x), (at_lander ?l ?y), (communicated_soil_data ?y), (visible ?x ?y), (channel_free ?l), (have_soil_analysis ?r ?p), (communicated_rock_data ?y), (can_traverse ?r ?x ?y), (at_soil_sample ?p), (communicated_rock_data ?p), (at_soil_sample ?p), (visible ?x ?p), (have_soil_analysis ?r ?y), (communicated_rock_data ?x), (can_traverse ?r ?p ?x), (at_rock_sample ?p), (at_rock_sample ?x), (have_soil_analysis ?r ?x), (can_traverse ?r ?y ?x), (can_traverse ?r ?x ?p), (visible ?y ?x), (have_rock_analysis ?r ?y), (at_soil_sample ?x), (have_rock_analysis ?r ?p), (can_traverse ?r ?p ?x), (communicated_soil_data ?y), (at_lander ?l ?y), (equipped_for_soil_analysis ?r), (at ?r ?x), (at_rock_sample ?y), (have_rock_analysis ?r ?y), (have_soil_analysis ?r ?y), (equipped_for_imaging ?r), (equipped_for_rock_analysis ?r), (at_rock_sample ?y), (communicated_soil_data ?x), (can_traverse ?r ?p ?y), (can_traverse ?r ?y ?x), (communicated_soil_data ?p), (available ?r), (visible ?y ?p), (visible ?y ?p), (at_rock_sample ?x), (visible ?y ?x), (channel_free ?l), (equipped_for_rock_analysis ?r), (at_lander ?l ?p), (at ?r ?p), 
;; navigate action has changed: (available ?x), (at_soil_sample ?y), (equipped_for_soil_analysis ?x), (at_rock_sample ?z), (at_rock_sample ?y), (at ?x ?z), (have_soil_analysis ?x ?z), (communicated_rock_data ?z), (at ?x ?z), (have_rock_analysis ?x ?z), (at ?x ?y), (communicated_soil_data ?y), (communicated_soil_data ?z), (visible ?z ?y), (have_soil_analysis ?x ?y), (at_soil_sample ?z), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (have_soil_analysis ?x ?z), (at_soil_sample ?z), (at_rock_sample ?y), (communicated_rock_data ?z), 
;; take_image action has changed: (communicated_image_data ?o ?m), (have_soil_analysis ?r ?p), (equipped_for_soil_analysis ?r), (at ?r ?p), (visible_from ?o ?p), (equipped_for_rock_analysis ?r), (at_rock_sample ?p), (communicated_image_data ?o ?m), (have_image ?r ?o ?m), (have_soil_analysis ?r ?p), (supports ?i ?m), (have_rock_analysis ?r ?p), (at_soil_sample ?p), (communicated_rock_data ?p), (equipped_for_imaging ?r), (calibration_target ?i ?o), (on_board ?i ?r), (at_soil_sample ?p), (communicated_rock_data ?p), (at_rock_sample ?p), (visible_from ?o ?p), (calibrated ?i ?r), (equipped_for_soil_analysis ?r), (at ?r ?p), 
;; sample_soil action has changed: (communicated_rock_data ?p), (available ?x), (at ?x ?p), (equipped_for_rock_analysis ?x), (available ?x), (communicated_soil_data ?p), (equipped_for_soil_analysis ?x), (full ?s), (equipped_for_soil_analysis ?x), (have_soil_analysis ?x ?p), (at ?x ?p), (empty ?s), (at_soil_sample ?p), (full ?s), (have_rock_analysis ?x ?p), 
;; communicate_soil_data action has changed: (at ?r ?y), (communicated_rock_data ?y), (have_rock_analysis ?r ?p), (visible ?x ?p), (available ?r), (visible ?y ?x), (can_traverse ?r ?p ?y), (visible ?x ?p), (at_soil_sample ?x), (at_lander ?l ?p), (at ?r ?x), (communicated_rock_data ?p), (can_traverse ?r ?x ?y), (have_soil_analysis ?r ?x), (at_lander ?l ?p), (have_rock_analysis ?r ?x), (at_soil_sample ?y), (have_soil_analysis ?r ?y), (at_rock_sample ?x), (can_traverse ?r ?y ?x), (equipped_for_soil_analysis ?r), (at_rock_sample ?p), (at ?r ?y), (have_soil_analysis ?r ?x), (have_rock_analysis ?r ?y), (at_soil_sample ?y), (at_soil_sample ?p), (have_rock_analysis ?r ?p), (at ?r ?p), (visible ?p ?y), (channel_free ?l), (at_soil_sample ?x), (have_rock_analysis ?r ?x), (channel_free ?l), (can_traverse ?r ?x ?y), (at_rock_sample ?p), (can_traverse ?r ?p ?x), (communicated_soil_data ?x), (have_soil_analysis ?r ?y), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?y), (at_lander ?l ?x), (can_traverse ?r ?x ?p), (have_soil_analysis ?r ?p), (at ?r ?p), (communicated_soil_data ?p), 
;; calibrate action has changed: (at_soil_sample ?w), (at_rock_sample ?w), (on_board ?i ?r), (equipped_for_rock_analysis ?r), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?w), (communicated_soil_data ?w), (have_rock_analysis ?r ?w), (have_soil_analysis ?r ?w), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?w), (available ?r), (at_rock_sample ?w), (equipped_for_imaging ?r), (equipped_for_imaging ?r), 
;; sample_rock action has changed: (at ?x ?p), (equipped_for_imaging ?x), (empty ?s), (equipped_for_rock_analysis ?x), (store_of ?s ?x), (at_rock_sample ?p), (store_of ?s ?x), (communicated_soil_data ?p), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?p), (empty ?s), (communicated_rock_data ?p), (communicated_rock_data ?p), (available ?x), (have_soil_analysis ?x ?p), (full ?s), (at_soil_sample ?p), (equipped_for_soil_analysis ?x), (at_soil_sample ?p), 
;; communicate_image_data action has changed: (have_soil_analysis ?r ?x), (equipped_for_imaging ?r), (at_lander ?l ?x), (have_rock_analysis ?r ?y), (at_lander ?l ?y), (visible ?x ?y), (at_rock_sample ?y), (visible ?x ?y), (visible_from ?o ?x), (visible_from ?o ?x), (at_rock_sample ?y), (at ?r ?x), (at_rock_sample ?x), (can_traverse ?r ?y ?x), (equipped_for_rock_analysis ?r), (equipped_for_imaging ?r), (available ?r), (have_rock_analysis ?r ?x), (at ?r ?y), (visible_from ?o ?y), (at_soil_sample ?y), (communicated_rock_data ?x), (equipped_for_soil_analysis ?r), (communicated_rock_data ?y), 
;; drop action has changed: (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (equipped_for_imaging ?x), (full ?y), (full ?y), (store_of ?y ?x), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), 
;; Last_reduced_capability_num_dropped_pals: None

