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
        (is_depot ?to)
			(height ?to ?h)
			(at ?from)
			(height ?from ?h)
			(neighbor ?from ?to)
			(has_block)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(not (height ?to ?h))
			(not (at ?from))
			(not (neighbor ?from ?to))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (is_depot ?to)
			(succ ?hto ?hfrom)
			(not (height ?from ?hfrom))
			(not (height ?to ?hto))
			(height ?to ?hfrom)
			(not (neighbor ?from ?to))
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(not (at ?to))
			(is_depot ?from)
			(not (height ?from ?hto))
			(height ?from ?hfrom)
			(height ?to ?hto)
			(not (height ?to ?hfrom))
			(at ?from)
			(neighbor ?from ?to)
			(has_block)
			(not (succ ?hfrom ?hto))
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(not (at ?to))
			(not (is_depot ?from))
			(height ?from ?hto)
			(height ?from ?hfrom)
			(height ?to ?hto)
			(not (height ?to ?hfrom))
			(not (succ ?hfrom ?hto))
			
    )
    :effect
    (and
        (is_depot ?to)
			(at ?to)
			(is_depot ?from)
			(not (height ?from ?hfrom))
			(not (height ?to ?hto))
			(height ?to ?hfrom)
			(not (neighbor ?from ?to))
			(not (has_block))
			(succ ?hfrom ?hto)
			(neighbor ?to ?from)
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(not (is_depot ?bpos))
			(not (succ ?hafter ?hbefore))
			(not (neighbor ?bpos ?rpos))
			(not (succ ?hbefore ?hafter))
			(not (is_depot ?rpos))
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(not (at ?rpos))
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(is_depot ?bpos)
			(succ ?hafter ?hbefore)
			(not (height ?bpos ?hafter))
			(neighbor ?bpos ?rpos)
			(is_depot ?rpos)
			(not (height ?rpos ?hbefore))
			(not (height ?rpos ?hafter))
			(at ?bpos)
			(has_block)
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (is_depot ?bpos)
			(not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(not (height ?bpos ?hafter))
			(not (neighbor ?bpos ?rpos))
			(succ ?hbefore ?hafter)
			(not (is_depot ?rpos))
			(height ?rpos ?hafter)
			(not (at ?rpos))
			(not (at ?bpos))
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(neighbor ?rpos ?bpos)
			(neighbor ?bpos ?rpos)
			(not (height ?rpos ?hafter))
			(at ?rpos)
			(not (has_block))
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (is_depot ?p)
			(has_block)
			
    )
    :effect
    (and
        (at ?p)
			(not (has_block))
			
    )
)

(:action destroy_block
    :parameters (?p - position)
    :precondition
    (and
        (not (is_depot ?p))
			(not (at ?p))
			(has_block)
			
    )
    :effect
    (and
        (is_depot ?p)
			(at ?p)
			
    )
)

)

;; 
;; move action has changed: (neighbor ?to ?from), (has_block), (is_depot ?to), (at ?to), (height ?to ?h), (neighbor ?from ?to), (is_depot ?to), 
;; move_up action has changed: (succ ?hfrom ?hto), (height ?from ?hfrom), (is_depot ?from), (neighbor ?from ?to), (at ?from), (succ ?hfrom ?hto), (neighbor ?from ?to), (is_depot ?to), (height ?to ?hfrom), (at ?to), (height ?from ?hfrom), (height ?to ?hto), (has_block), (at ?from), (height ?from ?hto), (height ?to ?hfrom), (is_depot ?to), (height ?to ?hto), 
;; remove_block action has changed: (has_block), (succ ?hafter ?hbefore), (at ?rpos), (height ?bpos ?hafter), (neighbor ?bpos ?rpos), (height ?rpos ?hafter), (is_depot ?bpos), (neighbor ?rpos ?bpos), (at ?rpos), (at ?bpos), (height ?bpos ?hbefore), (height ?bpos ?hafter), (neighbor ?rpos ?bpos), (has_block), (neighbor ?bpos ?rpos), (is_depot ?rpos), 
;; move_down action has changed: (is_depot ?to), (at ?from), (succ ?hfrom ?hto), (has_block), (succ ?hfrom ?hto), (is_depot ?to), (at ?to), (height ?to ?hfrom), (height ?from ?hfrom), (neighbor ?from ?to), (height ?from ?hto), (neighbor ?from ?to), (is_depot ?from), (is_depot ?from), (height ?to ?hfrom), (height ?to ?hto), (at ?from), (neighbor ?to ?from), 
;; place_block action has changed: (is_depot ?rpos), (has_block), (is_depot ?bpos), (at ?bpos), (neighbor ?bpos ?rpos), (succ ?hafter ?hbefore), (at ?rpos), (has_block), (height ?bpos ?hafter), (height ?rpos ?hafter), (height ?rpos ?hbefore), (neighbor ?rpos ?bpos), (height ?rpos ?hafter), (is_depot ?rpos), (succ ?hbefore ?hafter), (is_depot ?bpos), (succ ?hafter ?hbefore), (neighbor ?bpos ?rpos), 
;; create_block action has changed: (at ?p), (has_block), (at ?p), 
;; destroy_block action has changed: (is_depot ?p), (at ?p), (at ?p), (is_depot ?p), (has_block), 
;; Last_reduced_capability_num_dropped_pals: None
