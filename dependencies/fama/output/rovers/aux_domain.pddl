(define (domain rover)
 (:requirements :typing)
 (:types object - None rover - object waypoint - object store - object camera - object mode - object lander - object objective - object )
 (:predicates (at ?o1 - rover ?o2 - waypoint) (at-lander ?o1 - lander ?o2 - waypoint) (at-rock-sample ?o2 - waypoint) (at-soil-sample ?o1 - waypoint) (available ?o1 - rover) (calibrated ?o1 - camera ?o2 - rover) (calibration-target ?o1 - camera ?o2 - objective) (can-traverse ?o1 - rover ?o2 - waypoint ?o3 - waypoint) (channel-free ?o1 - lander) (communicated-image-data ?o1 - objective ?o2 - mode) (communicated-rock-data ?o1 - waypoint) (communicated-soil-data ?o1 - waypoint) (empty ?o1 - store) (equipped-for-imaging ?o1 - rover) (equipped-for-rock-analysis ?o1 - rover) (equipped-for-soil-analysis ?o1 - rover) (full ?o1 - store) (have-image ?o1 - rover ?o2 - objective ?o3 - mode) (have-rock-analysis ?o1 - rover ?o2 - waypoint) (have-soil-analysis ?o1 - rover ?o2 - waypoint) (on-board ?o1 - camera ?o2 - rover) (store-of ?o1 - store ?o2 - rover) (supports ?o1 - camera ?o2 - mode) (visible ?o1 - waypoint ?o2 - waypoint) (visible-from ?o1 - objective ?o2 - waypoint))

 (:action navigate
   :parameters (?o1 - rover ?o2 - waypoint ?o3 - waypoint)
   :precondition (and (can-traverse ?o1 ?o2 ?o3)(available ?o1)(at ?o1 ?o2)(visible ?o2 ?o3))
   :effect (and (not (at ?o1 ?o2))(at ?o1 ?o3)))

 (:action sample-soil
   :parameters (?o1 - rover ?o2 - store ?o3 - waypoint)
   :precondition (and (at ?o1 ?o3)(at-soil-sample ?o3)(equipped-for-soil-analysis ?o1)(store-of ?o2 ?o1)(empty ?o2))
   :effect (and (not (empty ?o2))(full ?o2)(have-soil-analysis ?o1 ?o3)(not (at-soil-sample ?o3))))

 (:action sample-rock
   :parameters (?o1 - rover ?o2 - store ?o3 - waypoint)
   :precondition (and (at ?o1 ?o3)(at-rock-sample ?o3)(equipped-for-rock-analysis ?o1)(store-of ?o2 ?o1)(empty ?o2))
   :effect (and (not (empty ?o2))(full ?o2)(have-rock-analysis ?o1 ?o3)(not (at-rock-sample ?o3))))

 (:action drop
   :parameters (?o1 - rover ?o2 - store)
   :precondition (and (store-of ?o2 ?o1)(full ?o2))
   :effect (and (not (full ?o2))(empty ?o2)))

 (:action calibrate
   :parameters (?o1 - rover ?o2 - camera ?o3 - objective ?o4 - waypoint)
   :precondition (and (equipped-for-imaging ?o1)(calibration-target ?o2 ?o3)(at ?o1 ?o4)(visible-from ?o3 ?o4)(on-board ?o2 ?o1))
   :effect (and (calibrated ?o2 ?o1)))

 (:action take-image
   :parameters (?o1 - rover ?o2 - waypoint ?o3 - objective ?o4 - camera ?o5 - mode)
   :precondition (and (calibrated ?o4 ?o1)(on-board ?o4 ?o1)(equipped-for-imaging ?o1)(supports ?o4 ?o5)(visible-from ?o3 ?o2)(at ?o1 ?o2))
   :effect (and (have-image ?o1 ?o3 ?o5)(not (calibrated ?o4 ?o1))))

 (:action communicate-soil-data
   :parameters (?o1 - rover ?o2 - lander ?o3 - waypoint ?o4 - waypoint ?o5 - waypoint)
   :precondition (and (at ?o1 ?o4)(at-lander ?o2 ?o5)(have-soil-analysis ?o1 ?o3)(visible ?o4 ?o5)(available ?o1)(channel-free ?o2))
   :effect (and (communicated-soil-data ?o3)))

 (:action communicate-rock-data
   :parameters (?o1 - rover ?o2 - lander ?o3 - waypoint ?o4 - waypoint ?o5 - waypoint)
   :precondition (and (at ?o1 ?o4)(at-lander ?o2 ?o5)(have-rock-analysis ?o1 ?o3)(visible ?o4 ?o5)(available ?o1)(channel-free ?o2))
   :effect (and (communicated-rock-data ?o3)))

 (:action communicate-image-data
   :parameters (?o1 - rover ?o2 - lander ?o3 - objective ?o4 - mode ?o5 - waypoint ?o6 - waypoint)
   :precondition (and (at ?o1 ?o5)(at-lander ?o2 ?o6)(have-image ?o1 ?o3 ?o4)(visible ?o5 ?o6)(available ?o1)(channel-free ?o2))
   :effect (and (communicated-image-data ?o3 ?o4)))

)