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
			(visible ?z ?y)
			(not (equipped_for_imaging ?x))
			(at_rock_sample ?y)
			(can_traverse ?x ?z ?y)
			(not (have_soil_analysis ?x ?y))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?z))
			(not (communicated_rock_data ?z))
			(communicated_soil_data ?y)
			(not (visible ?y ?z))
			(not (can_traverse ?x ?y ?z))
			(at ?x ?z)
			(not (have_rock_analysis ?x ?y))
			(not (communicated_rock_data ?y))
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (not (at_rock_sample ?z))
			(have_rock_analysis ?x ?z)
			(available ?x)
			(visible ?z ?y)
			(not (at_rock_sample ?y))
			(at ?x ?y)
			(at_soil_sample ?z)
			(at_soil_sample ?y)
			(communicated_soil_data ?z)
			(not (communicated_rock_data ?z))
			(not (communicated_soil_data ?y))
			(not (visible ?y ?z))
			(equipped_for_rock_analysis ?x)
			(not (can_traverse ?x ?y ?z))
			(not (have_soil_analysis ?x ?z))
			(not (have_rock_analysis ?x ?y))
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (available ?x))
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(not (store_of ?s ?x))
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (available ?x)
			(at ?x ?p)
			(empty ?s)
			(at_rock_sample ?p)
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
			(not (empty ?y))
			(not (equipped_for_soil_analysis ?x))
			(not (full ?y))
			(not (equipped_for_imaging ?x))
			
          )
        :effect (and 
               (available ?x)
			(not (store_of ?y ?x))
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
               (equipped_for_rock_analysis ?r)
			(not (have_soil_analysis ?r ?w))
			(available ?r)
			(not (at_rock_sample ?w))
			(have_rock_analysis ?r ?w)
			(not (communicated_soil_data ?w))
			(not (communicated_rock_data ?w))
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(not (equipped_for_rock_analysis ?r))
			(have_soil_analysis ?r ?w)
			(not (available ?r))
			(not (equipped_for_imaging ?r))
			(not (at ?r ?w))
			(not (at_rock_sample ?w))
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			(not (communicated_soil_data ?w))
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
               (not (supports ?i ?m))
			(communicated_image_data ?o ?m)
			(not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(not (have_image ?r ?o ?m))
			(not (calibration_target ?i ?o))
			(equipped_for_imaging ?r)
			(have_rock_analysis ?r ?p)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
			(not (calibrated ?i ?r))
			(not (at ?r ?p))
			
          )
          :effect (and 
               (not (supports ?i ?m))
			(not (have_soil_analysis ?r ?p))
			(equipped_for_rock_analysis ?r)
			(not (available ?r))
			(have_image ?r ?o ?m)
			(not (calibration_target ?i ?o))
			(equipped_for_soil_analysis ?r)
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(have_rock_analysis ?r ?p)
			(not (visible_from ?o ?p))
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
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
               (not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(not (visible ?p ?x))
			(visible ?p ?y)
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (can_traverse ?r ?p ?y))
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(have_rock_analysis ?r ?x)
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (visible ?p ?y))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(not (visible ?y ?p))
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
               (not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(not (visible ?p ?y))
			(at_rock_sample ?x)
			(not (at ?r ?p))
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(have_rock_analysis ?r ?x)
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(visible ?p ?x)
			(not (visible ?p ?y))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?p ?y))
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (at ?r ?x))
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
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
			(not (have_image ?r ?o ?m))
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(not (available ?r))
			(not (at_rock_sample ?y))
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?x))
			(visible_from ?o ?y)
			(equipped_for_rock_analysis ?r)
			(can_traverse ?r ?y ?x)
			(communicated_image_data ?o ?m)
			
          )
         :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(visible ?y ?x)
			(not (have_image ?r ?o ?m))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(at_rock_sample ?x)
			(not (at ?r ?y))
			(not (available ?r))
			(not (at_rock_sample ?y))
			(visible_from ?o ?x)
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			(visible_from ?o ?y)
			(equipped_for_rock_analysis ?r)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			
          )
    )

)

;; 
;; communicate_image_data action has changed: (equipped_for_imaging ?r), (at_rock_sample ?y), (at_soil_sample ?y), (have_rock_analysis ?r ?x), (have_soil_analysis ?r ?x), (communicated_rock_data ?y), (available ?r), (at ?r ?x), (at_soil_sample ?x), (available ?r), (at_lander ?l ?x), (channel_free ?l), (at_rock_sample ?y), (can_traverse ?r ?x ?y), (have_image ?r ?o ?m), (at_lander ?l ?y), (have_rock_analysis ?r ?y), (have_image ?r ?o ?m), (communicated_soil_data ?x), (at ?r ?y), (communicated_image_data ?o ?m), (at ?r ?y), (have_soil_analysis ?r ?x), (visible_from ?o ?x), (equipped_for_rock_analysis ?r), (equipped_for_imaging ?r), (visible_from ?o ?y), (can_traverse ?r ?y ?x), (communicated_image_data ?o ?m), (visible_from ?o ?y), (at_soil_sample ?y), (visible_from ?o ?x), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?y), (at_rock_sample ?x), (visible ?y ?x), (communicated_soil_data ?y), (communicated_rock_data ?x), (have_rock_analysis ?r ?x), (communicated_rock_data ?x), (channel_free ?l), (can_traverse ?r ?y ?x), (at_lander ?l ?y), (equipped_for_soil_analysis ?r), (at_rock_sample ?x), (at_lander ?l ?x), (equipped_for_rock_analysis ?r), 
;; take_image action has changed: (communicated_rock_data ?p), (have_image ?r ?o ?m), (equipped_for_imaging ?r), (calibrated ?i ?r), (at ?r ?p), (have_rock_analysis ?r ?p), (on_board ?i ?r), (available ?r), (communicated_soil_data ?p), (communicated_soil_data ?p), (communicated_rock_data ?p), (visible_from ?o ?p), (calibration_target ?i ?o), (have_soil_analysis ?r ?p), (at_rock_sample ?p), (at_soil_sample ?p), (on_board ?i ?r), (equipped_for_rock_analysis ?r), (equipped_for_rock_analysis ?r), (at ?r ?p), (calibrated ?i ?r), (supports ?i ?m), (calibration_target ?i ?o), (visible_from ?o ?p), (supports ?i ?m), (available ?r), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?p), (communicated_image_data ?o ?m), 
;; communicate_rock_data action has changed: (can_traverse ?r ?p ?y), (communicated_soil_data ?y), (visible ?x ?y), (at_rock_sample ?y), (at_rock_sample ?x), (at ?r ?x), (can_traverse ?r ?x ?p), (equipped_for_rock_analysis ?r), (communicated_rock_data ?y), (at_rock_sample ?p), (communicated_soil_data ?p), (equipped_for_soil_analysis ?r), (communicated_soil_data ?y), (at ?r ?x), (equipped_for_imaging ?r), (have_rock_analysis ?r ?y), (have_rock_analysis ?r ?p), (visible ?y ?x), (visible ?x ?p), (have_soil_analysis ?r ?y), (at_soil_sample ?x), (at_rock_sample ?p), (at_lander ?l ?y), (can_traverse ?r ?x ?y), (have_soil_analysis ?r ?x), (visible ?p ?y), (communicated_rock_data ?x), (at ?r ?p), (visible ?p ?y), (can_traverse ?r ?p ?x), (can_traverse ?r ?y ?p), (channel_free ?l), (can_traverse ?r ?y ?x), (at_lander ?l ?p), (available ?r), (visible ?x ?p), (communicated_rock_data ?y), (have_rock_analysis ?r ?x), (have_soil_analysis ?r ?p), (can_traverse ?r ?y ?p), (visible ?p ?x), (at_soil_sample ?p), (can_traverse ?r ?x ?y), (equipped_for_soil_analysis ?r), (at_lander ?l ?p), (can_traverse ?r ?y ?x), (visible ?y ?p), (at ?r ?y), (at ?r ?p), (have_soil_analysis ?r ?x), (communicated_soil_data ?p), (at_rock_sample ?x), (can_traverse ?r ?x ?p), (communicated_rock_data ?p), (at ?r ?y), (equipped_for_imaging ?r), (at_rock_sample ?y), (visible ?x ?y), (at_lander ?l ?y), (available ?r), (have_rock_analysis ?r ?x), (communicated_rock_data ?x), (can_traverse ?r ?p ?x), (have_soil_analysis ?r ?p), (have_rock_analysis ?r ?y), (have_rock_analysis ?r ?p), (equipped_for_rock_analysis ?r), (communicated_soil_data ?x), (at_soil_sample ?y), (at_soil_sample ?p), (visible ?y ?x), (at_lander ?l ?x), (channel_free ?l), (at_soil_sample ?x), 
;; calibrate action has changed: (available ?r), (at_rock_sample ?w), (calibrated ?i ?r), (equipped_for_rock_analysis ?r), (at_soil_sample ?w), (communicated_soil_data ?w), (calibration_target ?i ?t), (have_rock_analysis ?r ?w), (equipped_for_imaging ?r), (available ?r), (have_soil_analysis ?r ?w), (equipped_for_rock_analysis ?r), (at_rock_sample ?w), (communicated_soil_data ?w), (communicated_rock_data ?w), (visible_from ?t ?w), (at ?r ?w), (have_soil_analysis ?r ?w), (at ?r ?w), (calibrated ?i ?r), (equipped_for_imaging ?r), (communicated_rock_data ?w), (on_board ?i ?r), (equipped_for_soil_analysis ?r), (visible_from ?t ?w), (calibration_target ?i ?t), 
;; communicate_soil_data action has changed: (communicated_soil_data ?x), (visible ?x ?p), (communicated_rock_data ?x), (at_soil_sample ?x), (visible ?p ?y), (have_rock_analysis ?r ?p), (communicated_soil_data ?y), (visible ?y ?p), (have_rock_analysis ?r ?x), (equipped_for_rock_analysis ?r), (visible ?y ?x), (communicated_rock_data ?y), (at_lander ?l ?x), (can_traverse ?r ?p ?x), (equipped_for_soil_analysis ?r), (visible ?y ?x), (communicated_soil_data ?p), (have_soil_analysis ?r ?x), (at_lander ?l ?y), (at_rock_sample ?y), (at ?r ?y), (have_rock_analysis ?r ?y), (visible ?p ?y), (have_rock_analysis ?r ?p), (visible ?x ?y), (communicated_rock_data ?p), (can_traverse ?r ?y ?p), (equipped_for_rock_analysis ?r), (at ?r ?p), (at ?r ?y), (at_rock_sample ?x), (at_rock_sample ?p), (have_soil_analysis ?r ?y), (visible ?p ?x), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?x), (can_traverse ?r ?x ?p), (at_lander ?l ?p), (at_rock_sample ?p), (can_traverse ?r ?x ?p), (communicated_soil_data ?p), (communicated_soil_data ?x), (can_traverse ?r ?x ?y), (have_soil_analysis ?r ?p), (can_traverse ?r ?y ?x), (at_rock_sample ?x), (at ?r ?x), (can_traverse ?r ?p ?y), (equipped_for_imaging ?r), (communicated_rock_data ?y), (channel_free ?l), (can_traverse ?r ?y ?p), (have_rock_analysis ?r ?y), (visible ?y ?p), (at_lander ?l ?y), (equipped_for_imaging ?r), (have_soil_analysis ?r ?y), (at_soil_sample ?p), (available ?r), (visible ?x ?p), (at_rock_sample ?y), (channel_free ?l), (have_soil_analysis ?r ?p), (at_lander ?l ?p), (communicated_rock_data ?p), (at_soil_sample ?y), (at_soil_sample ?p), (available ?r), (communicated_soil_data ?y), 
;; sample_soil action has changed: (have_rock_analysis ?x ?p), (available ?x), (communicated_soil_data ?p), (have_soil_analysis ?x ?p), (equipped_for_imaging ?x), (at_rock_sample ?p), (have_rock_analysis ?x ?p), (equipped_for_soil_analysis ?x), (at_rock_sample ?p), (full ?s), (equipped_for_imaging ?x), (available ?x), (empty ?s), (communicated_rock_data ?p), (at_soil_sample ?p), (communicated_soil_data ?p), (full ?s), (at ?x ?p), (equipped_for_soil_analysis ?x), (communicated_rock_data ?p), (have_soil_analysis ?x ?p), (equipped_for_rock_analysis ?x), (store_of ?s ?x), (empty ?s), 
;; navigate action has changed: (can_traverse ?x ?z ?y), (visible ?z ?y), (have_soil_analysis ?x ?y), (communicated_soil_data ?z), (communicated_soil_data ?y), (at_rock_sample ?z), (at ?x ?z), (available ?x), (at_soil_sample ?y), (at_rock_sample ?y), (at ?x ?y), (equipped_for_imaging ?x), (have_rock_analysis ?x ?y), (have_rock_analysis ?x ?z), (have_rock_analysis ?x ?y), (at_soil_sample ?z), (can_traverse ?x ?y ?z), (equipped_for_soil_analysis ?x), (at ?x ?z), (at ?x ?y), (communicated_rock_data ?y), (communicated_soil_data ?y), (at_soil_sample ?y), (visible ?y ?z), (visible ?y ?z), (equipped_for_rock_analysis ?x), (at_rock_sample ?z), (communicated_rock_data ?z), (equipped_for_soil_analysis ?x), (communicated_soil_data ?z), (have_soil_analysis ?x ?z), (can_traverse ?x ?y ?z), (available ?x), (at_rock_sample ?y), (visible ?z ?y), (communicated_rock_data ?z), 
;; sample_rock action has changed: (equipped_for_soil_analysis ?x), (communicated_rock_data ?p), (at ?x ?p), (at_rock_sample ?p), (have_soil_analysis ?x ?p), (communicated_soil_data ?p), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (available ?x), (communicated_rock_data ?p), (at ?x ?p), (store_of ?s ?x), (communicated_soil_data ?p), (available ?x), (at_soil_sample ?p), (have_rock_analysis ?x ?p), (full ?s), (empty ?s), (have_rock_analysis ?x ?p), (full ?s), (at_rock_sample ?p), (empty ?s), 
;; drop action has changed: (store_of ?y ?x), (equipped_for_rock_analysis ?x), (full ?y), (available ?x), (store_of ?y ?x), (empty ?y), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (empty ?y), (available ?x), (full ?y), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), 
;; Last_reduced_capability_num_dropped_pals: None

