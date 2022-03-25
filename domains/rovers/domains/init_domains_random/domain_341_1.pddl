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
			(not (available ?x))
			(not (visible ?z ?y))
			(equipped_for_imaging ?x)
			(not (can_traverse ?x ?z ?y))
			(have_soil_analysis ?x ?y)
			(at_soil_sample ?y)
			(communicated_soil_data ?z)
			(communicated_rock_data ?z)
			(not (communicated_soil_data ?y))
			(not (visible ?y ?z))
			(equipped_for_rock_analysis ?x)
			(at ?x ?z)
			(not (have_soil_analysis ?x ?z))
			(not (have_rock_analysis ?x ?y))
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (at_rock_sample ?z)
			(equipped_for_imaging ?x)
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?z))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?z))
			(communicated_rock_data ?z)
			(visible ?y ?z)
			(not (equipped_for_rock_analysis ?x))
			(not (can_traverse ?x ?y ?z))
			(at ?x ?z)
			(not (have_soil_analysis ?x ?z))
			(not (communicated_rock_data ?y))
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(not (at ?x ?p))
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (available ?x)
			(not (at ?x ?p))
			(full ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(not (have_soil_analysis ?x ?p))
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
			(equipped_for_imaging ?x)
			(full ?s)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (not (available ?x))
			(at ?x ?p)
			(empty ?s)
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(have_soil_analysis ?x ?p)
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
			(not (empty ?y))
			(not (equipped_for_rock_analysis ?x))
			(equipped_for_soil_analysis ?x)
			(full ?y)
			(not (equipped_for_imaging ?x))
			
          )
        :effect (and 
               (available ?x)
			(not (store_of ?y ?x))
			(not (equipped_for_imaging ?x))
			
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
			(not (calibrated ?i ?r))
			
          )
         :effect (and 
               (not (calibration_target ?i ?t))
			(equipped_for_rock_analysis ?r)
			(have_soil_analysis ?r ?w)
			(available ?r)
			(not (equipped_for_imaging ?r))
			(not (at ?r ?w))
			(on_board ?i ?r)
			(not (at_rock_sample ?w))
			(not (equipped_for_soil_analysis ?r))
			(visible_from ?t ?w)
			(have_rock_analysis ?r ?w)
			(communicated_soil_data ?w)
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
               (communicated_image_data ?o ?m)
			(not (have_soil_analysis ?r ?p))
			(equipped_for_rock_analysis ?r)
			(not (available ?r))
			(not (have_image ?r ?o ?m))
			(not (calibration_target ?i ?o))
			(not (equipped_for_soil_analysis ?r))
			(not (on_board ?i ?r))
			(have_rock_analysis ?r ?p)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (communicated_soil_data ?p))
			(not (calibrated ?i ?r))
			(not (at ?r ?p))
			
          )
          :effect (and 
               (supports ?i ?m)
			(not (communicated_image_data ?o ?m))
			(not (have_soil_analysis ?r ?p))
			(not (equipped_for_rock_analysis ?r))
			(available ?r)
			(calibration_target ?i ?o)
			(equipped_for_imaging ?r)
			(not (on_board ?i ?r))
			(have_rock_analysis ?r ?p)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (visible_from ?o ?p))
			(communicated_rock_data ?p)
			(calibrated ?i ?r)
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
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(visible ?p ?y)
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(have_rock_analysis ?r ?x)
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(visible ?p ?y)
			(visible ?x ?y)
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(not (equipped_for_rock_analysis ?r))
			(visible ?y ?p)
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
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(visible ?p ?y)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
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
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(equipped_for_soil_analysis ?r)
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(have_rock_analysis ?r ?x)
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(not (visible ?y ?p))
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
			(not (have_image ?r ?o ?m))
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(not (at_rock_sample ?y))
			(not (visible_from ?o ?x))
			(not (at ?r ?x))
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (not (channel_free ?l))
			(not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(have_image ?r ?o ?m)
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(not (at_rock_sample ?y))
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(visible_from ?o ?y)
			(not (equipped_for_rock_analysis ?r))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; communicate_soil_data action has changed: (channel_free ?l), (visible ?p ?x), (have_soil_analysis ?r ?p), (communicated_rock_data ?y), (equipped_for_rock_analysis ?r), (visible ?p ?x), (visible ?y ?p), (at_soil_sample ?p), (communicated_soil_data ?p), (visible ?x ?y), (have_soil_analysis ?r ?y), (can_traverse ?r ?x ?y), (visible ?p ?y), (communicated_soil_data ?p), (at_rock_sample ?y), (at ?r ?p), (channel_free ?l), (at ?r ?y), (visible ?y ?p), (have_soil_analysis ?r ?x), (can_traverse ?r ?p ?x), (at ?r ?p), (at_rock_sample ?x), (equipped_for_soil_analysis ?r), (can_traverse ?r ?y ?x), (at_soil_sample ?p), (at_lander ?l ?p), (have_rock_analysis ?r ?p), (communicated_rock_data ?y), (have_rock_analysis ?r ?y), (can_traverse ?r ?p ?y), (at_soil_sample ?x), (can_traverse ?r ?y ?x), (can_traverse ?r ?p ?x), (communicated_rock_data ?p), (at_lander ?l ?x), (visible ?p ?y), (at ?r ?y), (can_traverse ?r ?x ?p), (have_rock_analysis ?r ?x), (at_rock_sample ?x), (visible ?x ?p), (visible ?y ?x), (at_lander ?l ?x), (at_soil_sample ?y), (at ?r ?x), (have_soil_analysis ?r ?p), (at_rock_sample ?p), (communicated_rock_data ?x), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?p), (at_lander ?l ?y), (communicated_soil_data ?y), (communicated_soil_data ?y), (have_rock_analysis ?r ?x), (at_lander ?l ?y), (at_rock_sample ?y), (at_rock_sample ?p), (can_traverse ?r ?y ?p), (communicated_rock_data ?x), (communicated_soil_data ?x), (can_traverse ?r ?x ?p), (at_soil_sample ?x), (available ?r), (can_traverse ?r ?p ?y), (at ?r ?x), (communicated_rock_data ?p), (at_soil_sample ?y), (available ?r), (have_soil_analysis ?r ?x), (have_rock_analysis ?r ?y), (communicated_soil_data ?x), (visible ?x ?y), (equipped_for_soil_analysis ?r), (equipped_for_imaging ?r), 
;; sample_rock action has changed: (equipped_for_rock_analysis ?x), (full ?s), (have_soil_analysis ?x ?p), (at ?x ?p), (have_rock_analysis ?x ?p), (have_rock_analysis ?x ?p), (at_rock_sample ?p), (empty ?s), (full ?s), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (at_soil_sample ?p), (at_soil_sample ?p), (at_rock_sample ?p), (communicated_rock_data ?p), (have_soil_analysis ?x ?p), (store_of ?s ?x), (empty ?s), (communicated_soil_data ?p), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (at ?x ?p), (available ?x), (communicated_rock_data ?p), (store_of ?s ?x), (available ?x), 
;; sample_soil action has changed: (store_of ?s ?x), (available ?x), (have_soil_analysis ?x ?p), (equipped_for_imaging ?x), (at_soil_sample ?p), (have_rock_analysis ?x ?p), (store_of ?s ?x), (communicated_soil_data ?p), (communicated_rock_data ?p), (at ?x ?p), (at_soil_sample ?p), (at ?x ?p), (communicated_soil_data ?p), (available ?x), (empty ?s), (have_rock_analysis ?x ?p), (equipped_for_soil_analysis ?x), (at_rock_sample ?p), (at_rock_sample ?p), (full ?s), (have_soil_analysis ?x ?p), (equipped_for_soil_analysis ?x), 
;; take_image action has changed: (have_rock_analysis ?r ?p), (supports ?i ?m), (communicated_image_data ?o ?m), (visible_from ?o ?p), (have_image ?r ?o ?m), (have_soil_analysis ?r ?p), (have_soil_analysis ?r ?p), (at_rock_sample ?p), (equipped_for_imaging ?r), (at_soil_sample ?p), (communicated_soil_data ?p), (at ?r ?p), (calibrated ?i ?r), (have_image ?r ?o ?m), (equipped_for_rock_analysis ?r), (equipped_for_imaging ?r), (on_board ?i ?r), (at ?r ?p), (equipped_for_soil_analysis ?r), (calibrated ?i ?r), (visible_from ?o ?p), (supports ?i ?m), (on_board ?i ?r), (at_rock_sample ?p), (communicated_image_data ?o ?m), (calibration_target ?i ?o), (calibration_target ?i ?o), (at_soil_sample ?p), (have_rock_analysis ?r ?p), (available ?r), (communicated_rock_data ?p), (available ?r), (equipped_for_rock_analysis ?r), 
;; communicate_image_data action has changed: (at ?r ?x), (visible_from ?o ?y), (visible ?x ?y), (at_rock_sample ?x), (at ?r ?x), (at ?r ?y), (channel_free ?l), (can_traverse ?r ?x ?y), (at_lander ?l ?y), (communicated_soil_data ?y), (have_image ?r ?o ?m), (channel_free ?l), (can_traverse ?r ?y ?x), (communicated_image_data ?o ?m), (can_traverse ?r ?x ?y), (at_lander ?l ?x), (at_soil_sample ?y), (visible_from ?o ?x), (have_rock_analysis ?r ?y), (equipped_for_soil_analysis ?r), (at_lander ?l ?x), (at ?r ?y), (communicated_rock_data ?y), (can_traverse ?r ?y ?x), (at_soil_sample ?x), (at_rock_sample ?y), (have_soil_analysis ?r ?x), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?y), (visible ?y ?x), (at_rock_sample ?x), (communicated_rock_data ?x), (at_rock_sample ?y), (available ?r), (communicated_soil_data ?y), (have_image ?r ?o ?m), (equipped_for_rock_analysis ?r), (communicated_rock_data ?x), (equipped_for_imaging ?r), (have_rock_analysis ?r ?y), (equipped_for_imaging ?r), (have_rock_analysis ?r ?x), (communicated_image_data ?o ?m), (at_lander ?l ?y), (have_soil_analysis ?r ?x), (at_soil_sample ?x), (at_soil_sample ?y), (communicated_rock_data ?y), (visible_from ?o ?y), (visible ?y ?x), (equipped_for_rock_analysis ?r), 
;; communicate_rock_data action has changed: (communicated_rock_data ?p), (at_lander ?l ?y), (have_rock_analysis ?r ?x), (at_lander ?l ?y), (at_lander ?l ?x), (at_soil_sample ?p), (at ?r ?p), (at_rock_sample ?x), (can_traverse ?r ?x ?p), (can_traverse ?r ?x ?y), (equipped_for_soil_analysis ?r), (at_soil_sample ?y), (communicated_rock_data ?p), (communicated_rock_data ?x), (equipped_for_rock_analysis ?r), (at_rock_sample ?x), (communicated_soil_data ?y), (at ?r ?x), (equipped_for_imaging ?r), (at_soil_sample ?p), (can_traverse ?r ?y ?x), (equipped_for_imaging ?r), (at_rock_sample ?p), (at_soil_sample ?x), (visible ?p ?x), (at_rock_sample ?p), (at ?r ?y), (can_traverse ?r ?p ?y), (communicated_soil_data ?p), (have_rock_analysis ?r ?x), (visible ?p ?y), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?y), (communicated_rock_data ?x), (available ?r), (communicated_rock_data ?y), (at ?r ?y), (at_lander ?l ?x), (have_soil_analysis ?r ?y), (can_traverse ?r ?y ?p), (can_traverse ?r ?x ?p), (have_soil_analysis ?r ?x), (have_soil_analysis ?r ?p), (visible ?x ?p), (at_soil_sample ?x), (have_rock_analysis ?r ?p), (can_traverse ?r ?x ?y), (can_traverse ?r ?p ?y), (visible ?p ?x), (can_traverse ?r ?p ?x), (have_soil_analysis ?r ?p), (communicated_soil_data ?x), (available ?r), (communicated_soil_data ?x), (at_rock_sample ?y), (visible ?x ?y), (at ?r ?p), (visible ?x ?p), (visible ?y ?p), (channel_free ?l), (at_lander ?l ?p), (communicated_rock_data ?y), (have_rock_analysis ?r ?p), (at_rock_sample ?y), 
;; navigate action has changed: (at ?x ?y), (equipped_for_soil_analysis ?x), (communicated_rock_data ?z), (equipped_for_imaging ?x), (at_soil_sample ?z), (at_rock_sample ?z), (at ?x ?z), (can_traverse ?x ?y ?z), (communicated_soil_data ?y), (have_soil_analysis ?x ?z), (equipped_for_rock_analysis ?x), (at ?x ?y), (have_soil_analysis ?x ?y), (at_soil_sample ?y), (at_rock_sample ?z), (can_traverse ?x ?z ?y), (at_soil_sample ?y), (communicated_rock_data ?z), (visible ?z ?y), (visible ?y ?z), (have_soil_analysis ?x ?z), (communicated_rock_data ?y), (equipped_for_imaging ?x), (visible ?y ?z), (can_traverse ?x ?y ?z), (at_rock_sample ?y), (communicated_soil_data ?z), (communicated_soil_data ?z), (equipped_for_soil_analysis ?x), (available ?x), (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?y), 
;; drop action has changed: (available ?x), (store_of ?y ?x), (equipped_for_imaging ?x), (empty ?y), (empty ?y), (equipped_for_imaging ?x), (full ?y), (available ?x), (equipped_for_soil_analysis ?x), (store_of ?y ?x), (equipped_for_rock_analysis ?x), 
;; calibrate action has changed: (available ?r), (have_rock_analysis ?r ?w), (at_rock_sample ?w), (communicated_soil_data ?w), (equipped_for_soil_analysis ?r), (on_board ?i ?r), (have_soil_analysis ?r ?w), (calibration_target ?i ?t), (equipped_for_imaging ?r), (equipped_for_rock_analysis ?r), (calibrated ?i ?r), (on_board ?i ?r), (equipped_for_soil_analysis ?r), (communicated_rock_data ?w), (at_soil_sample ?w), (equipped_for_rock_analysis ?r), (at ?r ?w), (at_rock_sample ?w), (visible_from ?t ?w), (have_rock_analysis ?r ?w), (communicated_rock_data ?w), (at_soil_sample ?w), (communicated_soil_data ?w), (have_soil_analysis ?r ?w), (visible_from ?t ?w), (calibration_target ?i ?t), (available ?r), 
;; Last_reduced_capability_num_dropped_pals: None
