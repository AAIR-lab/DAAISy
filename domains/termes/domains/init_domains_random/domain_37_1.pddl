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
			(is_depot ?from)
			(at ?from)
			(height ?from ?h)
			(neighbor ?from ?to)
			
    )
    :effect
    (and
        (at ?to)
			(not (at ?from))
			(not (height ?from ?h))
			(not (neighbor ?from ?to))
			
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
        (not (at ?to))
			(not (neighbor ?from ?to))
			(not (neighbor ?to ?from))
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?from))
			(height ?from ?hto)
			(height ?to ?hto)
			(at ?from)
			(neighbor ?from ?to)
			
    )
    :effect
    (and
        (at ?to)
			(succ ?hto ?hfrom)
			(is_depot ?from)
			(not (height ?from ?hto))
			(not (at ?from))
			(not (neighbor ?from ?to))
			(not (has_block))
			
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
			(not (height ?bpos ?hafter))
			(is_depot ?rpos)
			(height ?rpos ?hbefore)
			(has_block)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(height ?bpos ?hafter)
			(not (succ ?hbefore ?hafter))
			(not (at ?rpos))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (neighbor ?rpos ?bpos)
			(not (height ?bpos ?hafter))
			(succ ?hbefore ?hafter)
			(not (is_depot ?rpos))
			(height ?rpos ?hafter)
			(not (at ?rpos))
			(not (at ?bpos))
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(height ?bpos ?hafter)
			(not (succ ?hbefore ?hafter))
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
        (not (is_depot ?p))
			(not (at ?p))
			(not (has_block))
			
    )
)

(:action destroy_block
    :parameters (?p - position)
    :precondition
    (and
        (is_depot ?p)
			(not (at ?p))
			(has_block)
			
    )
    :effect
    (and
        (at ?p)
			(not (has_block))
			
    )
)

)

;; 
;; place_block action has changed: (has_block), (succ ?hafter ?hbefore), (neighbor ?rpos ?bpos), (at ?rpos), (at ?rpos), (is_depot ?rpos), (succ ?hbefore ?hafter), (height ?bpos ?hafter), 
;; move_down action has changed: (height ?from ?hto), (is_depot ?from), (succ ?hfrom ?hto), (height ?from ?hfrom), (succ ?hto ?hfrom), (neighbor ?from ?to), (height ?from ?hto), (is_depot ?from), (has_block), 
;; create_block action has changed: (at ?p), (is_depot ?p), (has_block), 
;; move action has changed: (is_depot ?from), (neighbor ?from ?to), (height ?from ?h), 
;; remove_block action has changed: (is_depot ?rpos), (at ?rpos), (succ ?hbefore ?hafter), (height ?bpos ?hafter), (has_block), (height ?bpos ?hbefore), (at ?bpos), 
;; destroy_block action has changed: (at ?p), (at ?p), 
;; move_up action has changed: (neighbor ?from ?to), (at ?to), (height ?from ?hto), (at ?from), (neighbor ?to ?from), 
;; Last_reduced_capability_num_dropped_pals: None
