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
			(not (available ?x))
			(not (equipped_for_imaging ?x))
			(at ?x ?y)
			(not (have_soil_analysis ?x ?y))
			(at_soil_sample ?z)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?z))
			(visible ?y ?z)
			(equipped_for_rock_analysis ?x)
			(can_traverse ?x ?y ?z)
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (at_rock_sample ?z)
			(have_rock_analysis ?x ?z)
			(not (available ?x))
			(can_traverse ?x ?z ?y)
			(not (at ?x ?y))
			(not (at_soil_sample ?z))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?y)
			(at ?x ?z)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(not (empty ?s))
			(not (full ?s))
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (available ?x)
			(not (at ?x ?p))
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(not (full ?s))
			(store_of ?s ?x)
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(have_soil_analysis ?x ?p)
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(at ?x ?p)
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(not (store_of ?s ?x))
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (at ?x ?p))
			(empty ?s)
			(equipped_for_imaging ?x)
			(not (store_of ?s ?x))
			(not (at_rock_sample ?p))
			(not (equipped_for_rock_analysis ?x))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (available ?x))
			(store_of ?y ?x)
			(equipped_for_rock_analysis ?x)
			(full ?y)
			
          )
        :effect (and 
               (not (store_of ?y ?x))
			(empty ?y)
			(equipped_for_rock_analysis ?x)
			(equipped_for_soil_analysis ?x)
			(not (full ?y))
			
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
			(not (equipped_for_imaging ?r))
			(at ?r ?w)
			(on_board ?i ?r)
			(visible_from ?t ?w)
			(not (communicated_soil_data ?w))
			
          )
         :effect (and 
               (at ?r ?w)
			(not (on_board ?i ?r))
			(have_rock_analysis ?r ?w)
			(communicated_soil_data ?w)
			
          )
    )  
    
    (:action take_image
         :parameters (?r - rover 
                      ?p - waypoint 
                      ?o - objective 
                      ?i - camera 
                      ?m - mode)
         :precondition (and 
               (not (have_image ?r ?o ?m))
			(equipped_for_soil_analysis ?r)
			(equipped_for_imaging ?r)
			(not (on_board ?i ?r))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (communicated_soil_data ?p))
			(communicated_rock_data ?p)
			(not (calibrated ?i ?r))
			(at ?r ?p)
			
          )
          :effect (and 
               (have_soil_analysis ?r ?p)
			(not (equipped_for_rock_analysis ?r))
			(available ?r)
			(have_image ?r ?o ?m)
			(not (equipped_for_soil_analysis ?r))
			(have_rock_analysis ?r ?p)
			(at_rock_sample ?p)
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
			(not (visible ?x ?y))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_rock_sample ?p)
			(not (communicated_rock_data ?p))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			
          )
          :effect (and 
               (equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(at_rock_sample ?x)
			(not (can_traverse ?r ?p ?y))
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(not (can_traverse ?r ?y ?p))
			(not (have_rock_analysis ?r ?y))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(have_rock_analysis ?r ?x)
			(communicated_soil_data ?p)
			(not (visible ?y ?p))
			
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
			(communicated_rock_data ?x)
			(not (visible ?p ?y))
			(available ?r)
			(at_soil_sample ?p)
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(at_lander ?l ?y)
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?p))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (available ?r))
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(communicated_soil_data ?x)
			(at_lander ?l ?p)
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
			(have_image ?r ?o ?m)
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(visible ?x ?y)
			(not (at ?r ?y))
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (at_soil_sample ?y))
			(not (at_soil_sample ?x))
			(equipped_for_rock_analysis ?r)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			
          )
         :effect (and 
               (equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(not (visible ?x ?y))
			(have_soil_analysis ?r ?y)
			(not (at_rock_sample ?y))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; sample_soil action has changed: (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?p), (have_rock_analysis ?x ?p), (equipped_for_soil_analysis ?x), (at_soil_sample ?p), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (store_of ?s ?x), (empty ?s), (at_rock_sample ?p), (full ?s), (communicated_rock_data ?p), (full ?s), (at ?x ?p), (available ?x), (equipped_for_soil_analysis ?x), 
;; communicate_soil_data action has changed: (visible ?y ?x), (can_traverse ?r ?y ?p), (can_traverse ?r ?x ?y), (at_soil_sample ?x), (at_soil_sample ?y), (at_lander ?l ?p), (visible ?x ?y), (communicated_soil_data ?x), (visible ?y ?p), (can_traverse ?r ?x ?p), (have_soil_analysis ?r ?p), (at_rock_sample ?x), (communicated_rock_data ?p), (have_rock_analysis ?r ?y), (equipped_for_imaging ?r), (available ?r), (can_traverse ?r ?y ?x), (at_rock_sample ?p), (communicated_soil_data ?y), (communicated_soil_data ?x), (at_lander ?l ?x), (can_traverse ?r ?x ?y), (have_rock_analysis ?r ?x), (have_rock_analysis ?r ?p), (at ?r ?x), (at ?r ?y), (can_traverse ?r ?p ?y), (have_rock_analysis ?r ?p), (communicated_soil_data ?p), (visible ?y ?p), 
;; sample_rock action has changed: (empty ?s), (store_of ?s ?x), (available ?x), (equipped_for_imaging ?x), (equipped_for_imaging ?x), (have_rock_analysis ?x ?p), (at ?x ?p), (equipped_for_rock_analysis ?x), (store_of ?s ?x), (have_rock_analysis ?x ?p), (equipped_for_soil_analysis ?x), (full ?s), (empty ?s), 
;; navigate action has changed: (at_soil_sample ?z), (at_rock_sample ?z), (at_rock_sample ?z), (communicated_soil_data ?y), (equipped_for_imaging ?x), (at_soil_sample ?y), (at_soil_sample ?z), (equipped_for_rock_analysis ?x), (communicated_rock_data ?y), (have_rock_analysis ?x ?z), (available ?x), (have_soil_analysis ?x ?y), (at_soil_sample ?y), (communicated_soil_data ?z), (can_traverse ?x ?z ?y), (available ?x), 
;; calibrate action has changed: (calibrated ?i ?r), (have_soil_analysis ?r ?w), (equipped_for_imaging ?r), (communicated_soil_data ?w), (communicated_soil_data ?w), (at ?r ?w), (have_rock_analysis ?r ?w), (on_board ?i ?r), 
;; take_image action has changed: (at_rock_sample ?p), (visible_from ?o ?p), (at_soil_sample ?p), (supports ?i ?m), (available ?r), (calibrated ?i ?r), (communicated_soil_data ?p), (have_rock_analysis ?r ?p), (equipped_for_rock_analysis ?r), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?p), (equipped_for_soil_analysis ?r), (communicated_rock_data ?p), (have_image ?r ?o ?m), (at_rock_sample ?p), (on_board ?i ?r), 
;; communicate_rock_data action has changed: (available ?r), (at_lander ?l ?p), (communicated_soil_data ?p), (at_soil_sample ?p), (have_soil_analysis ?r ?y), (at_rock_sample ?x), (communicated_rock_data ?p), (visible ?x ?y), (visible ?x ?y), (equipped_for_imaging ?r), (equipped_for_imaging ?r), (communicated_rock_data ?x), (visible ?y ?p), (at ?r ?y), (have_rock_analysis ?r ?y), (communicated_rock_data ?y), (visible ?p ?y), (equipped_for_soil_analysis ?r), (channel_free ?l), (at_soil_sample ?x), (communicated_soil_data ?x), (communicated_rock_data ?p), 
;; communicate_image_data action has changed: (at_lander ?l ?x), (equipped_for_rock_analysis ?r), (channel_free ?l), (communicated_rock_data ?y), (at_soil_sample ?x), (visible ?y ?x), (at_rock_sample ?y), (have_soil_analysis ?r ?y), (at_soil_sample ?y), (communicated_rock_data ?x), (have_soil_analysis ?r ?x), (visible ?x ?y), (can_traverse ?r ?y ?x), (at ?r ?y), (equipped_for_imaging ?r), 
;; drop action has changed: (available ?x), (equipped_for_rock_analysis ?x), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (store_of ?y ?x), 
;; Last_reduced_capability_num_dropped_pals: None

