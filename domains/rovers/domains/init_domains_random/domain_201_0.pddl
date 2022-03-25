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
			(not (at_rock_sample ?y))
			(can_traverse ?x ?z ?y)
			(at ?x ?y)
			(not (communicated_soil_data ?z))
			(visible ?y ?z)
			(equipped_for_rock_analysis ?x)
			(not (can_traverse ?x ?y ?z))
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (not (available ?x))
			(not (at_rock_sample ?y))
			(not (at ?x ?y))
			(not (have_soil_analysis ?x ?y))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?z))
			(communicated_rock_data ?z)
			(not (visible ?y ?z))
			(not (equipped_for_rock_analysis ?x))
			(at ?x ?z)
			(not (have_soil_analysis ?x ?z))
			(have_rock_analysis ?x ?y)
			(not (communicated_rock_data ?y))
			(not (equipped_for_soil_analysis ?x))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (at ?x ?p))
			(empty ?s)
			(equipped_for_imaging ?x)
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (not (available ?x))
			(at ?x ?p)
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(store_of ?s ?x)
			(not (have_soil_analysis ?x ?p))
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (not (at ?x ?p))
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			
          )
        :effect (and 
               (not (available ?x))
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (available ?x))
			(store_of ?y ?x)
			(not (empty ?y))
			(equipped_for_rock_analysis ?x)
			(equipped_for_soil_analysis ?x)
			
          )
        :effect (and 
               (empty ?y)
			(equipped_for_rock_analysis ?x)
			(equipped_for_soil_analysis ?x)
			(full ?y)
			(not (equipped_for_imaging ?x))
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (not (calibration_target ?i ?t))
			(at ?r ?w)
			(on_board ?i ?r)
			(equipped_for_soil_analysis ?r)
			(not (visible_from ?t ?w))
			(not (have_rock_analysis ?r ?w))
			
          )
         :effect (and 
               (not (calibration_target ?i ?t))
			(not (have_soil_analysis ?r ?w))
			(not (at ?r ?w))
			(at_rock_sample ?w)
			(visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
			(communicated_rock_data ?w)
			(not (at_soil_sample ?w))
			
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
			(on_board ?i ?r)
			(not (communicated_rock_data ?p))
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (not (equipped_for_rock_analysis ?r))
			(available ?r)
			(have_image ?r ?o ?m)
			(calibration_target ?i ?o)
			(not (equipped_for_soil_analysis ?r))
			(not (equipped_for_imaging ?r))
			(at_rock_sample ?p)
			(visible_from ?o ?p)
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
               (not (channel_free ?l))
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (can_traverse ?r ?p ?y))
			(not (have_soil_analysis ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(not (communicated_soil_data ?x))
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(visible ?y ?p)
			(can_traverse ?r ?y ?x)
			
          )
          :effect (and 
               (not (visible ?y ?x))
			(visible ?p ?x)
			(not (visible ?x ?y))
			(can_traverse ?r ?p ?y)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (communicated_rock_data ?p))
			(have_rock_analysis ?r ?y)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(not (have_rock_analysis ?r ?p))
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(visible ?x ?p)
			(not (visible ?y ?p))
			(not (communicated_rock_data ?y))
			
          )
    )
    
    (:action communicate_rock_data
         :parameters (?r - rover 
                      ?l - lander 
                      ?p - waypoint 
                      ?x - waypoint 
                      ?y - waypoint)
         :precondition (and 
               (communicated_rock_data ?x)
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (can_traverse ?r ?p ?y))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(can_traverse ?r ?y ?x)
			
          )
          :effect (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(at_rock_sample ?x)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(have_soil_analysis ?r ?p)
			(have_rock_analysis ?r ?y)
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
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
			(not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(have_image ?r ?o ?m)
			(not (at_rock_sample ?x))
			(have_soil_analysis ?r ?y)
			(not (available ?r))
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (visible_from ?o ?y))
			(not (can_traverse ?r ?y ?x))
			
          )
         :effect (and 
               (equipped_for_imaging ?r)
			(not (have_soil_analysis ?r ?x))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(have_soil_analysis ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(at_rock_sample ?y)
			(not (visible_from ?o ?x))
			(not (at ?r ?x))
			(not (at_lander ?l ?y))
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(visible_from ?o ?y)
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; drop action has changed: (empty ?y), (full ?y), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (available ?x), (full ?y), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (equipped_for_soil_analysis ?x), 
;; calibrate action has changed: (have_rock_analysis ?r ?w), (have_soil_analysis ?r ?w), (at_rock_sample ?w), (visible_from ?t ?w), (communicated_rock_data ?w), (visible_from ?t ?w), (calibrated ?i ?r), (calibration_target ?i ?t), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?w), (at_soil_sample ?w), (equipped_for_imaging ?r), (at ?r ?w), (calibration_target ?i ?t), 
;; navigate action has changed: (available ?x), (communicated_rock_data ?y), (communicated_soil_data ?z), (have_soil_analysis ?x ?z), (have_soil_analysis ?x ?y), (communicated_soil_data ?z), (can_traverse ?x ?y ?z), (at_rock_sample ?y), (equipped_for_soil_analysis ?x), (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), (at_rock_sample ?z), (communicated_rock_data ?z), (can_traverse ?x ?z ?y), (have_rock_analysis ?x ?y), (visible ?y ?z), (equipped_for_rock_analysis ?x), (available ?x), (at_rock_sample ?y), (at_soil_sample ?y), 
;; communicate_image_data action has changed: (visible ?y ?x), (visible_from ?o ?x), (visible_from ?o ?y), (have_soil_analysis ?r ?y), (can_traverse ?r ?x ?y), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?x), (at_rock_sample ?x), (visible_from ?o ?y), (visible ?x ?y), (at_soil_sample ?x), (at_rock_sample ?x), (equipped_for_imaging ?r), (at_rock_sample ?y), (communicated_image_data ?o ?m), (have_soil_analysis ?r ?y), (communicated_soil_data ?x), (available ?r), (have_rock_analysis ?r ?y), (at_lander ?l ?y), (at ?r ?x), (at_soil_sample ?y), (equipped_for_soil_analysis ?r), (equipped_for_imaging ?r), (can_traverse ?r ?y ?x), (at_soil_sample ?x), (communicated_rock_data ?y), (visible ?x ?y), (communicated_soil_data ?x), 
;; communicate_soil_data action has changed: (have_rock_analysis ?r ?y), (can_traverse ?r ?p ?y), (can_traverse ?r ?x ?p), (at_lander ?l ?y), (communicated_soil_data ?p), (at ?r ?x), (visible ?x ?y), (channel_free ?l), (communicated_soil_data ?x), (communicated_rock_data ?p), (visible ?x ?p), (can_traverse ?r ?x ?y), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?p), (equipped_for_rock_analysis ?r), (visible ?y ?x), (visible ?y ?p), (at_rock_sample ?x), (can_traverse ?r ?y ?x), (have_rock_analysis ?r ?x), (at_rock_sample ?y), (equipped_for_soil_analysis ?r), (communicated_rock_data ?x), (visible ?p ?x), (have_soil_analysis ?r ?y), (at_soil_sample ?p), (visible ?p ?y), (at_rock_sample ?p), (communicated_rock_data ?y), (can_traverse ?r ?x ?y), (at ?r ?y), (have_soil_analysis ?r ?p), (communicated_rock_data ?p), (at_soil_sample ?y), (visible ?y ?p), (can_traverse ?r ?y ?p), (can_traverse ?r ?p ?y), (at_lander ?l ?p), (available ?r), (at_lander ?l ?x), (visible ?x ?p), (have_rock_analysis ?r ?y), (have_rock_analysis ?r ?x), (communicated_soil_data ?x), (visible ?p ?x), 
;; communicate_rock_data action has changed: (communicated_soil_data ?y), (at ?r ?y), (at ?r ?y), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?y), (have_rock_analysis ?r ?y), (communicated_rock_data ?p), (channel_free ?l), (can_traverse ?r ?p ?y), (communicated_rock_data ?x), (at_rock_sample ?p), (can_traverse ?r ?y ?x), (can_traverse ?r ?y ?x), (at_lander ?l ?p), (at_soil_sample ?p), (at_lander ?l ?y), (have_soil_analysis ?r ?p), (at ?r ?x), (can_traverse ?r ?x ?p), (have_soil_analysis ?r ?p), (communicated_soil_data ?p), (at_soil_sample ?x), (communicated_soil_data ?y), (channel_free ?l), (at_rock_sample ?x), (at_rock_sample ?y), (at_rock_sample ?x), (have_rock_analysis ?r ?p), (visible ?y ?x), (can_traverse ?r ?x ?y), (communicated_soil_data ?x), (at_lander ?l ?x), (have_rock_analysis ?r ?x), (equipped_for_imaging ?r), (can_traverse ?r ?y ?p), (have_rock_analysis ?r ?y), (communicated_rock_data ?p), (communicated_rock_data ?y), 
;; sample_rock action has changed: (full ?s), (equipped_for_rock_analysis ?x), (at_soil_sample ?p), (available ?x), (at ?x ?p), (communicated_rock_data ?p), (equipped_for_rock_analysis ?x), (at_rock_sample ?p), (equipped_for_imaging ?x), (store_of ?s ?x), (equipped_for_imaging ?x), (have_soil_analysis ?x ?p), (equipped_for_soil_analysis ?x), (equipped_for_soil_analysis ?x), (empty ?s), (communicated_soil_data ?p), 
;; sample_soil action has changed: (communicated_soil_data ?p), (communicated_rock_data ?p), (have_rock_analysis ?x ?p), (at_soil_sample ?p), (at_soil_sample ?p), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (at ?x ?p), (available ?x), (store_of ?s ?x), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (have_soil_analysis ?x ?p), (at_rock_sample ?p), (have_soil_analysis ?x ?p), (at ?x ?p), (have_rock_analysis ?x ?p), 
;; take_image action has changed: (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?p), (equipped_for_imaging ?r), (available ?r), (calibration_target ?i ?o), (visible_from ?o ?p), (at_rock_sample ?p), (calibrated ?i ?r), (communicated_rock_data ?p), (communicated_image_data ?o ?m), (equipped_for_soil_analysis ?r), (visible_from ?o ?p), (at ?r ?p), 
;; Last_reduced_capability_num_dropped_pals: None

