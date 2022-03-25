(define (problem roverprob1234) (:domain Rover)
(:objects
	general - Lander
	colour high_res low_res - Mode
	rover0 - Rover
	rover0store - Store
	waypoint0 waypoint1 waypoint2 waypoint3 - Waypoint
	camera0 - Camera
	objective0 objective1 - Objective
	)

(:INIT (equipped_for_rock_analysis rover0)(visible waypoint2 waypoint0)(store_of rover0store rover0)(visible waypoint3 waypoint2)(at_soil_sample waypoint0)(equipped_for_imaging rover0)(visible_from objective1 waypoint1)(visible waypoint0 waypoint1)(visible waypoint2 waypoint1)(supports camera0 colour)(visible waypoint1 waypoint3)(at_rock_sample waypoint2)(on_board camera0 rover0)(can_traverse rover0 waypoint1 waypoint2)(can_traverse rover0 waypoint2 waypoint1)(calibration_target camera0 objective1)(visible_from objective0 waypoint1)(visible waypoint2 waypoint3)(can_traverse rover0 waypoint3 waypoint0)(visible waypoint3 waypoint1)(visible_from objective1 waypoint3)(equipped_for_soil_analysis rover0)(can_traverse rover0 waypoint0 waypoint3)(visible_from objective0 waypoint2)(visible_from objective0 waypoint3)(visible waypoint0 waypoint3)(visible_from objective1 waypoint2)(visible waypoint0 waypoint2)(visible waypoint1 waypoint0)(visible waypoint3 waypoint0)(supports camera0 high_res)(can_traverse rover0 waypoint1 waypoint3)(at_lander general waypoint0)(at_soil_sample waypoint3)(at_rock_sample waypoint1)(channel_free general)(visible_from objective1 waypoint0)(visible waypoint1 waypoint2)(visible_from objective0 waypoint0)(can_traverse rover0 waypoint3 waypoint1)(available rover0)(have_rock_analysis rover0 waypoint3)(communicated_rock_data waypoint3)(at rover0 waypoint2)(have_image rover0 objective1 high_res)(communicated_image_data objective1 high_res)(full rover0store)(have_soil_analysis rover0 waypoint2))
(:goal (AND (equipped_for_rock_analysis rover0)(visible waypoint2 waypoint0)(store_of rover0store rover0)(visible waypoint3 waypoint2)(at_soil_sample waypoint0)(equipped_for_imaging rover0)(visible_from objective1 waypoint1)(visible waypoint0 waypoint1)(visible waypoint2 waypoint1)(supports camera0 colour)(visible waypoint1 waypoint3)(at_rock_sample waypoint2)(on_board camera0 rover0)(can_traverse rover0 waypoint1 waypoint2)(can_traverse rover0 waypoint2 waypoint1)(calibration_target camera0 objective1)(visible_from objective0 waypoint1)(visible waypoint2 waypoint3)(can_traverse rover0 waypoint3 waypoint0)(visible waypoint3 waypoint1)(visible_from objective1 waypoint3)(equipped_for_soil_analysis rover0)(can_traverse rover0 waypoint0 waypoint3)(visible_from objective0 waypoint2)(visible_from objective0 waypoint3)(visible waypoint0 waypoint3)(visible_from objective1 waypoint2)(visible waypoint0 waypoint2)(visible waypoint1 waypoint0)(visible waypoint3 waypoint0)(supports camera0 high_res)(can_traverse rover0 waypoint1 waypoint3)(at_lander general waypoint0)(at_soil_sample waypoint3)(at_rock_sample waypoint1)(channel_free general)(visible_from objective1 waypoint0)(visible waypoint1 waypoint2)(visible_from objective0 waypoint0)(can_traverse rover0 waypoint3 waypoint1)(available rover0)(have_rock_analysis rover0 waypoint3)(communicated_rock_data waypoint3)(at rover0 waypoint2)(have_image rover0 objective1 high_res)(communicated_image_data objective1 high_res)(full rover0store)(have_soil_analysis rover0 waypoint2)(communicated_soil_data waypoint2)))
)