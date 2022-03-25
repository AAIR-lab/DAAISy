(define (domain termes)
(:requirements :typing :negative-preconditions)
(:types
    numb - object
    position - object
)
(:predicates
    (height ?p - position ?h - numb)
    (at ?p - position)
    (has_block)
    ;
    ; static predicates
    (SUCC ?n1 - numb ?n2 - numb)
    (NEIGHBOR ?p1 - position ?p2 - position)
    (IS_DEPOT ?p - position)
)

(:action move
    :parameters (?from - position ?to - position ?h - numb)
    :precondition
    (and
        (height ?to ?h)
			(at ?from)
			(height ?from ?h)
			(neighbor ?from ?to)
			
    )
    :effect
    (and
        (at ?to)
			(not (at ?from))
			(not (neighbor ?to ?from))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (succ ?hto ?hfrom)
			(not (is_depot ?from))
			(height ?to ?hto)
			(at ?from)
			(neighbor ?from ?to)
			
    )
    :effect
    (and
        (at ?to)
			(height ?to ?hfrom)
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (height ?from ?hfrom)
			(height ?to ?hto)
			(at ?from)
			(neighbor ?from ?to)
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (not (height ?from ?hto))
			(not (height ?from ?hfrom))
			(not (height ?to ?hfrom))
			(not (at ?from))
			(not (neighbor ?to ?from))
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(is_depot ?bpos)
			(succ ?hafter ?hbefore)
			(neighbor ?rpos ?bpos)
			(not (succ ?hbefore ?hafter))
			(is_depot ?rpos)
			(height ?rpos ?hbefore)
			(at ?rpos)
			(has_block)
			
    )
    :effect
    (and
        (height ?bpos ?hafter)
			(height ?rpos ?hafter)
			(not (has_block))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (succ ?hafter ?hbefore)
			(neighbor ?rpos ?bpos)
			(succ ?hbefore ?hafter)
			(height ?rpos ?hafter)
			(at ?rpos)
			(has_block)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(not (succ ?hafter ?hbefore))
			(height ?bpos ?hafter)
			(is_depot ?rpos)
			(has_block)
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (is_depot ?p)
			(at ?p)
			(has_block)
			
    )
    :effect
    (and
        (has_block)
			
    )
)

(:action destroy_block
    :parameters (?p - position)
    :precondition
    (and
        (at ?p)
			(has_block)
			
    )
    :effect
    (and
        (not (has_block))
			
    )
)

)

;; 
;; place_block action has changed: (height ?bpos ?hbefore), (succ ?hbefore ?hafter), (is_depot ?rpos), (height ?rpos ?hafter), 
;; remove_block action has changed: (height ?bpos ?hbefore), (succ ?hafter ?hbefore), (is_depot ?rpos), (succ ?hafter ?hbefore), 
;; move_down action has changed: (height ?from ?hto), (at ?to), (neighbor ?to ?from), (height ?to ?hfrom), (height ?from ?hfrom), 
;; move_up action has changed: (height ?to ?hfrom), (is_depot ?from), (height ?from ?hfrom), (at ?from), 
;; destroy_block action has changed: (is_depot ?p), 
;; move action has changed: (neighbor ?to ?from), 
;; Last_reduced_capability_num_dropped_pals: None
