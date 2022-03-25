(define (domain parking)
 (:requirements :strips :typing)
 (:types car curb)
 (:predicates 
    (at-curb ?o1 - car) 
    (at-curb-num ?o1 - car ?o2 - curb)
    (behind-car ?o1 - car ?o2 - car)
    (car-clear ?o1 - car) 
    (curb-clear ?o1 - curb)
 )

	(:action move-curb-to-curb
		:parameters (?o1 - car ?o2 - curb ?o3 - curb)
		:precondition (and 
			(car-clear ?o1)
			(curb-clear ?o3)
			(at-curb-num ?o1 ?o2)
		)
		:effect (and 
			(not (curb-clear ?o3))
			(curb-clear ?o2)
			(at-curb-num ?o1 ?o3)
			(not (at-curb-num ?o1 ?o2))
		)
	)

	(:action move-curb-to-car
		:parameters (?o1 - car ?o2 - curb ?o3 - car)
		:precondition (and 
			(car-clear ?o1)
			(car-clear ?o3)
			(at-curb-num ?o1 ?o2)
			(at-curb ?o3) 
		)
		:effect (and 
			(not (car-clear ?o3))
			(curb-clear ?o2)
			(behind-car ?o1 ?o3)
			(not (at-curb-num ?o1 ?o2))
			(not (at-curb ?o1))
		)
	)

	(:action move-car-to-curb
		:parameters (?o1 - car ?o2 - car ?o3 - curb)
		:precondition (and 
			(car-clear ?o1)
			(curb-clear ?o3)
			(behind-car ?o1 ?o2)
		)
		:effect (and 
			(not (curb-clear ?o3))
			(car-clear ?o2)
			(at-curb-num ?o1 ?o3)
			(not (behind-car ?o1 ?o2))
			(at-curb ?o1)
		)
	)

	(:action move-car-to-car
		:parameters (?o1 - car ?o2 - car ?o3 - car)
		:precondition (and 
			(car-clear ?o1)
			(car-clear ?o3)
			(behind-car ?o1 ?o2)
			(at-curb ?o3) 
		)
		:effect (and 
			(not (car-clear ?o3))
			(car-clear ?o2)
			(behind-car ?o1 ?o3)
			(not (behind-car ?o1 ?o2))
		)
	)
)
