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
			(not (available ?x))
			(visible ?z ?y)
			(not (equipped_for_imaging ?x))
			(not (at ?x ?y))
			(have_soil_analysis ?x ?y)
			(not (at_soil_sample ?z))
			(communicated_soil_data ?z)
			(not (communicated_rock_data ?z))
			(not (communicated_soil_data ?y))
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			(not (at ?x ?z))
			(have_soil_analysis ?x ?z)
			(not (have_rock_analysis ?x ?y))
			(not (communicated_rock_data ?y))
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (at_rock_sample ?z)
			(not (available ?x))
			(not (can_traverse ?x ?z ?y))
			(at ?x ?y)
			(not (at_soil_sample ?z))
			(not (at_soil_sample ?y))
			(equipped_for_rock_analysis ?x)
			(not (can_traverse ?x ?y ?z))
			(at ?x ?z)
			(have_soil_analysis ?x ?z)
			(not (have_rock_analysis ?x ?y))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (at ?x ?p))
			(not (empty ?s))
			(not (full ?s))
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(not (equipped_for_rock_analysis ?x))
			
          )
        :effect (and 
               (equipped_for_imaging ?x)
			(full ?s)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(not (equipped_for_rock_analysis ?x))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (available ?x)
			(not (at ?x ?p))
			(empty ?s)
			(equipped_for_imaging ?x)
			(not (full ?s))
			(at_rock_sample ?p)
			(communicated_soil_data ?p)
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			
          )
        :effect (and 
               (available ?x)
			(at ?x ?p)
			(not (equipped_for_imaging ?x))
			(full ?s)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (available ?x))
			(store_of ?y ?x)
			(empty ?y)
			(not (equipped_for_rock_analysis ?x))
			(not (equipped_for_soil_analysis ?x))
			(not (equipped_for_imaging ?x))
			
          )
        :effect (and 
               (not (available ?x))
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
			(not (have_soil_analysis ?r ?w))
			(not (available ?r))
			(not (equipped_for_imaging ?r))
			(not (at ?r ?w))
			(on_board ?i ?r)
			(equipped_for_soil_analysis ?r)
			(not (visible_from ?t ?w))
			(communicated_soil_data ?w)
			(not (at_soil_sample ?w))
			(not (calibrated ?i ?r))
			
          )
         :effect (and 
               (equipped_for_rock_analysis ?r)
			(not (have_soil_analysis ?r ?w))
			(available ?r)
			(equipped_for_imaging ?r)
			(not (on_board ?i ?r))
			(not (at_rock_sample ?w))
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
			(not (communicated_soil_data ?w))
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
			(communicated_image_data ?o ?m)
			(have_soil_analysis ?r ?p)
			(equipped_for_rock_analysis ?r)
			(available ?r)
			(have_image ?r ?o ?m)
			(not (equipped_for_soil_analysis ?r))
			(not (on_board ?i ?r))
			(have_rock_analysis ?r ?p)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (visible_from ?o ?p))
			(communicated_soil_data ?p)
			(calibrated ?i ?r)
			
          )
          :effect (and 
               (not (communicated_image_data ?o ?m))
			(have_soil_analysis ?r ?p)
			(not (equipped_for_rock_analysis ?r))
			(available ?r)
			(not (calibration_target ?i ?o))
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(not (have_rock_analysis ?r ?p))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
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
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (at ?r ?p))
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(can_traverse ?r ?x ?y)
			(not (available ?r))
			(not (at_rock_sample ?p))
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?x)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(not (equipped_for_rock_analysis ?r))
			(visible ?x ?p)
			(visible ?y ?p)
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
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(not (communicated_rock_data ?x))
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(communicated_rock_data ?p)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(have_rock_analysis ?r ?x)
			(at_lander ?l ?p)
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(visible ?x ?p)
			(can_traverse ?r ?y ?x)
			
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
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(communicated_rock_data ?x)
			(at_rock_sample ?x)
			(have_soil_analysis ?r ?y)
			(visible_from ?o ?x)
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(not (equipped_for_rock_analysis ?r))
			(communicated_rock_data ?y)
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (not (channel_free ?l))
			(not (visible ?y ?x))
			(not (have_image ?r ?o ?m))
			(communicated_rock_data ?x)
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(available ?r)
			(not (visible_from ?o ?x))
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(not (visible_from ?o ?y))
			(equipped_for_rock_analysis ?r)
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_soil_data action has changed: (equipped_for_soil_analysis ?r), (channel_free ?l), (at_soil_sample ?y), (have_soil_analysis ?r ?y), (have_soil_analysis ?r ?x), (communicated_rock_data ?y), (communicated_rock_data ?x), (at_rock_sample ?x), (at_soil_sample ?x), (at_soil_sample ?p), (can_traverse ?r ?x ?p), (visible ?x ?p), (equipped_for_rock_analysis ?r), (can_traverse ?r ?y ?x), (can_traverse ?r ?p ?y), (at_rock_sample ?y), (communicated_soil_data ?p), (can_traverse ?r ?y ?p), (at_lander ?l ?y), (at_soil_sample ?y), (communicated_rock_data ?p), (visible ?p ?x), (have_rock_analysis ?r ?x), (have_rock_analysis ?r ?x), (can_traverse ?r ?p ?x), (equipped_for_imaging ?r), (communicated_soil_data ?p), (communicated_soil_data ?y), (communicated_rock_data ?p), (communicated_rock_data ?x), (equipped_for_rock_analysis ?r), (can_traverse ?r ?x ?y), (at ?r ?y), (at ?r ?p), (at ?r ?p), (at ?r ?x), (visible ?y ?p), (have_rock_analysis ?r ?p), (have_soil_analysis ?r ?x), (have_rock_analysis ?r ?y), (equipped_for_soil_analysis ?r), (can_traverse ?r ?x ?y), (equipped_for_imaging ?r), (at_soil_sample ?x), (at_lander ?l ?p), (at_lander ?l ?x), (communicated_soil_data ?x), (at_rock_sample ?x), (available ?r), (can_traverse ?r ?x ?p), (at ?r ?x), (visible ?y ?p), (at_lander ?l ?x), (available ?r), (at_rock_sample ?p), (at_rock_sample ?p), 
;; communicate_rock_data action has changed: (communicated_soil_data ?y), (at_lander ?l ?p), (can_traverse ?r ?x ?p), (have_rock_analysis ?r ?p), (visible ?x ?y), (can_traverse ?r ?p ?y), (at_soil_sample ?p), (at_soil_sample ?p), (have_rock_analysis ?r ?y), (channel_free ?l), (visible ?x ?p), (visible ?y ?p), (equipped_for_soil_analysis ?r), (at_soil_sample ?x), (communicated_soil_data ?x), (have_rock_analysis ?r ?x), (communicated_rock_data ?x), (visible ?p ?y), (can_traverse ?r ?x ?y), (communicated_soil_data ?y), (at_lander ?l ?y), (can_traverse ?r ?x ?p), (have_rock_analysis ?r ?x), (at_lander ?l ?p), (equipped_for_imaging ?r), (have_soil_analysis ?r ?y), (visible ?x ?p), (communicated_rock_data ?p), (available ?r), (at_rock_sample ?p), (communicated_rock_data ?x), (at ?r ?y), (at_rock_sample ?p), (can_traverse ?r ?x ?y), (communicated_rock_data ?y), (at_rock_sample ?x), (at ?r ?y), (have_rock_analysis ?r ?p), (at_lander ?l ?x), (can_traverse ?r ?y ?p), (at_lander ?l ?x), (visible ?p ?x), (communicated_soil_data ?x), (available ?r), (can_traverse ?r ?y ?x), (at_rock_sample ?y), (at ?r ?p), (equipped_for_imaging ?r), (have_soil_analysis ?r ?x), (have_soil_analysis ?r ?p), (equipped_for_rock_analysis ?r), (at ?r ?x), (communicated_rock_data ?p), (at_soil_sample ?y), (have_rock_analysis ?r ?y), (can_traverse ?r ?y ?x), (visible ?x ?y), (have_soil_analysis ?r ?p), 
;; sample_soil action has changed: (empty ?s), (at_soil_sample ?p), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), (at_rock_sample ?p), (equipped_for_soil_analysis ?x), (full ?s), (at_rock_sample ?p), (empty ?s), (at ?x ?p), (equipped_for_imaging ?x), (communicated_soil_data ?p), (have_soil_analysis ?x ?p), (communicated_rock_data ?p), (have_soil_analysis ?x ?p), (communicated_soil_data ?p), 
;; navigate action has changed: (available ?x), (visible ?y ?z), (available ?x), (have_soil_analysis ?x ?z), (can_traverse ?x ?y ?z), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (communicated_rock_data ?y), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (communicated_rock_data ?z), (at_rock_sample ?z), (at_soil_sample ?z), (have_soil_analysis ?x ?z), (at ?x ?y), (at_soil_sample ?y), (have_rock_analysis ?x ?z), (communicated_soil_data ?y), (at_soil_sample ?z), (visible ?z ?y), (communicated_soil_data ?z), (can_traverse ?x ?z ?y), (have_rock_analysis ?x ?y), (at ?x ?y), (have_rock_analysis ?x ?y), (have_soil_analysis ?x ?y), (at ?x ?z), 
;; communicate_image_data action has changed: (communicated_soil_data ?y), (communicated_image_data ?o ?m), (at_lander ?l ?y), (have_soil_analysis ?r ?y), (equipped_for_rock_analysis ?r), (can_traverse ?r ?y ?x), (communicated_soil_data ?x), (equipped_for_imaging ?r), (visible_from ?o ?x), (visible ?y ?x), (at_soil_sample ?y), (channel_free ?l), (visible ?x ?y), (communicated_rock_data ?y), (at_lander ?l ?y), (have_soil_analysis ?r ?y), (equipped_for_soil_analysis ?r), (have_image ?r ?o ?m), (at_rock_sample ?x), (available ?r), (communicated_rock_data ?x), (at ?r ?y), (communicated_soil_data ?x), (at ?r ?x), (equipped_for_rock_analysis ?r), (have_image ?r ?o ?m), (available ?r), (communicated_soil_data ?y), (communicated_rock_data ?y), (at_lander ?l ?x), (visible_from ?o ?y), (at_soil_sample ?y), (visible_from ?o ?x), (at ?r ?x), (at_soil_sample ?x), (have_rock_analysis ?r ?y), (at_rock_sample ?x), (communicated_rock_data ?x), (have_rock_analysis ?r ?x), (visible ?y ?x), (visible ?x ?y), (have_rock_analysis ?r ?x), 
;; sample_rock action has changed: (equipped_for_rock_analysis ?x), (at_soil_sample ?p), (at_rock_sample ?p), (equipped_for_imaging ?x), (equipped_for_imaging ?x), (empty ?s), (available ?x), (communicated_rock_data ?p), (at ?x ?p), (have_rock_analysis ?x ?p), (have_soil_analysis ?x ?p), (full ?s), (equipped_for_rock_analysis ?x), (at ?x ?p), (communicated_soil_data ?p), (available ?x), (communicated_soil_data ?p), (equipped_for_soil_analysis ?x), (store_of ?s ?x), (communicated_rock_data ?p), 
;; calibrate action has changed: (at_rock_sample ?w), (communicated_soil_data ?w), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?w), (on_board ?i ?r), (available ?r), (available ?r), (equipped_for_imaging ?r), (communicated_soil_data ?w), (equipped_for_soil_analysis ?r), (at ?r ?w), (have_rock_analysis ?r ?w), (communicated_rock_data ?w), (have_soil_analysis ?r ?w), (visible_from ?t ?w), (equipped_for_soil_analysis ?r), (at_soil_sample ?w), (calibrated ?i ?r), (equipped_for_imaging ?r), (visible_from ?t ?w), 
;; take_image action has changed: (at_rock_sample ?p), (at_soil_sample ?p), (visible_from ?o ?p), (on_board ?i ?r), (supports ?i ?m), (equipped_for_rock_analysis ?r), (at_rock_sample ?p), (on_board ?i ?r), (communicated_soil_data ?p), (at ?r ?p), (have_soil_analysis ?r ?p), (have_soil_analysis ?r ?p), (communicated_image_data ?o ?m), (available ?r), (available ?r), (at_soil_sample ?p), (have_rock_analysis ?r ?p), (communicated_rock_data ?p), (equipped_for_imaging ?r), (calibration_target ?i ?o), (have_rock_analysis ?r ?p), (calibrated ?i ?r), (equipped_for_imaging ?r), (have_image ?r ?o ?m), (equipped_for_rock_analysis ?r), (equipped_for_soil_analysis ?r), (have_image ?r ?o ?m), (communicated_image_data ?o ?m), (visible_from ?o ?p), (communicated_soil_data ?p), 
;; drop action has changed: (equipped_for_imaging ?x), (available ?x), (store_of ?y ?x), (full ?y), (empty ?y), (empty ?y), (equipped_for_soil_analysis ?x), (available ?x), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), 
;; Last_reduced_capability_num_dropped_pals: None

