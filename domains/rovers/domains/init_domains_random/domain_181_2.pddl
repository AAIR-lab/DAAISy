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
			(not (equipped_for_imaging ?x))
			(at_rock_sample ?y)
			(not (at ?x ?y))
			(communicated_rock_data ?z)
			(visible ?y ?z)
			(not (can_traverse ?x ?y ?z))
			(at ?x ?z)
			(not (have_soil_analysis ?x ?z))
			(not (have_rock_analysis ?x ?y))
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (at_rock_sample ?z)
			(have_rock_analysis ?x ?z)
			(at ?x ?y)
			(have_soil_analysis ?x ?y)
			(at_soil_sample ?z)
			(communicated_soil_data ?z)
			(not (communicated_soil_data ?y))
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			(not (have_soil_analysis ?x ?z))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(not (empty ?s))
			(full ?s)
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			(have_soil_analysis ?x ?p)
			(communicated_rock_data ?p)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (equipped_for_imaging ?x))
			(full ?s)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (empty ?s)
			(equipped_for_imaging ?x)
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (equipped_for_imaging ?x))
			(full ?s)
			(not (equipped_for_soil_analysis ?x))
			(not (have_soil_analysis ?x ?p))
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
			(not (store_of ?y ?x))
			(empty ?y)
			(not (equipped_for_imaging ?x))
			
          )
        :effect (and 
               (available ?x)
			(not (empty ?y))
			(equipped_for_soil_analysis ?x)
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
               (equipped_for_rock_analysis ?r)
			(not (have_soil_analysis ?r ?w))
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(on_board ?i ?r)
			(visible_from ?t ?w)
			(not (communicated_rock_data ?w))
			
          )
         :effect (and 
               (not (calibration_target ?i ?t))
			(not (at ?r ?w))
			(not (equipped_for_soil_analysis ?r))
			(visible_from ?t ?w)
			(have_rock_analysis ?r ?w)
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
			(not (equipped_for_rock_analysis ?r))
			(available ?r)
			(not (have_image ?r ?o ?m))
			(not (calibration_target ?i ?o))
			(equipped_for_soil_analysis ?r)
			(not (equipped_for_imaging ?r))
			(not (on_board ?i ?r))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(visible_from ?o ?p)
			(not (communicated_soil_data ?p))
			(not (communicated_rock_data ?p))
			(not (calibrated ?i ?r))
			(at ?r ?p)
			
          )
          :effect (and 
               (not (have_soil_analysis ?r ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(not (equipped_for_soil_analysis ?r))
			(at_rock_sample ?p)
			(not (communicated_soil_data ?p))
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
               (equipped_for_imaging ?r)
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(visible ?p ?y)
			(not (visible ?x ?y))
			(not (can_traverse ?r ?p ?y))
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(equipped_for_soil_analysis ?r)
			(communicated_soil_data ?x)
			(not (have_rock_analysis ?r ?p))
			(at_lander ?l ?p)
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(not (visible ?x ?y))
			(not (can_traverse ?r ?p ?y))
			(not (at ?r ?y))
			(not (have_soil_analysis ?r ?p))
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(not (can_traverse ?r ?x ?p))
			(communicated_soil_data ?p)
			(not (visible ?x ?p))
			(can_traverse ?r ?y ?x)
			
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
			(equipped_for_imaging ?r)
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(visible ?p ?y)
			(not (at ?r ?y))
			(at_rock_sample ?y)
			(at ?r ?x)
			(not (can_traverse ?r ?y ?p))
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (have_rock_analysis ?r ?x))
			(communicated_soil_data ?p)
			
          )
          :effect (and 
               (not (channel_free ?l))
			(not (visible ?y ?x))
			(not (visible ?p ?x))
			(visible ?p ?y)
			(not (at_rock_sample ?x))
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (available ?r))
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?y))
			(communicated_soil_data ?x)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
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
               (not (channel_free ?l))
			(have_image ?r ?o ?m)
			(not (communicated_rock_data ?x))
			(not (visible ?x ?y))
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (have_rock_analysis ?r ?y))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?x)
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (channel_free ?l)
			(have_image ?r ?o ?m)
			(not (visible ?x ?y))
			(at ?r ?y)
			(not (available ?r))
			(at_rock_sample ?y)
			(at_lander ?l ?y)
			(not (have_rock_analysis ?r ?y))
			(at_soil_sample ?y)
			(not (at_soil_sample ?x))
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			(not (communicated_rock_data ?y))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; drop action has changed: (available ?x), (store_of ?y ?x), (equipped_for_soil_analysis ?x), (empty ?y), (equipped_for_imaging ?x), (equipped_for_imaging ?x), (empty ?y), (full ?y), (available ?x), 
;; communicate_rock_data action has changed: (can_traverse ?r ?y ?p), (can_traverse ?r ?y ?p), (have_rock_analysis ?r ?x), (visible ?y ?x), (equipped_for_imaging ?r), (at_rock_sample ?y), (visible ?x ?y), (available ?r), (visible ?p ?y), (at_lander ?l ?y), (have_rock_analysis ?r ?y), (visible ?p ?x), (communicated_soil_data ?x), (at ?r ?x), (at ?r ?y), (communicated_rock_data ?x), (at_rock_sample ?x), (can_traverse ?r ?p ?x), (channel_free ?l), (communicated_soil_data ?p), (have_rock_analysis ?r ?p), (available ?r), (at_soil_sample ?x), (have_rock_analysis ?r ?x), (visible ?p ?y), (communicated_soil_data ?y), (at_lander ?l ?y), (at ?r ?p), (visible ?p ?x), (at_soil_sample ?y), (have_soil_analysis ?r ?y), (communicated_soil_data ?x), (at ?r ?y), 
;; take_image action has changed: (available ?r), (have_image ?r ?o ?m), (available ?r), (communicated_soil_data ?p), (calibration_target ?i ?o), (calibrated ?i ?r), (equipped_for_rock_analysis ?r), (at_soil_sample ?p), (equipped_for_soil_analysis ?r), (at_rock_sample ?p), (communicated_soil_data ?p), (have_image ?r ?o ?m), (communicated_rock_data ?p), (on_board ?i ?r), (communicated_rock_data ?p), (at_rock_sample ?p), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?p), (equipped_for_rock_analysis ?r), (equipped_for_imaging ?r), 
;; communicate_soil_data action has changed: (can_traverse ?r ?y ?x), (can_traverse ?r ?p ?y), (equipped_for_soil_analysis ?r), (visible ?y ?x), (at_rock_sample ?y), (can_traverse ?r ?x ?p), (have_soil_analysis ?r ?y), (equipped_for_imaging ?r), (channel_free ?l), (communicated_rock_data ?p), (at_lander ?l ?p), (communicated_soil_data ?x), (can_traverse ?r ?p ?y), (at ?r ?y), (visible ?x ?y), (at_soil_sample ?y), (equipped_for_imaging ?r), (at ?r ?y), (visible ?p ?x), (visible ?p ?x), (at_soil_sample ?x), (have_rock_analysis ?r ?p), (communicated_rock_data ?y), (communicated_rock_data ?x), (at_lander ?l ?y), (equipped_for_soil_analysis ?r), (visible ?p ?y), (visible ?x ?y), (have_soil_analysis ?r ?p), (at_soil_sample ?p), (visible ?x ?p), (communicated_soil_data ?x), (can_traverse ?r ?y ?x), (communicated_rock_data ?x), 
;; sample_rock action has changed: (have_rock_analysis ?x ?p), (equipped_for_imaging ?x), (have_soil_analysis ?x ?p), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (at ?x ?p), (have_rock_analysis ?x ?p), (at_rock_sample ?p), (at_soil_sample ?p), (communicated_soil_data ?p), (empty ?s), (equipped_for_soil_analysis ?x), 
;; navigate action has changed: (have_soil_analysis ?x ?z), (communicated_rock_data ?z), (at_rock_sample ?z), (can_traverse ?x ?y ?z), (have_soil_analysis ?x ?y), (have_soil_analysis ?x ?z), (have_rock_analysis ?x ?y), (at ?x ?y), (communicated_soil_data ?z), (at ?x ?y), (at_soil_sample ?z), (at_rock_sample ?z), (at ?x ?z), (communicated_rock_data ?y), (can_traverse ?x ?y ?z), (have_rock_analysis ?x ?z), (equipped_for_imaging ?x), (communicated_soil_data ?y), (at_rock_sample ?y), (visible ?y ?z), 
;; communicate_image_data action has changed: (available ?r), (visible ?x ?y), (equipped_for_rock_analysis ?r), (channel_free ?l), (at_soil_sample ?x), (at ?r ?y), (have_image ?r ?o ?m), (communicated_soil_data ?y), (at_lander ?l ?y), (visible_from ?o ?x), (at_soil_sample ?y), (have_rock_analysis ?r ?x), (communicated_rock_data ?y), (communicated_rock_data ?x), (at_rock_sample ?y), (at ?r ?y), (available ?r), (visible ?x ?y), (communicated_rock_data ?y), (at_soil_sample ?x), (equipped_for_rock_analysis ?r), (channel_free ?l), (visible_from ?o ?y), (visible_from ?o ?y), (can_traverse ?r ?y ?x), (have_rock_analysis ?r ?x), (communicated_image_data ?o ?m), (have_rock_analysis ?r ?y), (can_traverse ?r ?x ?y), (have_rock_analysis ?r ?y), 
;; calibrate action has changed: (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?w), (equipped_for_soil_analysis ?r), (at ?r ?w), (calibration_target ?i ?t), (communicated_rock_data ?w), (have_rock_analysis ?r ?w), (calibration_target ?i ?t), (visible_from ?t ?w), 
;; sample_soil action has changed: (at_soil_sample ?p), (equipped_for_imaging ?x), (empty ?s), (store_of ?s ?x), (at ?x ?p), (full ?s), (have_soil_analysis ?x ?p), (at_rock_sample ?p), (empty ?s), (have_soil_analysis ?x ?p), (communicated_rock_data ?p), (have_rock_analysis ?x ?p), (available ?x), 
;; Last_reduced_capability_num_dropped_pals: None

