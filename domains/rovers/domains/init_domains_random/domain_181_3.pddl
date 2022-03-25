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
			(not (available ?x))
			(not (visible ?z ?y))
			(not (equipped_for_imaging ?x))
			(at ?x ?y)
			(communicated_soil_data ?z)
			(communicated_rock_data ?z)
			(visible ?y ?z)
			(equipped_for_rock_analysis ?x)
			(can_traverse ?x ?y ?z)
			(not (at ?x ?z))
			(not (have_soil_analysis ?x ?z))
			(not (communicated_rock_data ?y))
			(equipped_for_soil_analysis ?x)
			
          )
          :effect (and 
               (available ?x)
			(visible ?z ?y)
			(not (at_rock_sample ?y))
			(not (at ?x ?y))
			(not (communicated_rock_data ?z))
			(not (equipped_for_rock_analysis ?x))
			(not (at ?x ?z))
			(not (have_rock_analysis ?x ?y))
			(not (communicated_rock_data ?y))
			(not (equipped_for_soil_analysis ?x))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (at ?x ?p))
			(empty ?s)
			(not (full ?s))
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (available ?x)
			(at ?x ?p)
			(equipped_for_imaging ?x)
			(full ?s)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (communicated_soil_data ?p))
			(not (have_soil_analysis ?x ?p))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (empty ?s)
			(full ?s)
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(communicated_soil_data ?p)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (available ?x))
			(not (store_of ?y ?x))
			(equipped_for_soil_analysis ?x)
			(full ?y)
			
          )
        :effect (and 
               (empty ?y)
			(full ?y)
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
			(equipped_for_rock_analysis ?r)
			(not (available ?r))
			(at ?r ?w)
			(not (on_board ?i ?r))
			(not (at_rock_sample ?w))
			(visible_from ?t ?w)
			(communicated_soil_data ?w)
			(at_soil_sample ?w)
			
          )
         :effect (and 
               (not (calibration_target ?i ?t))
			(not (equipped_for_rock_analysis ?r))
			(have_soil_analysis ?r ?w)
			(equipped_for_imaging ?r)
			(not (at ?r ?w))
			(not (on_board ?i ?r))
			(not (at_rock_sample ?w))
			(not (have_rock_analysis ?r ?w))
			(not (communicated_rock_data ?w))
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
			(have_soil_analysis ?r ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (calibration_target ?i ?o))
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(visible_from ?o ?p)
			(not (calibrated ?i ?r))
			
          )
          :effect (and 
               (communicated_image_data ?o ?m)
			(not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(equipped_for_imaging ?r)
			(at_soil_sample ?p)
			(visible_from ?o ?p)
			(not (communicated_soil_data ?p))
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
               (not (visible ?y ?x))
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(visible ?p ?y)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (at ?r ?p))
			(available ?r)
			(at_rock_sample ?y)
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(equipped_for_rock_analysis ?r)
			(can_traverse ?r ?y ?x)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (have_soil_analysis ?r ?x)
			(not (visible ?p ?x))
			(not (can_traverse ?r ?p ?y))
			(have_soil_analysis ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(not (at_rock_sample ?y))
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(communicated_soil_data ?p)
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
               (channel_free ?l)
			(visible ?p ?x)
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(not (at_soil_sample ?p))
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(communicated_soil_data ?x)
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			(communicated_soil_data ?p)
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(not (at ?r ?p))
			(at ?r ?y)
			(not (have_soil_analysis ?r ?p))
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(not (at_soil_sample ?y))
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(not (can_traverse ?r ?x ?p))
			(at_lander ?l ?p)
			(equipped_for_rock_analysis ?r)
			(communicated_rock_data ?y)
			
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
			(not (at_rock_sample ?x))
			(not (at ?r ?y))
			(available ?r)
			(at_rock_sample ?y)
			(at ?r ?x)
			(not (communicated_soil_data ?x))
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			(communicated_image_data ?o ?m)
			
          )
         :effect (and 
               (channel_free ?l)
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(visible ?x ?y)
			(at_rock_sample ?x)
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(at_rock_sample ?y)
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (have_rock_analysis ?r ?y))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?x)
			(equipped_for_rock_analysis ?r)
			(not (can_traverse ?r ?y ?x))
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; communicate_soil_data action has changed: (have_soil_analysis ?r ?p), (channel_free ?l), (at_lander ?l ?x), (at_rock_sample ?x), (have_soil_analysis ?r ?x), (at ?r ?p), (visible ?p ?y), (have_rock_analysis ?r ?x), (can_traverse ?r ?p ?x), (at_soil_sample ?x), (have_rock_analysis ?r ?x), (communicated_soil_data ?y), (at_lander ?l ?y), (at_soil_sample ?y), (at_lander ?l ?x), (have_soil_analysis ?r ?y), (have_rock_analysis ?r ?y), (communicated_soil_data ?x), (communicated_rock_data ?x), (can_traverse ?r ?x ?y), (at_rock_sample ?y), (can_traverse ?r ?y ?x), (at_rock_sample ?y), (visible ?p ?x), (can_traverse ?r ?y ?x), (can_traverse ?r ?x ?p), (communicated_soil_data ?x), (have_rock_analysis ?r ?p), (visible ?y ?x), (communicated_rock_data ?y), (visible ?p ?x), (at ?r ?x), (equipped_for_rock_analysis ?r), (can_traverse ?r ?p ?y), (at_soil_sample ?x), 
;; calibrate action has changed: (equipped_for_imaging ?r), (available ?r), (on_board ?i ?r), (calibrated ?i ?r), (equipped_for_rock_analysis ?r), (at_rock_sample ?w), (on_board ?i ?r), (at_rock_sample ?w), (have_soil_analysis ?r ?w), (calibration_target ?i ?t), (equipped_for_rock_analysis ?r), (communicated_rock_data ?w), (communicated_soil_data ?w), (have_rock_analysis ?r ?w), (at_soil_sample ?w), (equipped_for_imaging ?r), (at ?r ?w), 
;; communicate_rock_data action has changed: (visible ?p ?x), (at_soil_sample ?y), (at_lander ?l ?p), (communicated_rock_data ?p), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?p), (can_traverse ?r ?x ?y), (at_lander ?l ?y), (at ?r ?p), (communicated_soil_data ?x), (available ?r), (equipped_for_imaging ?r), (have_rock_analysis ?r ?p), (communicated_soil_data ?y), (at ?r ?x), (visible ?y ?p), (at_rock_sample ?y), (at ?r ?x), (can_traverse ?r ?p ?x), (communicated_rock_data ?y), (communicated_rock_data ?y), (visible ?x ?p), (have_soil_analysis ?r ?x), (at_soil_sample ?p), (channel_free ?l), (have_soil_analysis ?r ?p), (at_soil_sample ?p), (at_lander ?l ?y), (communicated_soil_data ?p), (can_traverse ?r ?x ?p), (can_traverse ?r ?y ?p), (at_lander ?l ?x), (at_rock_sample ?x), (have_rock_analysis ?r ?x), (have_rock_analysis ?r ?p), (at ?r ?y), (communicated_rock_data ?x), (at_soil_sample ?x), 
;; sample_soil action has changed: (empty ?s), (have_rock_analysis ?x ?p), (at_soil_sample ?p), (communicated_soil_data ?p), (communicated_rock_data ?p), (full ?s), (at ?x ?p), (equipped_for_imaging ?x), (have_soil_analysis ?x ?p), (available ?x), (at_rock_sample ?p), (at_rock_sample ?p), (at ?x ?p), (have_soil_analysis ?x ?p), 
;; communicate_image_data action has changed: (channel_free ?l), (at_lander ?l ?y), (communicated_image_data ?o ?m), (at ?r ?x), (communicated_soil_data ?y), (can_traverse ?r ?y ?x), (communicated_soil_data ?x), (visible ?x ?y), (visible ?x ?y), (communicated_rock_data ?y), (at ?r ?y), (at_rock_sample ?x), (have_soil_analysis ?r ?x), (have_soil_analysis ?r ?x), (equipped_for_rock_analysis ?r), (at_rock_sample ?x), (at_rock_sample ?y), (have_rock_analysis ?r ?x), (have_rock_analysis ?r ?y), (have_rock_analysis ?r ?x), (visible_from ?o ?x), (have_soil_analysis ?r ?y), (visible ?y ?x), (communicated_image_data ?o ?m), (at ?r ?y), (at_soil_sample ?x), (can_traverse ?r ?y ?x), (at_rock_sample ?y), (at_lander ?l ?y), 
;; take_image action has changed: (calibration_target ?i ?o), (at_soil_sample ?p), (communicated_soil_data ?p), (have_soil_analysis ?r ?p), (have_image ?r ?o ?m), (calibrated ?i ?r), (at ?r ?p), (equipped_for_rock_analysis ?r), (equipped_for_imaging ?r), (visible_from ?o ?p), (available ?r), (at_soil_sample ?p), (at_rock_sample ?p), (equipped_for_rock_analysis ?r), (communicated_image_data ?o ?m), 
;; navigate action has changed: (equipped_for_soil_analysis ?x), (at_rock_sample ?z), (have_rock_analysis ?x ?y), (communicated_soil_data ?z), (communicated_rock_data ?z), (equipped_for_rock_analysis ?x), (equipped_for_rock_analysis ?x), (available ?x), (at ?x ?z), (communicated_rock_data ?y), (equipped_for_imaging ?x), (visible ?z ?y), (available ?x), (at_rock_sample ?y), (have_soil_analysis ?x ?z), (equipped_for_soil_analysis ?x), (communicated_rock_data ?z), (visible ?z ?y), (at ?x ?z), (communicated_rock_data ?y), 
;; sample_rock action has changed: (communicated_soil_data ?p), (at ?x ?p), (communicated_soil_data ?p), (full ?s), (at_soil_sample ?p), (at_soil_sample ?p), (at_rock_sample ?p), (equipped_for_soil_analysis ?x), 
;; drop action has changed: (equipped_for_imaging ?x), (store_of ?y ?x), (available ?x), (equipped_for_soil_analysis ?x), (full ?y), 
;; Last_reduced_capability_num_dropped_pals: None

