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
			(visible ?z ?y)
			(not (at_rock_sample ?y))
			(at ?x ?y)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?z))
			(not (communicated_rock_data ?z))
			(equipped_for_rock_analysis ?x)
			(can_traverse ?x ?y ?z)
			(not (at ?x ?z))
			(not (have_rock_analysis ?x ?y))
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (at_rock_sample ?y)
			(not (at ?x ?y))
			(have_soil_analysis ?x ?y)
			(not (at_soil_sample ?z))
			(not (at_soil_sample ?y))
			(not (communicated_rock_data ?z))
			(not (communicated_soil_data ?y))
			(not (visible ?y ?z))
			(equipped_for_rock_analysis ?x)
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			(communicated_rock_data ?y)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(not (full ?s))
			(not (at_soil_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(have_soil_analysis ?x ?p)
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (equipped_for_imaging ?x))
			(full ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(have_soil_analysis ?x ?p)
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(equipped_for_imaging ?x)
			(not (full ?s))
			(store_of ?s ?x)
			(not (at_rock_sample ?p))
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (store_of ?y ?x))
			(not (full ?y))
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (not (empty ?y))
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
			(not (have_soil_analysis ?r ?w))
			(at ?r ?w)
			(not (on_board ?i ?r))
			(at_rock_sample ?w)
			(not (communicated_soil_data ?w))
			(communicated_rock_data ?w)
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (not (equipped_for_soil_analysis ?r))
			(visible_from ?t ?w)
			(communicated_soil_data ?w)
			(at_soil_sample ?w)
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
               (equipped_for_rock_analysis ?r)
			(not (available ?r))
			(not (have_image ?r ?o ?m))
			(calibration_target ?i ?o)
			(equipped_for_soil_analysis ?r)
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(not (have_rock_analysis ?r ?p))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(visible_from ?o ?p)
			(communicated_soil_data ?p)
			(calibrated ?i ?r)
			(not (at ?r ?p))
			
          )
          :effect (and 
               (supports ?i ?m)
			(not (communicated_image_data ?o ?m))
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(equipped_for_soil_analysis ?r)
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(not (calibrated ?i ?r))
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
			(equipped_for_imaging ?r)
			(not (communicated_rock_data ?x))
			(not (at_rock_sample ?x))
			(not (at ?r ?p))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_soil_sample ?p)
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?x))
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(not (communicated_rock_data ?y))
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(not (have_soil_analysis ?r ?x))
			(visible ?x ?y)
			(not (at ?r ?p))
			(not (at ?r ?y))
			(available ?r)
			(not (at_rock_sample ?p))
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(not (at_soil_sample ?x))
			(communicated_soil_data ?y)
			(have_rock_analysis ?r ?x)
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(not (visible ?y ?p))
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
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(at_rock_sample ?x)
			(not (can_traverse ?r ?p ?y))
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (at ?r ?x))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(not (have_rock_analysis ?r ?p))
			(can_traverse ?r ?x ?p)
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(visible ?y ?p)
			(communicated_rock_data ?y)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(have_rock_analysis ?r ?x)
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(visible ?x ?p)
			(visible ?y ?p)
			(communicated_rock_data ?y)
			(can_traverse ?r ?p ?x)
			
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
			(not (visible ?y ?x))
			(not (have_image ?r ?o ?m))
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (at_rock_sample ?y))
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(communicated_soil_data ?y)
			(not (visible_from ?o ?y))
			(not (communicated_rock_data ?y))
			
          )
         :effect (and 
               (not (visible ?y ?x))
			(communicated_rock_data ?x)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(not (have_soil_analysis ?r ?y))
			(can_traverse ?r ?x ?y)
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(have_rock_analysis ?r ?x)
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (available ?r), (at_rock_sample ?p), (at_rock_sample ?x), (equipped_for_rock_analysis ?r), (at_lander ?l ?p), (communicated_rock_data ?x), (visible ?y ?p), (can_traverse ?r ?x ?y), (can_traverse ?r ?x ?p), (at_lander ?l ?y), (equipped_for_soil_analysis ?r), (communicated_rock_data ?x), (visible ?x ?p), (have_soil_analysis ?r ?p), (have_rock_analysis ?r ?p), (equipped_for_imaging ?r), (can_traverse ?r ?p ?x), (at ?r ?x), (communicated_soil_data ?x), (at_soil_sample ?p), (have_soil_analysis ?r ?x), (have_rock_analysis ?r ?y), (communicated_soil_data ?p), (at_soil_sample ?y), (communicated_soil_data ?p), (have_rock_analysis ?r ?p), (communicated_rock_data ?y), (can_traverse ?r ?p ?y), (visible ?x ?y), (at_rock_sample ?x), (visible ?p ?y), (have_soil_analysis ?r ?y), (have_rock_analysis ?r ?x), (visible ?x ?y), (have_soil_analysis ?r ?x), (visible ?y ?p), (can_traverse ?r ?p ?x), (at ?r ?x), (visible ?y ?x), (equipped_for_rock_analysis ?r), (communicated_rock_data ?y), (at ?r ?y), (channel_free ?l), (at_soil_sample ?x), (at ?r ?y), (equipped_for_imaging ?r), 
;; communicate_soil_data action has changed: (equipped_for_imaging ?r), (visible ?y ?p), (visible ?x ?p), (at ?r ?p), (channel_free ?l), (can_traverse ?r ?p ?x), (at ?r ?y), (communicated_rock_data ?y), (at_soil_sample ?p), (at_rock_sample ?x), (available ?r), (at ?r ?p), (can_traverse ?r ?p ?x), (at_soil_sample ?x), (equipped_for_rock_analysis ?r), (at_lander ?l ?y), (have_rock_analysis ?r ?y), (visible ?x ?y), (at_soil_sample ?x), (communicated_soil_data ?y), (have_rock_analysis ?r ?x), (can_traverse ?r ?y ?p), (communicated_soil_data ?p), (communicated_rock_data ?x), (equipped_for_imaging ?r), (equipped_for_soil_analysis ?r), (at_rock_sample ?p), (have_soil_analysis ?r ?x), (visible ?x ?y), (at_soil_sample ?y), (at_lander ?l ?p), (channel_free ?l), (equipped_for_soil_analysis ?r), (communicated_rock_data ?p), 
;; calibrate action has changed: (on_board ?i ?r), (equipped_for_soil_analysis ?r), (communicated_rock_data ?w), (equipped_for_imaging ?r), (calibration_target ?i ?t), (communicated_soil_data ?w), (at_rock_sample ?w), (at_soil_sample ?w), (visible_from ?t ?w), (communicated_soil_data ?w), (have_soil_analysis ?r ?w), (visible_from ?t ?w), (calibrated ?i ?r), 
;; sample_rock action has changed: (communicated_rock_data ?p), (equipped_for_rock_analysis ?x), (at_soil_sample ?p), (have_rock_analysis ?x ?p), (equipped_for_rock_analysis ?x), (have_soil_analysis ?x ?p), (communicated_rock_data ?p), (empty ?s), (available ?x), (at_rock_sample ?p), (equipped_for_imaging ?x), (full ?s), (at ?x ?p), 
;; take_image action has changed: (at ?r ?p), (at ?r ?p), (equipped_for_rock_analysis ?r), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?p), (have_image ?r ?o ?m), (available ?r), (supports ?i ?m), (supports ?i ?m), (equipped_for_imaging ?r), (communicated_soil_data ?p), (on_board ?i ?r), (at_soil_sample ?p), (calibration_target ?i ?o), (equipped_for_soil_analysis ?r), (equipped_for_imaging ?r), (communicated_image_data ?o ?m), (have_rock_analysis ?r ?p), (at_rock_sample ?p), (available ?r), (have_image ?r ?o ?m), 
;; navigate action has changed: (communicated_rock_data ?y), (at_soil_sample ?y), (communicated_rock_data ?y), (visible ?y ?z), (have_soil_analysis ?x ?y), (at_soil_sample ?z), (at_rock_sample ?y), (at_rock_sample ?z), (equipped_for_rock_analysis ?x), (at_soil_sample ?y), (communicated_soil_data ?z), (communicated_rock_data ?z), (equipped_for_rock_analysis ?x), (visible ?z ?y), (can_traverse ?x ?y ?z), (at ?x ?z), (communicated_soil_data ?y), (have_rock_analysis ?x ?y), (visible ?y ?z), (at_rock_sample ?y), (communicated_rock_data ?z), 
;; drop action has changed: (empty ?y), (equipped_for_imaging ?x), (equipped_for_imaging ?x), (store_of ?y ?x), (full ?y), (full ?y), 
;; communicate_image_data action has changed: (communicated_soil_data ?y), (equipped_for_soil_analysis ?r), (can_traverse ?r ?x ?y), (visible_from ?o ?y), (communicated_rock_data ?y), (at_rock_sample ?x), (have_soil_analysis ?r ?y), (communicated_rock_data ?x), (visible ?x ?y), (have_rock_analysis ?r ?x), (at_rock_sample ?y), (have_image ?r ?o ?m), (communicated_rock_data ?y), (equipped_for_rock_analysis ?r), (communicated_soil_data ?y), (visible ?y ?x), (visible ?y ?x), (communicated_rock_data ?x), (visible_from ?o ?y), (at_soil_sample ?y), (available ?r), (can_traverse ?r ?y ?x), (visible ?x ?y), (at_rock_sample ?x), (have_soil_analysis ?r ?x), (channel_free ?l), (at ?r ?y), (have_soil_analysis ?r ?y), (at_lander ?l ?x), (at_soil_sample ?x), (can_traverse ?r ?x ?y), 
;; sample_soil action has changed: (communicated_rock_data ?p), (full ?s), (store_of ?s ?x), (have_rock_analysis ?x ?p), (store_of ?s ?x), (equipped_for_rock_analysis ?x), (have_soil_analysis ?x ?p), (at_rock_sample ?p), (empty ?s), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (empty ?s), (communicated_rock_data ?p), (equipped_for_soil_analysis ?x), (at_soil_sample ?p), (at_soil_sample ?p), 
;; Last_reduced_capability_num_dropped_pals: None

