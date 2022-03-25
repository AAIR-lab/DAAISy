(define (problem roverprob4132)
  (:domain rover)
  (:objects high-res -  mode general -  lander low-res -  mode rover0 -  rover rover1 -  rover rover2 -  rover colour -  mode rover0store -  store rover3 -  rover rover1store -  store rover2store -  store rover3store -  store waypoint0 -  waypoint waypoint1 -  waypoint waypoint2 -  waypoint waypoint3 -  waypoint waypoint4 -  waypoint waypoint5 -  waypoint waypoint6 -  waypoint camera0 -  camera camera1 -  camera camera2 -  camera camera3 -  camera camera4 -  camera objective0 -  objective objective1 -  objective objective2 -  objective )
  (:init (can-traverse rover0 waypoint5 waypoint6) (equipped-for-imaging rover0) (supports camera4 colour) (calibration-target camera2 objective0) (visible waypoint4 waypoint3) (visible waypoint6 waypoint4) (can-traverse rover3 waypoint0 waypoint2) (can-traverse rover3 waypoint1 waypoint2) (visible waypoint1 waypoint0) (equipped-for-rock-analysis rover1) (visible waypoint1 waypoint4) (can-traverse rover2 waypoint0 waypoint1) (store-of rover2store rover2) (visible waypoint4 waypoint1) (at-rock-sample waypoint3) (can-traverse rover1 waypoint1 waypoint2) (empty rover0store) (visible-from objective1 waypoint0) (can-traverse rover0 waypoint6 waypoint5) (visible waypoint1 waypoint2) (visible waypoint5 waypoint1) (can-traverse rover1 waypoint6 waypoint2) (visible waypoint1 waypoint6) (can-traverse rover3 waypoint0 waypoint3) (can-traverse rover0 waypoint5 waypoint2) (can-traverse rover3 waypoint2 waypoint6) (can-traverse rover3 waypoint3 waypoint0) (can-traverse rover1 waypoint2 waypoint5) (can-traverse rover1 waypoint3 waypoint1) (visible waypoint0 waypoint3) (visible-from objective2 waypoint2) (equipped-for-imaging rover3) (visible waypoint2 waypoint1) (can-traverse rover3 waypoint0 waypoint5) (supports camera0 colour) (channel-free general) (visible waypoint2 waypoint5) (can-traverse rover0 waypoint5 waypoint1) (visible waypoint1 waypoint3) (at-soil-sample waypoint1) (visible-from objective0 waypoint2) (can-traverse rover0 waypoint1 waypoint3) (can-traverse rover0 waypoint0 waypoint5) (visible-from objective1 waypoint5) (visible-from objective0 waypoint1) (can-traverse rover2 waypoint1 waypoint2) (can-traverse rover2 waypoint0 waypoint3) (can-traverse rover2 waypoint6 waypoint0) (visible waypoint5 waypoint6) (calibration-target camera3 objective0) (visible waypoint5 waypoint0) (can-traverse rover1 waypoint2 waypoint6) (visible waypoint5 waypoint2) (supports camera3 low-res) (visible waypoint2 waypoint6) (visible-from objective2 waypoint3) (visible-from objective1 waypoint4) (can-traverse rover1 waypoint0 waypoint2) (can-traverse rover2 waypoint3 waypoint4) (at-rock-sample waypoint1) (on-board camera2 rover0) (on-board camera4 rover1) (visible waypoint2 waypoint0) (on-board camera0 rover3) (visible-from objective2 waypoint0) (visible-from objective1 waypoint3) (visible-from objective2 waypoint5) (visible waypoint6 waypoint2) (at-lander general waypoint4) (visible waypoint0 waypoint2) (can-traverse rover2 waypoint1 waypoint0) (at rover1 waypoint2) (can-traverse rover1 waypoint1 waypoint3) (can-traverse rover2 waypoint2 waypoint1) (equipped-for-imaging rover1) (supports camera0 low-res) (store-of rover0store rover0) (empty rover1store) (supports camera3 colour) (at rover0 waypoint5) (visible-from objective2 waypoint6) (visible waypoint3 waypoint0) (visible waypoint6 waypoint0) (can-traverse rover0 waypoint3 waypoint1) (can-traverse rover0 waypoint1 waypoint5) (visible waypoint3 waypoint6) (can-traverse rover1 waypoint1 waypoint4) (visible waypoint3 waypoint4) (equipped-for-soil-analysis rover2) (available rover3) (can-traverse rover3 waypoint2 waypoint0) (calibration-target camera4 objective1) (supports camera1 colour) (equipped-for-imaging rover2) (visible-from objective1 waypoint1) (can-traverse rover2 waypoint5 waypoint1) (store-of rover1store rover1) (can-traverse rover1 waypoint5 waypoint2) (calibration-target camera0 objective2) (can-traverse rover1 waypoint2 waypoint1) (calibration-target camera1 objective2) (visible-from objective1 waypoint2) (can-traverse rover2 waypoint3 waypoint0) (store-of rover3store rover3) (can-traverse rover2 waypoint0 waypoint6) (visible waypoint0 waypoint5) (visible waypoint3 waypoint1) (at-rock-sample waypoint0) (at-rock-sample waypoint5) (at-rock-sample waypoint6) (visible waypoint6 waypoint5) (visible waypoint0 waypoint1) (can-traverse rover3 waypoint2 waypoint1) (can-traverse rover1 waypoint2 waypoint0) (visible waypoint6 waypoint1) (available rover0) (can-traverse rover0 waypoint4 waypoint1) (available rover2) (equipped-for-soil-analysis rover3) (supports camera2 low-res) (visible-from objective2 waypoint1) (can-traverse rover0 waypoint5 waypoint0) (visible-from objective0 waypoint0) (visible waypoint4 waypoint6) (on-board camera1 rover0) (visible waypoint6 waypoint3) (supports camera3 high-res) (can-traverse rover1 waypoint4 waypoint1) (supports camera4 low-res) (visible waypoint1 waypoint5) (visible-from objective2 waypoint4) (can-traverse rover0 waypoint1 waypoint4) (can-traverse rover3 waypoint6 waypoint2) (can-traverse rover2 waypoint1 waypoint5) (can-traverse rover2 waypoint4 waypoint3) (available rover1) (visible waypoint0 waypoint6) (can-traverse rover3 waypoint5 waypoint0) (on-board camera3 rover2) (at-soil-sample waypoint5) (can-traverse rover0 waypoint2 waypoint5) (can-traverse rover3 waypoint1 waypoint4) (can-traverse rover3 waypoint4 waypoint1) (at rover3 waypoint6) (full rover3store) (have-soil-analysis rover3 waypoint6) (communicated-soil-data waypoint6) (have-image rover3 objective2 low-res) (communicated-image-data objective2 low-res) (have-image rover3 objective2 colour) (communicated-image-data objective2 colour) (have-soil-analysis rover2 waypoint4) (communicated-soil-data waypoint4) (full rover2store) (have-soil-analysis rover2 waypoint0) (at rover2 waypoint6) )
  (:goal (and (can-traverse rover0 waypoint5 waypoint6)(equipped-for-imaging rover0)(supports camera4 colour)(calibration-target camera2 objective0)(visible waypoint4 waypoint3)(visible waypoint6 waypoint4)(can-traverse rover3 waypoint0 waypoint2)(can-traverse rover3 waypoint1 waypoint2)(visible waypoint1 waypoint0)(equipped-for-rock-analysis rover1)(visible waypoint1 waypoint4)(can-traverse rover2 waypoint0 waypoint1)(store-of rover2store rover2)(visible waypoint4 waypoint1)(at-rock-sample waypoint3)(can-traverse rover1 waypoint1 waypoint2)(empty rover0store)(visible-from objective1 waypoint0)(can-traverse rover0 waypoint6 waypoint5)(visible waypoint1 waypoint2)(visible waypoint5 waypoint1)(can-traverse rover1 waypoint6 waypoint2)(visible waypoint1 waypoint6)(can-traverse rover3 waypoint0 waypoint3)(can-traverse rover0 waypoint5 waypoint2)(can-traverse rover3 waypoint2 waypoint6)(can-traverse rover3 waypoint3 waypoint0)(can-traverse rover1 waypoint2 waypoint5)(can-traverse rover1 waypoint3 waypoint1)(visible waypoint0 waypoint3)(visible-from objective2 waypoint2)(equipped-for-imaging rover3)(visible waypoint2 waypoint1)(can-traverse rover3 waypoint0 waypoint5)(supports camera0 colour)(channel-free general)(visible waypoint2 waypoint5)(can-traverse rover0 waypoint5 waypoint1)(visible waypoint1 waypoint3)(at-soil-sample waypoint1)(visible-from objective0 waypoint2)(can-traverse rover0 waypoint1 waypoint3)(can-traverse rover0 waypoint0 waypoint5)(visible-from objective1 waypoint5)(visible-from objective0 waypoint1)(can-traverse rover2 waypoint1 waypoint2)(can-traverse rover2 waypoint0 waypoint3)(can-traverse rover2 waypoint6 waypoint0)(visible waypoint5 waypoint6)(calibration-target camera3 objective0)(visible waypoint5 waypoint0)(can-traverse rover1 waypoint2 waypoint6)(visible waypoint5 waypoint2)(supports camera3 low-res)(visible waypoint2 waypoint6)(visible-from objective2 waypoint3)(visible-from objective1 waypoint4)(can-traverse rover1 waypoint0 waypoint2)(can-traverse rover2 waypoint3 waypoint4)(at-rock-sample waypoint1)(on-board camera2 rover0)(on-board camera4 rover1)(visible waypoint2 waypoint0)(on-board camera0 rover3)(visible-from objective2 waypoint0)(visible-from objective1 waypoint3)(visible-from objective2 waypoint5)(visible waypoint6 waypoint2)(at-lander general waypoint4)(visible waypoint0 waypoint2)(can-traverse rover2 waypoint1 waypoint0)(can-traverse rover1 waypoint1 waypoint3)(can-traverse rover2 waypoint2 waypoint1)(equipped-for-imaging rover1)(supports camera0 low-res)(store-of rover0store rover0)(supports camera3 colour)(at rover0 waypoint5)(visible-from objective2 waypoint6)(visible waypoint3 waypoint0)(visible waypoint6 waypoint0)(can-traverse rover0 waypoint3 waypoint1)(can-traverse rover0 waypoint1 waypoint5)(visible waypoint3 waypoint6)(can-traverse rover1 waypoint1 waypoint4)(visible waypoint3 waypoint4)(equipped-for-soil-analysis rover2)(available rover3)(can-traverse rover3 waypoint2 waypoint0)(calibration-target camera4 objective1)(supports camera1 colour)(equipped-for-imaging rover2)(visible-from objective1 waypoint1)(can-traverse rover2 waypoint5 waypoint1)(store-of rover1store rover1)(can-traverse rover1 waypoint5 waypoint2)(calibration-target camera0 objective2)(can-traverse rover1 waypoint2 waypoint1)(calibration-target camera1 objective2)(visible-from objective1 waypoint2)(can-traverse rover2 waypoint3 waypoint0)(store-of rover3store rover3)(can-traverse rover2 waypoint0 waypoint6)(visible waypoint0 waypoint5)(visible waypoint3 waypoint1)(at-rock-sample waypoint5)(at-rock-sample waypoint6)(visible waypoint6 waypoint5)(visible waypoint0 waypoint1)(can-traverse rover3 waypoint2 waypoint1)(can-traverse rover1 waypoint2 waypoint0)(visible waypoint6 waypoint1)(available rover0)(can-traverse rover0 waypoint4 waypoint1)(available rover2)(equipped-for-soil-analysis rover3)(supports camera2 low-res)(visible-from objective2 waypoint1)(can-traverse rover0 waypoint5 waypoint0)(visible-from objective0 waypoint0)(visible waypoint4 waypoint6)(on-board camera1 rover0)(visible waypoint6 waypoint3)(supports camera3 high-res)(can-traverse rover1 waypoint4 waypoint1)(supports camera4 low-res)(visible waypoint1 waypoint5)(visible-from objective2 waypoint4)(can-traverse rover0 waypoint1 waypoint4)(can-traverse rover3 waypoint6 waypoint2)(can-traverse rover2 waypoint1 waypoint5)(can-traverse rover2 waypoint4 waypoint3)(available rover1)(visible waypoint0 waypoint6)(can-traverse rover3 waypoint5 waypoint0)(on-board camera3 rover2)(at-soil-sample waypoint5)(can-traverse rover0 waypoint2 waypoint5)(can-traverse rover3 waypoint1 waypoint4)(can-traverse rover3 waypoint4 waypoint1)(at rover3 waypoint6)(full rover3store)(have-soil-analysis rover3 waypoint6)(communicated-soil-data waypoint6)(have-image rover3 objective2 low-res)(communicated-image-data objective2 low-res)(have-image rover3 objective2 colour)(communicated-image-data objective2 colour)(have-soil-analysis rover2 waypoint4)(communicated-soil-data waypoint4)(full rover2store)(have-soil-analysis rover2 waypoint0)(at rover2 waypoint6)(communicated-soil-data waypoint0)(at rover1 waypoint0)(full rover1store)(have-rock-analysis rover1 waypoint0))))