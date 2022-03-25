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
			(available ?x)
			(visible ?z ?y)
			(at ?x ?y)
			(at_soil_sample ?y)
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			
          )
          :effect (and 
               (equipped_for_imaging ?x)
			(not (at_rock_sample ?y))
			(not (at ?x ?y))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?z))
			(not (communicated_rock_data ?z))
			(communicated_soil_data ?y)
			(not (equipped_for_rock_analysis ?x))
			(at ?x ?z)
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(at ?x ?p)
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (communicated_soil_data ?p))
			(not (have_soil_analysis ?x ?p))
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (equipped_for_imaging ?x))
			(full ?s)
			(not (at_soil_sample ?p))
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(not (communicated_rock_data ?p))
			
          )
        :effect (and 
               (not (empty ?s))
			(equipped_for_imaging ?x)
			(full ?s)
			(not (at_rock_sample ?p))
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
			(equipped_for_soil_analysis ?x)
			(not (full ?y))
			
          )
        :effect (and 
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
			(available ?r)
			(not (equipped_for_imaging ?r))
			(not (at ?r ?w))
			(on_board ?i ?r)
			(at_rock_sample ?w)
			(visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
			(not (communicated_soil_data ?w))
			(not (communicated_rock_data ?w))
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (not (at_rock_sample ?w))
			(equipped_for_soil_analysis ?r)
			(not (communicated_rock_data ?w))
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
               (supports ?i ?m)
			(not (communicated_image_data ?o ?m))
			(not (equipped_for_rock_analysis ?r))
			(not (have_image ?r ?o ?m))
			(equipped_for_soil_analysis ?r)
			(on_board ?i ?r)
			(not (have_rock_analysis ?r ?p))
			(not (at_soil_sample ?p))
			(visible_from ?o ?p)
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
			(calibrated ?i ?r)
			(not (at ?r ?p))
			
          )
          :effect (and 
               (not (have_soil_analysis ?r ?p))
			(available ?r)
			(have_image ?r ?o ?m)
			(calibration_target ?i ?o)
			(not (communicated_rock_data ?p))
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
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(not (visible ?x ?y))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(at_lander ?l ?x)
			(equipped_for_soil_analysis ?r)
			(communicated_soil_data ?x)
			(not (have_rock_analysis ?r ?p))
			(have_rock_analysis ?r ?x)
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(can_traverse ?r ?y ?x)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (channel_free ?l)
			(visible ?x ?y)
			(at_rock_sample ?x)
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(not (at_rock_sample ?p))
			(at_lander ?l ?x)
			(not (at_soil_sample ?x))
			(communicated_soil_data ?y)
			(not (communicated_soil_data ?p))
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
               (channel_free ?l)
			(not (visible ?p ?x))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (have_soil_analysis ?r ?y))
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(not (at_rock_sample ?y))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (channel_free ?l)
			(communicated_rock_data ?x)
			(visible ?p ?y)
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_soil_sample ?p)
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (can_traverse ?r ?x ?p))
			
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
			(have_image ?r ?o ?m)
			(not (have_soil_analysis ?r ?x))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(available ?r)
			(visible_from ?o ?x)
			(not (at_lander ?l ?x))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(communicated_soil_data ?y)
			(equipped_for_rock_analysis ?r)
			(communicated_image_data ?o ?m)
			
          )
         :effect (and 
               (channel_free ?l)
			(not (communicated_rock_data ?x))
			(not (at_rock_sample ?x))
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(available ?r)
			(visible_from ?o ?x)
			(not (at_lander ?l ?y))
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(communicated_soil_data ?y)
			(have_rock_analysis ?r ?x)
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; sample_rock action has changed: (communicated_rock_data ?p), (communicated_rock_data ?p), (equipped_for_imaging ?x), (equipped_for_imaging ?x), (have_soil_analysis ?x ?p), (at_soil_sample ?p), (communicated_soil_data ?p), (empty ?s), (have_soil_analysis ?x ?p), (equipped_for_rock_analysis ?x), (equipped_for_rock_analysis ?x), 
;; navigate action has changed: (equipped_for_imaging ?x), (at_rock_sample ?z), (communicated_soil_data ?y), (communicated_rock_data ?z), (visible ?z ?y), (at_soil_sample ?y), (equipped_for_rock_analysis ?x), (at ?x ?z), (at_rock_sample ?y), (equipped_for_soil_analysis ?x), (visible ?y ?z), (communicated_soil_data ?z), (at_soil_sample ?y), (have_rock_analysis ?x ?z), 
;; communicate_rock_data action has changed: (can_traverse ?r ?y ?p), (can_traverse ?r ?y ?x), (visible ?y ?p), (have_soil_analysis ?r ?p), (communicated_rock_data ?x), (have_soil_analysis ?r ?y), (visible ?p ?x), (communicated_rock_data ?p), (communicated_soil_data ?y), (at_lander ?l ?x), (at_rock_sample ?y), (have_soil_analysis ?r ?y), (at_lander ?l ?y), (communicated_rock_data ?y), (have_rock_analysis ?r ?y), (have_rock_analysis ?r ?x), (at_soil_sample ?x), (channel_free ?l), (equipped_for_soil_analysis ?r), (available ?r), (available ?r), (communicated_rock_data ?p), (at ?r ?p), (can_traverse ?r ?x ?p), (have_soil_analysis ?r ?p), (communicated_soil_data ?p), (at_soil_sample ?y), (visible ?p ?y), (visible ?x ?p), (communicated_soil_data ?x), (can_traverse ?r ?y ?p), (at_soil_sample ?p), (at_rock_sample ?x), (equipped_for_rock_analysis ?r), 
;; sample_soil action has changed: (store_of ?s ?x), (equipped_for_rock_analysis ?x), (empty ?s), (communicated_soil_data ?p), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (at_soil_sample ?p), (available ?x), (equipped_for_imaging ?x), (at_rock_sample ?p), (communicated_soil_data ?p), (have_soil_analysis ?x ?p), 
;; calibrate action has changed: (available ?r), (have_rock_analysis ?r ?w), (at_rock_sample ?w), (calibrated ?i ?r), (equipped_for_soil_analysis ?r), (calibrated ?i ?r), (communicated_rock_data ?w), (at_rock_sample ?w), (communicated_soil_data ?w), (at ?r ?w), (have_soil_analysis ?r ?w), (communicated_rock_data ?w), (equipped_for_imaging ?r), 
;; drop action has changed: (full ?y), (store_of ?y ?x), (available ?x), (equipped_for_soil_analysis ?x), (empty ?y), 
;; communicate_image_data action has changed: (channel_free ?l), (communicated_soil_data ?x), (visible_from ?o ?x), (at ?r ?x), (communicated_soil_data ?y), (at_rock_sample ?x), (communicated_image_data ?o ?m), (have_soil_analysis ?r ?x), (communicated_soil_data ?x), (visible ?y ?x), (communicated_image_data ?o ?m), (at_lander ?l ?y), (communicated_soil_data ?y), (equipped_for_rock_analysis ?r), (can_traverse ?r ?x ?y), (have_rock_analysis ?r ?y), (at_rock_sample ?x), (at_lander ?l ?y), (at_soil_sample ?y), (channel_free ?l), (have_rock_analysis ?r ?x), (equipped_for_soil_analysis ?r), (visible_from ?o ?x), (at_lander ?l ?x), (communicated_rock_data ?x), (available ?r), (at ?r ?y), (at_soil_sample ?y), 
;; communicate_soil_data action has changed: (communicated_soil_data ?p), (visible ?x ?p), (channel_free ?l), (at_lander ?l ?y), (communicated_rock_data ?p), (can_traverse ?r ?p ?x), (equipped_for_imaging ?r), (communicated_soil_data ?y), (equipped_for_soil_analysis ?r), (visible ?x ?y), (have_rock_analysis ?r ?p), (can_traverse ?r ?y ?x), (can_traverse ?r ?x ?y), (at ?r ?x), (at_rock_sample ?x), (at_soil_sample ?x), (equipped_for_rock_analysis ?r), (can_traverse ?r ?x ?y), (visible ?x ?y), (communicated_rock_data ?y), (at_rock_sample ?p), (at ?r ?p), (communicated_soil_data ?x), (at_lander ?l ?x), (can_traverse ?r ?p ?x), (at_lander ?l ?x), (have_rock_analysis ?r ?x), (visible ?y ?x), (have_soil_analysis ?r ?y), (have_soil_analysis ?r ?x), 
;; take_image action has changed: (have_soil_analysis ?r ?p), (at_soil_sample ?p), (equipped_for_soil_analysis ?r), (available ?r), (communicated_rock_data ?p), (equipped_for_rock_analysis ?r), (equipped_for_imaging ?r), (communicated_rock_data ?p), (calibration_target ?i ?o), (have_rock_analysis ?r ?p), (have_image ?r ?o ?m), (communicated_image_data ?o ?m), (at ?r ?p), (communicated_soil_data ?p), 
;; Last_reduced_capability_num_dropped_pals: None

