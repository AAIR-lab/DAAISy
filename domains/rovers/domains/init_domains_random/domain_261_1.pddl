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
			(at_rock_sample ?y)
			(not (can_traverse ?x ?z ?y))
			(at ?x ?y)
			(have_soil_analysis ?x ?y)
			(not (at_soil_sample ?z))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?z)
			(equipped_for_rock_analysis ?x)
			(not (at ?x ?z))
			(not (have_rock_analysis ?x ?y))
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (not (have_rock_analysis ?x ?z))
			(not (visible ?z ?y))
			(equipped_for_imaging ?x)
			(not (at_rock_sample ?y))
			(not (communicated_soil_data ?y))
			(not (equipped_for_rock_analysis ?x))
			(not (can_traverse ?x ?y ?z))
			(not (at ?x ?z))
			(not (have_rock_analysis ?x ?y))
			(communicated_rock_data ?y)
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (empty ?s))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (available ?x)
			(not (at ?x ?p))
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(full ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (empty ?s)
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(store_of ?s ?x)
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (available ?x)
			(not (at ?x ?p))
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(full ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(equipped_for_rock_analysis ?x)
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (available ?x)
			(empty ?y)
			(not (equipped_for_rock_analysis ?x))
			(not (equipped_for_soil_analysis ?x))
			(full ?y)
			(equipped_for_imaging ?x)
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (not (equipped_for_rock_analysis ?r))
			(have_soil_analysis ?r ?w)
			(equipped_for_imaging ?r)
			(not (at ?r ?w))
			(not (on_board ?i ?r))
			(not (equipped_for_soil_analysis ?r))
			(communicated_soil_data ?w)
			(communicated_rock_data ?w)
			(not (at_soil_sample ?w))
			
          )
         :effect (and 
               (not (available ?r))
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(at_rock_sample ?w)
			(not (equipped_for_soil_analysis ?r))
			(have_rock_analysis ?r ?w)
			(not (communicated_rock_data ?w))
			
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
			(not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(not (equipped_for_soil_analysis ?r))
			(on_board ?i ?r)
			(at_rock_sample ?p)
			(visible_from ?o ?p)
			(communicated_rock_data ?p)
			(calibrated ?i ?r)
			(not (at ?r ?p))
			
          )
          :effect (and 
               (not (communicated_image_data ?o ?m))
			(not (have_soil_analysis ?r ?p))
			(equipped_for_rock_analysis ?r)
			(not (available ?r))
			(calibration_target ?i ?o)
			(on_board ?i ?r)
			(not (have_rock_analysis ?r ?p))
			(at_rock_sample ?p)
			(not (communicated_soil_data ?p))
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
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(not (communicated_rock_data ?x))
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(visible ?y ?p)
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(visible ?x ?y)
			(not (have_soil_analysis ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(not (at_lander ?l ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			
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
			(communicated_rock_data ?x)
			(visible ?p ?y)
			(visible ?x ?y)
			(not (can_traverse ?r ?p ?y))
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(can_traverse ?r ?x ?y)
			(not (available ?r))
			(not (at_soil_sample ?p))
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(equipped_for_soil_analysis ?r)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(can_traverse ?r ?x ?p)
			(have_rock_analysis ?r ?x)
			(not (at_lander ?l ?p))
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(not (visible ?y ?p))
			(not (communicated_rock_data ?y))
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (not (equipped_for_imaging ?r))
			(have_soil_analysis ?r ?x)
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?y))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
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
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (available ?r))
			(not (visible_from ?o ?x))
			(at_lander ?l ?x)
			(equipped_for_soil_analysis ?r)
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			(not (visible_from ?o ?y))
			(not (can_traverse ?r ?y ?x))
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (channel_free ?l)
			(not (have_image ?r ?o ?m))
			(not (have_soil_analysis ?r ?x))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(not (available ?r))
			(at_rock_sample ?y)
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?y))
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(not (visible_from ?o ?y))
			(not (communicated_rock_data ?y))
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (can_traverse ?r ?x ?p), (equipped_for_rock_analysis ?r), (can_traverse ?r ?x ?p), (at_soil_sample ?x), (can_traverse ?r ?p ?y), (communicated_soil_data ?x), (available ?r), (have_rock_analysis ?r ?p), (can_traverse ?r ?y ?p), (have_rock_analysis ?r ?x), (communicated_soil_data ?p), (communicated_rock_data ?y), (have_soil_analysis ?r ?p), (visible ?y ?p), (can_traverse ?r ?x ?y), (visible ?y ?p), (have_soil_analysis ?r ?x), (can_traverse ?r ?x ?y), (have_rock_analysis ?r ?y), (at ?r ?p), (communicated_rock_data ?x), (visible ?x ?p), (can_traverse ?r ?y ?x), (communicated_soil_data ?y), (can_traverse ?r ?p ?x), (at_lander ?l ?y), (visible ?p ?y), (equipped_for_imaging ?r), (can_traverse ?r ?p ?x), (at_lander ?l ?y), (at_rock_sample ?y), (have_soil_analysis ?r ?y), (at ?r ?p), (communicated_rock_data ?y), (equipped_for_rock_analysis ?r), (at_soil_sample ?y), (equipped_for_soil_analysis ?r), (at ?r ?x), (at_lander ?l ?p), (at ?r ?x), (available ?r), (can_traverse ?r ?y ?p), (visible ?p ?y), (channel_free ?l), (visible ?p ?x), (can_traverse ?r ?p ?y), (at_soil_sample ?p), (at_soil_sample ?p), (visible ?y ?x), (at_lander ?l ?p), (communicated_rock_data ?p), (at_lander ?l ?x), (at_soil_sample ?x), 
;; calibrate action has changed: (visible_from ?t ?w), (on_board ?i ?r), (have_soil_analysis ?r ?w), (communicated_rock_data ?w), (at_soil_sample ?w), (communicated_soil_data ?w), (equipped_for_soil_analysis ?r), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?w), (at ?r ?w), (on_board ?i ?r), (communicated_rock_data ?w), (equipped_for_soil_analysis ?r), (available ?r), (calibration_target ?i ?t), (at_rock_sample ?w), (calibrated ?i ?r), (equipped_for_imaging ?r), 
;; sample_rock action has changed: (at ?x ?p), (communicated_soil_data ?p), (available ?x), (at ?x ?p), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?p), (communicated_soil_data ?p), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (communicated_rock_data ?p), (full ?s), (at_soil_sample ?p), (at_rock_sample ?p), (have_soil_analysis ?x ?p), (store_of ?s ?x), (empty ?s), (communicated_rock_data ?p), (have_rock_analysis ?x ?p), (equipped_for_imaging ?x), 
;; drop action has changed: (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (equipped_for_imaging ?x), (full ?y), (full ?y), (equipped_for_soil_analysis ?x), (available ?x), (equipped_for_rock_analysis ?x), 
;; communicate_soil_data action has changed: (communicated_rock_data ?x), (at ?r ?p), (at_lander ?l ?x), (at_rock_sample ?y), (can_traverse ?r ?y ?p), (can_traverse ?r ?x ?p), (communicated_rock_data ?y), (at_soil_sample ?y), (communicated_soil_data ?y), (at_lander ?l ?x), (communicated_rock_data ?p), (communicated_soil_data ?p), (at ?r ?y), (at_lander ?l ?y), (communicated_soil_data ?x), (can_traverse ?r ?p ?x), (visible ?p ?y), (channel_free ?l), (communicated_rock_data ?x), (at_rock_sample ?y), (equipped_for_rock_analysis ?r), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?y), (at_lander ?l ?p), (visible ?x ?y), (have_rock_analysis ?r ?p), (have_soil_analysis ?r ?p), (can_traverse ?r ?y ?p), (at_lander ?l ?p), (can_traverse ?r ?x ?y), (visible ?y ?p), (visible ?y ?p), (can_traverse ?r ?y ?x), (equipped_for_soil_analysis ?r), (can_traverse ?r ?x ?y), (communicated_soil_data ?p), (visible ?x ?y), (at_soil_sample ?x), (have_rock_analysis ?r ?y), (equipped_for_soil_analysis ?r), (available ?r), (visible ?p ?x), (have_rock_analysis ?r ?y), (have_soil_analysis ?r ?x), (communicated_soil_data ?y), (at_soil_sample ?p), (at ?r ?x), (at_soil_sample ?x), (available ?r), (at ?r ?x), (communicated_rock_data ?y), (channel_free ?l), (equipped_for_imaging ?r), (have_soil_analysis ?r ?y), (at_soil_sample ?p), (communicated_rock_data ?p), 
;; take_image action has changed: (equipped_for_imaging ?r), (have_rock_analysis ?r ?p), (on_board ?i ?r), (equipped_for_rock_analysis ?r), (available ?r), (communicated_soil_data ?p), (equipped_for_rock_analysis ?r), (at ?r ?p), (available ?r), (have_image ?r ?o ?m), (communicated_image_data ?o ?m), (communicated_rock_data ?p), (at_rock_sample ?p), (at ?r ?p), (at_rock_sample ?p), (have_soil_analysis ?r ?p), (equipped_for_soil_analysis ?r), (calibration_target ?i ?o), 
;; sample_soil action has changed: (equipped_for_imaging ?x), (empty ?s), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?p), (equipped_for_rock_analysis ?x), (have_soil_analysis ?x ?p), (communicated_rock_data ?p), (at_rock_sample ?p), (have_rock_analysis ?x ?p), (have_soil_analysis ?x ?p), (equipped_for_rock_analysis ?x), (communicated_rock_data ?p), (at ?x ?p), (empty ?s), (store_of ?s ?x), (at_soil_sample ?p), (equipped_for_soil_analysis ?x), (full ?s), (at ?x ?p), (store_of ?s ?x), (available ?x), (equipped_for_imaging ?x), (communicated_soil_data ?p), 
;; navigate action has changed: (at ?x ?y), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (visible ?y ?z), (at ?x ?z), (have_soil_analysis ?x ?y), (can_traverse ?x ?z ?y), (communicated_soil_data ?z), (at_rock_sample ?y), (at_soil_sample ?y), (can_traverse ?x ?y ?z), (have_rock_analysis ?x ?y), (communicated_rock_data ?y), (available ?x), (equipped_for_soil_analysis ?x), (visible ?z ?y), (at_soil_sample ?z), (have_rock_analysis ?x ?z), (have_rock_analysis ?x ?z), (at ?x ?z), (have_rock_analysis ?x ?y), (communicated_soil_data ?y), (at_rock_sample ?y), (communicated_rock_data ?y), (can_traverse ?x ?y ?z), (equipped_for_rock_analysis ?x), 
;; communicate_image_data action has changed: (at_rock_sample ?x), (have_image ?r ?o ?m), (can_traverse ?r ?x ?y), (visible_from ?o ?x), (have_rock_analysis ?r ?y), (at_lander ?l ?y), (at_soil_sample ?y), (channel_free ?l), (equipped_for_soil_analysis ?r), (communicated_image_data ?o ?m), (can_traverse ?r ?y ?x), (at ?r ?y), (at ?r ?y), (at ?r ?x), (visible_from ?o ?y), (visible_from ?o ?y), (at_rock_sample ?y), (communicated_rock_data ?x), (communicated_rock_data ?y), (communicated_soil_data ?y), (have_soil_analysis ?r ?y), (available ?r), (at_rock_sample ?x), (visible_from ?o ?x), (have_image ?r ?o ?m), (visible ?x ?y), (have_soil_analysis ?r ?x), (equipped_for_imaging ?r), (have_soil_analysis ?r ?x), (channel_free ?l), (communicated_image_data ?o ?m), (communicated_soil_data ?y), (have_rock_analysis ?r ?x), (at ?r ?x), (available ?r), (have_soil_analysis ?r ?y), (at_lander ?l ?x), (at_soil_sample ?x), (visible ?y ?x), 
;; Last_reduced_capability_num_dropped_pals: None

