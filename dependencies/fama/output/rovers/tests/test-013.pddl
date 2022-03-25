(define (problem roverprob2435)
  (:domain rover)
  (:objects high-res -  mode general -  lander low-res -  mode rover0 -  rover rover1 -  rover rover0store -  store colour -  mode waypoint0 -  waypoint rover1store -  store waypoint1 -  waypoint waypoint2 -  waypoint waypoint3 -  waypoint camera0 -  camera camera1 -  camera camera2 -  camera objective0 -  objective objective1 -  objective objective2 -  objective )
  (:init (channel-free general) (supports camera0 low-res) (equipped-for-imaging rover0) (visible-from objective2 waypoint0) (visible waypoint3 waypoint1) (can-traverse rover1 waypoint0 waypoint1) (at-rock-sample waypoint0) (visible waypoint0 waypoint2) (visible waypoint1 waypoint3) (visible waypoint0 waypoint1) (visible waypoint2 waypoint1) (supports camera2 colour) (at-soil-sample waypoint1) (can-traverse rover0 waypoint0 waypoint1) (visible-from objective0 waypoint2) (visible waypoint1 waypoint0) (equipped-for-imaging rover1) (supports camera2 low-res) (visible-from objective2 waypoint1) (at-soil-sample waypoint2) (calibration-target camera0 objective1) (at-lander general waypoint3) (equipped-for-soil-analysis rover1) (can-traverse rover1 waypoint1 waypoint3) (visible-from objective0 waypoint1) (store-of rover0store rover0) (empty rover1store) (supports camera1 high-res) (at-soil-sample waypoint3) (on-board camera1 rover1) (visible waypoint3 waypoint2) (can-traverse rover0 waypoint1 waypoint0) (can-traverse rover1 waypoint1 waypoint2) (empty rover0store) (visible-from objective1 waypoint0) (visible waypoint3 waypoint0) (can-traverse rover0 waypoint3 waypoint0) (available rover0) (supports camera2 high-res) (visible waypoint1 waypoint2) (visible-from objective0 waypoint0) (can-traverse rover1 waypoint1 waypoint0) (calibration-target camera2 objective1) (visible waypoint2 waypoint0) (equipped-for-rock-analysis rover0) (on-board camera0 rover1) (supports camera1 colour) (visible-from objective1 waypoint1) (available rover1) (on-board camera2 rover0) (store-of rover1store rover1) (can-traverse rover1 waypoint3 waypoint1) (can-traverse rover1 waypoint2 waypoint1) (visible waypoint0 waypoint3) (visible-from objective1 waypoint2) (visible-from objective2 waypoint2) (at rover0 waypoint0) (at-rock-sample waypoint1) (supports camera0 high-res) (can-traverse rover0 waypoint0 waypoint3) (calibration-target camera1 objective1) (visible-from objective0 waypoint3) (visible waypoint2 waypoint3) (at rover1 waypoint1) (have-image rover1 objective0 high-res) (communicated-image-data objective0 high-res) (have-image rover1 objective2 high-res) )
  (:goal (and (channel-free general)(supports camera0 low-res)(equipped-for-imaging rover0)(visible-from objective2 waypoint0)(visible waypoint3 waypoint1)(can-traverse rover1 waypoint0 waypoint1)(at-rock-sample waypoint0)(visible waypoint0 waypoint2)(visible waypoint1 waypoint3)(visible waypoint0 waypoint1)(visible waypoint2 waypoint1)(supports camera2 colour)(at-soil-sample waypoint1)(can-traverse rover0 waypoint0 waypoint1)(visible-from objective0 waypoint2)(visible waypoint1 waypoint0)(equipped-for-imaging rover1)(supports camera2 low-res)(visible-from objective2 waypoint1)(at-soil-sample waypoint2)(calibration-target camera0 objective1)(at-lander general waypoint3)(equipped-for-soil-analysis rover1)(can-traverse rover1 waypoint1 waypoint3)(visible-from objective0 waypoint1)(store-of rover0store rover0)(empty rover1store)(supports camera1 high-res)(at-soil-sample waypoint3)(on-board camera1 rover1)(visible waypoint3 waypoint2)(can-traverse rover0 waypoint1 waypoint0)(can-traverse rover1 waypoint1 waypoint2)(empty rover0store)(visible-from objective1 waypoint0)(visible waypoint3 waypoint0)(can-traverse rover0 waypoint3 waypoint0)(available rover0)(supports camera2 high-res)(visible waypoint1 waypoint2)(visible-from objective0 waypoint0)(can-traverse rover1 waypoint1 waypoint0)(calibration-target camera2 objective1)(visible waypoint2 waypoint0)(equipped-for-rock-analysis rover0)(on-board camera0 rover1)(supports camera1 colour)(visible-from objective1 waypoint1)(available rover1)(on-board camera2 rover0)(store-of rover1store rover1)(can-traverse rover1 waypoint3 waypoint1)(can-traverse rover1 waypoint2 waypoint1)(visible waypoint0 waypoint3)(visible-from objective1 waypoint2)(visible-from objective2 waypoint2)(at rover0 waypoint0)(at-rock-sample waypoint1)(supports camera0 high-res)(can-traverse rover0 waypoint0 waypoint3)(calibration-target camera1 objective1)(visible-from objective0 waypoint3)(visible waypoint2 waypoint3)(at rover1 waypoint1)(have-image rover1 objective0 high-res)(communicated-image-data objective0 high-res)(have-image rover1 objective2 high-res)(communicated-image-data objective2 high-res)(have-image rover1 objective0 colour))))