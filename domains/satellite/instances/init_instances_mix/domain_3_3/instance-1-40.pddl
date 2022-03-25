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

(:INIT (supports instrument0 thermograph0)(on_board instrument0 satellite0)(calibration_target instrument0 groundstation2)(power_on instrument0)(calibrated instrument0)(have_image phenomenon4 thermograph0)(pointing satellite0 phenomenon6))
(:goal (AND (supports instrument0 thermograph0)(on_board instrument0 satellite0)(calibration_target instrument0 groundstation2)(power_on instrument0)(calibrated instrument0)(have_image phenomenon4 thermograph0)(have_image phenomenon6 thermograph0)(pointing satellite0 star5)))
)