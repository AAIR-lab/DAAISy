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
			(not (visible ?z ?y))
			(at_rock_sample ?y)
			(not (have_soil_analysis ?x ?y))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?z))
			(not (communicated_soil_data ?y))
			(visible ?y ?z)
			(equipped_for_rock_analysis ?x)
			(at ?x ?z)
			(have_rock_analysis ?x ?y)
			(not (communicated_rock_data ?y))
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (have_rock_analysis ?x ?z)
			(available ?x)
			(not (visible ?z ?y))
			(not (equipped_for_imaging ?x))
			(can_traverse ?x ?z ?y)
			(not (at ?x ?y))
			(have_soil_analysis ?x ?y)
			(not (at_soil_sample ?z))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?z))
			(equipped_for_rock_analysis ?x)
			(can_traverse ?x ?y ?z)
			(not (at ?x ?z))
			(not (have_rock_analysis ?x ?y))
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
			(not (at_soil_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(not (have_soil_analysis ?x ?p))
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (not (available ?x))
			(not (at ?x ?p))
			(not (empty ?s))
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(not (equipped_for_soil_analysis ?x))
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
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(not (have_soil_analysis ?x ?p))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (at ?x ?p)
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (communicated_soil_data ?p))
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
			(store_of ?y ?x)
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (available ?x)
			(store_of ?y ?x)
			(empty ?y)
			(not (equipped_for_rock_analysis ?x))
			(not (full ?y))
			(equipped_for_imaging ?x)
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (not (equipped_for_rock_analysis ?r))
			(not (have_soil_analysis ?r ?w))
			(not (equipped_for_imaging ?r))
			(not (at ?r ?w))
			(not (on_board ?i ?r))
			(not (at_rock_sample ?w))
			(not (equipped_for_soil_analysis ?r))
			(have_rock_analysis ?r ?w)
			(not (communicated_soil_data ?w))
			(not (communicated_rock_data ?w))
			(at_soil_sample ?w)
			(not (calibrated ?i ?r))
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(not (equipped_for_rock_analysis ?r))
			(not (have_soil_analysis ?r ?w))
			(available ?r)
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(not (at_rock_sample ?w))
			(not (equipped_for_soil_analysis ?r))
			(visible_from ?t ?w)
			(not (communicated_soil_data ?w))
			(not (communicated_rock_data ?w))
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
               (not (supports ?i ?m))
			(have_soil_analysis ?r ?p)
			(equipped_for_rock_analysis ?r)
			(not (available ?r))
			(not (equipped_for_soil_analysis ?r))
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(not (have_rock_analysis ?r ?p))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
			(not (calibrated ?i ?r))
			
          )
          :effect (and 
               (not (supports ?i ?m))
			(not (have_soil_analysis ?r ?p))
			(equipped_for_rock_analysis ?r)
			(not (have_image ?r ?o ?m))
			(not (calibration_target ?i ?o))
			(equipped_for_soil_analysis ?r)
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(have_rock_analysis ?r ?p)
			(at_soil_sample ?p)
			(not (visible_from ?o ?p))
			(communicated_rock_data ?p)
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
			(not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(not (have_soil_analysis ?r ?x))
			(visible ?p ?y)
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(not (at_rock_sample ?y))
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(have_rock_analysis ?r ?x)
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(not (have_soil_analysis ?r ?x))
			(not (visible ?p ?y))
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_rock_sample ?y)
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(visible ?y ?p)
			(can_traverse ?r ?y ?x)
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
               (not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(not (can_traverse ?r ?p ?y))
			(at ?r ?p)
			(at ?r ?y)
			(not (available ?r))
			(not (at_rock_sample ?p))
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(at_lander ?l ?y)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(not (at_rock_sample ?x))
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (at ?r ?x))
			(not (at_lander ?l ?x))
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(visible ?y ?p)
			(can_traverse ?r ?y ?x)
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
               (have_image ?r ?o ?m)
			(not (at_rock_sample ?x))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (available ?r))
			(not (at_rock_sample ?y))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?x))
			(not (visible_from ?o ?y))
			(equipped_for_rock_analysis ?r)
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			(communicated_image_data ?o ?m)
			
          )
         :effect (and 
               (not (channel_free ?l))
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(not (at ?r ?y))
			(available ?r)
			(visible_from ?o ?x)
			(not (at ?r ?x))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(not (visible_from ?o ?y))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; sample_soil action has changed: (have_soil_analysis ?x ?p), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (store_of ?s ?x), (full ?s), (at ?x ?p), (at_soil_sample ?p), (available ?x), (equipped_for_imaging ?x), (have_rock_analysis ?x ?p), (store_of ?s ?x), (equipped_for_soil_analysis ?x), 
;; communicate_rock_data action has changed: (equipped_for_soil_analysis ?r), (visible ?x ?p), (can_traverse ?r ?x ?y), (visible ?y ?p), (equipped_for_rock_analysis ?r), (at ?r ?y), (communicated_soil_data ?x), (can_traverse ?r ?y ?x), (can_traverse ?r ?p ?x), (visible ?x ?y), (can_traverse ?r ?p ?x), (have_soil_analysis ?r ?x), (can_traverse ?r ?p ?y), (have_soil_analysis ?r ?y), (communicated_rock_data ?x), (communicated_rock_data ?x), (at ?r ?p), (have_soil_analysis ?r ?p), (have_rock_analysis ?r ?p), (at_soil_sample ?y), (visible ?y ?x), (channel_free ?l), (visible ?x ?p), (at_rock_sample ?p), (equipped_for_rock_analysis ?r), (equipped_for_soil_analysis ?r), (at ?r ?p), (at ?r ?x), (visible ?y ?p), (at_lander ?l ?p), (channel_free ?l), (at_rock_sample ?x), (communicated_soil_data ?x), (equipped_for_imaging ?r), (communicated_rock_data ?p), (can_traverse ?r ?x ?p), (have_rock_analysis ?r ?x), (at_soil_sample ?y), (visible ?p ?x), (at_lander ?l ?x), (at_rock_sample ?p), (visible ?y ?x), (at_soil_sample ?x), (at_rock_sample ?y), (communicated_rock_data ?p), (can_traverse ?r ?y ?x), (have_rock_analysis ?r ?p), (at_soil_sample ?p), (communicated_soil_data ?p), (visible ?p ?x), (equipped_for_imaging ?r), (at ?r ?x), (available ?r), (communicated_soil_data ?y), (available ?r), (at_soil_sample ?x), (communicated_soil_data ?y), 
;; communicate_soil_data action has changed: (have_soil_analysis ?r ?y), (at_soil_sample ?y), (at_lander ?l ?y), (available ?r), (at_rock_sample ?x), (at ?r ?x), (have_rock_analysis ?r ?p), (equipped_for_imaging ?r), (have_rock_analysis ?r ?y), (equipped_for_soil_analysis ?r), (can_traverse ?r ?x ?p), (can_traverse ?r ?y ?x), (have_rock_analysis ?r ?x), (at_lander ?l ?p), (at_lander ?l ?x), (visible ?p ?y), (channel_free ?l), (communicated_rock_data ?p), (available ?r), (communicated_soil_data ?y), (can_traverse ?r ?x ?y), (visible ?p ?y), (can_traverse ?r ?p ?x), (visible ?y ?p), (communicated_rock_data ?p), (can_traverse ?r ?p ?y), (can_traverse ?r ?p ?y), (visible ?y ?x), (at ?r ?y), (visible ?x ?y), (at ?r ?x), (communicated_soil_data ?p), (communicated_rock_data ?y), (communicated_soil_data ?x), (equipped_for_imaging ?r), (can_traverse ?r ?p ?x), (communicated_soil_data ?y), (have_soil_analysis ?r ?p), (at_soil_sample ?y), (visible ?y ?p), (visible ?x ?p), (channel_free ?l), (at ?r ?y), (can_traverse ?r ?x ?y), (at_rock_sample ?p), (equipped_for_rock_analysis ?r), (communicated_soil_data ?p), (at_lander ?l ?x), (visible ?x ?p), (at_rock_sample ?y), (have_rock_analysis ?r ?p), (at_rock_sample ?x), (can_traverse ?r ?y ?p), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?x), (have_soil_analysis ?r ?x), (have_soil_analysis ?r ?p), (at_lander ?l ?y), (at_rock_sample ?y), (equipped_for_rock_analysis ?r), 
;; navigate action has changed: (at_rock_sample ?z), (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), (communicated_soil_data ?z), (communicated_soil_data ?z), (have_rock_analysis ?x ?z), (at_rock_sample ?y), (at_soil_sample ?y), (have_soil_analysis ?x ?y), (available ?x), (communicated_rock_data ?y), (have_rock_analysis ?x ?z), (have_soil_analysis ?x ?y), (at_soil_sample ?z), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (communicated_soil_data ?y), (at ?x ?z), (can_traverse ?x ?z ?y), (available ?x), (can_traverse ?x ?y ?z), (have_rock_analysis ?x ?y), (at_soil_sample ?y), (communicated_rock_data ?y), (can_traverse ?x ?y ?z), (have_rock_analysis ?x ?y), (visible ?z ?y), (at ?x ?y), (at ?x ?z), (equipped_for_imaging ?x), (visible ?z ?y), 
;; sample_rock action has changed: (empty ?s), (have_soil_analysis ?x ?p), (store_of ?s ?x), (equipped_for_soil_analysis ?x), (have_soil_analysis ?x ?p), (communicated_soil_data ?p), (equipped_for_imaging ?x), (store_of ?s ?x), (equipped_for_imaging ?x), (empty ?s), (communicated_soil_data ?p), (full ?s), (have_rock_analysis ?x ?p), (available ?x), (full ?s), (at_soil_sample ?p), (have_rock_analysis ?x ?p), (communicated_rock_data ?p), (equipped_for_rock_analysis ?x), (at ?x ?p), 
;; calibrate action has changed: (visible_from ?t ?w), (at_soil_sample ?w), (at ?r ?w), (at_soil_sample ?w), (at_rock_sample ?w), (have_soil_analysis ?r ?w), (on_board ?i ?r), (have_soil_analysis ?r ?w), (communicated_rock_data ?w), (visible_from ?t ?w), (equipped_for_rock_analysis ?r), (communicated_soil_data ?w), (equipped_for_imaging ?r), (calibrated ?i ?r), (at_rock_sample ?w), (calibration_target ?i ?t), (equipped_for_rock_analysis ?r), (on_board ?i ?r), (communicated_rock_data ?w), (have_rock_analysis ?r ?w), (equipped_for_soil_analysis ?r), (calibration_target ?i ?t), (calibrated ?i ?r), (available ?r), (equipped_for_soil_analysis ?r), (equipped_for_imaging ?r), (communicated_soil_data ?w), 
;; communicate_image_data action has changed: (communicated_rock_data ?y), (have_soil_analysis ?r ?x), (at_rock_sample ?y), (communicated_soil_data ?y), (available ?r), (have_rock_analysis ?r ?y), (communicated_rock_data ?x), (at ?r ?x), (communicated_image_data ?o ?m), (have_soil_analysis ?r ?y), (communicated_rock_data ?y), (equipped_for_soil_analysis ?r), (visible ?x ?y), (at ?r ?y), (at_rock_sample ?x), (visible_from ?o ?x), (equipped_for_rock_analysis ?r), (at ?r ?x), (communicated_image_data ?o ?m), (channel_free ?l), (at_lander ?l ?x), (at ?r ?y), (can_traverse ?r ?y ?x), (at_soil_sample ?y), (available ?r), (visible_from ?o ?y), (visible ?x ?y), (have_rock_analysis ?r ?x), (at_lander ?l ?y), (visible_from ?o ?y), (at_lander ?l ?x), (visible ?y ?x), (at_soil_sample ?x), (at_lander ?l ?y), (have_rock_analysis ?r ?y), (channel_free ?l), (have_rock_analysis ?r ?x), (at_rock_sample ?x), (can_traverse ?r ?y ?x), 
;; take_image action has changed: (have_rock_analysis ?r ?p), (have_image ?r ?o ?m), (supports ?i ?m), (equipped_for_soil_analysis ?r), (visible_from ?o ?p), (on_board ?i ?r), (at_rock_sample ?p), (supports ?i ?m), (communicated_soil_data ?p), (equipped_for_rock_analysis ?r), (communicated_rock_data ?p), (calibration_target ?i ?o), (calibrated ?i ?r), (available ?r), (equipped_for_soil_analysis ?r), (at_soil_sample ?p), (at_soil_sample ?p), (equipped_for_rock_analysis ?r), (equipped_for_imaging ?r), (have_rock_analysis ?r ?p), (visible_from ?o ?p), (at ?r ?p), (communicated_rock_data ?p), (have_soil_analysis ?r ?p), (at ?r ?p), (equipped_for_imaging ?r), (have_soil_analysis ?r ?p), (calibrated ?i ?r), 
;; drop action has changed: (equipped_for_imaging ?x), (store_of ?y ?x), (equipped_for_imaging ?x), (available ?x), (equipped_for_rock_analysis ?x), (available ?x), (full ?y), 
;; Last_reduced_capability_num_dropped_pals: None

