(define (problem strips-sat-x-1)
(:domain satellite)
(:objects
	satellite0 - satellite
	instrument0 - instrument
	image1 - mode
	spectrograph2 - mode
	thermograph0 - mode
	Star0 - direction
	GroundStation1 - direction
	GroundStation2 - direction
	Phenomenon3 - direction
	Phenomenon4 - direction
	Star5 - direction
	Phenomenon6 - direction
)

(:INIT (power_avail satellite0)(on_board instrument0 satellite0)(pointing satellite0 phenomenon6)(supports instrument0 thermograph0)(calibration_target instrument0 groundstation2))
(:goal (AND (on_board instrument0 satellite0)(supports instrument0 thermograph0)(calibration_target instrument0 groundstation2)(power_on instrument0)(pointing satellite0 groundstation2)(calibrated instrument0)))
)