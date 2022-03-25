(define (problem strips-sat-x-1)
  (:domain satellite)
  (:objects instrument3 -  instrument satellite2 -  satellite instrument4 -  instrument instrument5 -  instrument instrument0 -  instrument satellite0 -  satellite instrument1 -  instrument satellite1 -  satellite instrument2 -  instrument satellite3 -  satellite instrument6 -  instrument instrument7 -  instrument satellite4 -  satellite instrument8 -  instrument instrument9 -  instrument instrument10 -  instrument infrared0 -  mode spectrograph1 -  mode infrared3 -  mode image4 -  mode image2 -  mode star1 -  direction groundstation3 -  direction star4 -  direction star2 -  direction star0 -  direction planet5 -  direction star6 -  direction star7 -  direction phenomenon8 -  direction planet9 -  direction planet10 -  direction star11 -  direction star12 -  direction phenomenon13 -  direction phenomenon14 -  direction star15 -  direction star16 -  direction )
  (:init (on-board instrument6 satellite3) (pointing satellite0 star0) (supports instrument6 infrared0) (on-board instrument4 satellite2) (supports instrument5 infrared0) (supports instrument3 infrared0) (on-board instrument0 satellite0) (calibration-target instrument2 groundstation3) (calibration-target instrument8 star4) (supports instrument8 image4) (calibration-target instrument6 groundstation3) (on-board instrument1 satellite0) (supports instrument6 infrared3) (supports instrument8 spectrograph1) (supports instrument5 infrared3) (calibration-target instrument0 star1) (power-avail satellite1) (supports instrument4 spectrograph1) (supports instrument1 spectrograph1) (calibration-target instrument1 groundstation3) (supports instrument7 spectrograph1) (power-avail satellite0) (supports instrument2 infrared0) (supports instrument0 image4) (calibration-target instrument5 star0) (supports instrument4 image4) (supports instrument7 infrared3) (supports instrument2 image2) (on-board instrument7 satellite3) (calibration-target instrument4 star2) (on-board instrument10 satellite4) (on-board instrument5 satellite2) (pointing satellite2 star1) (calibration-target instrument10 star0) (supports instrument7 image4) (on-board instrument8 satellite4) (calibration-target instrument7 star4) (supports instrument1 infrared0) (supports instrument4 infrared0) (power-avail satellite2) (supports instrument3 infrared3) (on-board instrument3 satellite1) (calibration-target instrument3 star4) (on-board instrument2 satellite1) (supports instrument9 infrared3) (supports instrument10 image4) (on-board instrument9 satellite4) (supports instrument5 image2) (supports instrument10 image2) (calibration-target instrument9 star2) (pointing satellite4 star4) (pointing satellite1 groundstation3) (power-on instrument6) (calibrated instrument6) (have-image star6 infrared3) (have-image planet9 infrared0) (pointing satellite3 planet10) (have-image planet10 infrared3) (power-on instrument8) )
  (:goal (and (on-board instrument6 satellite3)(pointing satellite0 star0)(supports instrument6 infrared0)(on-board instrument4 satellite2)(supports instrument5 infrared0)(supports instrument3 infrared0)(on-board instrument0 satellite0)(calibration-target instrument2 groundstation3)(calibration-target instrument8 star4)(supports instrument8 image4)(calibration-target instrument6 groundstation3)(on-board instrument1 satellite0)(supports instrument6 infrared3)(supports instrument8 spectrograph1)(supports instrument5 infrared3)(calibration-target instrument0 star1)(power-avail satellite1)(supports instrument4 spectrograph1)(supports instrument1 spectrograph1)(calibration-target instrument1 groundstation3)(supports instrument7 spectrograph1)(power-avail satellite0)(supports instrument2 infrared0)(supports instrument0 image4)(calibration-target instrument5 star0)(supports instrument4 image4)(supports instrument7 infrared3)(supports instrument2 image2)(on-board instrument7 satellite3)(calibration-target instrument4 star2)(on-board instrument10 satellite4)(on-board instrument5 satellite2)(pointing satellite2 star1)(calibration-target instrument10 star0)(supports instrument7 image4)(on-board instrument8 satellite4)(calibration-target instrument7 star4)(supports instrument1 infrared0)(supports instrument4 infrared0)(power-avail satellite2)(supports instrument3 infrared3)(on-board instrument3 satellite1)(calibration-target instrument3 star4)(on-board instrument2 satellite1)(supports instrument9 infrared3)(supports instrument10 image4)(on-board instrument9 satellite4)(supports instrument5 image2)(supports instrument10 image2)(calibration-target instrument9 star2)(pointing satellite1 groundstation3)(power-on instrument6)(calibrated instrument6)(have-image star6 infrared3)(have-image planet9 infrared0)(pointing satellite3 planet10)(have-image planet10 infrared3)(power-on instrument8)(calibrated instrument8)(pointing satellite4 planet5)(have-image planet5 image4))))