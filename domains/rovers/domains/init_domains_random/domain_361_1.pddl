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
			(not (can_traverse ?x ?z ?y))
			(not (at ?x ?y))
			(not (have_soil_analysis ?x ?y))
			(not (at_soil_sample ?z))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?z))
			(not (communicated_rock_data ?z))
			(communicated_soil_data ?y)
			(not (visible ?y ?z))
			(not (equipped_for_rock_analysis ?x))
			(not (at ?x ?z))
			(not (have_soil_analysis ?x ?z))
			(have_rock_analysis ?x ?y)
			(communicated_rock_data ?y)
			(equipped_for_soil_analysis ?x)
			
          )
          :effect (and 
               (not (at_rock_sample ?z))
			(not (have_rock_analysis ?x ?z))
			(available ?x)
			(visible ?z ?y)
			(equipped_for_imaging ?x)
			(not (can_traverse ?x ?z ?y))
			(at ?x ?y)
			(have_soil_analysis ?x ?y)
			(not (at_soil_sample ?z))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?z))
			(not (communicated_rock_data ?z))
			(communicated_soil_data ?y)
			(not (visible ?y ?z))
			(not (can_traverse ?x ?y ?z))
			(not (have_soil_analysis ?x ?z))
			(have_rock_analysis ?x ?y)
			(communicated_rock_data ?y)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(empty ?s)
			(not (full ?s))
			(not (at_rock_sample ?p))
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (available ?x)
			(at ?x ?p)
			(empty ?s)
			(equipped_for_imaging ?x)
			(not (full ?s))
			(not (store_of ?s ?x))
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
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
			(not (full ?s))
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			(communicated_rock_data ?p)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (not (available ?x))
			(not (at ?x ?p))
			(empty ?s)
			(equipped_for_imaging ?x)
			(not (full ?s))
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (available ?x))
			(not (store_of ?y ?x))
			(equipped_for_rock_analysis ?x)
			(equipped_for_soil_analysis ?x)
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (available ?x)
			(store_of ?y ?x)
			(not (equipped_for_rock_analysis ?x))
			(equipped_for_soil_analysis ?x)
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
			(not (equipped_for_rock_analysis ?r))
			(have_soil_analysis ?r ?w)
			(not (equipped_for_imaging ?r))
			(equipped_for_soil_analysis ?r)
			(have_rock_analysis ?r ?w)
			(communicated_soil_data ?w)
			(communicated_rock_data ?w)
			(at_soil_sample ?w)
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (not (calibration_target ?i ?t))
			(equipped_for_rock_analysis ?r)
			(have_soil_analysis ?r ?w)
			(not (available ?r))
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(not (on_board ?i ?r))
			(not (at_rock_sample ?w))
			(equipped_for_soil_analysis ?r)
			(not (visible_from ?t ?w))
			(not (have_rock_analysis ?r ?w))
			(not (communicated_soil_data ?w))
			(communicated_rock_data ?w)
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
			(not (communicated_image_data ?o ?m))
			(not (have_soil_analysis ?r ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(not (have_image ?r ?o ?m))
			(not (calibration_target ?i ?o))
			(equipped_for_soil_analysis ?r)
			(have_rock_analysis ?r ?p)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (visible_from ?o ?p))
			(communicated_soil_data ?p)
			(at ?r ?p)
			
          )
          :effect (and 
               (supports ?i ?m)
			(not (communicated_image_data ?o ?m))
			(not (have_soil_analysis ?r ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(not (calibration_target ?i ?o))
			(not (equipped_for_soil_analysis ?r))
			(equipped_for_imaging ?r)
			(not (on_board ?i ?r))
			(have_rock_analysis ?r ?p)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(visible_from ?o ?p)
			(not (communicated_soil_data ?p))
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
			(not (have_soil_analysis ?r ?x))
			(not (visible ?p ?x))
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(not (can_traverse ?r ?p ?y))
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(not (available ?r))
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(visible ?p ?x)
			(visible ?p ?y)
			(not (visible ?x ?y))
			(not (can_traverse ?r ?p ?y))
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(have_rock_analysis ?r ?x)
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
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
               (equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?p ?y))
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(have_rock_analysis ?r ?x)
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(visible ?p ?y)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (available ?r))
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
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
			(equipped_for_imaging ?r)
			(visible ?y ?x)
			(have_image ?r ?o ?m)
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(not (at_rock_sample ?x))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(not (at_rock_sample ?y))
			(not (visible_from ?o ?x))
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			(not (visible_from ?o ?y))
			(equipped_for_rock_analysis ?r)
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			(communicated_image_data ?o ?m)
			
          )
         :effect (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(not (have_image ?r ?o ?m))
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (available ?r))
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(not (visible_from ?o ?y))
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			
          )
    )

)

;; 
;; sample_rock action has changed: (equipped_for_soil_analysis ?x), (full ?s), (communicated_rock_data ?p), (at_rock_sample ?p), (communicated_soil_data ?p), (have_soil_analysis ?x ?p), (equipped_for_imaging ?x), (at ?x ?p), (at_soil_sample ?p), (equipped_for_rock_analysis ?x), (at_rock_sample ?p), (have_rock_analysis ?x ?p), (available ?x), (at_soil_sample ?p), (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), (at ?x ?p), (communicated_rock_data ?p), (have_rock_analysis ?x ?p), (empty ?s), (store_of ?s ?x), (store_of ?s ?x), (have_soil_analysis ?x ?p), (empty ?s), (full ?s), (communicated_soil_data ?p), (available ?x), 
;; take_image action has changed: (have_image ?r ?o ?m), (visible_from ?o ?p), (equipped_for_rock_analysis ?r), (communicated_soil_data ?p), (on_board ?i ?r), (communicated_image_data ?o ?m), (calibrated ?i ?r), (on_board ?i ?r), (have_rock_analysis ?r ?p), (available ?r), (visible_from ?o ?p), (communicated_soil_data ?p), (at_rock_sample ?p), (have_soil_analysis ?r ?p), (calibration_target ?i ?o), (have_rock_analysis ?r ?p), (at ?r ?p), (calibration_target ?i ?o), (calibrated ?i ?r), (have_soil_analysis ?r ?p), (at_soil_sample ?p), (communicated_image_data ?o ?m), (at_soil_sample ?p), (equipped_for_soil_analysis ?r), (equipped_for_imaging ?r), (at_rock_sample ?p), (equipped_for_rock_analysis ?r), (available ?r), (have_image ?r ?o ?m), (equipped_for_soil_analysis ?r), (equipped_for_imaging ?r), (communicated_rock_data ?p), (supports ?i ?m), 
;; calibrate action has changed: (at ?r ?w), (available ?r), (on_board ?i ?r), (equipped_for_rock_analysis ?r), (equipped_for_soil_analysis ?r), (communicated_rock_data ?w), (have_soil_analysis ?r ?w), (at ?r ?w), (at_soil_sample ?w), (have_rock_analysis ?r ?w), (equipped_for_imaging ?r), (communicated_soil_data ?w), (visible_from ?t ?w), (communicated_rock_data ?w), (calibrated ?i ?r), (at_rock_sample ?w), (have_rock_analysis ?r ?w), (equipped_for_rock_analysis ?r), (calibration_target ?i ?t), (have_soil_analysis ?r ?w), (equipped_for_soil_analysis ?r), (calibration_target ?i ?t), (at_soil_sample ?w), (on_board ?i ?r), (communicated_soil_data ?w), (visible_from ?t ?w), (equipped_for_imaging ?r), 
;; communicate_rock_data action has changed: (can_traverse ?r ?y ?x), (visible ?p ?x), (at ?r ?y), (communicated_rock_data ?y), (at ?r ?x), (visible ?x ?y), (equipped_for_rock_analysis ?r), (at_soil_sample ?x), (communicated_rock_data ?x), (can_traverse ?r ?x ?y), (have_soil_analysis ?r ?x), (visible ?x ?p), (can_traverse ?r ?y ?p), (have_rock_analysis ?r ?p), (equipped_for_imaging ?r), (communicated_soil_data ?x), (have_rock_analysis ?r ?x), (have_rock_analysis ?r ?p), (communicated_soil_data ?y), (communicated_soil_data ?x), (at_rock_sample ?x), (can_traverse ?r ?p ?x), (at ?r ?p), (visible ?x ?y), (visible ?x ?p), (at ?r ?y), (equipped_for_rock_analysis ?r), (available ?r), (can_traverse ?r ?p ?y), (at_lander ?l ?x), (visible ?y ?x), (communicated_soil_data ?p), (at_lander ?l ?y), (have_soil_analysis ?r ?x), (equipped_for_soil_analysis ?r), (at_soil_sample ?x), (communicated_rock_data ?x), (visible ?p ?y), (at_rock_sample ?p), (visible ?y ?p), (at_rock_sample ?x), (at_rock_sample ?p), (have_rock_analysis ?r ?y), (at_lander ?l ?y), (equipped_for_soil_analysis ?r), (at_lander ?l ?x), (at_soil_sample ?p), (at_lander ?l ?p), (at_rock_sample ?y), (communicated_rock_data ?p), (communicated_rock_data ?y), (have_rock_analysis ?r ?x), (visible ?p ?x), (can_traverse ?r ?p ?x), (can_traverse ?r ?x ?y), (at_soil_sample ?y), (can_traverse ?r ?y ?x), (can_traverse ?r ?p ?y), (visible ?y ?x), (can_traverse ?r ?x ?p), (at_rock_sample ?y), (communicated_soil_data ?y), (communicated_soil_data ?p), (at ?r ?x), (at_soil_sample ?p), (visible ?y ?p), (have_rock_analysis ?r ?y), (channel_free ?l), (available ?r), (at_lander ?l ?p), (have_soil_analysis ?r ?p), (can_traverse ?r ?y ?p), (have_soil_analysis ?r ?y), 
;; navigate action has changed: (at_rock_sample ?z), (available ?x), (communicated_rock_data ?y), (at ?x ?y), (visible ?y ?z), (equipped_for_imaging ?x), (can_traverse ?x ?y ?z), (have_soil_analysis ?x ?y), (visible ?z ?y), (equipped_for_rock_analysis ?x), (at_rock_sample ?z), (can_traverse ?x ?z ?y), (have_rock_analysis ?x ?z), (equipped_for_soil_analysis ?x), (have_soil_analysis ?x ?y), (have_rock_analysis ?x ?y), (available ?x), (have_soil_analysis ?x ?z), (at_soil_sample ?y), (can_traverse ?x ?z ?y), (communicated_rock_data ?z), (visible ?y ?z), (communicated_soil_data ?y), (can_traverse ?x ?y ?z), (at ?x ?z), (have_rock_analysis ?x ?z), (at_soil_sample ?z), (at_soil_sample ?y), (communicated_soil_data ?y), (communicated_rock_data ?y), (communicated_rock_data ?z), (at_rock_sample ?y), (at_soil_sample ?z), (at ?x ?y), (have_rock_analysis ?x ?y), (visible ?z ?y), (communicated_soil_data ?z), (at ?x ?z), (communicated_soil_data ?z), (have_soil_analysis ?x ?z), 
;; communicate_image_data action has changed: (have_soil_analysis ?r ?x), (communicated_rock_data ?y), (at ?r ?y), (have_rock_analysis ?r ?y), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?x), (at_rock_sample ?x), (have_rock_analysis ?r ?y), (visible ?x ?y), (at_soil_sample ?x), (equipped_for_soil_analysis ?r), (visible_from ?o ?y), (communicated_rock_data ?y), (can_traverse ?r ?y ?x), (available ?r), (can_traverse ?r ?x ?y), (channel_free ?l), (have_rock_analysis ?r ?x), (can_traverse ?r ?x ?y), (at_soil_sample ?x), (communicated_rock_data ?x), (communicated_soil_data ?y), (equipped_for_imaging ?r), (at_lander ?l ?x), (communicated_rock_data ?x), (have_soil_analysis ?r ?y), (at_lander ?l ?y), (at_rock_sample ?x), (communicated_image_data ?o ?m), (at ?r ?y), (visible ?y ?x), (communicated_soil_data ?y), (visible ?y ?x), (communicated_soil_data ?x), (at_soil_sample ?y), (communicated_image_data ?o ?m), (equipped_for_imaging ?r), (visible_from ?o ?x), (can_traverse ?r ?y ?x), (at ?r ?x), (have_soil_analysis ?r ?y), (visible_from ?o ?x), (equipped_for_rock_analysis ?r), (at_lander ?l ?y), (visible ?x ?y), (channel_free ?l), (at_rock_sample ?y), (visible_from ?o ?y), (at ?r ?x), (communicated_soil_data ?x), (at_soil_sample ?y), (have_soil_analysis ?r ?x), (have_image ?r ?o ?m), 
;; communicate_soil_data action has changed: (have_soil_analysis ?r ?p), (communicated_soil_data ?x), (have_rock_analysis ?r ?p), (visible ?x ?p), (at_soil_sample ?x), (can_traverse ?r ?p ?x), (at_lander ?l ?y), (visible ?p ?x), (can_traverse ?r ?x ?y), (at_soil_sample ?p), (communicated_rock_data ?p), (available ?r), (visible ?x ?p), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?x), (visible ?y ?x), (equipped_for_rock_analysis ?r), (channel_free ?l), (at ?r ?y), (at_rock_sample ?y), (at_lander ?l ?y), (can_traverse ?r ?x ?y), (have_rock_analysis ?r ?x), (can_traverse ?r ?y ?p), (channel_free ?l), (at ?r ?y), (communicated_soil_data ?y), (can_traverse ?r ?y ?p), (have_soil_analysis ?r ?y), (communicated_rock_data ?p), (can_traverse ?r ?p ?y), (at_lander ?l ?p), (at_rock_sample ?p), (can_traverse ?r ?x ?p), (visible ?x ?y), (communicated_rock_data ?y), (communicated_soil_data ?y), (at_rock_sample ?p), (have_soil_analysis ?r ?x), (visible ?p ?x), (at_soil_sample ?y), (at_rock_sample ?y), (available ?r), (communicated_soil_data ?p), (visible ?y ?p), (visible ?p ?y), (equipped_for_imaging ?r), (communicated_soil_data ?p), (have_soil_analysis ?r ?y), (can_traverse ?r ?y ?x), (at_lander ?l ?p), (have_rock_analysis ?r ?y), (equipped_for_soil_analysis ?r), (can_traverse ?r ?p ?y), (at_rock_sample ?x), (at_soil_sample ?x), (communicated_rock_data ?y), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?p), (equipped_for_imaging ?r), (at_soil_sample ?p), (at_lander ?l ?x), (can_traverse ?r ?p ?x), (visible ?x ?y), (communicated_rock_data ?x), (at_lander ?l ?x), (can_traverse ?r ?x ?p), (equipped_for_soil_analysis ?r), (at_soil_sample ?y), (communicated_soil_data ?x), 
;; drop action has changed: (store_of ?y ?x), (equipped_for_rock_analysis ?x), (equipped_for_rock_analysis ?x), (available ?x), (available ?x), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (store_of ?y ?x), (equipped_for_soil_analysis ?x), (full ?y), (full ?y), (empty ?y), (equipped_for_imaging ?x), 
;; sample_soil action has changed: (communicated_rock_data ?p), (have_soil_analysis ?x ?p), (empty ?s), (at_soil_sample ?p), (available ?x), (at ?x ?p), (equipped_for_soil_analysis ?x), (store_of ?s ?x), (store_of ?s ?x), (at_rock_sample ?p), (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?p), (full ?s), (communicated_rock_data ?p), (full ?s), (at_rock_sample ?p), (communicated_soil_data ?p), (have_rock_analysis ?x ?p), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (at ?x ?p), (have_soil_analysis ?x ?p), (available ?x), (equipped_for_soil_analysis ?x), (at_soil_sample ?p), 
;; Last_reduced_capability_num_dropped_pals: None

