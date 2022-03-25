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
			(not (can_traverse ?x ?z ?y))
			(at ?x ?y)
			(at_soil_sample ?z)
			(communicated_rock_data ?z)
			(visible ?y ?z)
			(not (can_traverse ?x ?y ?z))
			(at ?x ?z)
			(not (have_soil_analysis ?x ?z))
			(have_rock_analysis ?x ?y)
			(equipped_for_soil_analysis ?x)
			
          )
          :effect (and 
               (at_rock_sample ?z)
			(not (available ?x))
			(visible ?z ?y)
			(equipped_for_imaging ?x)
			(at_rock_sample ?y)
			(can_traverse ?x ?z ?y)
			(not (at ?x ?y))
			(at_soil_sample ?z)
			(communicated_soil_data ?z)
			(communicated_rock_data ?z)
			(can_traverse ?x ?y ?z)
			(have_soil_analysis ?x ?z)
			(have_rock_analysis ?x ?y)
			(not (equipped_for_soil_analysis ?x))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (at ?x ?p))
			(equipped_for_imaging ?x)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(communicated_soil_data ?p)
			
          )
        :effect (and 
               (not (at ?x ?p))
			(not (full ?s))
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(not (have_soil_analysis ?x ?p))
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(not (at ?x ?p))
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (communicated_soil_data ?p))
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (available ?x)
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(communicated_rock_data ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(not (equipped_for_rock_analysis ?x))
			(not (full ?y))
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (store_of ?y ?x)
			(equipped_for_rock_analysis ?x)
			(not (equipped_for_soil_analysis ?x))
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
			(equipped_for_rock_analysis ?r)
			(available ?r)
			(equipped_for_imaging ?r)
			(not (at ?r ?w))
			(at_rock_sample ?w)
			(not (equipped_for_soil_analysis ?r))
			(not (have_rock_analysis ?r ?w))
			(communicated_soil_data ?w)
			(communicated_rock_data ?w)
			(not (at_soil_sample ?w))
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(not (equipped_for_rock_analysis ?r))
			(have_soil_analysis ?r ?w)
			(available ?r)
			(equipped_for_imaging ?r)
			(not (at ?r ?w))
			(at_rock_sample ?w)
			(equipped_for_soil_analysis ?r)
			(not (visible_from ?t ?w))
			(not (have_rock_analysis ?r ?w))
			(not (communicated_soil_data ?w))
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
               (not (supports ?i ?m))
			(communicated_image_data ?o ?m)
			(not (have_soil_analysis ?r ?p))
			(not (equipped_for_imaging ?r))
			(not (have_rock_analysis ?r ?p))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(communicated_rock_data ?p)
			(not (calibrated ?i ?r))
			
          )
          :effect (and 
               (not (supports ?i ?m))
			(not (communicated_image_data ?o ?m))
			(have_soil_analysis ?r ?p)
			(have_image ?r ?o ?m)
			(not (calibration_target ?i ?o))
			(not (equipped_for_soil_analysis ?r))
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?p)
			(communicated_rock_data ?p)
			(not (calibrated ?i ?r))
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
			(not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(not (visible ?p ?x))
			(visible ?p ?y)
			(not (visible ?x ?y))
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(at ?r ?x)
			(communicated_rock_data ?p)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(not (visible ?x ?p))
			(visible ?y ?p)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(visible ?p ?y)
			(not (visible ?x ?y))
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(have_rock_analysis ?r ?x)
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(visible ?x ?p)
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
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
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(communicated_rock_data ?x)
			(visible ?p ?x)
			(not (visible ?p ?y))
			(visible ?x ?y)
			(at ?r ?y)
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(not (have_rock_analysis ?r ?y))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(communicated_rock_data ?p)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(visible ?y ?p)
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
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(have_image ?r ?o ?m)
			(visible ?x ?y)
			(have_soil_analysis ?r ?y)
			(available ?r)
			(at_rock_sample ?y)
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(not (communicated_rock_data ?y))
			(communicated_image_data ?o ?m)
			
          )
         :effect (and 
               (channel_free ?l)
			(visible ?y ?x)
			(not (have_image ?r ?o ?m))
			(not (communicated_rock_data ?x))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(not (available ?r))
			(not (at_rock_sample ?y))
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(communicated_soil_data ?y)
			(not (equipped_for_rock_analysis ?r))
			(communicated_rock_data ?y)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; sample_soil action has changed: (at ?x ?p), (at_soil_sample ?p), (equipped_for_soil_analysis ?x), (empty ?s), (at_rock_sample ?p), (at ?x ?p), (communicated_soil_data ?p), (have_rock_analysis ?x ?p), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (empty ?s), (store_of ?s ?x), (full ?s), (equipped_for_imaging ?x), (have_soil_analysis ?x ?p), 
;; communicate_rock_data action has changed: (communicated_soil_data ?y), (communicated_soil_data ?y), (at_lander ?l ?p), (have_rock_analysis ?r ?y), (can_traverse ?r ?y ?p), (visible ?y ?x), (at_rock_sample ?x), (visible ?p ?x), (communicated_soil_data ?p), (communicated_rock_data ?y), (at ?r ?y), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?p), (communicated_rock_data ?p), (equipped_for_imaging ?r), (have_rock_analysis ?r ?p), (have_soil_analysis ?r ?p), (have_rock_analysis ?r ?x), (can_traverse ?r ?p ?x), (have_rock_analysis ?r ?x), (at_soil_sample ?p), (communicated_rock_data ?x), (available ?r), (equipped_for_imaging ?r), (at_soil_sample ?y), (can_traverse ?r ?p ?y), (can_traverse ?r ?x ?y), (communicated_rock_data ?y), (have_rock_analysis ?r ?y), (at ?r ?y), (visible ?y ?x), (communicated_soil_data ?p), (at_rock_sample ?p), (at_soil_sample ?p), (at_rock_sample ?y), (at_rock_sample ?p), (at ?r ?x), (can_traverse ?r ?x ?p), (have_soil_analysis ?r ?x), (visible ?y ?p), (equipped_for_soil_analysis ?r), (equipped_for_rock_analysis ?r), (at_lander ?l ?x), (at_soil_sample ?x), (at_soil_sample ?y), (visible ?p ?y), (communicated_soil_data ?x), 
;; communicate_soil_data action has changed: (visible ?x ?y), (at_lander ?l ?p), (at_lander ?l ?y), (can_traverse ?r ?x ?p), (at ?r ?x), (at_soil_sample ?p), (visible ?p ?y), (visible ?y ?p), (can_traverse ?r ?x ?p), (have_rock_analysis ?r ?y), (at_rock_sample ?p), (can_traverse ?r ?y ?x), (at_rock_sample ?p), (communicated_rock_data ?y), (at ?r ?p), (visible ?p ?x), (have_rock_analysis ?r ?p), (can_traverse ?r ?x ?y), (visible ?x ?p), (have_soil_analysis ?r ?y), (visible ?x ?y), (visible ?y ?p), (have_rock_analysis ?r ?x), (at_lander ?l ?x), (visible ?p ?y), (communicated_soil_data ?y), (can_traverse ?r ?p ?x), (visible ?y ?x), (communicated_soil_data ?p), (communicated_rock_data ?p), (visible ?p ?x), (at_soil_sample ?x), (at ?r ?y), (equipped_for_soil_analysis ?r), (equipped_for_imaging ?r), (have_soil_analysis ?r ?x), (at ?r ?p), (visible ?y ?x), (visible ?x ?p), (have_soil_analysis ?r ?x), (have_rock_analysis ?r ?x), (communicated_rock_data ?p), (can_traverse ?r ?p ?y), (at_rock_sample ?y), (have_soil_analysis ?r ?p), (have_soil_analysis ?r ?y), (communicated_rock_data ?x), (equipped_for_imaging ?r), (available ?r), (equipped_for_soil_analysis ?r), (at_lander ?l ?y), (can_traverse ?r ?x ?y), (at_soil_sample ?p), (can_traverse ?r ?p ?x), (have_rock_analysis ?r ?y), 
;; communicate_image_data action has changed: (visible ?y ?x), (have_image ?r ?o ?m), (communicated_soil_data ?y), (communicated_soil_data ?y), (can_traverse ?r ?x ?y), (at_soil_sample ?y), (have_rock_analysis ?r ?y), (communicated_rock_data ?x), (at ?r ?x), (communicated_image_data ?o ?m), (equipped_for_imaging ?r), (available ?r), (at_soil_sample ?x), (at ?r ?y), (visible ?y ?x), (at_rock_sample ?y), (channel_free ?l), (communicated_rock_data ?y), (visible_from ?o ?x), (communicated_soil_data ?x), (visible_from ?o ?x), (at_lander ?l ?y), (at_lander ?l ?x), (have_soil_analysis ?r ?y), (have_rock_analysis ?r ?y), (equipped_for_rock_analysis ?r), (visible ?x ?y), (at_rock_sample ?x), (equipped_for_soil_analysis ?r), (communicated_rock_data ?y), (at_rock_sample ?y), 
;; sample_rock action has changed: (at_soil_sample ?p), (communicated_rock_data ?p), (equipped_for_imaging ?x), (at_soil_sample ?p), (available ?x), (have_rock_analysis ?x ?p), (have_rock_analysis ?x ?p), (communicated_soil_data ?p), (at ?x ?p), (communicated_rock_data ?p), (equipped_for_imaging ?x), (available ?x), (communicated_soil_data ?p), (equipped_for_soil_analysis ?x), 
;; navigate action has changed: (can_traverse ?x ?y ?z), (equipped_for_soil_analysis ?x), (at_rock_sample ?z), (available ?x), (visible ?z ?y), (at_soil_sample ?z), (at_rock_sample ?z), (have_soil_analysis ?x ?z), (have_rock_analysis ?x ?y), (can_traverse ?x ?z ?y), (have_rock_analysis ?x ?y), (communicated_soil_data ?z), (equipped_for_soil_analysis ?x), (at_soil_sample ?z), (communicated_rock_data ?z), (communicated_rock_data ?z), (have_soil_analysis ?x ?z), (can_traverse ?x ?z ?y), (at_rock_sample ?y), (at_rock_sample ?y), (at ?x ?z), (can_traverse ?x ?y ?z), (at ?x ?z), (equipped_for_imaging ?x), (visible ?z ?y), 
;; calibrate action has changed: (have_soil_analysis ?r ?w), (equipped_for_soil_analysis ?r), (equipped_for_soil_analysis ?r), (available ?r), (communicated_soil_data ?w), (visible_from ?t ?w), (at_soil_sample ?w), (have_rock_analysis ?r ?w), (available ?r), (at_rock_sample ?w), (have_rock_analysis ?r ?w), (equipped_for_rock_analysis ?r), (at_soil_sample ?w), (communicated_rock_data ?w), (at ?r ?w), (equipped_for_imaging ?r), (on_board ?i ?r), (calibration_target ?i ?t), (at_rock_sample ?w), (communicated_rock_data ?w), (at ?r ?w), (communicated_soil_data ?w), (equipped_for_rock_analysis ?r), (visible_from ?t ?w), 
;; take_image action has changed: (supports ?i ?m), (communicated_image_data ?o ?m), (equipped_for_imaging ?r), (at ?r ?p), (have_rock_analysis ?r ?p), (calibrated ?i ?r), (communicated_image_data ?o ?m), (at_rock_sample ?p), (have_soil_analysis ?r ?p), (communicated_rock_data ?p), (communicated_soil_data ?p), (visible_from ?o ?p), (calibration_target ?i ?o), (supports ?i ?m), (at_soil_sample ?p), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?p), (communicated_rock_data ?p), (have_soil_analysis ?r ?p), (on_board ?i ?r), (at ?r ?p), 
;; drop action has changed: (full ?y), (equipped_for_imaging ?x), (store_of ?y ?x), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (empty ?y), (equipped_for_rock_analysis ?x), (equipped_for_rock_analysis ?x), (full ?y), 
;; Last_reduced_capability_num_dropped_pals: None

