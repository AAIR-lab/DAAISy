(define (problem strips-sat-x-1)
  (:domain satellite)
  (:objects satellite0 -  satellite satellite1 -  satellite instrument1 -  instrument instrument2 -  instrument instrument3 -  instrument satellite2 -  satellite instrument4 -  instrument instrument0 -  instrument thermograph2 -  mode spectrograph0 -  mode infrared1 -  mode infrared3 -  mode groundstation3 -  direction star1 -  direction star2 -  direction star0 -  direction planet4 -  direction planet5 -  direction star6 -  direction star7 -  direction phenomenon8 -  direction star9 -  direction star10 -  direction )
  (:init (supports instrument2 thermograph2) (pointing satellite2 star6) (on-board instrument4 satellite2) (on-board instrument0 satellite0) (supports instrument3 infrared1) (on-board instrument1 satellite1) (calibration-target instrument0 star1) (supports instrument0 infrared1) (supports instrument2 infrared1) (supports instrument2 infrared3) (on-board instrument3 satellite1) (supports instrument0 spectrograph0) (calibration-target instrument2 star2) (supports instrument4 infrared3) (calibration-target instrument1 star2) (power-avail satellite2) (calibration-target instrument3 star2) (calibration-target instrument4 star0) (supports instrument1 infrared3) (on-board instrument2 satellite1) (supports instrument3 spectrograph0) (supports instrument3 infrared3) (power-on instrument0) (power-on instrument2) (calibrated instrument0) (have-image planet5 spectrograph0) (have-image phenomenon8 spectrograph0) (pointing satellite0 star9) (have-image star9 infrared1) (calibrated instrument2) (have-image planet4 thermograph2) (pointing satellite1 star6) )
  (:goal (and (supports instrument2 thermograph2)(pointing satellite2 star6)(on-board instrument4 satellite2)(on-board instrument0 satellite0)(supports instrument3 infrared1)(on-board instrument1 satellite1)(calibration-target instrument0 star1)(supports instrument0 infrared1)(supports instrument2 infrared1)(supports instrument2 infrared3)(on-board instrument3 satellite1)(supports instrument0 spectrograph0)(calibration-target instrument2 star2)(supports instrument4 infrared3)(calibration-target instrument1 star2)(power-avail satellite2)(calibration-target instrument3 star2)(calibration-target instrument4 star0)(supports instrument1 infrared3)(on-board instrument2 satellite1)(supports instrument3 spectrograph0)(supports instrument3 infrared3)(power-on instrument0)(power-on instrument2)(calibrated instrument0)(have-image planet5 spectrograph0)(have-image phenomenon8 spectrograph0)(pointing satellite0 star9)(have-image star9 infrared1)(calibrated instrument2)(have-image planet4 thermograph2)(have-image star6 thermograph2)(pointing satellite1 star7)(have-image star7 infrared3))))