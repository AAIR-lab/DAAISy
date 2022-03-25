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
			(not (is_depot ?from))
			(not (neighbor ?from ?to))
			(not (has_block))
			
    )
    :effect
    (and
        (not (height ?to ?h))
			(at ?to)
			(is_depot ?from)
			(at ?from)
			(not (neighbor ?to ?from))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (succ ?hto ?hfrom)
			(height ?from ?hto)
			(height ?from ?hfrom)
			(height ?to ?hto)
			(at ?from)
			(neighbor ?from ?to)
			
    )
    :effect
    (and
        (at ?to)
			(not (height ?from ?hto))
			(not (at ?from))
			(not (neighbor ?from ?to))
			(has_block)
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (height ?from ?hto))
			(height ?from ?hfrom)
			(height ?to ?hto)
			(at ?from)
			(neighbor ?from ?to)
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (at ?to)
			(not (has_block))
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(not (height ?bpos ?hafter))
			(neighbor ?bpos ?rpos)
			(at ?rpos)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(not (succ ?hbefore ?hafter))
			(is_depot ?rpos)
			(height ?rpos ?hafter)
			(not (has_block))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(neighbor ?rpos ?bpos)
			(not (neighbor ?bpos ?rpos))
			(succ ?hbefore ?hafter)
			(is_depot ?rpos)
			(height ?rpos ?hafter)
			(at ?rpos)
			(has_block)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(height ?bpos ?hafter)
			(has_block)
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (at ?p)
			
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
        (is_depot ?p)
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
;; create_block action has changed: (is_depot ?p), (has_block), 
;; place_block action has changed: (height ?bpos ?hafter), (height ?rpos ?hafter), (neighbor ?rpos ?bpos), (is_depot ?rpos), (succ ?hbefore ?hafter), (neighbor ?bpos ?rpos), (height ?bpos ?hafter), (height ?rpos ?hbefore), (has_block), (is_depot ?bpos), 
;; remove_block action has changed: (neighbor ?bpos ?rpos), (neighbor ?rpos ?bpos), (is_depot ?rpos), 
;; move action has changed: (is_depot ?from), (at ?from), (has_block), (neighbor ?to ?from), (height ?to ?h), (height ?from ?h), (is_depot ?from), (neighbor ?from ?to), (at ?from), 
;; move_up action has changed: (neighbor ?from ?to), (has_block), (height ?from ?hto), (height ?from ?hto), 
;; move_down action has changed: (has_block), (height ?from ?hto), (at ?from), 
;; Last_reduced_capability_num_dropped_pals: None
