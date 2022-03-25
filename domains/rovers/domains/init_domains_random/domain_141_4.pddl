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
			(not (at_rock_sample ?y))
			(can_traverse ?x ?z ?y)
			(at ?x ?y)
			(have_soil_analysis ?x ?y)
			(not (at_soil_sample ?z))
			(at_soil_sample ?y)
			(communicated_soil_data ?z)
			(communicated_rock_data ?z)
			(not (visible ?y ?z))
			(not (can_traverse ?x ?y ?z))
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (visible ?z ?y)
			(at ?x ?y)
			(communicated_soil_data ?z)
			(communicated_rock_data ?z)
			(not (visible ?y ?z))
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			(not (have_rock_analysis ?x ?y))
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(full ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(have_soil_analysis ?x ?p)
			(not (communicated_rock_data ?p))
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (available ?x)
			(at ?x ?p)
			(not (empty ?s))
			(full ?s)
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(have_soil_analysis ?x ?p)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(equipped_for_imaging ?x)
			(full ?s)
			(not (store_of ?s ?x))
			(at_rock_sample ?p)
			(have_soil_analysis ?x ?p)
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (at ?x ?p)
			(not (empty ?s))
			(full ?s)
			(store_of ?s ?x)
			(not (at_rock_sample ?p))
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
			(not (store_of ?y ?x))
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (not (available ?x))
			(empty ?y)
			(not (equipped_for_soil_analysis ?x))
			(not (full ?y))
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (available ?r)
			(not (equipped_for_imaging ?r))
			(at ?r ?w)
			(visible_from ?t ?w)
			(not (communicated_soil_data ?w))
			(communicated_rock_data ?w)
			(at_soil_sample ?w)
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(not (at ?r ?w))
			(not (visible_from ?t ?w))
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
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(visible_from ?o ?p)
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (communicated_image_data ?o ?m)
			(have_image ?r ?o ?m)
			(not (equipped_for_soil_analysis ?r))
			(equipped_for_imaging ?r)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (visible_from ?o ?p))
			(not (communicated_rock_data ?p))
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
               (channel_free ?l)
			(have_soil_analysis ?r ?x)
			(not (visible ?p ?x))
			(visible ?p ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(have_rock_analysis ?r ?p)
			(not (equipped_for_rock_analysis ?r))
			(can_traverse ?r ?y ?x)
			
          )
          :effect (and 
               (equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(communicated_rock_data ?x)
			(visible ?p ?x)
			(visible ?p ?y)
			(not (at ?r ?y))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(not (can_traverse ?r ?y ?x))
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
               (not (channel_free ?l))
			(visible ?y ?x)
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(available ?r)
			(at ?r ?x)
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(communicated_soil_data ?x)
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(have_rock_analysis ?r ?x)
			(not (at_lander ?l ?p))
			
          )
          :effect (and 
               (have_soil_analysis ?r ?x)
			(visible ?p ?x)
			(visible ?x ?y)
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(at_rock_sample ?p)
			(at ?r ?x)
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?y))
			(not (at_soil_sample ?y))
			(not (have_rock_analysis ?r ?x))
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
               (have_image ?r ?o ?m)
			(visible ?x ?y)
			(available ?r)
			(visible_from ?o ?x)
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(not (visible_from ?o ?y))
			(equipped_for_rock_analysis ?r)
			(communicated_image_data ?o ?m)
			
          )
         :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(not (have_image ?r ?o ?m))
			(can_traverse ?r ?x ?y)
			(at_rock_sample ?y)
			(not (visible_from ?o ?x))
			(not (have_rock_analysis ?r ?y))
			(visible_from ?o ?y)
			(not (equipped_for_rock_analysis ?r))
			(not (communicated_rock_data ?y))
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; navigate action has changed: (at_rock_sample ?y), (can_traverse ?x ?z ?y), (at ?x ?y), (equipped_for_soil_analysis ?x), (visible ?y ?z), (communicated_rock_data ?z), (have_rock_analysis ?x ?y), (can_traverse ?x ?y ?z), (communicated_soil_data ?z), (visible ?y ?z), (communicated_rock_data ?y), (at_soil_sample ?y), (can_traverse ?x ?y ?z), (visible ?z ?y), (communicated_soil_data ?z), (communicated_rock_data ?z), (at_soil_sample ?z), (have_soil_analysis ?x ?y), 
;; communicate_rock_data action has changed: (at ?r ?y), (communicated_soil_data ?y), (visible ?x ?y), (have_soil_analysis ?r ?x), (have_rock_analysis ?r ?x), (channel_free ?l), (can_traverse ?r ?x ?p), (can_traverse ?r ?y ?x), (at_rock_sample ?x), (communicated_rock_data ?p), (visible ?p ?y), (have_rock_analysis ?r ?x), (at_lander ?l ?p), (can_traverse ?r ?x ?y), (visible ?y ?x), (visible ?p ?x), (at ?r ?x), (at_soil_sample ?y), (visible ?x ?y), (at_rock_sample ?p), (at_lander ?l ?x), (communicated_soil_data ?x), (can_traverse ?r ?y ?p), (have_soil_analysis ?r ?p), (at_lander ?l ?y), (can_traverse ?r ?y ?p), 
;; sample_rock action has changed: (empty ?s), (have_rock_analysis ?x ?p), (equipped_for_imaging ?x), (at ?x ?p), (store_of ?s ?x), (communicated_soil_data ?p), (communicated_rock_data ?p), (full ?s), (have_soil_analysis ?x ?p), (equipped_for_rock_analysis ?x), (store_of ?s ?x), 
;; communicate_image_data action has changed: (visible_from ?o ?x), (have_image ?r ?o ?m), (equipped_for_soil_analysis ?r), (visible_from ?o ?y), (equipped_for_rock_analysis ?r), (equipped_for_rock_analysis ?r), (communicated_rock_data ?y), (communicated_image_data ?o ?m), (visible ?y ?x), (visible_from ?o ?y), (have_rock_analysis ?r ?y), (can_traverse ?r ?x ?y), (have_rock_analysis ?r ?y), (channel_free ?l), (communicated_image_data ?o ?m), (visible_from ?o ?x), (channel_free ?l), (equipped_for_imaging ?r), (at_rock_sample ?y), (communicated_soil_data ?x), (at_soil_sample ?x), 
;; communicate_soil_data action has changed: (equipped_for_rock_analysis ?r), (at ?r ?y), (equipped_for_rock_analysis ?r), (can_traverse ?r ?y ?x), (at_rock_sample ?p), (communicated_rock_data ?x), (visible ?p ?x), (visible ?p ?y), (visible ?p ?y), (have_soil_analysis ?r ?x), (visible ?p ?x), (equipped_for_imaging ?r), (have_rock_analysis ?r ?x), (visible ?x ?y), (at_lander ?l ?x), (can_traverse ?r ?y ?x), (can_traverse ?r ?p ?x), (visible ?x ?p), (at_soil_sample ?y), (communicated_soil_data ?x), (communicated_soil_data ?y), (have_rock_analysis ?r ?y), (at_soil_sample ?p), (visible ?y ?x), (have_rock_analysis ?r ?p), (at_soil_sample ?y), (equipped_for_soil_analysis ?r), (communicated_soil_data ?x), 
;; calibrate action has changed: (available ?r), (available ?r), (equipped_for_rock_analysis ?r), (calibrated ?i ?r), (communicated_rock_data ?w), (equipped_for_imaging ?r), (visible_from ?t ?w), (calibration_target ?i ?t), (at ?r ?w), (on_board ?i ?r), (communicated_soil_data ?w), (at_soil_sample ?w), 
;; sample_soil action has changed: (have_rock_analysis ?x ?p), (communicated_rock_data ?p), (empty ?s), (store_of ?s ?x), (full ?s), (have_soil_analysis ?x ?p), (equipped_for_soil_analysis ?x), (at ?x ?p), (available ?x), 
;; take_image action has changed: (communicated_rock_data ?p), (communicated_soil_data ?p), (at ?r ?p), (communicated_rock_data ?p), (equipped_for_imaging ?r), (equipped_for_soil_analysis ?r), (at_soil_sample ?p), (at_rock_sample ?p), (communicated_image_data ?o ?m), (visible_from ?o ?p), 
;; drop action has changed: (available ?x), (equipped_for_soil_analysis ?x), (full ?y), (equipped_for_imaging ?x), (available ?x), (store_of ?y ?x), 
;; Last_reduced_capability_num_dropped_pals: None

