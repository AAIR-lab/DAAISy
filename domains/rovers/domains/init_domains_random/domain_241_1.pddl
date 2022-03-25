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
			(at ?x ?y)
			(have_soil_analysis ?x ?y)
			(not (communicated_soil_data ?z))
			(not (communicated_soil_data ?y))
			(not (visible ?y ?z))
			(not (equipped_for_rock_analysis ?x))
			(not (have_soil_analysis ?x ?z))
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (at_rock_sample ?z)
			(not (have_rock_analysis ?x ?z))
			(not (available ?x))
			(at_rock_sample ?y)
			(not (at ?x ?y))
			(have_soil_analysis ?x ?y)
			(at_soil_sample ?y)
			(communicated_rock_data ?z)
			(communicated_soil_data ?y)
			(not (have_soil_analysis ?x ?z))
			(not (have_rock_analysis ?x ?y))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(empty ?s)
			(equipped_for_imaging ?x)
			(full ?s)
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (empty ?s)
			(full ?s)
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(not (have_soil_analysis ?x ?p))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (not (at ?x ?p))
			(empty ?s)
			(equipped_for_imaging ?x)
			(not (full ?s))
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (available ?x)
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (communicated_soil_data ?p))
			(communicated_rock_data ?p)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (available ?x))
			(store_of ?y ?x)
			(equipped_for_rock_analysis ?x)
			(not (equipped_for_soil_analysis ?x))
			(not (full ?y))
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (not (available ?x))
			(not (store_of ?y ?x))
			(equipped_for_rock_analysis ?x)
			(equipped_for_soil_analysis ?x)
			
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
			(not (equipped_for_soil_analysis ?r))
			(not (visible_from ?t ?w))
			(have_rock_analysis ?r ?w)
			(not (communicated_soil_data ?w))
			(not (at_soil_sample ?w))
			
          )
         :effect (and 
               (not (equipped_for_rock_analysis ?r))
			(have_soil_analysis ?r ?w)
			(not (at_rock_sample ?w))
			(not (equipped_for_soil_analysis ?r))
			(not (visible_from ?t ?w))
			(communicated_rock_data ?w)
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
			(available ?r)
			(have_image ?r ?o ?m)
			(not (equipped_for_imaging ?r))
			(not (have_rock_analysis ?r ?p))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (communicated_soil_data ?p))
			(not (calibrated ?i ?r))
			
          )
          :effect (and 
               (communicated_image_data ?o ?m)
			(not (have_soil_analysis ?r ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(have_image ?r ?o ?m)
			(equipped_for_soil_analysis ?r)
			(on_board ?i ?r)
			(not (have_rock_analysis ?r ?p))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (communicated_soil_data ?p))
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
               (not (channel_free ?l))
			(not (visible ?p ?x))
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(have_soil_analysis ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(equipped_for_soil_analysis ?r)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(visible ?x ?p)
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
			
          )
          :effect (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(visible ?p ?x)
			(visible ?p ?y)
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(at_rock_sample ?y)
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(have_rock_analysis ?r ?x)
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(not (visible ?x ?p))
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
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
               (equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(visible ?x ?y)
			(can_traverse ?r ?p ?y)
			(at ?r ?y)
			(available ?r)
			(not (at ?r ?x))
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?x))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(not (communicated_rock_data ?x))
			(visible ?p ?y)
			(not (visible ?x ?y))
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(visible ?x ?p)
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			
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
               (not (equipped_for_imaging ?r))
			(have_soil_analysis ?r ?x)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(not (available ?r))
			(visible_from ?o ?x)
			(at ?r ?x)
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(not (communicated_soil_data ?x))
			(not (have_rock_analysis ?r ?x))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			
          )
         :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(available ?r)
			(not (at_rock_sample ?y))
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(not (communicated_rock_data ?y))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; navigate action has changed: (visible ?y ?z), (communicated_rock_data ?y), (communicated_soil_data ?z), (at ?x ?z), (have_soil_analysis ?x ?z), (equipped_for_rock_analysis ?x), (communicated_soil_data ?y), (have_soil_analysis ?x ?y), (at_rock_sample ?z), (have_rock_analysis ?x ?y), (available ?x), (at_rock_sample ?y), (have_rock_analysis ?x ?z), (have_soil_analysis ?x ?y), (have_soil_analysis ?x ?z), (at_soil_sample ?y), (communicated_rock_data ?z), (communicated_soil_data ?y), (can_traverse ?x ?y ?z), (available ?x), (at_rock_sample ?z), 
;; calibrate action has changed: (at ?r ?w), (equipped_for_imaging ?r), (at_rock_sample ?w), (have_soil_analysis ?r ?w), (have_rock_analysis ?r ?w), (on_board ?i ?r), (equipped_for_soil_analysis ?r), (available ?r), (communicated_rock_data ?w), (communicated_soil_data ?w), (visible_from ?t ?w), (visible_from ?t ?w), (equipped_for_soil_analysis ?r), (calibration_target ?i ?t), (equipped_for_rock_analysis ?r), (at_soil_sample ?w), 
;; sample_soil action has changed: (full ?s), (communicated_rock_data ?p), (at_soil_sample ?p), (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), (at_rock_sample ?p), (communicated_soil_data ?p), (have_soil_analysis ?x ?p), (empty ?s), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?p), (equipped_for_imaging ?x), (store_of ?s ?x), 
;; communicate_rock_data action has changed: (at_lander ?l ?x), (visible ?x ?p), (can_traverse ?r ?y ?p), (communicated_soil_data ?p), (at_soil_sample ?p), (can_traverse ?r ?x ?p), (visible ?y ?x), (channel_free ?l), (at_soil_sample ?x), (can_traverse ?r ?y ?x), (communicated_rock_data ?x), (available ?r), (at_lander ?l ?p), (can_traverse ?r ?p ?x), (at_lander ?l ?y), (have_rock_analysis ?r ?x), (at_rock_sample ?p), (at ?r ?x), (have_soil_analysis ?r ?p), (visible ?p ?x), (equipped_for_imaging ?r), (can_traverse ?r ?x ?p), (at ?r ?p), (visible ?x ?p), (communicated_rock_data ?x), (communicated_soil_data ?x), (can_traverse ?r ?p ?y), (communicated_rock_data ?p), (at_rock_sample ?y), (visible ?y ?p), (channel_free ?l), (visible ?y ?p), (communicated_rock_data ?y), (equipped_for_imaging ?r), (at_soil_sample ?y), (at ?r ?x), (communicated_soil_data ?x), (can_traverse ?r ?y ?x), (at ?r ?y), (have_soil_analysis ?r ?y), (visible ?x ?y), (at_lander ?l ?y), (at_lander ?l ?p), (visible ?p ?y), (can_traverse ?r ?x ?y), (can_traverse ?r ?y ?p), (communicated_soil_data ?y), (equipped_for_rock_analysis ?r), 
;; take_image action has changed: (available ?r), (on_board ?i ?r), (at ?r ?p), (at_soil_sample ?p), (calibrated ?i ?r), (communicated_image_data ?o ?m), (supports ?i ?m), (have_soil_analysis ?r ?p), (communicated_rock_data ?p), (have_soil_analysis ?r ?p), (available ?r), (communicated_image_data ?o ?m), (at_rock_sample ?p), (on_board ?i ?r), (equipped_for_rock_analysis ?r), (at ?r ?p), (equipped_for_soil_analysis ?r), (at_soil_sample ?p), (have_image ?r ?o ?m), (have_rock_analysis ?r ?p), (equipped_for_imaging ?r), (at_rock_sample ?p), (visible_from ?o ?p), (communicated_soil_data ?p), (have_rock_analysis ?r ?p), (communicated_soil_data ?p), 
;; communicate_image_data action has changed: (at_lander ?l ?x), (have_image ?r ?o ?m), (at ?r ?y), (have_rock_analysis ?r ?x), (at_lander ?l ?x), (can_traverse ?r ?y ?x), (equipped_for_soil_analysis ?r), (communicated_soil_data ?x), (equipped_for_imaging ?r), (at_rock_sample ?y), (communicated_soil_data ?x), (visible ?x ?y), (equipped_for_soil_analysis ?r), (at_lander ?l ?y), (have_soil_analysis ?r ?y), (available ?r), (visible_from ?o ?x), (channel_free ?l), (communicated_rock_data ?x), (at_rock_sample ?x), (at_soil_sample ?y), (have_rock_analysis ?r ?y), (channel_free ?l), (can_traverse ?r ?x ?y), (equipped_for_imaging ?r), (communicated_rock_data ?y), (have_rock_analysis ?r ?y), (have_soil_analysis ?r ?x), (available ?r), (can_traverse ?r ?x ?y), (visible ?x ?y), (at ?r ?x), (at_rock_sample ?x), (communicated_rock_data ?y), (at ?r ?y), (at_lander ?l ?y), 
;; sample_rock action has changed: (equipped_for_imaging ?x), (at_soil_sample ?p), (empty ?s), (store_of ?s ?x), (available ?x), (communicated_soil_data ?p), (at ?x ?p), (full ?s), (communicated_rock_data ?p), (full ?s), (have_rock_analysis ?x ?p), (equipped_for_soil_analysis ?x), (store_of ?s ?x), (equipped_for_imaging ?x), (communicated_soil_data ?p), (at_rock_sample ?p), (communicated_rock_data ?p), 
;; communicate_soil_data action has changed: (visible ?y ?p), (have_soil_analysis ?r ?y), (equipped_for_rock_analysis ?r), (can_traverse ?r ?x ?y), (visible ?p ?y), (equipped_for_soil_analysis ?r), (visible ?x ?y), (communicated_soil_data ?p), (have_rock_analysis ?r ?y), (communicated_soil_data ?x), (visible ?y ?p), (have_rock_analysis ?r ?p), (visible ?p ?x), (at_soil_sample ?x), (can_traverse ?r ?x ?p), (channel_free ?l), (have_rock_analysis ?r ?p), (communicated_soil_data ?y), (can_traverse ?r ?p ?y), (visible ?y ?x), (communicated_soil_data ?x), (visible ?x ?p), (visible ?p ?x), (communicated_rock_data ?y), (at_lander ?l ?x), (can_traverse ?r ?x ?p), (visible ?x ?p), (at ?r ?y), (have_rock_analysis ?r ?x), (have_soil_analysis ?r ?p), (at_soil_sample ?y), (communicated_soil_data ?p), (can_traverse ?r ?y ?x), (equipped_for_imaging ?r), (at_rock_sample ?p), (at_lander ?l ?y), (at ?r ?x), (equipped_for_soil_analysis ?r), (at_rock_sample ?x), (have_rock_analysis ?r ?x), (channel_free ?l), (can_traverse ?r ?p ?x), (at_lander ?l ?p), (have_soil_analysis ?r ?x), (at ?r ?x), (at_lander ?l ?p), (at_rock_sample ?y), (can_traverse ?r ?p ?y), (can_traverse ?r ?x ?y), (can_traverse ?r ?y ?x), (at_rock_sample ?x), (communicated_rock_data ?p), (at_lander ?l ?y), 
;; drop action has changed: (store_of ?y ?x), (available ?x), (full ?y), (available ?x), (equipped_for_rock_analysis ?x), (full ?y), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (empty ?y), (equipped_for_rock_analysis ?x), 
;; Last_reduced_capability_num_dropped_pals: None

