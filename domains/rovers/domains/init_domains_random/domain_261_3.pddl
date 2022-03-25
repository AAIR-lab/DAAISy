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
			(not (visible ?z ?y))
			(equipped_for_imaging ?x)
			(not (at_soil_sample ?y))
			(communicated_soil_data ?z)
			(communicated_soil_data ?y)
			(not (visible ?y ?z))
			(equipped_for_rock_analysis ?x)
			(can_traverse ?x ?y ?z)
			(not (at ?x ?z))
			(have_rock_analysis ?x ?y)
			(communicated_rock_data ?y)
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (not (at_rock_sample ?z))
			(equipped_for_imaging ?x)
			(not (can_traverse ?x ?z ?y))
			(at ?x ?y)
			(not (have_soil_analysis ?x ?y))
			(at_soil_sample ?z)
			(communicated_soil_data ?z)
			(communicated_rock_data ?z)
			(not (communicated_soil_data ?y))
			(visible ?y ?z)
			(at ?x ?z)
			(have_soil_analysis ?x ?z)
			(have_rock_analysis ?x ?y)
			(communicated_rock_data ?y)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(not (at ?x ?p))
			(empty ?s)
			(equipped_for_imaging ?x)
			(not (full ?s))
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(communicated_rock_data ?p)
			
          )
        :effect (and 
               (not (available ?x))
			(at ?x ?p)
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
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
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(not (store_of ?s ?x))
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (at ?x ?p))
			(not (empty ?s))
			(full ?s)
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(not (have_soil_analysis ?x ?p))
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
			(not (store_of ?y ?x))
			(not (empty ?y))
			(equipped_for_soil_analysis ?x)
			(full ?y)
			(not (equipped_for_imaging ?x))
			
          )
        :effect (and 
               (not (available ?x))
			(not (store_of ?y ?x))
			(not (empty ?y))
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
			(available ?r)
			(at ?r ?w)
			(not (on_board ?i ?r))
			(at_rock_sample ?w)
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			(have_rock_analysis ?r ?w)
			(communicated_soil_data ?w)
			(communicated_rock_data ?w)
			(not (calibrated ?i ?r))
			
          )
         :effect (and 
               (not (available ?r))
			(not (equipped_for_imaging ?r))
			(not (at ?r ?w))
			(not (on_board ?i ?r))
			(equipped_for_soil_analysis ?r)
			(not (have_rock_analysis ?r ?w))
			(communicated_soil_data ?w)
			(communicated_rock_data ?w)
			(not (at_soil_sample ?w))
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
               (equipped_for_rock_analysis ?r)
			(not (available ?r))
			(not (have_image ?r ?o ?m))
			(calibration_target ?i ?o)
			(not (on_board ?i ?r))
			(not (have_rock_analysis ?r ?p))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (visible_from ?o ?p))
			(not (communicated_soil_data ?p))
			(not (communicated_rock_data ?p))
			(not (calibrated ?i ?r))
			(at ?r ?p)
			
          )
          :effect (and 
               (not (supports ?i ?m))
			(not (communicated_image_data ?o ?m))
			(not (have_soil_analysis ?r ?p))
			(not (have_image ?r ?o ?m))
			(not (equipped_for_imaging ?r))
			(not (on_board ?i ?r))
			(have_rock_analysis ?r ?p)
			(at_soil_sample ?p)
			(visible_from ?o ?p)
			(not (communicated_rock_data ?p))
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
			(not (equipped_for_imaging ?r))
			(not (have_soil_analysis ?r ?x))
			(not (visible ?p ?x))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(have_soil_analysis ?r ?y)
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(not (at_soil_sample ?p))
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(not (at_lander ?l ?y))
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(have_rock_analysis ?r ?x)
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(visible ?y ?p)
			(not (communicated_rock_data ?y))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (visible ?y ?x))
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(visible ?p ?y)
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(not (at_rock_sample ?y))
			(not (at_rock_sample ?p))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(have_rock_analysis ?r ?x)
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(can_traverse ?r ?y ?x)
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
               (equipped_for_imaging ?r)
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(not (can_traverse ?r ?p ?y))
			(at ?r ?p)
			(not (at ?r ?y))
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(at_lander ?l ?p)
			(not (equipped_for_rock_analysis ?r))
			(visible ?x ?p)
			(can_traverse ?r ?y ?x)
			
          )
          :effect (and 
               (not (channel_free ?l))
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(can_traverse ?r ?p ?y)
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(available ?r)
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?x)
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
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
               (channel_free ?l)
			(not (have_image ?r ?o ?m))
			(visible ?x ?y)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(at_rock_sample ?y)
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(not (have_rock_analysis ?r ?y))
			(at_soil_sample ?y)
			(not (at_soil_sample ?x))
			(equipped_for_rock_analysis ?r)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (equipped_for_imaging ?r)
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(not (visible ?x ?y))
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(not (available ?r))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; communicate_image_data action has changed: (have_rock_analysis ?r ?y), (at ?r ?y), (at_soil_sample ?x), (can_traverse ?r ?y ?x), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?y), (communicated_image_data ?o ?m), (at_lander ?l ?y), (equipped_for_imaging ?r), (at ?r ?y), (visible_from ?o ?x), (visible_from ?o ?y), (communicated_rock_data ?y), (at_lander ?l ?x), (available ?r), (have_rock_analysis ?r ?x), (can_traverse ?r ?x ?y), (communicated_rock_data ?x), (communicated_image_data ?o ?m), (at_soil_sample ?x), (equipped_for_rock_analysis ?r), (have_image ?r ?o ?m), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?x), (communicated_rock_data ?y), (at_lander ?l ?y), (visible ?x ?y), (available ?r), (at_rock_sample ?y), (at_soil_sample ?y), (communicated_soil_data ?y), (have_rock_analysis ?r ?y), (can_traverse ?r ?x ?y), 
;; take_image action has changed: (communicated_rock_data ?p), (calibrated ?i ?r), (on_board ?i ?r), (at_soil_sample ?p), (communicated_rock_data ?p), (equipped_for_rock_analysis ?r), (calibrated ?i ?r), (have_rock_analysis ?r ?p), (have_rock_analysis ?r ?p), (on_board ?i ?r), (equipped_for_imaging ?r), (supports ?i ?m), (visible_from ?o ?p), (equipped_for_imaging ?r), (have_image ?r ?o ?m), (have_image ?r ?o ?m), (have_soil_analysis ?r ?p), (at ?r ?p), (calibration_target ?i ?o), (visible_from ?o ?p), (communicated_image_data ?o ?m), (supports ?i ?m), (available ?r), (communicated_soil_data ?p), (at_soil_sample ?p), (at_rock_sample ?p), 
;; communicate_soil_data action has changed: (visible ?p ?x), (at_soil_sample ?x), (equipped_for_rock_analysis ?r), (communicated_rock_data ?y), (communicated_rock_data ?y), (equipped_for_soil_analysis ?r), (at_lander ?l ?x), (can_traverse ?r ?x ?p), (at ?r ?x), (have_rock_analysis ?r ?x), (can_traverse ?r ?x ?y), (at_rock_sample ?y), (visible ?x ?p), (communicated_soil_data ?x), (channel_free ?l), (have_soil_analysis ?r ?p), (at_lander ?l ?y), (communicated_rock_data ?p), (have_rock_analysis ?r ?p), (visible ?x ?p), (communicated_rock_data ?x), (have_soil_analysis ?r ?y), (have_soil_analysis ?r ?x), (at_rock_sample ?p), (can_traverse ?r ?p ?x), (at_soil_sample ?x), (visible ?p ?y), (at_lander ?l ?p), (at ?r ?p), (can_traverse ?r ?p ?y), (visible ?y ?x), (equipped_for_imaging ?r), (communicated_soil_data ?x), (communicated_soil_data ?y), (can_traverse ?r ?x ?y), (communicated_soil_data ?y), (at_rock_sample ?x), (have_rock_analysis ?r ?y), (visible ?p ?x), (at_soil_sample ?y), (have_soil_analysis ?r ?p), (can_traverse ?r ?x ?p), (can_traverse ?r ?p ?x), (available ?r), (at_soil_sample ?p), (can_traverse ?r ?y ?x), (at_rock_sample ?x), (have_rock_analysis ?r ?x), (equipped_for_rock_analysis ?r), (communicated_soil_data ?p), (have_soil_analysis ?r ?y), (at ?r ?y), (visible ?y ?p), (have_rock_analysis ?r ?y), 
;; communicate_rock_data action has changed: (at ?r ?y), (at_soil_sample ?x), (can_traverse ?r ?p ?x), (can_traverse ?r ?p ?y), (communicated_soil_data ?y), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?x), (at_soil_sample ?p), (communicated_rock_data ?x), (channel_free ?l), (can_traverse ?r ?x ?p), (equipped_for_imaging ?r), (equipped_for_rock_analysis ?r), (at_soil_sample ?y), (communicated_rock_data ?y), (channel_free ?l), (at ?r ?p), (communicated_soil_data ?p), (equipped_for_soil_analysis ?r), (available ?r), (communicated_rock_data ?x), (visible ?p ?y), (at_rock_sample ?p), (communicated_rock_data ?p), (visible ?y ?x), (communicated_soil_data ?x), (at_rock_sample ?y), (equipped_for_rock_analysis ?r), (visible ?p ?x), (equipped_for_imaging ?r), (can_traverse ?r ?y ?x), (at_lander ?l ?p), (visible ?y ?p), (communicated_soil_data ?x), (have_rock_analysis ?r ?y), (at_rock_sample ?y), (can_traverse ?r ?p ?y), (at_lander ?l ?x), (visible ?y ?x), (have_soil_analysis ?r ?x), (can_traverse ?r ?y ?p), (at_soil_sample ?x), (can_traverse ?r ?y ?p), (at ?r ?x), (visible ?x ?y), (can_traverse ?r ?y ?x), (available ?r), (visible ?x ?p), (at ?r ?y), (at_soil_sample ?p), (have_soil_analysis ?r ?y), (have_rock_analysis ?r ?y), (have_soil_analysis ?r ?x), 
;; calibrate action has changed: (communicated_soil_data ?w), (at_rock_sample ?w), (communicated_rock_data ?w), (equipped_for_rock_analysis ?r), (on_board ?i ?r), (communicated_soil_data ?w), (calibrated ?i ?r), (on_board ?i ?r), (calibration_target ?i ?t), (equipped_for_soil_analysis ?r), (at_soil_sample ?w), (available ?r), (have_rock_analysis ?r ?w), (equipped_for_imaging ?r), (at ?r ?w), (communicated_rock_data ?w), (equipped_for_soil_analysis ?r), (available ?r), (calibrated ?i ?r), (have_rock_analysis ?r ?w), (equipped_for_imaging ?r), 
;; sample_soil action has changed: (communicated_rock_data ?p), (have_soil_analysis ?x ?p), (equipped_for_soil_analysis ?x), (at ?x ?p), (communicated_soil_data ?p), (available ?x), (at_soil_sample ?p), (equipped_for_imaging ?x), (store_of ?s ?x), (at ?x ?p), (equipped_for_imaging ?x), (full ?s), (available ?x), (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?p), (equipped_for_soil_analysis ?x), (store_of ?s ?x), (communicated_soil_data ?p), 
;; drop action has changed: (store_of ?y ?x), (empty ?y), (full ?y), (equipped_for_imaging ?x), (store_of ?y ?x), (equipped_for_imaging ?x), (available ?x), (empty ?y), (equipped_for_soil_analysis ?x), (equipped_for_soil_analysis ?x), (available ?x), 
;; navigate action has changed: (at_rock_sample ?z), (equipped_for_imaging ?x), (communicated_rock_data ?z), (communicated_soil_data ?y), (communicated_rock_data ?y), (have_rock_analysis ?x ?y), (equipped_for_rock_analysis ?x), (communicated_soil_data ?y), (at ?x ?y), (communicated_rock_data ?y), (at ?x ?z), (visible ?y ?z), (communicated_soil_data ?z), (equipped_for_soil_analysis ?x), (can_traverse ?x ?z ?y), (communicated_soil_data ?z), (have_soil_analysis ?x ?y), (at ?x ?y), (equipped_for_imaging ?x), (available ?x), (at_soil_sample ?z), (have_rock_analysis ?x ?y), (at_soil_sample ?y), (visible ?z ?y), (visible ?y ?z), (have_soil_analysis ?x ?z), (have_rock_analysis ?x ?z), 
;; sample_rock action has changed: (have_rock_analysis ?x ?p), (have_soil_analysis ?x ?p), (at_rock_sample ?p), (equipped_for_imaging ?x), (available ?x), (at ?x ?p), (full ?s), (equipped_for_soil_analysis ?x), (communicated_soil_data ?p), (equipped_for_rock_analysis ?x), (empty ?s), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?p), (at ?x ?p), (at_soil_sample ?p), (store_of ?s ?x), (equipped_for_rock_analysis ?x), (store_of ?s ?x), 
;; Last_reduced_capability_num_dropped_pals: None

