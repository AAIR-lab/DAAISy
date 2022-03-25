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
               (available ?x)
			(not (equipped_for_imaging ?x))
			(not (at_rock_sample ?y))
			(can_traverse ?x ?z ?y)
			(at ?x ?y)
			(at_soil_sample ?z)
			(communicated_rock_data ?z)
			(not (have_rock_analysis ?x ?y))
			
          )
          :effect (and 
               (not (at_rock_sample ?z))
			(not (equipped_for_imaging ?x))
			(can_traverse ?x ?z ?y)
			(not (at ?x ?y))
			(have_soil_analysis ?x ?y)
			(communicated_soil_data ?z)
			(communicated_rock_data ?z)
			(not (communicated_soil_data ?y))
			(not (at ?x ?z))
			(not (have_rock_analysis ?x ?y))
			(not (equipped_for_soil_analysis ?x))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (at ?x ?p))
			(empty ?s)
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			(have_soil_analysis ?x ?p)
			(not (communicated_rock_data ?p))
			
          )
        :effect (and 
               (at ?x ?p)
			(empty ?s)
			(equipped_for_imaging ?x)
			(not (full ?s))
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(have_soil_analysis ?x ?p)
			(equipped_for_rock_analysis ?x)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(empty ?s)
			(full ?s)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			
          )
        :effect (and 
               (full ?s)
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_rock_data ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
			(store_of ?y ?x)
			(not (empty ?y))
			
          )
        :effect (and 
               (empty ?y)
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
			(not (have_soil_analysis ?r ?w))
			(equipped_for_imaging ?r)
			(not (at ?r ?w))
			(not (on_board ?i ?r))
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
			(not (communicated_soil_data ?w))
			(communicated_rock_data ?w)
			(at_soil_sample ?w)
			
          )
         :effect (and 
               (not (have_soil_analysis ?r ?w))
			(not (at ?r ?w))
			(not (equipped_for_soil_analysis ?r))
			(visible_from ?t ?w)
			(communicated_rock_data ?w)
			(not (at_soil_sample ?w))
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
			(not (have_soil_analysis ?r ?p))
			(equipped_for_rock_analysis ?r)
			(not (have_image ?r ?o ?m))
			(not (equipped_for_soil_analysis ?r))
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(visible_from ?o ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (not (supports ?i ?m))
			(equipped_for_rock_analysis ?r)
			(have_image ?r ?o ?m)
			(not (equipped_for_soil_analysis ?r))
			(not (at_rock_sample ?p))
			(communicated_rock_data ?p)
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
               (visible ?p ?x)
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?y ?x)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (equipped_for_imaging ?r))
			(not (communicated_rock_data ?x))
			(visible ?p ?y)
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(available ?r)
			(at_soil_sample ?p)
			(not (equipped_for_soil_analysis ?r))
			(not (communicated_soil_data ?x))
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
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
			(visible ?y ?x)
			(not (visible ?p ?x))
			(visible ?x ?y)
			(not (at ?r ?p))
			(available ?r)
			(at ?r ?x)
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?p)
			(have_rock_analysis ?r ?x)
			(not (communicated_soil_data ?p))
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(not (can_traverse ?r ?p ?y))
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (at_soil_sample ?p))
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(at_soil_sample ?y)
			(have_rock_analysis ?r ?x)
			(visible ?x ?p)
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
               (not (have_image ?r ?o ?m))
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(not (visible_from ?o ?x))
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(visible_from ?o ?y)
			
          )
         :effect (and 
               (communicated_rock_data ?x)
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(at ?r ?x)
			(at_lander ?l ?x)
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?x)
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; navigate action has changed: (have_rock_analysis ?x ?y), (at ?x ?z), (have_rock_analysis ?x ?y), (communicated_rock_data ?z), (communicated_rock_data ?z), (at_rock_sample ?y), (at_soil_sample ?z), (communicated_soil_data ?z), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (communicated_soil_data ?y), (visible ?y ?z), (can_traverse ?x ?y ?z), (have_soil_analysis ?x ?y), (can_traverse ?x ?z ?y), (at_rock_sample ?z), (can_traverse ?x ?z ?y), 
;; communicate_image_data action has changed: (at ?r ?x), (equipped_for_rock_analysis ?r), (channel_free ?l), (visible_from ?o ?y), (at_lander ?l ?x), (can_traverse ?r ?y ?x), (at_lander ?l ?x), (equipped_for_soil_analysis ?r), (can_traverse ?r ?x ?y), (at ?r ?x), (can_traverse ?r ?x ?y), (at_soil_sample ?x), (have_image ?r ?o ?m), (communicated_rock_data ?x), (equipped_for_soil_analysis ?r), (at_rock_sample ?x), (at ?r ?y), (have_rock_analysis ?r ?y), (at ?r ?y), (communicated_rock_data ?x), (visible_from ?o ?x), 
;; calibrate action has changed: (at ?r ?w), (equipped_for_soil_analysis ?r), (communicated_rock_data ?w), (equipped_for_rock_analysis ?r), (communicated_soil_data ?w), (at_soil_sample ?w), (have_rock_analysis ?r ?w), (have_soil_analysis ?r ?w), (at_soil_sample ?w), (visible_from ?t ?w), (have_soil_analysis ?r ?w), (communicated_rock_data ?w), (on_board ?i ?r), (equipped_for_soil_analysis ?r), (at ?r ?w), 
;; take_image action has changed: (at_rock_sample ?p), (equipped_for_rock_analysis ?r), (equipped_for_rock_analysis ?r), (communicated_rock_data ?p), (at_rock_sample ?p), (have_image ?r ?o ?m), (at_soil_sample ?p), (equipped_for_soil_analysis ?r), (equipped_for_soil_analysis ?r), (supports ?i ?m), (have_soil_analysis ?r ?p), 
;; sample_soil action has changed: (have_soil_analysis ?x ?p), (at ?x ?p), (full ?s), (empty ?s), (equipped_for_imaging ?x), (store_of ?s ?x), (at ?x ?p), (equipped_for_rock_analysis ?x), (communicated_rock_data ?p), (store_of ?s ?x), (at_rock_sample ?p), 
;; communicate_rock_data action has changed: (have_rock_analysis ?r ?x), (communicated_rock_data ?p), (have_soil_analysis ?r ?y), (at_lander ?l ?y), (at ?r ?p), (at ?r ?y), (communicated_rock_data ?y), (visible ?p ?x), (can_traverse ?r ?p ?y), (at_soil_sample ?p), (visible ?x ?y), (at_soil_sample ?y), (communicated_rock_data ?y), (communicated_soil_data ?p), (can_traverse ?r ?y ?p), (at_lander ?l ?y), (have_rock_analysis ?r ?x), (at ?r ?p), (have_soil_analysis ?r ?x), (communicated_rock_data ?x), (can_traverse ?r ?y ?p), (at_lander ?l ?x), (visible ?x ?p), (visible ?y ?x), (at_lander ?l ?x), 
;; sample_rock action has changed: (have_rock_analysis ?x ?p), (equipped_for_soil_analysis ?x), (empty ?s), (equipped_for_rock_analysis ?x), (communicated_rock_data ?p), (equipped_for_soil_analysis ?x), (full ?s), 
;; drop action has changed: (equipped_for_imaging ?x), (full ?y), (empty ?y), (available ?x), 
;; communicate_soil_data action has changed: (can_traverse ?r ?y ?p), (available ?r), (can_traverse ?r ?x ?y), (equipped_for_soil_analysis ?r), (equipped_for_soil_analysis ?r), (at_soil_sample ?p), (at ?r ?x), (at ?r ?p), (communicated_soil_data ?x), (visible ?x ?y), (at_lander ?l ?x), (channel_free ?l), (visible ?p ?x), (equipped_for_imaging ?r), (at_soil_sample ?y), (at_rock_sample ?x), (visible ?x ?y), (at ?r ?y), (can_traverse ?r ?y ?x), (visible ?p ?y), (have_rock_analysis ?r ?x), (communicated_soil_data ?y), (have_soil_analysis ?r ?y), (equipped_for_rock_analysis ?r), (communicated_rock_data ?x), (can_traverse ?r ?p ?x), (visible ?x ?p), (communicated_soil_data ?y), (visible ?y ?p), 
;; Last_reduced_capability_num_dropped_pals: None

