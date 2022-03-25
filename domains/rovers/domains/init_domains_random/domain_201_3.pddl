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
			(visible ?z ?y)
			(not (at ?x ?y))
			(at_soil_sample ?z)
			(at_soil_sample ?y)
			(equipped_for_rock_analysis ?x)
			(can_traverse ?x ?y ?z)
			(equipped_for_soil_analysis ?x)
			
          )
          :effect (and 
               (visible ?z ?y)
			(not (at_rock_sample ?y))
			(not (can_traverse ?x ?z ?y))
			(not (at ?x ?y))
			(not (have_soil_analysis ?x ?y))
			(communicated_soil_data ?z)
			(communicated_rock_data ?z)
			(visible ?y ?z)
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			(not (have_soil_analysis ?x ?z))
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (at ?x ?p))
			(empty ?s)
			(equipped_for_imaging ?x)
			(store_of ?s ?x)
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			
          )
        :effect (and 
               (at ?x ?p)
			(not (empty ?s))
			(full ?s)
			(not (at_soil_sample ?p))
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			(not (communicated_rock_data ?p))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(full ?s)
			(not (store_of ?s ?x))
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (at ?x ?p))
			(not (empty ?s))
			(full ?s)
			(store_of ?s ?x)
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (available ?x))
			(store_of ?y ?x)
			(not (equipped_for_imaging ?x))
			
          )
        :effect (and 
               (available ?x)
			(equipped_for_rock_analysis ?x)
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
               (calibration_target ?i ?t)
			(not (equipped_for_rock_analysis ?r))
			(available ?r)
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(at_rock_sample ?w)
			(not (equipped_for_soil_analysis ?r))
			(visible_from ?t ?w)
			(have_rock_analysis ?r ?w)
			(communicated_rock_data ?w)
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (available ?r)
			(equipped_for_imaging ?r)
			(not (on_board ?i ?r))
			(not (have_rock_analysis ?r ?w))
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
			(communicated_image_data ?o ?m)
			(have_soil_analysis ?r ?p)
			(not (equipped_for_rock_analysis ?r))
			(equipped_for_soil_analysis ?r)
			(have_rock_analysis ?r ?p)
			(not (at_soil_sample ?p))
			(not (visible_from ?o ?p))
			(not (communicated_soil_data ?p))
			(not (communicated_rock_data ?p))
			
          )
          :effect (and 
               (communicated_image_data ?o ?m)
			(not (have_soil_analysis ?r ?p))
			(not (on_board ?i ?r))
			(have_rock_analysis ?r ?p)
			(at_rock_sample ?p)
			(visible_from ?o ?p)
			(communicated_soil_data ?p)
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
               (channel_free ?l)
			(visible ?y ?x)
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(visible ?p ?y)
			(visible ?x ?y)
			(not (can_traverse ?r ?p ?y))
			(not (have_soil_analysis ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(have_rock_analysis ?r ?y)
			(not (communicated_soil_data ?x))
			(have_rock_analysis ?r ?p)
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(communicated_rock_data ?x)
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(at ?r ?p)
			(have_soil_analysis ?r ?p)
			(at_rock_sample ?y)
			(not (at_rock_sample ?p))
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?y))
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(not (equipped_for_rock_analysis ?r))
			(visible ?x ?p)
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			
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
			(not (equipped_for_imaging ?r))
			(not (have_soil_analysis ?r ?x))
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(communicated_soil_data ?x)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(not (communicated_soil_data ?p))
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(have_soil_analysis ?r ?x)
			(visible ?p ?x)
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at_rock_sample ?y))
			(not (at_rock_sample ?p))
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?x)
			(not (at_soil_sample ?y))
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?y ?p))
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
               (equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_image ?r ?o ?m)
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(have_soil_analysis ?r ?y)
			(not (available ?r))
			(at_rock_sample ?y)
			(not (visible_from ?o ?x))
			(at_lander ?l ?y)
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (communicated_soil_data ?y))
			(visible_from ?o ?y)
			(not (equipped_for_rock_analysis ?r))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			
          )
         :effect (and 
               (channel_free ?l)
			(communicated_rock_data ?x)
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (at ?r ?x))
			(not (at_lander ?l ?y))
			(not (have_rock_analysis ?r ?y))
			(at_soil_sample ?x)
			(visible_from ?o ?y)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_soil_data action has changed: (visible ?y ?x), (equipped_for_rock_analysis ?r), (can_traverse ?r ?y ?p), (communicated_soil_data ?p), (communicated_soil_data ?y), (equipped_for_imaging ?r), (have_soil_analysis ?r ?x), (communicated_rock_data ?x), (have_rock_analysis ?r ?x), (at_lander ?l ?y), (available ?r), (equipped_for_rock_analysis ?r), (at_rock_sample ?p), (at_soil_sample ?p), (at_soil_sample ?x), (at_lander ?l ?y), (communicated_rock_data ?p), (have_soil_analysis ?r ?p), (at_rock_sample ?p), (can_traverse ?r ?x ?y), (at_lander ?l ?p), (have_rock_analysis ?r ?p), (channel_free ?l), (communicated_rock_data ?x), (visible ?x ?y), (have_soil_analysis ?r ?y), (visible ?p ?y), (communicated_soil_data ?x), (communicated_rock_data ?p), (can_traverse ?r ?y ?p), (at ?r ?p), (visible ?p ?y), (can_traverse ?r ?y ?x), (can_traverse ?r ?p ?x), (visible ?y ?p), (have_rock_analysis ?r ?x), (have_rock_analysis ?r ?y), (can_traverse ?r ?p ?y), (visible ?x ?p), (communicated_soil_data ?p), (at_rock_sample ?x), (communicated_soil_data ?x), (at_rock_sample ?y), 
;; sample_soil action has changed: (at ?x ?p), (at ?x ?p), (communicated_soil_data ?p), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (at_rock_sample ?p), (communicated_soil_data ?p), (at_soil_sample ?p), (communicated_rock_data ?p), (have_rock_analysis ?x ?p), (communicated_rock_data ?p), 
;; drop action has changed: (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (empty ?y), (full ?y), (equipped_for_imaging ?x), (equipped_for_imaging ?x), (available ?x), (available ?x), 
;; communicate_rock_data action has changed: (communicated_soil_data ?x), (at_lander ?l ?y), (visible ?x ?y), (can_traverse ?r ?x ?p), (visible ?y ?p), (have_rock_analysis ?r ?p), (at_soil_sample ?x), (can_traverse ?r ?p ?y), (at_soil_sample ?p), (can_traverse ?r ?y ?x), (have_rock_analysis ?r ?x), (can_traverse ?r ?y ?p), (at_rock_sample ?y), (equipped_for_rock_analysis ?r), (equipped_for_soil_analysis ?r), (communicated_soil_data ?p), (at_rock_sample ?x), (at_lander ?l ?p), (equipped_for_imaging ?r), (visible ?p ?x), (visible ?p ?y), (have_soil_analysis ?r ?x), (communicated_soil_data ?y), (communicated_soil_data ?y), (have_soil_analysis ?r ?p), (can_traverse ?r ?x ?y), (available ?r), (can_traverse ?r ?p ?x), (at_rock_sample ?p), (at_rock_sample ?p), (channel_free ?l), (visible ?x ?y), (at_soil_sample ?y), (at ?r ?x), (visible ?p ?y), (at_rock_sample ?y), (visible ?y ?p), (at_lander ?l ?x), (communicated_soil_data ?p), (channel_free ?l), (have_soil_analysis ?r ?x), (at ?r ?p), (have_rock_analysis ?r ?y), (can_traverse ?r ?x ?y), 
;; take_image action has changed: (have_soil_analysis ?r ?p), (communicated_image_data ?o ?m), (have_rock_analysis ?r ?p), (on_board ?i ?r), (communicated_rock_data ?p), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?p), (at ?r ?p), (at_rock_sample ?p), (at_soil_sample ?p), (on_board ?i ?r), (equipped_for_soil_analysis ?r), (communicated_image_data ?o ?m), (communicated_soil_data ?p), (communicated_soil_data ?p), (equipped_for_imaging ?r), (visible_from ?o ?p), (have_image ?r ?o ?m), (visible_from ?o ?p), (have_rock_analysis ?r ?p), (calibrated ?i ?r), 
;; sample_rock action has changed: (communicated_rock_data ?p), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?p), (at ?x ?p), (full ?s), (communicated_soil_data ?p), (store_of ?s ?x), (empty ?s), (at_rock_sample ?p), (equipped_for_soil_analysis ?x), (store_of ?s ?x), (have_rock_analysis ?x ?p), 
;; calibrate action has changed: (communicated_rock_data ?w), (available ?r), (calibrated ?i ?r), (have_rock_analysis ?r ?w), (at_rock_sample ?w), (equipped_for_imaging ?r), (equipped_for_soil_analysis ?r), (available ?r), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?w), (on_board ?i ?r), (on_board ?i ?r), 
;; navigate action has changed: (visible ?y ?z), (at_rock_sample ?y), (communicated_soil_data ?z), (visible ?y ?z), (at_rock_sample ?z), (at_soil_sample ?z), (can_traverse ?x ?z ?y), (available ?x), (equipped_for_rock_analysis ?x), (equipped_for_rock_analysis ?x), (can_traverse ?x ?y ?z), (communicated_rock_data ?z), (visible ?z ?y), (equipped_for_soil_analysis ?x), (at ?x ?y), (at_soil_sample ?y), (have_soil_analysis ?x ?y), (equipped_for_soil_analysis ?x), (have_soil_analysis ?x ?z), (visible ?z ?y), 
;; communicate_image_data action has changed: (at ?r ?x), (have_soil_analysis ?r ?x), (at_soil_sample ?x), (visible ?y ?x), (have_soil_analysis ?r ?y), (channel_free ?l), (at_rock_sample ?x), (visible_from ?o ?x), (communicated_rock_data ?x), (communicated_soil_data ?x), (visible ?x ?y), (at_soil_sample ?y), (communicated_rock_data ?y), (communicated_rock_data ?x), (available ?r), (have_rock_analysis ?r ?y), (can_traverse ?r ?x ?y), (channel_free ?l), (equipped_for_imaging ?r), (have_soil_analysis ?r ?y), (at ?r ?x), (at_lander ?l ?y), (visible_from ?o ?y), (equipped_for_rock_analysis ?r), (visible ?x ?y), (can_traverse ?r ?y ?x), (at_soil_sample ?x), (visible_from ?o ?y), (at_rock_sample ?y), (communicated_soil_data ?y), 
;; Last_reduced_capability_num_dropped_pals: None

