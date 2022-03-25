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
			(not (have_rock_analysis ?x ?z))
			(available ?x)
			(not (visible ?z ?y))
			(not (equipped_for_imaging ?x))
			(not (at ?x ?y))
			(have_soil_analysis ?x ?y)
			(not (communicated_soil_data ?z))
			(communicated_soil_data ?y)
			(not (visible ?y ?z))
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			(not (have_soil_analysis ?x ?z))
			(have_rock_analysis ?x ?y)
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (at ?x ?y)
			(not (at_soil_sample ?z))
			(communicated_rock_data ?z)
			(not (communicated_soil_data ?y))
			(not (visible ?y ?z))
			(not (equipped_for_rock_analysis ?x))
			(at ?x ?z)
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(at ?x ?p)
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (empty ?s))
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(have_soil_analysis ?x ?p)
			(not (equipped_for_rock_analysis ?x))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (empty ?s)
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			
          )
        :effect (and 
               (empty ?s)
			(full ?s)
			(communicated_rock_data ?p)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(not (equipped_for_rock_analysis ?x))
			(equipped_for_soil_analysis ?x)
			(not (full ?y))
			(not (equipped_for_imaging ?x))
			
          )
        :effect (and 
               (available ?x)
			(store_of ?y ?x)
			(not (empty ?y))
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
			(have_soil_analysis ?r ?w)
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(not (on_board ?i ?r))
			(communicated_soil_data ?w)
			(not (calibrated ?i ?r))
			
          )
         :effect (and 
               (not (calibration_target ?i ?t))
			(have_soil_analysis ?r ?w)
			(not (on_board ?i ?r))
			(not (equipped_for_soil_analysis ?r))
			(visible_from ?t ?w)
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
               (have_soil_analysis ?r ?p)
			(not (equipped_for_soil_analysis ?r))
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(not (at_soil_sample ?p))
			(not (communicated_soil_data ?p))
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (not (communicated_image_data ?o ?m))
			(not (have_soil_analysis ?r ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(calibration_target ?i ?o)
			(equipped_for_soil_analysis ?r)
			(equipped_for_imaging ?r)
			(not (have_rock_analysis ?r ?p))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(visible_from ?o ?p)
			(not (communicated_rock_data ?p))
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
               (not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(not (at_soil_sample ?p))
			(not (at ?r ?x))
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(can_traverse ?r ?x ?p)
			(have_rock_analysis ?r ?x)
			(not (communicated_soil_data ?p))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (equipped_for_imaging ?r))
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?p ?y))
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (have_soil_analysis ?r ?p))
			(at_rock_sample ?y)
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?x)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			
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
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(not (visible ?p ?y))
			(visible ?x ?y)
			(not (can_traverse ?r ?p ?y))
			(not (at ?r ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(at_soil_sample ?x)
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(equipped_for_rock_analysis ?r)
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(communicated_rock_data ?x)
			(visible ?p ?x)
			(visible ?p ?y)
			(visible ?x ?y)
			(not (can_traverse ?r ?p ?y))
			(not (at ?r ?p))
			(not (at ?r ?y))
			(have_soil_analysis ?r ?p)
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(not (communicated_rock_data ?p))
			(at_lander ?l ?x)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(not (have_rock_analysis ?r ?p))
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(visible ?y ?p)
			
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
			(visible ?y ?x)
			(have_image ?r ?o ?m)
			(at_rock_sample ?x)
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(not (at_rock_sample ?y))
			(not (visible_from ?o ?x))
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?x)
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			
          )
         :effect (and 
               (visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (available ?r))
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(not (visible_from ?o ?y))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; sample_rock action has changed: (empty ?s), (full ?s), (have_soil_analysis ?x ?p), (at_soil_sample ?p), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (at_rock_sample ?p), (communicated_rock_data ?p), (at ?x ?p), (communicated_soil_data ?p), 
;; navigate action has changed: (equipped_for_rock_analysis ?x), (equipped_for_rock_analysis ?x), (communicated_soil_data ?y), (communicated_soil_data ?z), (communicated_soil_data ?y), (equipped_for_imaging ?x), (visible ?z ?y), (at_soil_sample ?z), (visible ?y ?z), (at ?x ?y), (visible ?y ?z), (communicated_rock_data ?y), (at ?x ?y), (communicated_rock_data ?z), (have_rock_analysis ?x ?y), (have_soil_analysis ?x ?y), (have_rock_analysis ?x ?z), (at_rock_sample ?z), (equipped_for_soil_analysis ?x), (have_soil_analysis ?x ?z), 
;; communicate_image_data action has changed: (can_traverse ?r ?y ?x), (at_rock_sample ?x), (at_rock_sample ?x), (at_lander ?l ?y), (communicated_rock_data ?x), (have_rock_analysis ?r ?x), (visible ?y ?x), (visible_from ?o ?x), (visible ?x ?y), (at ?r ?x), (at_rock_sample ?y), (communicated_image_data ?o ?m), (have_soil_analysis ?r ?y), (at_soil_sample ?y), (equipped_for_rock_analysis ?r), (communicated_soil_data ?y), (at ?r ?y), (at_lander ?l ?x), (have_soil_analysis ?r ?x), (at ?r ?y), (have_soil_analysis ?r ?y), (visible_from ?o ?y), (at_soil_sample ?x), (communicated_rock_data ?y), (can_traverse ?r ?y ?x), (available ?r), (communicated_rock_data ?y), (at_soil_sample ?x), (can_traverse ?r ?x ?y), (visible_from ?o ?y), (have_rock_analysis ?r ?y), (available ?r), (visible ?y ?x), (at ?r ?x), (equipped_for_soil_analysis ?r), (at_lander ?l ?x), (have_rock_analysis ?r ?x), (have_rock_analysis ?r ?y), (at_lander ?l ?y), (communicated_soil_data ?x), (channel_free ?l), 
;; communicate_rock_data action has changed: (visible ?p ?y), (have_rock_analysis ?r ?p), (communicated_rock_data ?y), (visible ?y ?p), (communicated_rock_data ?p), (at_lander ?l ?x), (can_traverse ?r ?p ?y), (at_rock_sample ?y), (can_traverse ?r ?x ?p), (at ?r ?x), (have_rock_analysis ?r ?x), (visible ?y ?p), (at ?r ?y), (communicated_rock_data ?p), (equipped_for_rock_analysis ?r), (visible ?y ?x), (have_rock_analysis ?r ?x), (at_soil_sample ?y), (can_traverse ?r ?y ?x), (at_soil_sample ?p), (at_soil_sample ?y), (communicated_rock_data ?x), (at ?r ?y), (have_rock_analysis ?r ?p), (at ?r ?p), (equipped_for_imaging ?r), (at_lander ?l ?x), (can_traverse ?r ?p ?x), (equipped_for_soil_analysis ?r), (visible ?p ?x), (visible ?y ?x), (equipped_for_soil_analysis ?r), (communicated_soil_data ?p), (at_soil_sample ?x), (can_traverse ?r ?x ?p), (have_soil_analysis ?r ?p), (channel_free ?l), (have_rock_analysis ?r ?y), (communicated_soil_data ?y), (visible ?x ?y), (at_lander ?l ?p), (have_soil_analysis ?r ?x), (visible ?p ?y), (equipped_for_rock_analysis ?r), (equipped_for_imaging ?r), (have_soil_analysis ?r ?p), (can_traverse ?r ?p ?y), 
;; communicate_soil_data action has changed: (channel_free ?l), (at_soil_sample ?y), (at_soil_sample ?x), (can_traverse ?r ?y ?p), (equipped_for_rock_analysis ?r), (at ?r ?x), (have_soil_analysis ?r ?y), (communicated_soil_data ?x), (can_traverse ?r ?y ?p), (can_traverse ?r ?y ?x), (at_soil_sample ?p), (at_rock_sample ?y), (have_rock_analysis ?r ?y), (communicated_soil_data ?y), (equipped_for_imaging ?r), (equipped_for_imaging ?r), (communicated_soil_data ?p), (communicated_soil_data ?x), (visible ?y ?p), (at ?r ?x), (at ?r ?y), (communicated_soil_data ?p), (have_soil_analysis ?r ?p), (can_traverse ?r ?x ?p), (can_traverse ?r ?p ?x), (communicated_rock_data ?x), (at_rock_sample ?p), (at_rock_sample ?x), (communicated_rock_data ?x), (visible ?p ?x), (visible ?y ?x), (available ?r), (at_lander ?l ?x), (can_traverse ?r ?p ?y), (at_lander ?l ?x), (have_soil_analysis ?r ?x), (at_soil_sample ?y), (communicated_rock_data ?y), (have_rock_analysis ?r ?p), (can_traverse ?r ?y ?x), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?p), (communicated_rock_data ?p), (at_lander ?l ?y), (communicated_rock_data ?y), (have_rock_analysis ?r ?x), (have_rock_analysis ?r ?x), (at ?r ?p), (have_soil_analysis ?r ?y), (at_rock_sample ?x), 
;; sample_soil action has changed: (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?p), (equipped_for_rock_analysis ?x), (full ?s), (communicated_soil_data ?p), (empty ?s), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (at_rock_sample ?p), (at_soil_sample ?p), (equipped_for_rock_analysis ?x), (store_of ?s ?x), (available ?x), (communicated_rock_data ?p), 
;; calibrate action has changed: (visible_from ?t ?w), (visible_from ?t ?w), (have_rock_analysis ?r ?w), (equipped_for_soil_analysis ?r), (at_soil_sample ?w), (on_board ?i ?r), (have_soil_analysis ?r ?w), (calibrated ?i ?r), (calibration_target ?i ?t), (on_board ?i ?r), (calibrated ?i ?r), (communicated_soil_data ?w), (have_soil_analysis ?r ?w), 
;; take_image action has changed: (have_image ?r ?o ?m), (equipped_for_imaging ?r), (communicated_image_data ?o ?m), (have_soil_analysis ?r ?p), (available ?r), (equipped_for_soil_analysis ?r), (calibration_target ?i ?o), (at_rock_sample ?p), (equipped_for_soil_analysis ?r), (communicated_rock_data ?p), (equipped_for_rock_analysis ?r), (supports ?i ?m), (have_rock_analysis ?r ?p), (at_soil_sample ?p), (visible_from ?o ?p), (have_soil_analysis ?r ?p), (at_soil_sample ?p), (communicated_soil_data ?p), (visible_from ?o ?p), 
;; drop action has changed: (full ?y), (equipped_for_imaging ?x), (available ?x), (store_of ?y ?x), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (empty ?y), 
;; Last_reduced_capability_num_dropped_pals: None

