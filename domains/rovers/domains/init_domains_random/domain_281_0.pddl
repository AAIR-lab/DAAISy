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
			(available ?x)
			(visible ?z ?y)
			(equipped_for_imaging ?x)
			(at_rock_sample ?y)
			(not (can_traverse ?x ?z ?y))
			(not (at ?x ?y))
			(have_soil_analysis ?x ?y)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?y))
			(visible ?y ?z)
			(not (equipped_for_rock_analysis ?x))
			(not (can_traverse ?x ?y ?z))
			(not (at ?x ?z))
			(not (have_soil_analysis ?x ?z))
			(have_rock_analysis ?x ?y)
			(equipped_for_soil_analysis ?x)
			
          )
          :effect (and 
               (not (at_rock_sample ?z))
			(have_rock_analysis ?x ?z)
			(available ?x)
			(not (equipped_for_imaging ?x))
			(at_rock_sample ?y)
			(not (can_traverse ?x ?z ?y))
			(not (at ?x ?y))
			(have_soil_analysis ?x ?y)
			(at_soil_sample ?z)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?z))
			(not (equipped_for_rock_analysis ?x))
			(not (can_traverse ?x ?y ?z))
			(at ?x ?z)
			(have_soil_analysis ?x ?z)
			(not (communicated_rock_data ?y))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(at ?x ?p)
			(empty ?s)
			(equipped_for_imaging ?x)
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(not (have_soil_analysis ?x ?p))
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (not (available ?x))
			(at ?x ?p)
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(at_soil_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (not (at ?x ?p))
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(communicated_rock_data ?p)
			
          )
        :effect (and 
               (not (available ?x))
			(not (at ?x ?p))
			(not (empty ?s))
			(full ?s)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(communicated_rock_data ?p)
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (store_of ?y ?x))
			(not (empty ?y))
			(equipped_for_rock_analysis ?x)
			(not (equipped_for_soil_analysis ?x))
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (available ?x)
			(store_of ?y ?x)
			(empty ?y)
			(not (equipped_for_rock_analysis ?x))
			(equipped_for_soil_analysis ?x)
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
               (not (calibration_target ?i ?t))
			(equipped_for_rock_analysis ?r)
			(not (have_soil_analysis ?r ?w))
			(available ?r)
			(not (on_board ?i ?r))
			(not (equipped_for_soil_analysis ?r))
			(not (visible_from ?t ?w))
			(not (communicated_rock_data ?w))
			
          )
         :effect (and 
               (not (have_soil_analysis ?r ?w))
			(available ?r)
			(not (at ?r ?w))
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
			(communicated_soil_data ?w)
			(not (communicated_rock_data ?w))
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
               (not (communicated_image_data ?o ?m))
			(not (have_soil_analysis ?r ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(equipped_for_soil_analysis ?r)
			(not (on_board ?i ?r))
			(have_rock_analysis ?r ?p)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (visible_from ?o ?p))
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
			(at ?r ?p)
			
          )
          :effect (and 
               (not (have_soil_analysis ?r ?p))
			(calibration_target ?i ?o)
			(not (equipped_for_imaging ?r))
			(not (on_board ?i ?r))
			(not (have_rock_analysis ?r ?p))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (communicated_soil_data ?p))
			(communicated_rock_data ?p)
			
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
			(visible ?y ?x)
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(visible ?p ?x)
			(not (visible ?p ?y))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(not (have_soil_analysis ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(have_rock_analysis ?r ?x)
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
			(visible ?x ?p)
			(not (visible ?y ?p))
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?p ?y))
			(not (at ?r ?p))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(at_rock_sample ?y)
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(not (at_lander ?l ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(at_lander ?l ?p)
			(visible ?x ?p)
			(not (can_traverse ?r ?y ?x))
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
               (equipped_for_imaging ?r)
			(visible ?y ?x)
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(visible ?x ?y)
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (available ?r))
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(not (communicated_soil_data ?p))
			(visible ?x ?p)
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?p ?y))
			(at ?r ?p)
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(not (at_lander ?l ?p))
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
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
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(visible ?y ?x)
			(have_image ?r ?o ?m)
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(at_rock_sample ?y)
			(visible_from ?o ?x)
			(not (at ?r ?x))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			(not (visible_from ?o ?y))
			(not (can_traverse ?r ?y ?x))
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (not (channel_free ?l))
			(not (have_image ?r ?o ?m))
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(at_rock_sample ?x)
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(available ?r)
			(not (at_rock_sample ?y))
			(visible_from ?o ?x)
			(at ?r ?x)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			(visible_from ?o ?y)
			(not (equipped_for_rock_analysis ?r))
			(not (communicated_rock_data ?y))
			
          )
    )

)

;; 
;; sample_soil action has changed: (at_rock_sample ?p), (equipped_for_imaging ?x), (have_rock_analysis ?x ?p), (communicated_rock_data ?p), (equipped_for_rock_analysis ?x), (communicated_soil_data ?p), (have_soil_analysis ?x ?p), (have_rock_analysis ?x ?p), (at_soil_sample ?p), (at ?x ?p), (have_soil_analysis ?x ?p), (full ?s), (at_soil_sample ?p), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (available ?x), (available ?x), (equipped_for_soil_analysis ?x), (equipped_for_soil_analysis ?x), 
;; communicate_soil_data action has changed: (communicated_rock_data ?x), (communicated_soil_data ?p), (communicated_rock_data ?y), (have_soil_analysis ?r ?x), (at_rock_sample ?y), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?y), (visible ?y ?x), (at_soil_sample ?x), (at_rock_sample ?y), (available ?r), (channel_free ?l), (communicated_rock_data ?x), (have_soil_analysis ?r ?x), (at_soil_sample ?p), (at ?r ?p), (communicated_soil_data ?x), (equipped_for_soil_analysis ?r), (can_traverse ?r ?p ?y), (can_traverse ?r ?x ?y), (visible ?p ?x), (at_lander ?l ?x), (at_rock_sample ?x), (communicated_soil_data ?y), (can_traverse ?r ?y ?p), (at ?r ?x), (at_soil_sample ?x), (communicated_rock_data ?y), (visible ?x ?p), (communicated_soil_data ?x), (communicated_rock_data ?p), (at ?r ?x), (can_traverse ?r ?p ?x), (can_traverse ?r ?p ?y), (at_rock_sample ?p), (have_rock_analysis ?r ?x), (can_traverse ?r ?y ?x), (visible ?y ?p), (can_traverse ?r ?p ?x), (at_soil_sample ?y), (have_rock_analysis ?r ?p), (visible ?p ?x), (can_traverse ?r ?x ?y), (visible ?p ?y), (visible ?y ?x), (at_lander ?l ?p), (communicated_soil_data ?p), (have_soil_analysis ?r ?y), (at_lander ?l ?y), (at_rock_sample ?x), (at_lander ?l ?p), (have_rock_analysis ?r ?p), (at ?r ?y), (visible ?x ?p), 
;; communicate_image_data action has changed: (visible_from ?o ?y), (at_soil_sample ?y), (at_rock_sample ?y), (communicated_image_data ?o ?m), (have_soil_analysis ?r ?x), (at ?r ?x), (have_rock_analysis ?r ?x), (visible_from ?o ?x), (communicated_soil_data ?y), (at ?r ?y), (at_soil_sample ?x), (have_image ?r ?o ?m), (equipped_for_imaging ?r), (at_lander ?l ?x), (communicated_rock_data ?y), (visible ?x ?y), (visible ?y ?x), (at_soil_sample ?x), (at_lander ?l ?x), (channel_free ?l), (communicated_soil_data ?x), (available ?r), (can_traverse ?r ?x ?y), (have_rock_analysis ?r ?x), (have_soil_analysis ?r ?x), (communicated_image_data ?o ?m), (at ?r ?y), (can_traverse ?r ?y ?x), (have_rock_analysis ?r ?y), (have_soil_analysis ?r ?y), (at ?r ?x), (equipped_for_rock_analysis ?r), (communicated_soil_data ?y), (equipped_for_soil_analysis ?r), (visible_from ?o ?x), (communicated_rock_data ?x), (have_rock_analysis ?r ?y), (at_rock_sample ?y), (available ?r), (communicated_rock_data ?x), (channel_free ?l), (at_rock_sample ?x), (communicated_soil_data ?x), (visible_from ?o ?y), (at_lander ?l ?y), 
;; take_image action has changed: (equipped_for_rock_analysis ?r), (on_board ?i ?r), (have_soil_analysis ?r ?p), (calibration_target ?i ?o), (have_rock_analysis ?r ?p), (visible_from ?o ?p), (communicated_rock_data ?p), (supports ?i ?m), (available ?r), (equipped_for_imaging ?r), (equipped_for_imaging ?r), (have_soil_analysis ?r ?p), (at_rock_sample ?p), (have_rock_analysis ?r ?p), (communicated_rock_data ?p), (at_soil_sample ?p), (communicated_soil_data ?p), (calibrated ?i ?r), (communicated_soil_data ?p), (at_soil_sample ?p), (equipped_for_soil_analysis ?r), (have_image ?r ?o ?m), (on_board ?i ?r), (at_rock_sample ?p), (calibrated ?i ?r), (communicated_image_data ?o ?m), 
;; calibrate action has changed: (on_board ?i ?r), (communicated_soil_data ?w), (visible_from ?t ?w), (communicated_rock_data ?w), (equipped_for_soil_analysis ?r), (available ?r), (calibration_target ?i ?t), (at ?r ?w), (have_soil_analysis ?r ?w), (equipped_for_imaging ?r), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?w), (have_soil_analysis ?r ?w), (equipped_for_soil_analysis ?r), (communicated_rock_data ?w), (at_soil_sample ?w), (at ?r ?w), (available ?r), (calibrated ?i ?r), (visible_from ?t ?w), 
;; communicate_rock_data action has changed: (visible ?x ?p), (have_rock_analysis ?r ?p), (have_rock_analysis ?r ?y), (at_lander ?l ?p), (have_rock_analysis ?r ?x), (communicated_rock_data ?p), (at ?r ?p), (visible ?y ?x), (communicated_rock_data ?y), (can_traverse ?r ?y ?x), (at ?r ?y), (have_rock_analysis ?r ?y), (have_rock_analysis ?r ?x), (can_traverse ?r ?p ?y), (at_rock_sample ?x), (visible ?y ?p), (visible ?p ?y), (communicated_rock_data ?p), (have_soil_analysis ?r ?x), (at_soil_sample ?p), (at_soil_sample ?y), (visible ?p ?y), (at_soil_sample ?x), (communicated_soil_data ?p), (communicated_soil_data ?y), (visible ?y ?x), (at_lander ?l ?x), (channel_free ?l), (communicated_rock_data ?x), (can_traverse ?r ?y ?p), (at_lander ?l ?y), (communicated_soil_data ?y), (at_rock_sample ?y), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?p), (can_traverse ?r ?p ?x), (have_soil_analysis ?r ?x), (visible ?y ?p), (equipped_for_soil_analysis ?r), (can_traverse ?r ?x ?y), (can_traverse ?r ?y ?x), (at_lander ?l ?x), (equipped_for_imaging ?r), (can_traverse ?r ?p ?x), (channel_free ?l), (at_soil_sample ?p), (available ?r), (at ?r ?x), (at_rock_sample ?y), (can_traverse ?r ?x ?y), (visible ?x ?p), (at_rock_sample ?p), (visible ?p ?x), (at ?r ?p), (at_lander ?l ?y), (have_soil_analysis ?r ?y), (communicated_rock_data ?x), (visible ?p ?x), (can_traverse ?r ?y ?p), (at_soil_sample ?x), (equipped_for_rock_analysis ?r), (available ?r), 
;; drop action has changed: (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (available ?x), (empty ?y), (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), (store_of ?y ?x), (full ?y), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (store_of ?y ?x), 
;; navigate action has changed: (equipped_for_rock_analysis ?x), (at ?x ?z), (have_soil_analysis ?x ?y), (have_soil_analysis ?x ?z), (can_traverse ?x ?z ?y), (at ?x ?y), (at_rock_sample ?y), (have_rock_analysis ?x ?z), (available ?x), (at_soil_sample ?z), (have_rock_analysis ?x ?y), (communicated_soil_data ?y), (at_rock_sample ?y), (have_soil_analysis ?x ?y), (can_traverse ?x ?z ?y), (equipped_for_imaging ?x), (at_rock_sample ?z), (visible ?z ?y), (have_rock_analysis ?x ?z), (equipped_for_imaging ?x), (communicated_rock_data ?y), (at_soil_sample ?y), (at_soil_sample ?y), (have_soil_analysis ?x ?z), (can_traverse ?x ?y ?z), (equipped_for_rock_analysis ?x), (communicated_soil_data ?z), (can_traverse ?x ?y ?z), (equipped_for_soil_analysis ?x), 
;; sample_rock action has changed: (have_rock_analysis ?x ?p), (at ?x ?p), (empty ?s), (store_of ?s ?x), (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), (at ?x ?p), (equipped_for_imaging ?x), (at_soil_sample ?p), (available ?x), (communicated_rock_data ?p), (at_rock_sample ?p), (communicated_soil_data ?p), (at_soil_sample ?p), (communicated_rock_data ?p), 
;; Last_reduced_capability_num_dropped_pals: None

