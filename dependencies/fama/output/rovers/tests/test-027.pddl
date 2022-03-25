(define (problem roverprob2312)
  (:domain rover)
  (:objects high-res -  mode general -  lander low-res -  mode rover0 -  rover rover1 -  rover rover0store -  store colour -  mode waypoint0 -  waypoint rover1store -  store waypoint1 -  waypoint waypoint2 -  waypoint waypoint3 -  waypoint waypoint4 -  waypoint waypoint5 -  waypoint camera0 -  camera camera1 -  camera camera2 -  camera objective0 -  objective objective1 -  objective )
  (:init (visible waypoint3 waypoint5) (channel-free general) (equipped-for-imaging rover0) (visible waypoint0 waypoint5) (visible waypoint3 waypoint1) (supports camera2 high-res) (at-rock-sample waypoint5) (visible waypoint5 waypoint0) (visible waypoint0 waypoint2) (visible waypoint4 waypoint3) (visible waypoint1 waypoint3) (visible waypoint0 waypoint1) (can-traverse rover0 waypoint0 waypoint2) (supports camera0 colour) (visible waypoint5 waypoint3) (supports camera2 colour) (at-soil-sample waypoint1) (can-traverse rover0 waypoint0 waypoint1) (can-traverse rover0 waypoint2 waypoint0) (visible waypoint2 waypoint5) (visible waypoint1 waypoint0) (equipped-for-imaging rover1) (can-traverse rover1 waypoint4 waypoint3) (can-traverse rover1 waypoint0 waypoint1) (supports camera0 low-res) (at-lander general waypoint3) (visible waypoint1 waypoint4) (equipped-for-soil-analysis rover1) (visible-from objective0 waypoint1) (store-of rover0store rover0) (can-traverse rover0 waypoint1 waypoint4) (at-soil-sample waypoint3) (visible waypoint4 waypoint1) (at-rock-sample waypoint3) (visible waypoint5 waypoint4) (can-traverse rover0 waypoint1 waypoint0) (visible-from objective0 waypoint2) (visible-from objective0 waypoint5) (visible-from objective1 waypoint0) (visible waypoint3 waypoint0) (can-traverse rover0 waypoint3 waypoint0) (on-board camera1 rover0) (visible waypoint4 waypoint5) (available rover0) (can-traverse rover1 waypoint1 waypoint4) (can-traverse rover0 waypoint4 waypoint1) (can-traverse rover1 waypoint4 waypoint1) (visible-from objective0 waypoint0) (can-traverse rover1 waypoint5 waypoint4) (visible waypoint3 waypoint4) (on-board camera0 rover0) (visible waypoint2 waypoint0) (visible-from objective0 waypoint4) (equipped-for-rock-analysis rover0) (supports camera1 colour) (can-traverse rover1 waypoint1 waypoint0) (on-board camera2 rover1) (visible-from objective1 waypoint1) (calibration-target camera2 objective0) (available rover1) (at-rock-sample waypoint2) (store-of rover1store rover1) (can-traverse rover1 waypoint2 waypoint5) (calibration-target camera0 objective0) (can-traverse rover1 waypoint5 waypoint2) (can-traverse rover1 waypoint3 waypoint4) (visible waypoint0 waypoint3) (visible waypoint5 waypoint2) (can-traverse rover0 waypoint5 waypoint0) (visible waypoint3 waypoint2) (can-traverse rover1 waypoint4 waypoint5) (can-traverse rover0 waypoint0 waypoint5) (supports camera1 low-res) (can-traverse rover0 waypoint0 waypoint3) (calibration-target camera1 objective1) (visible-from objective0 waypoint3) (visible waypoint2 waypoint3) (at rover0 waypoint0) (have-image rover1 objective0 colour) (communicated-image-data objective0 colour) (have-image rover0 objective1 low-res) (communicated-image-data objective1 low-res) (have-image rover0 objective0 low-res) (communicated-image-data objective0 low-res) (have-soil-analysis rover1 waypoint4) (communicated-soil-data waypoint4) (have-rock-analysis rover0 waypoint0) (communicated-rock-data waypoint0) (empty rover0store) (have-soil-analysis rover1 waypoint5) (communicated-soil-data waypoint5) (have-soil-analysis rover1 waypoint2) (communicated-soil-data waypoint2) (at rover1 waypoint1) (empty rover1store) )
  (:goal (and (visible waypoint3 waypoint5)(channel-free general)(equipped-for-imaging rover0)(visible waypoint0 waypoint5)(visible waypoint3 waypoint1)(supports camera2 high-res)(at-rock-sample waypoint5)(visible waypoint5 waypoint0)(visible waypoint0 waypoint2)(visible waypoint4 waypoint3)(visible waypoint1 waypoint3)(visible waypoint0 waypoint1)(can-traverse rover0 waypoint0 waypoint2)(supports camera0 colour)(visible waypoint5 waypoint3)(supports camera2 colour)(can-traverse rover0 waypoint0 waypoint1)(can-traverse rover0 waypoint2 waypoint0)(visible waypoint2 waypoint5)(visible waypoint1 waypoint0)(equipped-for-imaging rover1)(can-traverse rover1 waypoint4 waypoint3)(can-traverse rover1 waypoint0 waypoint1)(supports camera0 low-res)(at-lander general waypoint3)(visible waypoint1 waypoint4)(equipped-for-soil-analysis rover1)(visible-from objective0 waypoint1)(store-of rover0store rover0)(can-traverse rover0 waypoint1 waypoint4)(at-soil-sample waypoint3)(visible waypoint4 waypoint1)(at-rock-sample waypoint3)(visible waypoint5 waypoint4)(can-traverse rover0 waypoint1 waypoint0)(visible-from objective0 waypoint2)(visible-from objective0 waypoint5)(visible-from objective1 waypoint0)(visible waypoint3 waypoint0)(can-traverse rover0 waypoint3 waypoint0)(on-board camera1 rover0)(visible waypoint4 waypoint5)(available rover0)(can-traverse rover1 waypoint1 waypoint4)(can-traverse rover0 waypoint4 waypoint1)(can-traverse rover1 waypoint4 waypoint1)(visible-from objective0 waypoint0)(can-traverse rover1 waypoint5 waypoint4)(visible waypoint3 waypoint4)(on-board camera0 rover0)(visible waypoint2 waypoint0)(visible-from objective0 waypoint4)(equipped-for-rock-analysis rover0)(supports camera1 colour)(can-traverse rover1 waypoint1 waypoint0)(on-board camera2 rover1)(visible-from objective1 waypoint1)(calibration-target camera2 objective0)(available rover1)(at-rock-sample waypoint2)(store-of rover1store rover1)(can-traverse rover1 waypoint2 waypoint5)(calibration-target camera0 objective0)(can-traverse rover1 waypoint5 waypoint2)(can-traverse rover1 waypoint3 waypoint4)(visible waypoint0 waypoint3)(visible waypoint5 waypoint2)(can-traverse rover0 waypoint5 waypoint0)(visible waypoint3 waypoint2)(can-traverse rover1 waypoint4 waypoint5)(can-traverse rover0 waypoint0 waypoint5)(supports camera1 low-res)(can-traverse rover0 waypoint0 waypoint3)(calibration-target camera1 objective1)(visible-from objective0 waypoint3)(visible waypoint2 waypoint3)(have-image rover1 objective0 colour)(communicated-image-data objective0 colour)(have-image rover0 objective1 low-res)(communicated-image-data objective1 low-res)(have-image rover0 objective0 low-res)(communicated-image-data objective0 low-res)(have-soil-analysis rover1 waypoint4)(communicated-soil-data waypoint4)(have-rock-analysis rover0 waypoint0)(communicated-rock-data waypoint0)(empty rover0store)(have-soil-analysis rover1 waypoint5)(communicated-soil-data waypoint5)(have-soil-analysis rover1 waypoint2)(communicated-soil-data waypoint2)(at rover1 waypoint1)(full rover1store)(have-soil-analysis rover1 waypoint1)(communicated-soil-data waypoint1)(at rover0 waypoint2))))