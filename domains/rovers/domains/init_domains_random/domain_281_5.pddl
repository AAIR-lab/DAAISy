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
			(not (have_rock_analysis ?x ?z))
			(not (available ?x))
			(visible ?z ?y)
			(equipped_for_imaging ?x)
			(at_rock_sample ?y)
			(not (can_traverse ?x ?z ?y))
			(not (have_soil_analysis ?x ?y))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?z))
			(not (communicated_soil_data ?y))
			(not (visible ?y ?z))
			(equipped_for_rock_analysis ?x)
			(not (can_traverse ?x ?y ?z))
			(not (at ?x ?z))
			(have_soil_analysis ?x ?z)
			(not (communicated_rock_data ?y))
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (at_rock_sample ?z)
			(have_rock_analysis ?x ?z)
			(visible ?z ?y)
			(equipped_for_imaging ?x)
			(can_traverse ?x ?z ?y)
			(at ?x ?y)
			(have_soil_analysis ?x ?y)
			(not (at_soil_sample ?y))
			(not (communicated_rock_data ?z))
			(visible ?y ?z)
			(equipped_for_rock_analysis ?x)
			(at ?x ?z)
			(have_soil_analysis ?x ?z)
			(not (have_rock_analysis ?x ?y))
			(communicated_rock_data ?y)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(at ?x ?p)
			(not (empty ?s))
			(not (full ?s))
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(not (communicated_soil_data ?p))
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (available ?x)
			(not (at ?x ?p))
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (available ?x)
			(not (at ?x ?p))
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (store_of ?s ?x))
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (available ?x))
			(empty ?s)
			(equipped_for_imaging ?x)
			(not (full ?s))
			(not (store_of ?s ?x))
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(not (have_soil_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (store_of ?y ?x))
			(not (empty ?y))
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (store_of ?y ?x)
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
               (not (have_soil_analysis ?r ?w))
			(not (available ?r))
			(equipped_for_imaging ?r)
			(not (at ?r ?w))
			(on_board ?i ?r)
			(not (at_rock_sample ?w))
			(visible_from ?t ?w)
			(have_rock_analysis ?r ?w)
			(communicated_soil_data ?w)
			(not (communicated_rock_data ?w))
			(at_soil_sample ?w)
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(not (available ?r))
			(equipped_for_imaging ?r)
			(not (at ?r ?w))
			(on_board ?i ?r)
			(at_rock_sample ?w)
			(not (equipped_for_soil_analysis ?r))
			(not (visible_from ?t ?w))
			(communicated_soil_data ?w)
			(communicated_rock_data ?w)
			(at_soil_sample ?w)
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
			(have_soil_analysis ?r ?p)
			(not (equipped_for_rock_analysis ?r))
			(available ?r)
			(not (equipped_for_soil_analysis ?r))
			(not (equipped_for_imaging ?r))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(communicated_soil_data ?p)
			
          )
          :effect (and 
               (not (communicated_image_data ?o ?m))
			(available ?r)
			(not (equipped_for_soil_analysis ?r))
			(not (equipped_for_imaging ?r))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (visible_from ?o ?p))
			(communicated_soil_data ?p)
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
			(not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(visible ?p ?y)
			(not (at ?r ?p))
			(not (can_traverse ?r ?x ?y))
			(not (available ?r))
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(not (visible ?y ?p))
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (not (channel_free ?l))
			(have_soil_analysis ?r ?x)
			(not (visible ?p ?x))
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(at ?r ?x)
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?x))
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(can_traverse ?r ?y ?x)
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
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(visible ?p ?y)
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (available ?r))
			(not (at_rock_sample ?y))
			(at_rock_sample ?p)
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			(not (visible ?x ?p))
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (visible ?y ?x)
			(communicated_rock_data ?x)
			(visible ?p ?y)
			(not (visible ?x ?y))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (available ?r))
			(at_rock_sample ?y)
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
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
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(visible ?y ?x)
			(not (have_image ?r ?o ?m))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(not (at_rock_sample ?y))
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(visible_from ?o ?y)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			
          )
         :effect (and 
               (not (channel_free ?l))
			(visible ?y ?x)
			(have_image ?r ?o ?m)
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(not (available ?r))
			(at_rock_sample ?y)
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(not (visible_from ?o ?y))
			(equipped_for_rock_analysis ?r)
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (communicated_rock_data ?x), (at_rock_sample ?y), (can_traverse ?r ?y ?x), (visible ?x ?y), (have_rock_analysis ?r ?x), (visible ?p ?x), (at_lander ?l ?x), (communicated_soil_data ?y), (visible ?y ?p), (communicated_soil_data ?x), (at ?r ?x), (have_rock_analysis ?r ?x), (visible ?y ?x), (can_traverse ?r ?p ?y), (at ?r ?y), (have_soil_analysis ?r ?y), (at ?r ?y), (equipped_for_soil_analysis ?r), (at_lander ?l ?y), (at_soil_sample ?y), (available ?r), (communicated_rock_data ?x), (communicated_rock_data ?y), (visible ?y ?p), (visible ?p ?y), (can_traverse ?r ?p ?x), (have_rock_analysis ?r ?p), (can_traverse ?r ?y ?x), (equipped_for_rock_analysis ?r), (visible ?x ?y), (at ?r ?x), (have_rock_analysis ?r ?y), (can_traverse ?r ?x ?y), (communicated_soil_data ?y), (communicated_rock_data ?p), (visible ?p ?y), (at_lander ?l ?x), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?y), (have_soil_analysis ?r ?x), (at_lander ?l ?y), (can_traverse ?r ?y ?p), (communicated_soil_data ?p), (visible ?y ?x), (at_rock_sample ?y), (communicated_rock_data ?p), (have_rock_analysis ?r ?p), (can_traverse ?r ?y ?p), (at_rock_sample ?x), (have_rock_analysis ?r ?y), (available ?r), (equipped_for_imaging ?r), (at_rock_sample ?p), (visible ?x ?p), (at_rock_sample ?p), 
;; communicate_soil_data action has changed: (equipped_for_rock_analysis ?r), (can_traverse ?r ?p ?y), (at ?r ?p), (at_rock_sample ?y), (can_traverse ?r ?x ?y), (have_soil_analysis ?r ?p), (communicated_soil_data ?x), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?x), (visible ?y ?p), (at_rock_sample ?p), (at_lander ?l ?x), (visible ?p ?x), (have_rock_analysis ?r ?p), (at ?r ?p), (can_traverse ?r ?y ?x), (communicated_soil_data ?y), (can_traverse ?r ?x ?p), (have_rock_analysis ?r ?p), (at_rock_sample ?x), (at ?r ?x), (have_soil_analysis ?r ?y), (can_traverse ?r ?x ?p), (visible ?p ?x), (equipped_for_soil_analysis ?r), (at ?r ?y), (at ?r ?x), (communicated_rock_data ?p), (visible ?y ?x), (at_soil_sample ?y), (at_lander ?l ?x), (communicated_rock_data ?x), (at_soil_sample ?y), (communicated_soil_data ?p), (have_soil_analysis ?r ?x), (visible ?x ?p), (at_soil_sample ?p), (visible ?p ?y), (at_rock_sample ?p), (can_traverse ?r ?y ?p), (communicated_rock_data ?y), (visible ?x ?y), (communicated_rock_data ?p), (at_lander ?l ?y), (communicated_soil_data ?y), (at_lander ?l ?p), (can_traverse ?r ?p ?x), (available ?r), (channel_free ?l), (can_traverse ?r ?x ?y), (have_rock_analysis ?r ?x), (have_soil_analysis ?r ?p), (at_soil_sample ?x), (equipped_for_rock_analysis ?r), (available ?r), (communicated_soil_data ?p), (visible ?x ?p), (have_rock_analysis ?r ?x), (communicated_rock_data ?y), 
;; calibrate action has changed: (calibrated ?i ?r), (have_soil_analysis ?r ?w), (visible_from ?t ?w), (at_soil_sample ?w), (available ?r), (calibration_target ?i ?t), (available ?r), (communicated_rock_data ?w), (communicated_rock_data ?w), (have_rock_analysis ?r ?w), (at_rock_sample ?w), (equipped_for_soil_analysis ?r), (at_soil_sample ?w), (at ?r ?w), (on_board ?i ?r), (at_rock_sample ?w), (equipped_for_imaging ?r), (calibration_target ?i ?t), (at ?r ?w), (communicated_soil_data ?w), (communicated_soil_data ?w), 
;; communicate_image_data action has changed: (have_rock_analysis ?r ?x), (visible ?y ?x), (communicated_soil_data ?x), (have_soil_analysis ?r ?x), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?y), (equipped_for_rock_analysis ?r), (available ?r), (at ?r ?y), (at_rock_sample ?y), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?y), (at_soil_sample ?y), (channel_free ?l), (at_soil_sample ?x), (visible ?x ?y), (have_rock_analysis ?r ?x), (equipped_for_imaging ?r), (equipped_for_soil_analysis ?r), (visible_from ?o ?y), (channel_free ?l), (at_rock_sample ?y), (communicated_rock_data ?x), (visible ?x ?y), (communicated_rock_data ?y), (at_rock_sample ?x), (can_traverse ?r ?y ?x), (communicated_image_data ?o ?m), (communicated_soil_data ?y), (have_rock_analysis ?r ?y), (can_traverse ?r ?x ?y), (communicated_soil_data ?y), (visible ?y ?x), (at ?r ?y), (visible_from ?o ?y), (have_image ?r ?o ?m), (visible_from ?o ?x), (have_image ?r ?o ?m), (at_lander ?l ?y), (communicated_soil_data ?x), (communicated_rock_data ?y), (can_traverse ?r ?x ?y), 
;; sample_rock action has changed: (at ?x ?p), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?p), (at_rock_sample ?p), (available ?x), (equipped_for_imaging ?x), (full ?s), (empty ?s), (communicated_rock_data ?p), (communicated_soil_data ?p), (equipped_for_soil_analysis ?x), (have_soil_analysis ?x ?p), (available ?x), (store_of ?s ?x), (have_soil_analysis ?x ?p), (full ?s), (communicated_soil_data ?p), (store_of ?s ?x), (equipped_for_imaging ?x), (empty ?s), (have_rock_analysis ?x ?p), 
;; navigate action has changed: (equipped_for_soil_analysis ?x), (visible ?z ?y), (available ?x), (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?y), (communicated_soil_data ?z), (communicated_rock_data ?y), (at ?x ?y), (visible ?y ?z), (equipped_for_rock_analysis ?x), (can_traverse ?x ?z ?y), (visible ?y ?z), (have_soil_analysis ?x ?y), (at_soil_sample ?y), (have_soil_analysis ?x ?y), (have_soil_analysis ?x ?z), (can_traverse ?x ?y ?z), (equipped_for_imaging ?x), (at ?x ?y), (communicated_rock_data ?y), (communicated_rock_data ?z), (have_soil_analysis ?x ?z), (at_soil_sample ?y), (visible ?z ?y), (at_rock_sample ?y), (have_rock_analysis ?x ?z), (at_rock_sample ?z), (at_rock_sample ?z), (have_rock_analysis ?x ?z), (equipped_for_imaging ?x), (at ?x ?z), (communicated_soil_data ?y), (can_traverse ?x ?z ?y), 
;; sample_soil action has changed: (available ?x), (have_rock_analysis ?x ?p), (communicated_soil_data ?p), (have_rock_analysis ?x ?p), (equipped_for_soil_analysis ?x), (at_soil_sample ?p), (at_soil_sample ?p), (available ?x), (full ?s), (at_rock_sample ?p), (full ?s), (communicated_soil_data ?p), (equipped_for_imaging ?x), (at ?x ?p), (equipped_for_rock_analysis ?x), (empty ?s), (equipped_for_soil_analysis ?x), 
;; drop action has changed: (equipped_for_soil_analysis ?x), (store_of ?y ?x), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (full ?y), (store_of ?y ?x), (empty ?y), (full ?y), (empty ?y), 
;; take_image action has changed: (equipped_for_imaging ?r), (at_rock_sample ?p), (visible_from ?o ?p), (at ?r ?p), (available ?r), (on_board ?i ?r), (have_image ?r ?o ?m), (equipped_for_rock_analysis ?r), (communicated_soil_data ?p), (at_soil_sample ?p), (at_soil_sample ?p), (communicated_soil_data ?p), (at_rock_sample ?p), (calibrated ?i ?r), (equipped_for_soil_analysis ?r), (communicated_image_data ?o ?m), (available ?r), (equipped_for_soil_analysis ?r), (communicated_rock_data ?p), (equipped_for_imaging ?r), (visible_from ?o ?p), (at ?r ?p), (communicated_image_data ?o ?m), (have_soil_analysis ?r ?p), 
;; Last_reduced_capability_num_dropped_pals: None
