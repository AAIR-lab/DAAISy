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
			(can_traverse ?x ?z ?y)
			(not (at ?x ?y))
			(have_soil_analysis ?x ?y)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?z))
			(communicated_soil_data ?y)
			(visible ?y ?z)
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			(equipped_for_soil_analysis ?x)
			
          )
          :effect (and 
               (have_rock_analysis ?x ?z)
			(available ?x)
			(visible ?z ?y)
			(at_rock_sample ?y)
			(not (can_traverse ?x ?z ?y))
			(not (at_soil_sample ?z))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?z))
			(not (communicated_rock_data ?z))
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			(not (have_soil_analysis ?x ?z))
			(have_rock_analysis ?x ?y)
			(communicated_rock_data ?y)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(at ?x ?p)
			(not (empty ?s))
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (available ?x))
			(at ?x ?p)
			(not (empty ?s))
			(full ?s)
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
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
			(not (full ?s))
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (available ?x))
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (store_of ?s ?x))
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(not (have_soil_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (empty ?y))
			(equipped_for_rock_analysis ?x)
			(not (full ?y))
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (not (available ?x))
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
               (not (equipped_for_rock_analysis ?r))
			(have_soil_analysis ?r ?w)
			(equipped_for_imaging ?r)
			(not (at ?r ?w))
			(not (on_board ?i ?r))
			(not (at_rock_sample ?w))
			(not (equipped_for_soil_analysis ?r))
			(visible_from ?t ?w)
			(communicated_soil_data ?w)
			
          )
         :effect (and 
               (not (calibration_target ?i ?t))
			(not (have_soil_analysis ?r ?w))
			(not (available ?r))
			(equipped_for_imaging ?r)
			(not (at ?r ?w))
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
			(not (communicated_soil_data ?w))
			(not (at_soil_sample ?w))
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
               (not (supports ?i ?m))
			(not (communicated_image_data ?o ?m))
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(equipped_for_imaging ?r)
			(not (on_board ?i ?r))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (visible_from ?o ?p))
			(not (communicated_soil_data ?p))
			(communicated_rock_data ?p)
			(not (at ?r ?p))
			
          )
          :effect (and 
               (supports ?i ?m)
			(not (communicated_image_data ?o ?m))
			(have_soil_analysis ?r ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (have_image ?r ?o ?m))
			(not (calibration_target ?i ?o))
			(on_board ?i ?r)
			(not (have_rock_analysis ?r ?p))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (visible_from ?o ?p))
			(not (communicated_soil_data ?p))
			(not (communicated_rock_data ?p))
			(calibrated ?i ?r)
			
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
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(not (at_rock_sample ?x))
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(at ?r ?x)
			(communicated_rock_data ?p)
			(not (have_rock_analysis ?r ?y))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(can_traverse ?r ?x ?p)
			(have_rock_analysis ?r ?x)
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(not (visible ?x ?p))
			(visible ?y ?p)
			
          )
          :effect (and 
               (have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(at_rock_sample ?p)
			(not (communicated_rock_data ?p))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(not (visible ?x ?p))
			(not (communicated_rock_data ?y))
			(can_traverse ?r ?p ?x)
			
          )
    )
    
    (:action communicate_rock_data
         :parameters (?r - rover 
                      ?l - lander 
                      ?p - waypoint 
                      ?x - waypoint 
                      ?y - waypoint)
         :precondition (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(visible ?p ?y)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(have_soil_analysis ?r ?y)
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(have_rock_analysis ?r ?y)
			(not (communicated_soil_data ?x))
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(at_lander ?l ?p)
			(not (equipped_for_rock_analysis ?r))
			(visible ?y ?p)
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (equipped_for_imaging ?r)
			(not (visible ?p ?x))
			(visible ?p ?y)
			(not (visible ?x ?y))
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(at ?r ?x)
			(communicated_rock_data ?p)
			(at_lander ?l ?y)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (can_traverse ?r ?x ?p))
			(have_rock_analysis ?r ?x)
			(at_lander ?l ?p)
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(not (communicated_rock_data ?y))
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
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(not (have_soil_analysis ?r ?y))
			(can_traverse ?r ?x ?y)
			(at_rock_sample ?y)
			(visible_from ?o ?x)
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(not (equipped_for_rock_analysis ?r))
			
          )
         :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(visible ?y ?x)
			(not (have_image ?r ?o ?m))
			(not (communicated_rock_data ?x))
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(not (have_soil_analysis ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (equipped_for_soil_analysis ?r))
			(communicated_soil_data ?x)
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_image_data action has changed: (channel_free ?l), (communicated_soil_data ?x), (have_soil_analysis ?r ?y), (equipped_for_rock_analysis ?r), (available ?r), (available ?r), (at_soil_sample ?y), (equipped_for_soil_analysis ?r), (at ?r ?x), (have_image ?r ?o ?m), (at_rock_sample ?y), (communicated_rock_data ?x), (communicated_soil_data ?y), (have_soil_analysis ?r ?y), (at_lander ?l ?y), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?x), (can_traverse ?r ?x ?y), (can_traverse ?r ?y ?x), (channel_free ?l), (have_soil_analysis ?r ?x), (visible ?x ?y), (can_traverse ?r ?x ?y), (at_rock_sample ?x), (communicated_soil_data ?x), (at_lander ?l ?x), (visible ?y ?x), (at_rock_sample ?x), (have_image ?r ?o ?m), (equipped_for_imaging ?r), (at_lander ?l ?x), (visible_from ?o ?x), (equipped_for_rock_analysis ?r), (communicated_rock_data ?x), (visible ?y ?x), (visible ?x ?y), 
;; communicate_soil_data action has changed: (have_rock_analysis ?r ?x), (channel_free ?l), (at_lander ?l ?x), (communicated_rock_data ?x), (can_traverse ?r ?x ?y), (can_traverse ?r ?p ?x), (visible ?y ?p), (equipped_for_imaging ?r), (at_lander ?l ?y), (communicated_soil_data ?x), (at_soil_sample ?p), (at_soil_sample ?y), (can_traverse ?r ?x ?p), (at ?r ?p), (at_soil_sample ?x), (visible ?x ?p), (communicated_soil_data ?p), (have_soil_analysis ?r ?y), (visible ?x ?p), (visible ?x ?y), (communicated_rock_data ?x), (have_rock_analysis ?r ?y), (at_lander ?l ?p), (visible ?x ?y), (at_lander ?l ?y), (have_rock_analysis ?r ?p), (have_soil_analysis ?r ?p), (at_lander ?l ?p), (communicated_soil_data ?y), (communicated_rock_data ?p), (communicated_rock_data ?p), (visible ?y ?x), (communicated_soil_data ?x), (visible ?p ?x), (at_rock_sample ?p), (at_rock_sample ?x), (at_rock_sample ?x), (at ?r ?p), (communicated_rock_data ?y), (have_soil_analysis ?r ?x), (can_traverse ?r ?x ?y), (have_soil_analysis ?r ?y), (at_rock_sample ?p), (at ?r ?y), (have_rock_analysis ?r ?y), 
;; communicate_rock_data action has changed: (can_traverse ?r ?x ?y), (at_soil_sample ?p), (can_traverse ?r ?x ?y), (at_soil_sample ?y), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?y), (available ?r), (at_soil_sample ?p), (at_lander ?l ?y), (at_rock_sample ?y), (communicated_rock_data ?p), (have_rock_analysis ?r ?y), (equipped_for_imaging ?r), (communicated_rock_data ?y), (at_rock_sample ?p), (at ?r ?x), (visible ?p ?y), (at_soil_sample ?x), (equipped_for_rock_analysis ?r), (can_traverse ?r ?x ?p), (have_soil_analysis ?r ?p), (communicated_soil_data ?y), (communicated_soil_data ?x), (equipped_for_rock_analysis ?r), (communicated_rock_data ?y), (visible ?x ?p), (communicated_rock_data ?x), (at ?r ?y), (have_rock_analysis ?r ?p), (can_traverse ?r ?y ?p), (visible ?p ?x), (at_rock_sample ?x), (channel_free ?l), (at ?r ?p), (at_lander ?l ?p), (at_lander ?l ?y), (can_traverse ?r ?p ?y), (visible ?x ?y), (visible ?p ?y), (equipped_for_imaging ?r), (available ?r), (at_rock_sample ?y), (visible ?y ?p), (have_rock_analysis ?r ?x), (have_soil_analysis ?r ?y), (visible ?x ?y), (have_rock_analysis ?r ?p), (at_lander ?l ?p), (at ?r ?x), (can_traverse ?r ?p ?x), (visible ?p ?x), 
;; navigate action has changed: (available ?x), (at ?x ?y), (have_rock_analysis ?x ?z), (can_traverse ?x ?z ?y), (communicated_soil_data ?y), (have_soil_analysis ?x ?z), (communicated_rock_data ?y), (equipped_for_soil_analysis ?x), (at_rock_sample ?y), (visible ?z ?y), (at ?x ?y), (at_soil_sample ?y), (have_rock_analysis ?x ?z), (have_rock_analysis ?x ?y), (communicated_soil_data ?z), (at ?x ?z), (have_soil_analysis ?x ?y), (communicated_soil_data ?z), (at_soil_sample ?y), (equipped_for_rock_analysis ?x), (equipped_for_rock_analysis ?x), (can_traverse ?x ?y ?z), (visible ?z ?y), (available ?x), (at_soil_sample ?z), (communicated_rock_data ?z), (can_traverse ?x ?z ?y), 
;; calibrate action has changed: (have_soil_analysis ?r ?w), (calibration_target ?i ?t), (calibrated ?i ?r), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?w), (communicated_soil_data ?w), (calibration_target ?i ?t), (equipped_for_soil_analysis ?r), (on_board ?i ?r), (at_rock_sample ?w), (equipped_for_soil_analysis ?r), (communicated_soil_data ?w), (visible_from ?t ?w), (at_soil_sample ?w), (equipped_for_imaging ?r), (have_soil_analysis ?r ?w), (at ?r ?w), (available ?r), (at ?r ?w), 
;; sample_rock action has changed: (have_rock_analysis ?x ?p), (equipped_for_soil_analysis ?x), (have_soil_analysis ?x ?p), (available ?x), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (at_rock_sample ?p), (at_soil_sample ?p), (equipped_for_imaging ?x), (store_of ?s ?x), (store_of ?s ?x), (communicated_soil_data ?p), (full ?s), 
;; take_image action has changed: (have_soil_analysis ?r ?p), (visible_from ?o ?p), (at_soil_sample ?p), (communicated_image_data ?o ?m), (available ?r), (communicated_rock_data ?p), (communicated_soil_data ?p), (calibration_target ?i ?o), (calibrated ?i ?r), (communicated_image_data ?o ?m), (communicated_soil_data ?p), (visible_from ?o ?p), (have_rock_analysis ?r ?p), (have_soil_analysis ?r ?p), (communicated_rock_data ?p), (supports ?i ?m), (equipped_for_rock_analysis ?r), (supports ?i ?m), (at_rock_sample ?p), (at_rock_sample ?p), (at_soil_sample ?p), (on_board ?i ?r), (have_image ?r ?o ?m), (on_board ?i ?r), (at ?r ?p), (calibrated ?i ?r), 
;; sample_soil action has changed: (have_rock_analysis ?x ?p), (empty ?s), (communicated_soil_data ?p), (equipped_for_rock_analysis ?x), (at_soil_sample ?p), (available ?x), (communicated_soil_data ?p), (at ?x ?p), (equipped_for_soil_analysis ?x), (equipped_for_soil_analysis ?x), (communicated_rock_data ?p), (communicated_rock_data ?p), (equipped_for_rock_analysis ?x), (at_soil_sample ?p), (have_rock_analysis ?x ?p), (available ?x), (at_rock_sample ?p), 
;; drop action has changed: (equipped_for_imaging ?x), (empty ?y), (available ?x), (store_of ?y ?x), (empty ?y), (equipped_for_rock_analysis ?x), (full ?y), 
;; Last_reduced_capability_num_dropped_pals: None

