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
               (not (have_rock_analysis ?x ?z))
			(not (equipped_for_imaging ?x))
			(at_rock_sample ?y)
			(at ?x ?y)
			(have_soil_analysis ?x ?y)
			(at_soil_sample ?y)
			(communicated_rock_data ?z)
			(not (visible ?y ?z))
			(can_traverse ?x ?y ?z)
			(not (at ?x ?z))
			(have_soil_analysis ?x ?z)
			(not (have_rock_analysis ?x ?y))
			
          )
          :effect (and 
               (not (at_rock_sample ?z))
			(not (equipped_for_imaging ?x))
			(can_traverse ?x ?z ?y)
			(not (have_soil_analysis ?x ?y))
			(at_soil_sample ?z)
			(not (at_soil_sample ?y))
			(communicated_rock_data ?z)
			(not (communicated_soil_data ?y))
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			(not (at ?x ?z))
			(not (have_soil_analysis ?x ?z))
			(communicated_rock_data ?y)
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(at ?x ?p)
			(empty ?s)
			(full ?s)
			(at_soil_sample ?p)
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (at ?x ?p)
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(not (full ?s))
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			(equipped_for_rock_analysis ?x)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (available ?x)
			(at ?x ?p)
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (at ?x ?p)
			(not (empty ?s))
			(not (full ?s))
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (empty ?y))
			(equipped_for_rock_analysis ?x)
			(equipped_for_soil_analysis ?x)
			(full ?y)
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (not (empty ?y))
			(not (equipped_for_rock_analysis ?x))
			(equipped_for_soil_analysis ?x)
			(full ?y)
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (not (calibration_target ?i ?t))
			(not (available ?r))
			(not (equipped_for_imaging ?r))
			(at ?r ?w)
			(on_board ?i ?r)
			(at_rock_sample ?w)
			(visible_from ?t ?w)
			(have_rock_analysis ?r ?w)
			(not (communicated_soil_data ?w))
			(communicated_rock_data ?w)
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(not (equipped_for_rock_analysis ?r))
			(not (at_rock_sample ?w))
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
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
			(not (have_image ?r ?o ?m))
			(calibration_target ?i ?o)
			(not (on_board ?i ?r))
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?p))
			(not (communicated_rock_data ?p))
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (not (supports ?i ?m))
			(not (communicated_image_data ?o ?m))
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(not (have_image ?r ?o ?m))
			(calibration_target ?i ?o)
			(have_rock_analysis ?r ?p)
			(not (at_soil_sample ?p))
			(not (visible_from ?o ?p))
			(not (communicated_soil_data ?p))
			(not (communicated_rock_data ?p))
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
			(not (have_soil_analysis ?r ?x))
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(visible ?x ?y)
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(not (at ?r ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(at_lander ?l ?y)
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(not (visible ?p ?x))
			(visible ?x ?y)
			(can_traverse ?r ?p ?y)
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(available ?r)
			(at_soil_sample ?p)
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
			(visible ?y ?p)
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
               (visible ?y ?x)
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (can_traverse ?r ?p ?y))
			(not (at ?r ?p))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(at ?r ?x)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(visible ?x ?p)
			(visible ?y ?p)
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (equipped_for_imaging ?r)
			(visible ?y ?x)
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(at_rock_sample ?x)
			(not (can_traverse ?r ?p ?y))
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(not (at_lander ?l ?y))
			(not (have_rock_analysis ?r ?y))
			(at_soil_sample ?y)
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(not (visible ?y ?p))
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
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_image ?r ?o ?m)
			(not (communicated_rock_data ?x))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(at ?r ?x)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?x)
			(visible_from ?o ?y)
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			(communicated_image_data ?o ?m)
			
          )
         :effect (and 
               (equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_image ?r ?o ?m)
			(not (communicated_rock_data ?x))
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(have_soil_analysis ?r ?y)
			(available ?r)
			(visible_from ?o ?x)
			(not (at ?r ?x))
			(at_lander ?l ?x)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(not (at_soil_sample ?x))
			(communicated_soil_data ?y)
			(have_rock_analysis ?r ?x)
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			
          )
    )

)

;; 
;; communicate_image_data action has changed: (have_soil_analysis ?r ?y), (visible_from ?o ?y), (at_lander ?l ?y), (visible ?y ?x), (have_rock_analysis ?r ?x), (have_rock_analysis ?r ?x), (have_image ?r ?o ?m), (channel_free ?l), (visible ?y ?x), (equipped_for_imaging ?r), (at_rock_sample ?x), (at ?r ?y), (equipped_for_rock_analysis ?r), (visible_from ?o ?x), (communicated_soil_data ?y), (communicated_soil_data ?x), (at_soil_sample ?x), (communicated_rock_data ?x), (at_soil_sample ?y), (equipped_for_soil_analysis ?r), (at_soil_sample ?x), (at_lander ?l ?x), (can_traverse ?r ?x ?y), (equipped_for_rock_analysis ?r), (communicated_image_data ?o ?m), (available ?r), (visible_from ?o ?y), (at ?r ?x), (at_soil_sample ?y), (equipped_for_imaging ?r), (communicated_rock_data ?y), (available ?r), (communicated_image_data ?o ?m), (communicated_rock_data ?x), (visible ?x ?y), (visible ?x ?y), (can_traverse ?r ?y ?x), 
;; calibrate action has changed: (calibration_target ?i ?t), (calibrated ?i ?r), (equipped_for_imaging ?r), (communicated_soil_data ?w), (have_rock_analysis ?r ?w), (at_rock_sample ?w), (visible_from ?t ?w), (equipped_for_soil_analysis ?r), (calibration_target ?i ?t), (at_soil_sample ?w), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?w), (at_rock_sample ?w), (communicated_rock_data ?w), (available ?r), 
;; take_image action has changed: (calibrated ?i ?r), (have_rock_analysis ?r ?p), (have_image ?r ?o ?m), (communicated_rock_data ?p), (calibration_target ?i ?o), (have_image ?r ?o ?m), (on_board ?i ?r), (available ?r), (equipped_for_imaging ?r), (visible_from ?o ?p), (supports ?i ?m), (communicated_soil_data ?p), (have_soil_analysis ?r ?p), (have_rock_analysis ?r ?p), (at ?r ?p), (at_soil_sample ?p), (calibration_target ?i ?o), (communicated_soil_data ?p), (communicated_image_data ?o ?m), (visible_from ?o ?p), (communicated_rock_data ?p), 
;; communicate_soil_data action has changed: (visible ?p ?y), (at_soil_sample ?y), (have_soil_analysis ?r ?y), (at_soil_sample ?x), (equipped_for_imaging ?r), (have_rock_analysis ?r ?y), (at ?r ?y), (available ?r), (equipped_for_rock_analysis ?r), (visible ?p ?x), (have_rock_analysis ?r ?p), (at ?r ?y), (at_soil_sample ?p), (at_rock_sample ?y), (communicated_rock_data ?p), (can_traverse ?r ?p ?x), (equipped_for_soil_analysis ?r), (equipped_for_rock_analysis ?r), (communicated_soil_data ?y), (communicated_rock_data ?p), (can_traverse ?r ?p ?y), (visible ?x ?y), (communicated_soil_data ?x), (can_traverse ?r ?p ?y), (at_rock_sample ?p), (at_lander ?l ?x), (visible ?y ?p), (communicated_soil_data ?y), (visible ?y ?x), (at_soil_sample ?p), (can_traverse ?r ?y ?p), (can_traverse ?r ?p ?x), (communicated_soil_data ?p), (at ?r ?p), (at_lander ?l ?p), (can_traverse ?r ?x ?p), (can_traverse ?r ?x ?p), (have_soil_analysis ?r ?x), (visible ?x ?p), (equipped_for_soil_analysis ?r), (channel_free ?l), (visible ?p ?x), (have_soil_analysis ?r ?x), (communicated_soil_data ?p), (at_soil_sample ?y), (at_lander ?l ?y), 
;; sample_rock action has changed: (communicated_rock_data ?p), (store_of ?s ?x), (have_rock_analysis ?x ?p), (equipped_for_soil_analysis ?x), (have_soil_analysis ?x ?p), (equipped_for_imaging ?x), (full ?s), (have_soil_analysis ?x ?p), (communicated_soil_data ?p), (at_soil_sample ?p), (equipped_for_soil_analysis ?x), (at ?x ?p), (full ?s), (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?p), (available ?x), (at_soil_sample ?p), (store_of ?s ?x), (communicated_soil_data ?p), 
;; communicate_rock_data action has changed: (at_rock_sample ?x), (communicated_rock_data ?y), (channel_free ?l), (at_soil_sample ?x), (at_lander ?l ?p), (communicated_rock_data ?y), (equipped_for_imaging ?r), (can_traverse ?r ?x ?y), (communicated_rock_data ?p), (at_lander ?l ?p), (have_rock_analysis ?r ?y), (visible ?p ?x), (at ?r ?y), (at_rock_sample ?p), (visible ?y ?p), (visible ?x ?p), (have_rock_analysis ?r ?p), (at_soil_sample ?y), (can_traverse ?r ?y ?p), (have_rock_analysis ?r ?x), (equipped_for_rock_analysis ?r), (at_rock_sample ?x), (communicated_soil_data ?y), (communicated_rock_data ?x), (communicated_soil_data ?p), (can_traverse ?r ?p ?y), (can_traverse ?r ?x ?p), (at_soil_sample ?x), (visible ?y ?x), (at_soil_sample ?y), (can_traverse ?r ?y ?x), (visible ?x ?p), (can_traverse ?r ?y ?x), (can_traverse ?r ?x ?y), (at_rock_sample ?p), (at_lander ?l ?x), (have_rock_analysis ?r ?y), (have_soil_analysis ?r ?y), (at_rock_sample ?y), (have_soil_analysis ?r ?p), (at_soil_sample ?p), (visible ?y ?x), (can_traverse ?r ?p ?y), (communicated_soil_data ?p), (at ?r ?p), (available ?r), (have_soil_analysis ?r ?p), (visible ?y ?p), (at ?r ?x), (at ?r ?p), (communicated_soil_data ?x), (at_soil_sample ?p), (at_lander ?l ?y), 
;; sample_soil action has changed: (available ?x), (equipped_for_rock_analysis ?x), (full ?s), (store_of ?s ?x), (at ?x ?p), (communicated_rock_data ?p), (have_rock_analysis ?x ?p), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (store_of ?s ?x), (at_soil_sample ?p), (full ?s), (equipped_for_soil_analysis ?x), (communicated_soil_data ?p), 
;; navigate action has changed: (communicated_rock_data ?z), (at ?x ?y), (communicated_rock_data ?y), (at_rock_sample ?z), (have_soil_analysis ?x ?y), (at_soil_sample ?y), (communicated_soil_data ?y), (equipped_for_rock_analysis ?x), (can_traverse ?x ?z ?y), (equipped_for_imaging ?x), (have_soil_analysis ?x ?z), (communicated_rock_data ?z), (have_rock_analysis ?x ?z), (have_soil_analysis ?x ?y), (at_soil_sample ?y), (available ?x), (at ?x ?z), (at_soil_sample ?z), (visible ?y ?z), (can_traverse ?x ?y ?z), (at ?x ?z), (have_soil_analysis ?x ?z), (equipped_for_soil_analysis ?x), (at_rock_sample ?y), (have_rock_analysis ?x ?y), (equipped_for_imaging ?x), 
;; drop action has changed: (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), (empty ?y), (store_of ?y ?x), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (empty ?y), (full ?y), 
;; Last_reduced_capability_num_dropped_pals: None

