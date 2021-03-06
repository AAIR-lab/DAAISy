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
               (have_rock_analysis ?x ?z)
			(not (available ?x))
			(not (visible ?z ?y))
			(not (equipped_for_imaging ?x))
			(at_rock_sample ?y)
			(not (have_soil_analysis ?x ?y))
			(not (at_soil_sample ?z))
			(at_soil_sample ?y)
			(communicated_soil_data ?z)
			(communicated_rock_data ?z)
			(not (communicated_soil_data ?y))
			(not (visible ?y ?z))
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			(have_soil_analysis ?x ?z)
			(have_rock_analysis ?x ?y)
			(communicated_rock_data ?y)
			(equipped_for_soil_analysis ?x)
			
          )
          :effect (and 
               (not (at_rock_sample ?z))
			(not (have_rock_analysis ?x ?z))
			(not (visible ?z ?y))
			(equipped_for_imaging ?x)
			(can_traverse ?x ?z ?y)
			(not (have_soil_analysis ?x ?y))
			(not (at_soil_sample ?z))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?z))
			(not (communicated_rock_data ?z))
			(visible ?y ?z)
			(equipped_for_rock_analysis ?x)
			(can_traverse ?x ?y ?z)
			(not (at ?x ?z))
			(have_rock_analysis ?x ?y)
			(communicated_rock_data ?y)
			(not (equipped_for_soil_analysis ?x))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(not (at ?x ?p))
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(not (full ?s))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (available ?x)
			(not (at ?x ?p))
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(not (have_soil_analysis ?x ?p))
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
               (available ?x)
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(not (communicated_rock_data ?p))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (not (at ?x ?p))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
			(not (store_of ?y ?x))
			(empty ?y)
			(not (equipped_for_rock_analysis ?x))
			(equipped_for_soil_analysis ?x)
			(not (full ?y))
			(not (equipped_for_imaging ?x))
			
          )
        :effect (and 
               (available ?x)
			(store_of ?y ?x)
			(not (empty ?y))
			(not (equipped_for_rock_analysis ?x))
			(not (equipped_for_soil_analysis ?x))
			(full ?y)
			(not (equipped_for_imaging ?x))
			
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
			(available ?r)
			(not (equipped_for_imaging ?r))
			(at ?r ?w)
			(not (on_board ?i ?r))
			(not (at_rock_sample ?w))
			(not (equipped_for_soil_analysis ?r))
			(not (visible_from ?t ?w))
			(not (have_rock_analysis ?r ?w))
			(not (communicated_soil_data ?w))
			(communicated_rock_data ?w)
			(at_soil_sample ?w)
			(not (calibrated ?i ?r))
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(equipped_for_rock_analysis ?r)
			(available ?r)
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(not (on_board ?i ?r))
			(at_rock_sample ?w)
			(not (equipped_for_soil_analysis ?r))
			(not (visible_from ?t ?w))
			(have_rock_analysis ?r ?w)
			(communicated_soil_data ?w)
			(not (communicated_rock_data ?w))
			(not (at_soil_sample ?w))
			
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
			(have_soil_analysis ?r ?p)
			(available ?r)
			(have_image ?r ?o ?m)
			(not (calibration_target ?i ?o))
			(not (on_board ?i ?r))
			(not (have_rock_analysis ?r ?p))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
			
          )
          :effect (and 
               (supports ?i ?m)
			(not (communicated_image_data ?o ?m))
			(have_soil_analysis ?r ?p)
			(equipped_for_rock_analysis ?r)
			(available ?r)
			(not (have_image ?r ?o ?m))
			(calibration_target ?i ?o)
			(equipped_for_soil_analysis ?r)
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(not (have_rock_analysis ?r ?p))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(visible_from ?o ?p)
			(not (communicated_soil_data ?p))
			(not (communicated_rock_data ?p))
			
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
			(not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(visible ?p ?y)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(at_lander ?l ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(visible ?y ?p)
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?p ?y))
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(not (at_rock_sample ?y))
			(at_rock_sample ?p)
			(at ?r ?x)
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?y ?p))
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
               (not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?p ?y))
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(have_rock_analysis ?r ?x)
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(visible ?y ?x)
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(visible ?p ?y)
			(not (visible ?x ?y))
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (available ?r))
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(at ?r ?x)
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(have_rock_analysis ?r ?x)
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
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
               (equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(at_rock_sample ?y)
			(visible_from ?o ?x)
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(communicated_soil_data ?y)
			(have_rock_analysis ?r ?x)
			(not (equipped_for_rock_analysis ?r))
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(not (have_image ?r ?o ?m))
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (available ?r))
			(at_rock_sample ?y)
			(not (at ?r ?x))
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(equipped_for_rock_analysis ?r)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			
          )
    )

)

;; 
;; communicate_soil_data action has changed: (visible ?p ?y), (visible ?x ?y), (at_lander ?l ?y), (available ?r), (visible ?x ?p), (at_lander ?l ?p), (can_traverse ?r ?x ?y), (communicated_rock_data ?y), (at ?r ?y), (have_soil_analysis ?r ?y), (at_rock_sample ?y), (can_traverse ?r ?x ?y), (communicated_rock_data ?y), (visible ?p ?x), (at_lander ?l ?y), (have_soil_analysis ?r ?x), (communicated_soil_data ?y), (at_rock_sample ?x), (equipped_for_soil_analysis ?r), (can_traverse ?r ?y ?p), (can_traverse ?r ?x ?p), (communicated_soil_data ?y), (visible ?y ?p), (can_traverse ?r ?p ?x), (channel_free ?l), (equipped_for_soil_analysis ?r), (at_lander ?l ?x), (have_soil_analysis ?r ?p), (communicated_soil_data ?x), (can_traverse ?r ?y ?x), (at_soil_sample ?y), (visible ?x ?y), (at ?r ?p), (at ?r ?y), (equipped_for_rock_analysis ?r), (channel_free ?l), (visible ?y ?x), (have_rock_analysis ?r ?y), (can_traverse ?r ?y ?p), (can_traverse ?r ?y ?x), (visible ?p ?y), (communicated_soil_data ?p), (equipped_for_rock_analysis ?r), (can_traverse ?r ?p ?y), (visible ?p ?x), (at_lander ?l ?x), (have_rock_analysis ?r ?p), (visible ?y ?p), (at_rock_sample ?p), (have_rock_analysis ?r ?x), (at_rock_sample ?x), (have_soil_analysis ?r ?p), (communicated_rock_data ?x), (communicated_rock_data ?x), (at_rock_sample ?y), (at_lander ?l ?p), (have_soil_analysis ?r ?y), (have_rock_analysis ?r ?y), (at_soil_sample ?x), (at_soil_sample ?y), (communicated_rock_data ?p), (at ?r ?p), (communicated_rock_data ?p), (equipped_for_imaging ?r), (at_soil_sample ?p), (communicated_soil_data ?x), (at_soil_sample ?x), (equipped_for_imaging ?r), (at ?r ?x), (can_traverse ?r ?p ?x), (visible ?y ?x), (at_rock_sample ?p), (have_soil_analysis ?r ?x), (at ?r ?x), 
;; communicate_rock_data action has changed: (at_rock_sample ?y), (visible ?p ?x), (can_traverse ?r ?x ?y), (communicated_soil_data ?y), (equipped_for_imaging ?r), (equipped_for_imaging ?r), (at_rock_sample ?p), (visible ?y ?p), (communicated_soil_data ?x), (visible ?x ?y), (at_lander ?l ?y), (visible ?p ?x), (at_soil_sample ?y), (have_soil_analysis ?r ?y), (visible ?x ?p), (have_rock_analysis ?r ?y), (have_rock_analysis ?r ?x), (equipped_for_rock_analysis ?r), (visible ?y ?p), (equipped_for_soil_analysis ?r), (communicated_rock_data ?p), (visible ?p ?y), (visible ?x ?y), (communicated_rock_data ?x), (can_traverse ?r ?p ?x), (visible ?p ?y), (can_traverse ?r ?y ?p), (have_rock_analysis ?r ?p), (at ?r ?y), (communicated_soil_data ?p), (available ?r), (at_soil_sample ?x), (channel_free ?l), (have_soil_analysis ?r ?p), (at_soil_sample ?y), (channel_free ?l), (visible ?y ?x), (communicated_rock_data ?y), (can_traverse ?r ?y ?x), (at ?r ?y), (visible ?x ?p), (have_soil_analysis ?r ?x), (have_soil_analysis ?r ?y), (available ?r), (can_traverse ?r ?x ?y), (at_lander ?l ?p), (at ?r ?x), (at_soil_sample ?p), (communicated_soil_data ?y), (at_soil_sample ?p), (at_lander ?l ?y), (communicated_rock_data ?x), (at_rock_sample ?x), (at ?r ?p), (visible ?y ?x), (have_rock_analysis ?r ?y), (have_soil_analysis ?r ?x), (at_soil_sample ?x), (communicated_soil_data ?x), (can_traverse ?r ?y ?p), (can_traverse ?r ?p ?y), (at ?r ?p), (at_rock_sample ?p), (have_rock_analysis ?r ?x), (communicated_rock_data ?p), (at_lander ?l ?x), (at_lander ?l ?x), (at_rock_sample ?y), (can_traverse ?r ?y ?x), (can_traverse ?r ?p ?y), (can_traverse ?r ?x ?p), (can_traverse ?r ?p ?x), (communicated_rock_data ?y), 
;; communicate_image_data action has changed: (have_soil_analysis ?r ?x), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?y), (at_soil_sample ?x), (at_lander ?l ?y), (equipped_for_rock_analysis ?r), (at ?r ?y), (communicated_soil_data ?y), (equipped_for_imaging ?r), (have_rock_analysis ?r ?y), (have_soil_analysis ?r ?x), (communicated_rock_data ?x), (at ?r ?x), (at_rock_sample ?y), (at_rock_sample ?y), (communicated_rock_data ?y), (at_soil_sample ?y), (communicated_soil_data ?x), (visible ?x ?y), (have_image ?r ?o ?m), (channel_free ?l), (have_rock_analysis ?r ?x), (channel_free ?l), (at_soil_sample ?y), (available ?r), (communicated_rock_data ?y), (can_traverse ?r ?x ?y), (communicated_image_data ?o ?m), (at_lander ?l ?x), (can_traverse ?r ?y ?x), (at ?r ?x), (can_traverse ?r ?x ?y), (visible_from ?o ?x), (communicated_image_data ?o ?m), (communicated_soil_data ?x), (at_rock_sample ?x), (have_image ?r ?o ?m), (have_soil_analysis ?r ?y), (have_rock_analysis ?r ?x), (communicated_soil_data ?y), (visible ?y ?x), (equipped_for_imaging ?r), (at_soil_sample ?x), (equipped_for_soil_analysis ?r), (at ?r ?y), (visible ?x ?y), (visible ?y ?x), (at_lander ?l ?x), (can_traverse ?r ?y ?x), (equipped_for_rock_analysis ?r), (at_rock_sample ?x), (communicated_rock_data ?x), 
;; navigate action has changed: (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (at_soil_sample ?z), (at ?x ?y), (communicated_soil_data ?y), (can_traverse ?x ?y ?z), (at_soil_sample ?z), (visible ?z ?y), (visible ?z ?y), (at ?x ?z), (have_rock_analysis ?x ?z), (equipped_for_rock_analysis ?x), (at ?x ?z), (have_soil_analysis ?x ?z), (at_soil_sample ?y), (at_rock_sample ?y), (communicated_rock_data ?z), (equipped_for_soil_analysis ?x), (at_rock_sample ?z), (equipped_for_imaging ?x), (at_soil_sample ?y), (at ?x ?y), (communicated_soil_data ?z), (can_traverse ?x ?z ?y), (equipped_for_imaging ?x), (have_rock_analysis ?x ?y), (communicated_rock_data ?z), (have_rock_analysis ?x ?z), (have_rock_analysis ?x ?y), (available ?x), (have_soil_analysis ?x ?y), (communicated_rock_data ?y), (have_soil_analysis ?x ?y), (visible ?y ?z), (visible ?y ?z), (communicated_soil_data ?z), (communicated_rock_data ?y), 
;; sample_soil action has changed: (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?p), (have_rock_analysis ?x ?p), (available ?x), (empty ?s), (full ?s), (at_soil_sample ?p), (have_soil_analysis ?x ?p), (at ?x ?p), (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), (store_of ?s ?x), (communicated_rock_data ?p), (store_of ?s ?x), (at ?x ?p), (equipped_for_imaging ?x), (full ?s), (at_rock_sample ?p), (empty ?s), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (at_rock_sample ?p), (have_soil_analysis ?x ?p), (communicated_rock_data ?p), (available ?x), (communicated_soil_data ?p), 
;; drop action has changed: (full ?y), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), (empty ?y), (full ?y), (equipped_for_rock_analysis ?x), (available ?x), (store_of ?y ?x), (available ?x), (equipped_for_imaging ?x), (store_of ?y ?x), (empty ?y), (equipped_for_soil_analysis ?x), 
;; calibrate action has changed: (have_soil_analysis ?r ?w), (calibration_target ?i ?t), (equipped_for_imaging ?r), (have_rock_analysis ?r ?w), (on_board ?i ?r), (available ?r), (calibration_target ?i ?t), (communicated_soil_data ?w), (available ?r), (at ?r ?w), (equipped_for_rock_analysis ?r), (communicated_rock_data ?w), (equipped_for_imaging ?r), (communicated_soil_data ?w), (equipped_for_rock_analysis ?r), (at_rock_sample ?w), (equipped_for_soil_analysis ?r), (calibrated ?i ?r), (at_soil_sample ?w), (communicated_rock_data ?w), (visible_from ?t ?w), (at_soil_sample ?w), (at_rock_sample ?w), (equipped_for_soil_analysis ?r), (visible_from ?t ?w), (on_board ?i ?r), (calibrated ?i ?r), (have_rock_analysis ?r ?w), 
;; take_image action has changed: (have_rock_analysis ?r ?p), (communicated_rock_data ?p), (visible_from ?o ?p), (on_board ?i ?r), (at ?r ?p), (communicated_image_data ?o ?m), (at_soil_sample ?p), (available ?r), (calibration_target ?i ?o), (have_rock_analysis ?r ?p), (on_board ?i ?r), (equipped_for_soil_analysis ?r), (calibrated ?i ?r), (available ?r), (supports ?i ?m), (have_image ?r ?o ?m), (calibration_target ?i ?o), (have_soil_analysis ?r ?p), (visible_from ?o ?p), (equipped_for_imaging ?r), (at_soil_sample ?p), (communicated_image_data ?o ?m), (supports ?i ?m), (have_soil_analysis ?r ?p), (at_rock_sample ?p), (communicated_soil_data ?p), (communicated_soil_data ?p), (calibrated ?i ?r), (equipped_for_imaging ?r), (communicated_rock_data ?p), (equipped_for_rock_analysis ?r), (at_rock_sample ?p), (have_image ?r ?o ?m), 
;; sample_rock action has changed: (have_soil_analysis ?x ?p), (at_soil_sample ?p), (available ?x), (empty ?s), (empty ?s), (store_of ?s ?x), (at ?x ?p), (equipped_for_rock_analysis ?x), (communicated_soil_data ?p), (at_soil_sample ?p), (equipped_for_imaging ?x), (at_rock_sample ?p), (at_rock_sample ?p), (have_soil_analysis ?x ?p), (equipped_for_imaging ?x), (communicated_soil_data ?p), (have_rock_analysis ?x ?p), (at ?x ?p), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?p), (full ?s), (communicated_rock_data ?p), (store_of ?s ?x), (communicated_rock_data ?p), 
;; Last_reduced_capability_num_dropped_pals: None

