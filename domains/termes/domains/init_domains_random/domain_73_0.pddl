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
        (not (is_depot ?to))
			(not (at ?to))
			(not (is_depot ?from))
			(not (height ?from ?h))
			
    )
    :effect
    (and
        (height ?to ?h)
			(at ?to)
			(height ?from ?h)
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (at ?to))
			(not (is_depot ?from))
			(height ?from ?hto)
			(height ?to ?hto)
			(not (neighbor ?from ?to))
			(not (succ ?hfrom ?hto))
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(height ?from ?hfrom)
			(at ?from)
			(neighbor ?from ?to)
			(neighbor ?to ?from)
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (succ ?hto ?hfrom)
			(is_depot ?from)
			(not (height ?from ?hto))
			(at ?from)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(at ?to)
			(not (is_depot ?from))
			(height ?from ?hto)
			(not (at ?from))
			(neighbor ?from ?to)
			(not (has_block))
			(neighbor ?to ?from)
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (succ ?hafter ?hbefore)
			(not (height ?bpos ?hafter))
			(not (neighbor ?bpos ?rpos))
			(not (is_depot ?rpos))
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(at ?rpos)
			
    )
    :effect
    (and
        (is_depot ?bpos)
			(neighbor ?bpos ?rpos)
			(is_depot ?rpos)
			(not (at ?rpos))
			(not (at ?bpos))
			(not (has_block))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(succ ?hafter ?hbefore)
			(neighbor ?rpos ?bpos)
			(succ ?hbefore ?hafter)
			(height ?rpos ?hafter)
			(at ?rpos)
			(not (has_block))
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(not (is_depot ?bpos))
			(not (neighbor ?bpos ?rpos))
			(not (succ ?hbefore ?hafter))
			(not (is_depot ?rpos))
			(not (height ?rpos ?hbefore))
			(not (at ?rpos))
			(at ?bpos)
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (not (is_depot ?p))
			
    )
    :effect
    (and
        (is_depot ?p)
			
    )
)

(:action destroy_block
    :parameters (?p - position)
    :precondition
    (and
        (not (is_depot ?p))
			(at ?p)
			
    )
    :effect
    (and
        (not (at ?p))
			(has_block)
			
    )
)

)

;; 
;; move_down action has changed: (height ?to ?hto), (neighbor ?to ?from), (succ ?hto ?hfrom), (is_depot ?from), (is_depot ?to), (is_depot ?from), (neighbor ?to ?from), (succ ?hfrom ?hto), (height ?from ?hfrom), (height ?from ?hto), (neighbor ?from ?to), (neighbor ?from ?to), (height ?from ?hto), (has_block), 
;; move_up action has changed: (at ?to), (neighbor ?from ?to), (succ ?hfrom ?hto), (at ?from), (neighbor ?to ?from), (is_depot ?from), (is_depot ?to), (at ?from), (neighbor ?from ?to), (at ?to), (succ ?hto ?hfrom), (height ?from ?hfrom), (height ?from ?hto), (height ?from ?hfrom), 
;; destroy_block action has changed: (at ?p), (has_block), (has_block), (is_depot ?p), 
;; create_block action has changed: (has_block), (has_block), (is_depot ?p), (at ?p), (is_depot ?p), 
;; place_block action has changed: (at ?rpos), (is_depot ?rpos), (neighbor ?bpos ?rpos), (is_depot ?rpos), (neighbor ?bpos ?rpos), (height ?bpos ?hbefore), (is_depot ?bpos), (has_block), (neighbor ?rpos ?bpos), (height ?bpos ?hbefore), (height ?bpos ?hafter), (at ?bpos), (is_depot ?bpos), (height ?bpos ?hafter), (height ?rpos ?hafter), 
;; remove_block action has changed: (height ?bpos ?hafter), (has_block), (at ?rpos), (has_block), (succ ?hafter ?hbefore), (is_depot ?rpos), (is_depot ?bpos), (succ ?hbefore ?hafter), (neighbor ?bpos ?rpos), (height ?rpos ?hbefore), (at ?bpos), 
;; move action has changed: (is_depot ?to), (neighbor ?from ?to), (height ?from ?h), (height ?to ?h), (at ?from), (height ?from ?h), (is_depot ?from), (at ?from), (at ?to), (height ?to ?h), 
;; Last_reduced_capability_num_dropped_pals: None
