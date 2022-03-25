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
			(not (have_rock_analysis ?x ?z))
			(not (available ?x))
			(visible ?z ?y)
			(equipped_for_imaging ?x)
			(not (at_rock_sample ?y))
			(can_traverse ?x ?z ?y)
			(at_soil_sample ?z)
			(at_soil_sample ?y)
			(communicated_soil_data ?z)
			(communicated_rock_data ?z)
			(not (communicated_soil_data ?y))
			(not (visible ?y ?z))
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			(not (at ?x ?z))
			(have_soil_analysis ?x ?z)
			(have_rock_analysis ?x ?y)
			(not (communicated_rock_data ?y))
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (not (available ?x))
			(not (at_rock_sample ?y))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?z))
			(not (visible ?y ?z))
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			(not (have_soil_analysis ?x ?z))
			(have_rock_analysis ?x ?y)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (at_soil_sample ?p))
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(not (store_of ?s ?x))
			(not (equipped_for_soil_analysis ?x))
			(communicated_rock_data ?p)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (available ?x)
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(not (have_soil_analysis ?x ?p))
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (not (available ?x))
			(not (empty ?s))
			(not (full ?s))
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
			(not (store_of ?y ?x))
			(empty ?y)
			(equipped_for_rock_analysis ?x)
			(equipped_for_soil_analysis ?x)
			(not (full ?y))
			(not (equipped_for_imaging ?x))
			
          )
        :effect (and 
               (available ?x)
			(store_of ?y ?x)
			(not (equipped_for_soil_analysis ?x))
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
               (calibration_target ?i ?t)
			(not (equipped_for_rock_analysis ?r))
			(not (have_soil_analysis ?r ?w))
			(not (available ?r))
			(not (equipped_for_imaging ?r))
			(not (at_rock_sample ?w))
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
			(not (communicated_soil_data ?w))
			(at_soil_sample ?w)
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(not (available ?r))
			(not (on_board ?i ?r))
			(not (at_rock_sample ?w))
			(visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
			(not (communicated_rock_data ?w))
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
               (not (supports ?i ?m))
			(not (communicated_image_data ?o ?m))
			(not (have_soil_analysis ?r ?p))
			(equipped_for_rock_analysis ?r)
			(not (available ?r))
			(not (have_image ?r ?o ?m))
			(equipped_for_soil_analysis ?r)
			(not (equipped_for_imaging ?r))
			(have_rock_analysis ?r ?p)
			(at_rock_sample ?p)
			(communicated_soil_data ?p)
			(communicated_rock_data ?p)
			(not (calibrated ?i ?r))
			(not (at ?r ?p))
			
          )
          :effect (and 
               (communicated_image_data ?o ?m)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (calibration_target ?i ?o))
			(equipped_for_soil_analysis ?r)
			(equipped_for_imaging ?r)
			(have_rock_analysis ?r ?p)
			(not (at_rock_sample ?p))
			(not (visible_from ?o ?p))
			(communicated_soil_data ?p)
			(communicated_rock_data ?p)
			(at ?r ?p)
			
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
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(not (have_soil_analysis ?r ?y))
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(visible ?y ?x)
			(not (communicated_rock_data ?x))
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
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
               (equipped_for_imaging ?r)
			(have_soil_analysis ?r ?x)
			(not (visible ?p ?y))
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(not (at_lander ?l ?x))
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(visible ?p ?y)
			(visible ?x ?y)
			(not (can_traverse ?r ?p ?y))
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(not (at_lander ?l ?p))
			(not (visible ?x ?p))
			(not (visible ?y ?p))
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
               (not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(available ?r)
			(at_rock_sample ?y)
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(equipped_for_rock_analysis ?r)
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			(communicated_image_data ?o ?m)
			
          )
         :effect (and 
               (channel_free ?l)
			(not (have_image ?r ?o ?m))
			(have_soil_analysis ?r ?x)
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (visible_from ?o ?x))
			(not (at ?r ?x))
			(not (at_lander ?l ?y))
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(not (visible_from ?o ?y))
			(equipped_for_rock_analysis ?r)
			(communicated_rock_data ?y)
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (can_traverse ?r ?p ?y), (equipped_for_soil_analysis ?r), (at ?r ?x), (can_traverse ?r ?x ?p), (can_traverse ?r ?p ?y), (can_traverse ?r ?y ?x), (visible ?y ?x), (visible ?x ?p), (available ?r), (communicated_soil_data ?x), (visible ?x ?y), (at ?r ?x), (at_lander ?l ?y), (at_soil_sample ?x), (at_soil_sample ?y), (at ?r ?p), (equipped_for_imaging ?r), (communicated_rock_data ?x), (at_lander ?l ?y), (have_soil_analysis ?r ?p), (communicated_soil_data ?p), (at_lander ?l ?p), (channel_free ?l), (have_soil_analysis ?r ?y), (visible ?x ?p), (at_soil_sample ?p), (have_soil_analysis ?r ?x), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?y), (can_traverse ?r ?x ?y), (can_traverse ?r ?y ?p), (visible ?p ?y), (can_traverse ?r ?p ?x), (can_traverse ?r ?x ?y), (communicated_rock_data ?y), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?p), (visible ?p ?y), (at ?r ?y), (at ?r ?p), (communicated_rock_data ?p), (have_rock_analysis ?r ?p), (have_rock_analysis ?r ?x), (at_lander ?l ?x), (at ?r ?y), (visible ?y ?p), (equipped_for_imaging ?r), (at_soil_sample ?x), (communicated_soil_data ?y), (visible ?x ?y), (can_traverse ?r ?p ?x), (at_rock_sample ?y), (channel_free ?l), (communicated_soil_data ?y), (have_soil_analysis ?r ?p), (can_traverse ?r ?y ?x), (visible ?y ?p), (have_soil_analysis ?r ?x), (at_lander ?l ?x), 
;; communicate_soil_data action has changed: (communicated_rock_data ?p), (at_soil_sample ?p), (equipped_for_rock_analysis ?r), (can_traverse ?r ?p ?y), (can_traverse ?r ?p ?y), (at ?r ?x), (visible ?p ?y), (at_lander ?l ?p), (visible ?y ?x), (have_soil_analysis ?r ?x), (visible ?y ?x), (at ?r ?y), (can_traverse ?r ?p ?x), (visible ?p ?x), (communicated_rock_data ?x), (at_rock_sample ?x), (communicated_soil_data ?x), (available ?r), (communicated_rock_data ?x), (available ?r), (communicated_soil_data ?y), (can_traverse ?r ?y ?x), (equipped_for_imaging ?r), (communicated_rock_data ?y), (at_soil_sample ?y), (at_soil_sample ?x), (at_soil_sample ?p), (at_rock_sample ?p), (can_traverse ?r ?x ?y), (at_soil_sample ?x), (have_rock_analysis ?r ?y), (communicated_soil_data ?p), (at_lander ?l ?x), (have_rock_analysis ?r ?y), (at_lander ?l ?p), (visible ?y ?p), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?x), (have_rock_analysis ?r ?p), (have_soil_analysis ?r ?y), (can_traverse ?r ?x ?p), (visible ?y ?p), (at_lander ?l ?x), (equipped_for_rock_analysis ?r), (at_rock_sample ?x), (at_soil_sample ?y), (have_rock_analysis ?r ?x), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?p), (at_rock_sample ?p), (have_rock_analysis ?r ?p), (equipped_for_imaging ?r), (have_soil_analysis ?r ?y), (visible ?x ?p), (equipped_for_soil_analysis ?r), (communicated_soil_data ?y), (visible ?p ?y), (at_rock_sample ?y), (can_traverse ?r ?y ?p), (can_traverse ?r ?y ?p), (communicated_soil_data ?p), (have_soil_analysis ?r ?p), (communicated_soil_data ?x), (visible ?x ?y), (communicated_rock_data ?y), (visible ?x ?y), (channel_free ?l), (communicated_rock_data ?p), 
;; navigate action has changed: (at_soil_sample ?z), (communicated_rock_data ?z), (communicated_rock_data ?y), (visible ?y ?z), (have_soil_analysis ?x ?z), (available ?x), (have_soil_analysis ?x ?z), (equipped_for_rock_analysis ?x), (can_traverse ?x ?y ?z), (have_rock_analysis ?x ?y), (at_rock_sample ?y), (visible ?y ?z), (have_rock_analysis ?x ?z), (equipped_for_soil_analysis ?x), (at ?x ?z), (have_rock_analysis ?x ?y), (at ?x ?z), (at_rock_sample ?z), (at_soil_sample ?y), (at_rock_sample ?y), (at ?x ?y), (communicated_soil_data ?z), (can_traverse ?x ?z ?y), (equipped_for_rock_analysis ?x), (communicated_soil_data ?z), (at ?x ?y), (visible ?z ?y), (equipped_for_imaging ?x), (available ?x), (at_soil_sample ?y), (communicated_soil_data ?y), 
;; calibrate action has changed: (have_rock_analysis ?r ?w), (at_soil_sample ?w), (have_soil_analysis ?r ?w), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?w), (communicated_rock_data ?w), (visible_from ?t ?w), (communicated_soil_data ?w), (equipped_for_imaging ?r), (at_rock_sample ?w), (on_board ?i ?r), (calibrated ?i ?r), (on_board ?i ?r), (at ?r ?w), (calibration_target ?i ?t), (available ?r), (at_rock_sample ?w), (equipped_for_soil_analysis ?r), (available ?r), 
;; take_image action has changed: (at ?r ?p), (equipped_for_rock_analysis ?r), (visible_from ?o ?p), (communicated_soil_data ?p), (have_rock_analysis ?r ?p), (communicated_rock_data ?p), (equipped_for_soil_analysis ?r), (equipped_for_soil_analysis ?r), (communicated_rock_data ?p), (have_soil_analysis ?r ?p), (available ?r), (communicated_image_data ?o ?m), (calibrated ?i ?r), (calibration_target ?i ?o), (visible_from ?o ?p), (available ?r), (have_image ?r ?o ?m), (calibrated ?i ?r), (at_rock_sample ?p), (have_image ?r ?o ?m), (equipped_for_imaging ?r), (have_soil_analysis ?r ?p), (at_rock_sample ?p), (at ?r ?p), (have_rock_analysis ?r ?p), (communicated_soil_data ?p), (communicated_image_data ?o ?m), (supports ?i ?m), (equipped_for_imaging ?r), (on_board ?i ?r), 
;; sample_soil action has changed: (store_of ?s ?x), (communicated_rock_data ?p), (have_soil_analysis ?x ?p), (empty ?s), (equipped_for_rock_analysis ?x), (at_soil_sample ?p), (have_rock_analysis ?x ?p), (equipped_for_soil_analysis ?x), (full ?s), (communicated_soil_data ?p), (have_soil_analysis ?x ?p), (equipped_for_imaging ?x), (have_rock_analysis ?x ?p), (at ?x ?p), (store_of ?s ?x), (at_soil_sample ?p), (available ?x), (communicated_rock_data ?p), 
;; drop action has changed: (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), (empty ?y), (full ?y), (equipped_for_soil_analysis ?x), (store_of ?y ?x), (store_of ?y ?x), (available ?x), (equipped_for_imaging ?x), (available ?x), (empty ?y), 
;; communicate_image_data action has changed: (can_traverse ?r ?x ?y), (have_soil_analysis ?r ?y), (visible_from ?o ?x), (have_soil_analysis ?r ?y), (have_rock_analysis ?r ?x), (communicated_soil_data ?y), (equipped_for_rock_analysis ?r), (at_rock_sample ?x), (at ?r ?y), (can_traverse ?r ?y ?x), (communicated_soil_data ?x), (visible ?y ?x), (have_rock_analysis ?r ?x), (channel_free ?l), (have_soil_analysis ?r ?x), (equipped_for_soil_analysis ?r), (communicated_soil_data ?y), (have_image ?r ?o ?m), (visible_from ?o ?y), (communicated_rock_data ?y), (at_lander ?l ?y), (communicated_rock_data ?y), (have_rock_analysis ?r ?y), (communicated_soil_data ?x), (have_soil_analysis ?r ?x), (visible ?x ?y), (at_lander ?l ?y), (at_lander ?l ?x), (at_rock_sample ?y), (at ?r ?y), (at ?r ?x), (at_soil_sample ?x), (at_soil_sample ?x), (at_soil_sample ?y), (communicated_image_data ?o ?m), (communicated_rock_data ?x), (at_rock_sample ?x), (have_image ?r ?o ?m), (equipped_for_rock_analysis ?r), (communicated_image_data ?o ?m), (have_rock_analysis ?r ?y), (channel_free ?l), (at_soil_sample ?y), (equipped_for_soil_analysis ?r), 
;; sample_rock action has changed: (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (available ?x), (have_soil_analysis ?x ?p), (at_soil_sample ?p), (equipped_for_soil_analysis ?x), (at_soil_sample ?p), (at_rock_sample ?p), (full ?s), (store_of ?s ?x), (communicated_rock_data ?p), (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?p), (available ?x), (have_rock_analysis ?x ?p), (have_soil_analysis ?x ?p), (at_rock_sample ?p), (at ?x ?p), (communicated_soil_data ?p), (store_of ?s ?x), 
;; Last_reduced_capability_num_dropped_pals: None

