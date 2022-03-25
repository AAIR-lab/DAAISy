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
			(have_rock_analysis ?x ?z)
			(not (visible ?z ?y))
			(not (at_rock_sample ?y))
			(not (at ?x ?y))
			(have_soil_analysis ?x ?y)
			(not (at_soil_sample ?y))
			(communicated_soil_data ?z)
			(not (communicated_rock_data ?z))
			(not (communicated_soil_data ?y))
			(not (visible ?y ?z))
			(can_traverse ?x ?y ?z)
			(not (at ?x ?z))
			(not (have_soil_analysis ?x ?z))
			(not (communicated_rock_data ?y))
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (have_rock_analysis ?x ?z)
			(not (available ?x))
			(not (visible ?z ?y))
			(not (equipped_for_imaging ?x))
			(not (at_rock_sample ?y))
			(can_traverse ?x ?z ?y)
			(not (at ?x ?y))
			(not (have_soil_analysis ?x ?y))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?z))
			(not (communicated_rock_data ?z))
			(communicated_soil_data ?y)
			(visible ?y ?z)
			(equipped_for_rock_analysis ?x)
			(not (can_traverse ?x ?y ?z))
			(not (at ?x ?z))
			(have_rock_analysis ?x ?y)
			(communicated_rock_data ?y)
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(not (at ?x ?p))
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (full ?s)
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
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
			(at_soil_sample ?p)
			(not (have_soil_analysis ?x ?p))
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (available ?x)
			(at ?x ?p)
			(empty ?s)
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
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
			(not (empty ?y))
			(equipped_for_rock_analysis ?x)
			(not (equipped_for_soil_analysis ?x))
			(not (full ?y))
			(not (equipped_for_imaging ?x))
			
          )
        :effect (and 
               (store_of ?y ?x)
			(not (empty ?y))
			(not (equipped_for_rock_analysis ?x))
			(full ?y)
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (equipped_for_rock_analysis ?r)
			(have_soil_analysis ?r ?w)
			(not (available ?r))
			(not (equipped_for_imaging ?r))
			(not (at ?r ?w))
			(on_board ?i ?r)
			(at_rock_sample ?w)
			(not (have_rock_analysis ?r ?w))
			(not (at_soil_sample ?w))
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(equipped_for_rock_analysis ?r)
			(not (have_soil_analysis ?r ?w))
			(available ?r)
			(at ?r ?w)
			(on_board ?i ?r)
			(at_rock_sample ?w)
			(equipped_for_soil_analysis ?r)
			(not (visible_from ?t ?w))
			(have_rock_analysis ?r ?w)
			(not (communicated_rock_data ?w))
			(at_soil_sample ?w)
			
          )
    )  
    
    (:action take_image
         :parameters (?r - rover 
                      ?p - waypoint 
                      ?o - objective 
                      ?i - camera 
                      ?m - mode)
         :precondition (and 
               (not (communicated_image_data ?o ?m))
			(equipped_for_rock_analysis ?r)
			(not (available ?r))
			(equipped_for_soil_analysis ?r)
			(equipped_for_imaging ?r)
			(have_rock_analysis ?r ?p)
			(not (at_soil_sample ?p))
			(calibrated ?i ?r)
			(not (at ?r ?p))
			
          )
          :effect (and 
               (supports ?i ?m)
			(not (communicated_image_data ?o ?m))
			(have_soil_analysis ?r ?p)
			(not (equipped_for_rock_analysis ?r))
			(available ?r)
			(have_image ?r ?o ?m)
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(have_rock_analysis ?r ?p)
			(at_soil_sample ?p)
			(not (visible_from ?o ?p))
			(not (communicated_soil_data ?p))
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
			(visible ?p ?y)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(at ?r ?y)
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (visible ?y ?x)
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(not (can_traverse ?r ?p ?y))
			(not (at ?r ?p))
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (at_rock_sample ?y))
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
			(visible ?x ?p)
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			
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
			(have_soil_analysis ?r ?x)
			(not (visible ?p ?x))
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(can_traverse ?r ?x ?y)
			(available ?r)
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(have_rock_analysis ?r ?x)
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(visible ?p ?y)
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			(can_traverse ?r ?p ?x)
			
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
			(have_soil_analysis ?r ?x)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(not (at_rock_sample ?y))
			(not (visible_from ?o ?x))
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(not (equipped_for_rock_analysis ?r))
			(communicated_image_data ?o ?m)
			
          )
         :effect (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(visible ?x ?y)
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(available ?r)
			(visible_from ?o ?x)
			(have_rock_analysis ?r ?y)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(not (communicated_soil_data ?y))
			(visible_from ?o ?y)
			(not (equipped_for_rock_analysis ?r))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			
          )
    )

)

;; 
;; take_image action has changed: (on_board ?i ?r), (available ?r), (at_soil_sample ?p), (available ?r), (on_board ?i ?r), (at ?r ?p), (communicated_image_data ?o ?m), (visible_from ?o ?p), (supports ?i ?m), (supports ?i ?m), (at ?r ?p), (have_soil_analysis ?r ?p), (equipped_for_rock_analysis ?r), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?p), (communicated_image_data ?o ?m), (communicated_soil_data ?p), (equipped_for_rock_analysis ?r), (calibrated ?i ?r), (at_soil_sample ?p), (have_rock_analysis ?r ?p), (visible_from ?o ?p), (equipped_for_imaging ?r), 
;; communicate_soil_data action has changed: (at ?r ?y), (communicated_soil_data ?x), (visible ?p ?y), (at_lander ?l ?p), (communicated_rock_data ?y), (communicated_soil_data ?x), (visible ?x ?p), (communicated_soil_data ?y), (at_soil_sample ?x), (at_lander ?l ?x), (at_soil_sample ?p), (visible ?x ?p), (at_lander ?l ?x), (can_traverse ?r ?y ?x), (can_traverse ?r ?p ?y), (at_soil_sample ?y), (equipped_for_rock_analysis ?r), (at ?r ?p), (at_rock_sample ?y), (at_soil_sample ?y), (at_rock_sample ?x), (can_traverse ?r ?x ?p), (can_traverse ?r ?y ?p), (available ?r), (communicated_soil_data ?p), (at ?r ?p), (visible ?y ?p), (at ?r ?y), (at ?r ?x), (visible ?x ?y), (at_soil_sample ?x), (can_traverse ?r ?x ?y), (can_traverse ?r ?p ?y), (equipped_for_soil_analysis ?r), (at_lander ?l ?p), (visible ?x ?y), (can_traverse ?r ?y ?x), (have_rock_analysis ?r ?y), (visible ?p ?y), (have_rock_analysis ?r ?p), (communicated_soil_data ?y), (communicated_rock_data ?p), (can_traverse ?r ?y ?p), (have_rock_analysis ?r ?y), (visible ?y ?x), (equipped_for_soil_analysis ?r), (can_traverse ?r ?p ?x), (at_rock_sample ?p), (communicated_rock_data ?y), 
;; communicate_rock_data action has changed: (visible ?p ?y), (visible ?y ?p), (communicated_soil_data ?x), (have_rock_analysis ?r ?x), (at_lander ?l ?x), (equipped_for_soil_analysis ?r), (visible ?x ?y), (equipped_for_rock_analysis ?r), (can_traverse ?r ?x ?y), (have_rock_analysis ?r ?p), (at_lander ?l ?y), (at_soil_sample ?p), (visible ?p ?x), (at_soil_sample ?p), (equipped_for_imaging ?r), (have_soil_analysis ?r ?y), (communicated_soil_data ?p), (communicated_rock_data ?p), (can_traverse ?r ?y ?x), (at ?r ?y), (at_rock_sample ?p), (have_rock_analysis ?r ?x), (at_lander ?l ?x), (can_traverse ?r ?p ?x), (at_rock_sample ?y), (can_traverse ?r ?p ?y), (at_soil_sample ?y), (communicated_rock_data ?p), (at_rock_sample ?x), (have_soil_analysis ?r ?p), (at_rock_sample ?x), (communicated_rock_data ?x), (communicated_soil_data ?x), (communicated_rock_data ?y), (can_traverse ?r ?x ?y), (visible ?x ?p), (have_rock_analysis ?r ?p), (communicated_soil_data ?y), (at ?r ?x), (channel_free ?l), (visible ?p ?x), (can_traverse ?r ?x ?p), (communicated_rock_data ?y), (can_traverse ?r ?y ?p), (communicated_soil_data ?y), (have_soil_analysis ?r ?x), (at_soil_sample ?y), (visible ?y ?p), (can_traverse ?r ?p ?x), (equipped_for_imaging ?r), (visible ?x ?p), (at ?r ?p), (visible ?x ?y), (communicated_soil_data ?p), (channel_free ?l), (have_rock_analysis ?r ?y), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?x), (can_traverse ?r ?y ?p), (equipped_for_soil_analysis ?r), (can_traverse ?r ?x ?p), (can_traverse ?r ?p ?y), (at_soil_sample ?x), (have_rock_analysis ?r ?y), (at_lander ?l ?p), (equipped_for_rock_analysis ?r), 
;; sample_soil action has changed: (equipped_for_imaging ?x), (have_rock_analysis ?x ?p), (equipped_for_rock_analysis ?x), (communicated_rock_data ?p), (equipped_for_soil_analysis ?x), (store_of ?s ?x), (have_soil_analysis ?x ?p), (empty ?s), (have_soil_analysis ?x ?p), (at ?x ?p), (at_rock_sample ?p), (communicated_soil_data ?p), (at_rock_sample ?p), (equipped_for_rock_analysis ?x), (available ?x), (full ?s), (have_rock_analysis ?x ?p), (empty ?s), 
;; navigate action has changed: (at_soil_sample ?y), (visible ?y ?z), (have_soil_analysis ?x ?z), (equipped_for_imaging ?x), (communicated_soil_data ?z), (visible ?z ?y), (communicated_soil_data ?y), (at ?x ?z), (visible ?y ?z), (equipped_for_rock_analysis ?x), (visible ?z ?y), (at_rock_sample ?y), (communicated_soil_data ?y), (communicated_soil_data ?z), (have_soil_analysis ?x ?y), (available ?x), (have_rock_analysis ?x ?z), (can_traverse ?x ?z ?y), (at ?x ?z), (available ?x), (communicated_rock_data ?z), (have_rock_analysis ?x ?z), (at_soil_sample ?y), (communicated_rock_data ?y), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?y), (communicated_rock_data ?y), (equipped_for_soil_analysis ?x), (can_traverse ?x ?y ?z), (at ?x ?y), (at_rock_sample ?y), (communicated_rock_data ?z), (at_rock_sample ?z), (have_soil_analysis ?x ?y), 
;; sample_rock action has changed: (at_soil_sample ?p), (full ?s), (available ?x), (empty ?s), (at_rock_sample ?p), (have_rock_analysis ?x ?p), (store_of ?s ?x), (at_soil_sample ?p), (have_rock_analysis ?x ?p), (equipped_for_rock_analysis ?x), (at_rock_sample ?p), (equipped_for_imaging ?x), (have_soil_analysis ?x ?p), (store_of ?s ?x), (equipped_for_soil_analysis ?x), (communicated_soil_data ?p), (available ?x), (at ?x ?p), (full ?s), (communicated_rock_data ?p), (equipped_for_rock_analysis ?x), (at ?x ?p), 
;; calibrate action has changed: (at ?r ?w), (have_rock_analysis ?r ?w), (visible_from ?t ?w), (available ?r), (have_soil_analysis ?r ?w), (have_soil_analysis ?r ?w), (at_soil_sample ?w), (calibration_target ?i ?t), (available ?r), (at_rock_sample ?w), (at_rock_sample ?w), (equipped_for_imaging ?r), (equipped_for_soil_analysis ?r), (calibrated ?i ?r), (communicated_rock_data ?w), (equipped_for_rock_analysis ?r), (calibration_target ?i ?t), (at_soil_sample ?w), (visible_from ?t ?w), (on_board ?i ?r), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?w), (at ?r ?w), 
;; communicate_image_data action has changed: (have_soil_analysis ?r ?y), (at ?r ?x), (communicated_soil_data ?x), (at_rock_sample ?x), (communicated_image_data ?o ?m), (equipped_for_rock_analysis ?r), (channel_free ?l), (at_rock_sample ?y), (at_lander ?l ?x), (visible ?y ?x), (equipped_for_rock_analysis ?r), (communicated_rock_data ?y), (visible_from ?o ?x), (at_soil_sample ?y), (channel_free ?l), (visible_from ?o ?y), (visible_from ?o ?x), (have_rock_analysis ?r ?y), (available ?r), (equipped_for_imaging ?r), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?y), (at ?r ?y), (communicated_image_data ?o ?m), (have_soil_analysis ?r ?x), (at_soil_sample ?x), (can_traverse ?r ?x ?y), (communicated_soil_data ?x), (visible ?y ?x), (communicated_soil_data ?y), (visible ?x ?y), (at ?r ?y), (at_soil_sample ?y), (communicated_soil_data ?y), (have_rock_analysis ?r ?x), (equipped_for_soil_analysis ?r), 
;; drop action has changed: (equipped_for_rock_analysis ?x), (full ?y), (full ?y), (store_of ?y ?x), (available ?x), (empty ?y), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (empty ?y), (equipped_for_rock_analysis ?x), 
;; Last_reduced_capability_num_dropped_pals: None

