(define (problem strips-sat-x-1)
  (:domain satellite)
  (:objects satellite0 -  satellite satellite1 -  satellite instrument1 -  instrument instrument2 -  instrument infrared0 -  mode infrared1 -  mode thermograph2 -  mode instrument0 -  instrument groundstation1 -  direction star0 -  direction star2 -  direction planet3 -  direction star4 -  direction planet5 -  direction star6 -  direction star7 -  direction phenomenon8 -  direction phenomenon9 -  direction )
  (:init (supports instrument2 thermograph2) (on-board instrument1 satellite1) (calibration-target instrument0 star0) (supports instrument2 infrared1) (supports instrument0 thermograph2) (supports instrument1 thermograph2) (on-board instrument0 satellite0) (on-board instrument2 satellite1) (supports instrument1 infrared1) (supports instrument0 infrared0) (calibration-target instrument2 star2) (calibration-target instrument1 star2) (supports instrument1 infrared0) (pointing satellite0 star0) (power-on instrument2) (calibrated instrument2) (have-image planet3 infrared1) (have-image star4 infrared1) (have-image star6 infrared1) (have-image phenomenon8 thermograph2) (pointing satellite1 planet5) (have-image planet5 thermograph2) (power-on instrument0) )
  (:goal (and (supports instrument2 thermograph2)(on-board instrument1 satellite1)(calibration-target instrument0 star0)(supports instrument2 infrared1)(supports instrument0 thermograph2)(supports instrument1 thermograph2)(on-board instrument0 satellite0)(on-board instrument2 satellite1)(supports instrument1 infrared1)(supports instrument0 infrared0)(calibration-target instrument2 star2)(calibration-target instrument1 star2)(supports instrument1 infrared0)(power-on instrument2)(calibrated instrument2)(have-image planet3 infrared1)(have-image star4 infrared1)(have-image star6 infrared1)(have-image phenomenon8 thermograph2)(pointing satellite1 planet5)(have-image planet5 thermograph2)(power-on instrument0)(calibrated instrument0)(pointing satellite0 star7)(have-image star7 infrared0))))