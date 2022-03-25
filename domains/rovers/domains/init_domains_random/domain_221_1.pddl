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
			(available ?x)
			(not (visible ?z ?y))
			(at_rock_sample ?y)
			(not (at ?x ?y))
			(not (have_soil_analysis ?x ?y))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?z))
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			(have_rock_analysis ?x ?y)
			(communicated_rock_data ?y)
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (at_rock_sample ?z)
			(not (have_rock_analysis ?x ?z))
			(available ?x)
			(not (can_traverse ?x ?z ?y))
			(at_soil_sample ?z)
			(not (communicated_soil_data ?y))
			(equipped_for_rock_analysis ?x)
			(at ?x ?z)
			(communicated_rock_data ?y)
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(full ?s)
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (communicated_soil_data ?p))
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (available ?x)
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (empty ?s)
			(full ?s)
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (communicated_soil_data ?p))
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			
          )
        :effect (and 
               (not (empty ?s))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(have_soil_analysis ?x ?p)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (available ?x))
			(not (equipped_for_rock_analysis ?x))
			(equipped_for_soil_analysis ?x)
			(full ?y)
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (available ?x)
			(store_of ?y ?x)
			(not (equipped_for_rock_analysis ?x))
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (calibration_target ?i ?t)
			(have_soil_analysis ?r ?w)
			(equipped_for_imaging ?r)
			(not (at ?r ?w))
			(not (on_board ?i ?r))
			(at_rock_sample ?w)
			(have_rock_analysis ?r ?w)
			(communicated_soil_data ?w)
			(not (communicated_rock_data ?w))
			
          )
         :effect (and 
               (not (equipped_for_rock_analysis ?r))
			(not (at ?r ?w))
			(at_rock_sample ?w)
			(not (equipped_for_soil_analysis ?r))
			(not (visible_from ?t ?w))
			(not (communicated_rock_data ?w))
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
               (supports ?i ?m)
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(not (equipped_for_imaging ?r))
			(have_rock_analysis ?r ?p)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (communicated_rock_data ?p))
			(at ?r ?p)
			
          )
          :effect (and 
               (communicated_image_data ?o ?m)
			(equipped_for_rock_analysis ?r)
			(have_image ?r ?o ?m)
			(not (calibration_target ?i ?o))
			(equipped_for_soil_analysis ?r)
			(equipped_for_imaging ?r)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(communicated_soil_data ?p)
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
               (not (channel_free ?l))
			(visible ?y ?x)
			(not (visible ?p ?x))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(at_soil_sample ?p)
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(visible ?y ?p)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (equipped_for_imaging ?r)
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(at_rock_sample ?x)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(can_traverse ?r ?y ?p)
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
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
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(available ?r)
			(not (at_rock_sample ?y))
			(at ?r ?x)
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(communicated_soil_data ?x)
			(have_rock_analysis ?r ?p)
			(not (have_rock_analysis ?r ?x))
			(visible ?x ?p)
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (not (equipped_for_imaging ?r))
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (available ?r))
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(not (at_soil_sample ?x))
			(can_traverse ?r ?x ?p)
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
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
               (channel_free ?l)
			(visible ?y ?x)
			(not (have_image ?r ?o ?m))
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(not (at ?r ?y))
			(not (at ?r ?x))
			(not (at_lander ?l ?x))
			(at_soil_sample ?x)
			(not (communicated_soil_data ?y))
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			(communicated_rock_data ?y)
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(not (communicated_rock_data ?x))
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (available ?r))
			(visible_from ?o ?x)
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			(not (communicated_rock_data ?y))
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (at_lander ?l ?y), (communicated_rock_data ?x), (have_soil_analysis ?r ?y), (channel_free ?l), (at_soil_sample ?x), (can_traverse ?r ?x ?p), (at_lander ?l ?y), (available ?r), (communicated_rock_data ?x), (visible ?x ?p), (at_lander ?l ?x), (equipped_for_imaging ?r), (at_rock_sample ?y), (have_rock_analysis ?r ?y), (at_lander ?l ?p), (at_soil_sample ?y), (visible ?p ?y), (communicated_rock_data ?y), (have_soil_analysis ?r ?y), (communicated_rock_data ?y), (equipped_for_imaging ?r), (at ?r ?p), (at ?r ?x), (equipped_for_soil_analysis ?r), (communicated_soil_data ?x), (visible ?p ?y), (at_rock_sample ?x), (can_traverse ?r ?x ?y), (communicated_soil_data ?p), (at ?r ?p), (visible ?y ?p), (have_soil_analysis ?r ?x), (have_rock_analysis ?r ?y), (can_traverse ?r ?y ?p), (visible ?x ?y), (have_rock_analysis ?r ?x), (visible ?y ?x), (have_soil_analysis ?r ?x), (can_traverse ?r ?p ?x), (communicated_rock_data ?p), (visible ?x ?y), (equipped_for_rock_analysis ?r), (can_traverse ?r ?y ?x), (visible ?p ?x), 
;; communicate_soil_data action has changed: (equipped_for_rock_analysis ?r), (at_rock_sample ?x), (have_soil_analysis ?r ?p), (can_traverse ?r ?p ?x), (at ?r ?y), (at_soil_sample ?p), (equipped_for_imaging ?r), (have_soil_analysis ?r ?p), (communicated_soil_data ?x), (at_rock_sample ?x), (at_soil_sample ?x), (have_rock_analysis ?r ?p), (can_traverse ?r ?x ?y), (at_lander ?l ?x), (can_traverse ?r ?p ?y), (equipped_for_soil_analysis ?r), (visible ?p ?x), (channel_free ?l), (at ?r ?y), (have_rock_analysis ?r ?x), (at_lander ?l ?y), (have_rock_analysis ?r ?y), (visible ?x ?y), (visible ?x ?p), (have_rock_analysis ?r ?y), (communicated_rock_data ?y), (have_soil_analysis ?r ?x), (have_rock_analysis ?r ?x), (at ?r ?x), (at_soil_sample ?p), (can_traverse ?r ?y ?p), (at_lander ?l ?p), (communicated_soil_data ?p), (visible ?y ?x), (available ?r), (communicated_soil_data ?y), (communicated_soil_data ?y), (can_traverse ?r ?p ?x), (equipped_for_rock_analysis ?r), (visible ?y ?p), (can_traverse ?r ?x ?p), (can_traverse ?r ?x ?y), (at_rock_sample ?p), (can_traverse ?r ?x ?p), (at ?r ?p), (at_soil_sample ?y), (at_soil_sample ?x), (communicated_rock_data ?x), 
;; sample_rock action has changed: (at_soil_sample ?p), (communicated_rock_data ?p), (equipped_for_rock_analysis ?x), (at_rock_sample ?p), (store_of ?s ?x), (at ?x ?p), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (full ?s), (communicated_soil_data ?p), (have_soil_analysis ?x ?p), 
;; navigate action has changed: (have_rock_analysis ?x ?y), (communicated_rock_data ?y), (at_rock_sample ?y), (visible ?z ?y), (communicated_rock_data ?y), (at_soil_sample ?y), (available ?x), (equipped_for_soil_analysis ?x), (equipped_for_soil_analysis ?x), (communicated_soil_data ?z), (at_soil_sample ?z), (at ?x ?y), (at_rock_sample ?z), (communicated_soil_data ?y), (at_rock_sample ?z), (at ?x ?z), (can_traverse ?x ?z ?y), (have_soil_analysis ?x ?y), (have_rock_analysis ?x ?z), (visible ?y ?z), (equipped_for_rock_analysis ?x), (at ?x ?y), 
;; drop action has changed: (equipped_for_rock_analysis ?x), (available ?x), (equipped_for_rock_analysis ?x), (store_of ?y ?x), (equipped_for_imaging ?x), (empty ?y), (store_of ?y ?x), (full ?y), (available ?x), (equipped_for_soil_analysis ?x), 
;; calibrate action has changed: (communicated_rock_data ?w), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?w), (have_rock_analysis ?r ?w), (equipped_for_rock_analysis ?r), (at_soil_sample ?w), (communicated_rock_data ?w), (at ?r ?w), (on_board ?i ?r), (visible_from ?t ?w), (at ?r ?w), (visible_from ?t ?w), (at_rock_sample ?w), (at_rock_sample ?w), (communicated_soil_data ?w), 
;; take_image action has changed: (communicated_rock_data ?p), (at_rock_sample ?p), (have_soil_analysis ?r ?p), (at_rock_sample ?p), (calibration_target ?i ?o), (at ?r ?p), (communicated_image_data ?o ?m), (at_soil_sample ?p), (equipped_for_rock_analysis ?r), (equipped_for_soil_analysis ?r), (visible_from ?o ?p), (have_rock_analysis ?r ?p), (equipped_for_imaging ?r), (available ?r), (equipped_for_imaging ?r), (at_soil_sample ?p), (calibrated ?i ?r), (calibrated ?i ?r), (on_board ?i ?r), (communicated_soil_data ?p), 
;; sample_soil action has changed: (full ?s), (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?p), (available ?x), (store_of ?s ?x), (equipped_for_imaging ?x), (at_rock_sample ?p), (have_soil_analysis ?x ?p), (communicated_rock_data ?p), (empty ?s), (full ?s), (store_of ?s ?x), (at_soil_sample ?p), (communicated_soil_data ?p), (have_rock_analysis ?x ?p), (equipped_for_imaging ?x), (at_rock_sample ?p), (have_soil_analysis ?x ?p), (equipped_for_rock_analysis ?x), 
;; communicate_image_data action has changed: (at ?r ?y), (communicated_soil_data ?y), (can_traverse ?r ?x ?y), (equipped_for_rock_analysis ?r), (at ?r ?x), (communicated_rock_data ?y), (have_rock_analysis ?r ?y), (visible_from ?o ?y), (communicated_rock_data ?y), (at_soil_sample ?x), (equipped_for_imaging ?r), (at ?r ?y), (at_lander ?l ?y), (available ?r), (visible_from ?o ?x), (communicated_rock_data ?x), (available ?r), (communicated_image_data ?o ?m), (visible_from ?o ?y), (communicated_image_data ?o ?m), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?x), (communicated_rock_data ?x), (visible ?y ?x), (have_image ?r ?o ?m), (at_lander ?l ?x), (communicated_soil_data ?y), (visible ?y ?x), (at_soil_sample ?y), (communicated_soil_data ?x), (equipped_for_rock_analysis ?r), 
;; Last_reduced_capability_num_dropped_pals: None

