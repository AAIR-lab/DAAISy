(define (problem roverprob4123)
  (:domain rover)
  (:objects high-res -  mode colour -  mode general -  lander rover0 -  rover rover1 -  rover rover2 -  rover low-res -  mode rover1store -  store rover0store -  store rover2store -  store waypoint0 -  waypoint waypoint1 -  waypoint waypoint2 -  waypoint waypoint3 -  waypoint waypoint4 -  waypoint waypoint5 -  waypoint camera0 -  camera camera1 -  camera objective0 -  objective objective1 -  objective )
  (:init (equipped-for-imaging rover0) (can-traverse rover1 waypoint3 waypoint2) (visible waypoint4 waypoint3) (supports camera0 colour) (can-traverse rover0 waypoint3 waypoint2) (visible waypoint1 waypoint0) (equipped-for-rock-analysis rover1) (store-of rover2store rover2) (visible-from objective1 waypoint0) (visible waypoint4 waypoint5) (visible waypoint1 waypoint2) (visible waypoint5 waypoint1) (visible-from objective0 waypoint0) (can-traverse rover1 waypoint1 waypoint0) (can-traverse rover2 waypoint0 waypoint1) (can-traverse rover0 waypoint5 waypoint2) (can-traverse rover0 waypoint2 waypoint3) (visible waypoint0 waypoint3) (visible waypoint2 waypoint1) (channel-free general) (visible waypoint2 waypoint5) (can-traverse rover2 waypoint5 waypoint4) (on-board camera1 rover2) (at-soil-sample waypoint1) (can-traverse rover2 waypoint4 waypoint0) (visible-from objective0 waypoint2) (can-traverse rover1 waypoint3 waypoint0) (can-traverse rover1 waypoint0 waypoint3) (at-lander general waypoint3) (visible-from objective0 waypoint1) (can-traverse rover2 waypoint0 waypoint3) (visible waypoint5 waypoint4) (can-traverse rover0 waypoint4 waypoint0) (visible waypoint5 waypoint0) (can-traverse rover1 waypoint5 waypoint0) (visible waypoint5 waypoint2) (can-traverse rover0 waypoint0 waypoint4) (can-traverse rover1 waypoint3 waypoint4) (visible-from objective1 waypoint3) (visible waypoint0 waypoint2) (can-traverse rover2 waypoint1 waypoint0) (can-traverse rover0 waypoint2 waypoint0) (can-traverse rover1 waypoint4 waypoint3) (store-of rover0store rover0) (calibration-target camera0 objective0) (visible waypoint3 waypoint2) (visible waypoint3 waypoint0) (at rover2 waypoint4) (can-traverse rover2 waypoint0 waypoint4) (available rover0) (can-traverse rover0 waypoint0 waypoint2) (visible waypoint3 waypoint4) (on-board camera0 rover0) (equipped-for-soil-analysis rover2) (equipped-for-rock-analysis rover2) (visible-from objective0 waypoint4) (equipped-for-rock-analysis rover0) (equipped-for-imaging rover2) (can-traverse rover1 waypoint2 waypoint3) (visible-from objective1 waypoint1) (store-of rover1store rover1) (visible-from objective1 waypoint2) (can-traverse rover2 waypoint3 waypoint0) (can-traverse rover2 waypoint2 waypoint5) (supports camera0 high-res) (calibration-target camera1 objective1) (visible-from objective0 waypoint3) (visible waypoint2 waypoint3) (can-traverse rover0 waypoint1 waypoint2) (visible waypoint4 waypoint0) (visible waypoint0 waypoint5) (at-rock-sample waypoint5) (visible waypoint0 waypoint1) (available rover2) (can-traverse rover2 waypoint5 waypoint2) (can-traverse rover1 waypoint0 waypoint1) (can-traverse rover1 waypoint0 waypoint5) (supports camera1 high-res) (can-traverse rover0 waypoint2 waypoint1) (at rover0 waypoint2) (visible waypoint1 waypoint5) (visible waypoint0 waypoint4) (can-traverse rover2 waypoint4 waypoint5) (equipped-for-soil-analysis rover0) (available rover1) (visible waypoint2 waypoint0) (can-traverse rover0 waypoint2 waypoint5) (have-image rover0 objective0 high-res) (communicated-image-data objective0 high-res) (full rover1store) (have-rock-analysis rover1 waypoint3) (at rover1 waypoint4) (communicated-rock-data waypoint3) (have-soil-analysis rover2 waypoint4) (communicated-soil-data waypoint4) (full rover2store) (have-rock-analysis rover2 waypoint4) (communicated-rock-data waypoint4) (full rover0store) (have-rock-analysis rover0 waypoint2) )
  (:goal (and (equipped-for-imaging rover0)(can-traverse rover1 waypoint3 waypoint2)(visible waypoint4 waypoint3)(supports camera0 colour)(can-traverse rover0 waypoint3 waypoint2)(visible waypoint1 waypoint0)(equipped-for-rock-analysis rover1)(store-of rover2store rover2)(visible-from objective1 waypoint0)(visible waypoint4 waypoint5)(visible waypoint1 waypoint2)(visible waypoint5 waypoint1)(visible-from objective0 waypoint0)(can-traverse rover1 waypoint1 waypoint0)(can-traverse rover2 waypoint0 waypoint1)(can-traverse rover0 waypoint5 waypoint2)(can-traverse rover0 waypoint2 waypoint3)(visible waypoint0 waypoint3)(visible waypoint2 waypoint1)(channel-free general)(visible waypoint2 waypoint5)(can-traverse rover2 waypoint5 waypoint4)(on-board camera1 rover2)(at-soil-sample waypoint1)(can-traverse rover2 waypoint4 waypoint0)(visible-from objective0 waypoint2)(can-traverse rover1 waypoint3 waypoint0)(can-traverse rover1 waypoint0 waypoint3)(at-lander general waypoint3)(visible-from objective0 waypoint1)(can-traverse rover2 waypoint0 waypoint3)(visible waypoint5 waypoint4)(can-traverse rover0 waypoint4 waypoint0)(visible waypoint5 waypoint0)(can-traverse rover1 waypoint5 waypoint0)(visible waypoint5 waypoint2)(can-traverse rover0 waypoint0 waypoint4)(can-traverse rover1 waypoint3 waypoint4)(visible-from objective1 waypoint3)(visible waypoint0 waypoint2)(can-traverse rover2 waypoint1 waypoint0)(can-traverse rover0 waypoint2 waypoint0)(can-traverse rover1 waypoint4 waypoint3)(store-of rover0store rover0)(calibration-target camera0 objective0)(visible waypoint3 waypoint2)(visible waypoint3 waypoint0)(at rover2 waypoint4)(can-traverse rover2 waypoint0 waypoint4)(available rover0)(can-traverse rover0 waypoint0 waypoint2)(visible waypoint3 waypoint4)(on-board camera0 rover0)(equipped-for-soil-analysis rover2)(equipped-for-rock-analysis rover2)(visible-from objective0 waypoint4)(equipped-for-rock-analysis rover0)(equipped-for-imaging rover2)(can-traverse rover1 waypoint2 waypoint3)(visible-from objective1 waypoint1)(store-of rover1store rover1)(visible-from objective1 waypoint2)(can-traverse rover2 waypoint3 waypoint0)(can-traverse rover2 waypoint2 waypoint5)(supports camera0 high-res)(calibration-target camera1 objective1)(visible-from objective0 waypoint3)(visible waypoint2 waypoint3)(can-traverse rover0 waypoint1 waypoint2)(visible waypoint4 waypoint0)(visible waypoint0 waypoint5)(at-rock-sample waypoint5)(visible waypoint0 waypoint1)(available rover2)(can-traverse rover2 waypoint5 waypoint2)(can-traverse rover1 waypoint0 waypoint1)(can-traverse rover1 waypoint0 waypoint5)(supports camera1 high-res)(can-traverse rover0 waypoint2 waypoint1)(visible waypoint1 waypoint5)(visible waypoint0 waypoint4)(can-traverse rover2 waypoint4 waypoint5)(equipped-for-soil-analysis rover0)(available rover1)(visible waypoint2 waypoint0)(can-traverse rover0 waypoint2 waypoint5)(have-image rover0 objective0 high-res)(communicated-image-data objective0 high-res)(full rover1store)(have-rock-analysis rover1 waypoint3)(at rover1 waypoint4)(communicated-rock-data waypoint3)(have-soil-analysis rover2 waypoint4)(communicated-soil-data waypoint4)(full rover2store)(have-rock-analysis rover2 waypoint4)(communicated-rock-data waypoint4)(have-rock-analysis rover0 waypoint2)(communicated-rock-data waypoint2)(empty rover0store)(at rover0 waypoint1))))