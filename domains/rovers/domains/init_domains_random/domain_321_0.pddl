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
               (have_rock_analysis ?x ?z)
			(not (available ?x))
			(visible ?z ?y)
			(equipped_for_imaging ?x)
			(at_rock_sample ?y)
			(not (at ?x ?y))
			(not (have_soil_analysis ?x ?y))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?y))
			(not (visible ?y ?z))
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			(not (have_soil_analysis ?x ?z))
			(have_rock_analysis ?x ?y)
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (at_rock_sample ?z)
			(have_rock_analysis ?x ?z)
			(not (available ?x))
			(visible ?z ?y)
			(not (equipped_for_imaging ?x))
			(at_rock_sample ?y)
			(can_traverse ?x ?z ?y)
			(at ?x ?y)
			(at_soil_sample ?z)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?z))
			(not (communicated_rock_data ?z))
			(communicated_soil_data ?y)
			(visible ?y ?z)
			(equipped_for_rock_analysis ?x)
			(at ?x ?z)
			(not (communicated_rock_data ?y))
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (available ?x)
			(at ?x ?p)
			(empty ?s)
			(not (full ?s))
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (not (equipped_for_imaging ?x))
			(not (full ?s))
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (at ?x ?p)
			(not (equipped_for_imaging ?x))
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(have_soil_analysis ?x ?p)
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
			(empty ?y)
			(equipped_for_rock_analysis ?x)
			(not (full ?y))
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (available ?x)
			(store_of ?y ?x)
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
               (not (calibration_target ?i ?t))
			(equipped_for_rock_analysis ?r)
			(have_soil_analysis ?r ?w)
			(not (available ?r))
			(not (at ?r ?w))
			(on_board ?i ?r)
			(not (at_rock_sample ?w))
			(not (equipped_for_soil_analysis ?r))
			(not (have_rock_analysis ?r ?w))
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(equipped_for_rock_analysis ?r)
			(not (have_soil_analysis ?r ?w))
			(not (available ?r))
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(not (on_board ?i ?r))
			(at_rock_sample ?w)
			(not (equipped_for_soil_analysis ?r))
			(visible_from ?t ?w)
			(have_rock_analysis ?r ?w)
			(not (communicated_soil_data ?w))
			(communicated_rock_data ?w)
			
          )
    )  
    
    (:action take_image
         :parameters (?r - rover 
                      ?p - waypoint 
                      ?o - objective 
                      ?i - camera 
                      ?m - mode)
         :precondition (and 
               (communicated_image_data ?o ?m)
			(not (equipped_for_rock_analysis ?r))
			(available ?r)
			(have_image ?r ?o ?m)
			(not (equipped_for_soil_analysis ?r))
			(on_board ?i ?r)
			(have_rock_analysis ?r ?p)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
			(at ?r ?p)
			
          )
          :effect (and 
               (supports ?i ?m)
			(communicated_image_data ?o ?m)
			(have_soil_analysis ?r ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(calibration_target ?i ?o)
			(equipped_for_soil_analysis ?r)
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(have_rock_analysis ?r ?p)
			(at_soil_sample ?p)
			(visible_from ?o ?p)
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
			(calibrated ?i ?r)
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
               (not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(visible ?p ?y)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(equipped_for_rock_analysis ?r)
			(visible ?y ?p)
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(visible ?p ?x)
			(not (visible ?p ?y))
			(visible ?x ?y)
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(visible ?x ?p)
			(visible ?y ?p)
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
               (equipped_for_imaging ?r)
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?p ?y))
			(not (have_soil_analysis ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(have_rock_analysis ?r ?x)
			(not (at_lander ?l ?p))
			(equipped_for_rock_analysis ?r)
			(not (visible ?y ?p))
			(not (communicated_rock_data ?y))
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (channel_free ?l)
			(not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?p ?y))
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(available ?r)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (communicated_rock_data ?p))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(not (can_traverse ?r ?x ?p))
			(have_rock_analysis ?r ?x)
			(at_lander ?l ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?y ?p))
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
               (not (channel_free ?l))
			(not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(not (have_image ?r ?o ?m))
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(not (at_rock_sample ?x))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (at_rock_sample ?y))
			(not (visible_from ?o ?x))
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(have_rock_analysis ?r ?x)
			(visible_from ?o ?y)
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			(communicated_image_data ?o ?m)
			
          )
         :effect (and 
               (equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_image ?r ?o ?m)
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(available ?r)
			(not (at_rock_sample ?y))
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(have_rock_analysis ?r ?x)
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; drop action has changed: (full ?y), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (empty ?y), (available ?x), (equipped_for_imaging ?x), (equipped_for_imaging ?x), (available ?x), (full ?y), (store_of ?y ?x), (store_of ?y ?x), (equipped_for_rock_analysis ?x), 
;; communicate_soil_data action has changed: (equipped_for_imaging ?r), (communicated_rock_data ?y), (available ?r), (visible ?p ?y), (at_soil_sample ?x), (at_rock_sample ?p), (at_lander ?l ?y), (equipped_for_rock_analysis ?r), (communicated_rock_data ?p), (at_soil_sample ?p), (at ?r ?x), (at ?r ?x), (visible ?x ?p), (communicated_soil_data ?y), (can_traverse ?r ?x ?p), (communicated_rock_data ?p), (can_traverse ?r ?p ?y), (have_soil_analysis ?r ?x), (at_rock_sample ?x), (communicated_rock_data ?x), (at ?r ?p), (have_soil_analysis ?r ?x), (communicated_rock_data ?y), (can_traverse ?r ?x ?p), (have_soil_analysis ?r ?p), (have_rock_analysis ?r ?y), (at ?r ?y), (can_traverse ?r ?y ?x), (equipped_for_soil_analysis ?r), (can_traverse ?r ?p ?y), (visible ?p ?y), (communicated_soil_data ?p), (at ?r ?p), (visible ?x ?y), (at_rock_sample ?p), (equipped_for_imaging ?r), (at_rock_sample ?y), (visible ?y ?p), (can_traverse ?r ?y ?p), (at_lander ?l ?x), (have_rock_analysis ?r ?p), (visible ?p ?x), (at_soil_sample ?p), (can_traverse ?r ?p ?x), (visible ?y ?p), (equipped_for_rock_analysis ?r), (at_rock_sample ?y), (can_traverse ?r ?x ?y), (have_soil_analysis ?r ?y), (can_traverse ?r ?x ?y), (have_rock_analysis ?r ?p), (at_lander ?l ?y), (communicated_rock_data ?x), (at_soil_sample ?y), (at_lander ?l ?p), (have_soil_analysis ?r ?p), (communicated_soil_data ?x), (equipped_for_soil_analysis ?r), (can_traverse ?r ?y ?p), (communicated_soil_data ?y), (communicated_soil_data ?x), (channel_free ?l), (available ?r), (visible ?y ?x), (visible ?y ?x), (can_traverse ?r ?p ?x), (have_rock_analysis ?r ?x), (at_soil_sample ?y), (visible ?x ?y), 
;; navigate action has changed: (at ?x ?y), (at_soil_sample ?y), (communicated_soil_data ?y), (communicated_rock_data ?z), (communicated_soil_data ?y), (at_soil_sample ?z), (available ?x), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (at_rock_sample ?z), (have_rock_analysis ?x ?y), (visible ?y ?z), (at_rock_sample ?y), (have_rock_analysis ?x ?z), (visible ?z ?y), (equipped_for_rock_analysis ?x), (at_soil_sample ?y), (visible ?y ?z), (can_traverse ?x ?z ?y), (equipped_for_soil_analysis ?x), (communicated_soil_data ?z), (at_rock_sample ?y), (have_soil_analysis ?x ?y), (at ?x ?y), (have_rock_analysis ?x ?z), (available ?x), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (communicated_rock_data ?y), (have_soil_analysis ?x ?z), (visible ?z ?y), 
;; sample_soil action has changed: (equipped_for_soil_analysis ?x), (communicated_soil_data ?p), (at_soil_sample ?p), (at ?x ?p), (have_rock_analysis ?x ?p), (at_soil_sample ?p), (available ?x), (store_of ?s ?x), (full ?s), (at_rock_sample ?p), (communicated_soil_data ?p), (store_of ?s ?x), (have_rock_analysis ?x ?p), (empty ?s), (equipped_for_soil_analysis ?x), (available ?x), (equipped_for_imaging ?x), (communicated_rock_data ?p), (empty ?s), (equipped_for_rock_analysis ?x), (equipped_for_rock_analysis ?x), (full ?s), (at ?x ?p), 
;; take_image action has changed: (calibration_target ?i ?o), (have_rock_analysis ?r ?p), (calibrated ?i ?r), (on_board ?i ?r), (communicated_image_data ?o ?m), (have_image ?r ?o ?m), (available ?r), (equipped_for_imaging ?r), (available ?r), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?p), (at_soil_sample ?p), (visible_from ?o ?p), (at ?r ?p), (communicated_image_data ?o ?m), (supports ?i ?m), (at_soil_sample ?p), (at_rock_sample ?p), (visible_from ?o ?p), (communicated_soil_data ?p), (equipped_for_rock_analysis ?r), (equipped_for_imaging ?r), (have_image ?r ?o ?m), (communicated_soil_data ?p), (equipped_for_soil_analysis ?r), (supports ?i ?m), (communicated_rock_data ?p), (communicated_rock_data ?p), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?p), (calibrated ?i ?r), 
;; communicate_image_data action has changed: (visible ?x ?y), (communicated_soil_data ?x), (have_image ?r ?o ?m), (visible_from ?o ?x), (communicated_soil_data ?x), (equipped_for_rock_analysis ?r), (channel_free ?l), (at ?r ?x), (have_soil_analysis ?r ?y), (at_lander ?l ?y), (communicated_image_data ?o ?m), (at_soil_sample ?y), (at ?r ?y), (communicated_image_data ?o ?m), (at ?r ?y), (visible_from ?o ?y), (available ?r), (at_rock_sample ?y), (equipped_for_soil_analysis ?r), (communicated_rock_data ?x), (have_image ?r ?o ?m), (communicated_rock_data ?y), (visible_from ?o ?x), (have_rock_analysis ?r ?x), (at_lander ?l ?y), (communicated_soil_data ?y), (at_rock_sample ?y), (can_traverse ?r ?y ?x), (have_rock_analysis ?r ?y), (have_soil_analysis ?r ?x), (equipped_for_imaging ?r), (have_rock_analysis ?r ?y), (equipped_for_imaging ?r), (available ?r), (at ?r ?x), (visible ?y ?x), (at_rock_sample ?x), (can_traverse ?r ?y ?x), (have_rock_analysis ?r ?x), (visible_from ?o ?y), (have_soil_analysis ?r ?x), (have_soil_analysis ?r ?y), (communicated_rock_data ?y), (at_lander ?l ?x), (visible ?y ?x), (at_soil_sample ?x), (at_soil_sample ?y), (communicated_rock_data ?x), 
;; communicate_rock_data action has changed: (have_rock_analysis ?r ?x), (can_traverse ?r ?x ?y), (visible ?p ?y), (available ?r), (communicated_rock_data ?x), (can_traverse ?r ?p ?x), (at_rock_sample ?p), (channel_free ?l), (equipped_for_imaging ?r), (have_soil_analysis ?r ?y), (have_soil_analysis ?r ?p), (have_soil_analysis ?r ?y), (equipped_for_rock_analysis ?r), (at_soil_sample ?y), (at_lander ?l ?p), (visible ?y ?x), (communicated_soil_data ?y), (at_lander ?l ?x), (equipped_for_soil_analysis ?r), (at_rock_sample ?x), (have_rock_analysis ?r ?p), (at_lander ?l ?x), (have_rock_analysis ?r ?p), (channel_free ?l), (equipped_for_soil_analysis ?r), (at_soil_sample ?x), (at ?r ?p), (can_traverse ?r ?p ?y), (have_rock_analysis ?r ?y), (communicated_rock_data ?y), (at_lander ?l ?y), (communicated_rock_data ?p), (communicated_rock_data ?y), (available ?r), (equipped_for_rock_analysis ?r), (visible ?p ?x), (at_rock_sample ?x), (have_soil_analysis ?r ?x), (at ?r ?y), (at_soil_sample ?p), (communicated_soil_data ?x), (communicated_rock_data ?p), (visible ?y ?p), (at_soil_sample ?x), (visible ?x ?y), (at_soil_sample ?y), (visible ?y ?p), (have_rock_analysis ?r ?x), (visible ?p ?x), (can_traverse ?r ?p ?y), (visible ?x ?y), (at_lander ?l ?p), (can_traverse ?r ?x ?p), (can_traverse ?r ?x ?p), (communicated_rock_data ?x), (at_lander ?l ?y), (communicated_soil_data ?x), (at_rock_sample ?p), 
;; sample_rock action has changed: (have_soil_analysis ?x ?p), (communicated_rock_data ?p), (communicated_rock_data ?p), (at_rock_sample ?p), (at ?x ?p), (equipped_for_soil_analysis ?x), (at_soil_sample ?p), (at_rock_sample ?p), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?p), (have_soil_analysis ?x ?p), (equipped_for_imaging ?x), (at_soil_sample ?p), (at ?x ?p), (empty ?s), (empty ?s), (full ?s), (store_of ?s ?x), (have_rock_analysis ?x ?p), (equipped_for_rock_analysis ?x), (store_of ?s ?x), (full ?s), 
;; calibrate action has changed: (visible_from ?t ?w), (have_rock_analysis ?r ?w), (equipped_for_soil_analysis ?r), (at ?r ?w), (calibration_target ?i ?t), (calibrated ?i ?r), (visible_from ?t ?w), (have_soil_analysis ?r ?w), (available ?r), (at ?r ?w), (have_rock_analysis ?r ?w), (calibration_target ?i ?t), (equipped_for_rock_analysis ?r), (communicated_soil_data ?w), (have_soil_analysis ?r ?w), (equipped_for_rock_analysis ?r), (on_board ?i ?r), (at_rock_sample ?w), (available ?r), (equipped_for_imaging ?r), (calibrated ?i ?r), (equipped_for_soil_analysis ?r), (at_rock_sample ?w), (equipped_for_imaging ?r), (communicated_rock_data ?w), 
;; Last_reduced_capability_num_dropped_pals: None

