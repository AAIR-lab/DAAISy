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
			(not (height ?to ?h))
			(not (is_depot ?from))
			
    )
    :effect
    (and
        (height ?to ?h)
			(not (at ?to))
			(is_depot ?from)
			(at ?from)
			(not (height ?from ?h))
			(neighbor ?from ?to)
			(not (has_block))
			(not (neighbor ?to ?from))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(not (at ?to))
			(succ ?hto ?hfrom)
			(is_depot ?from)
			(not (height ?from ?hto))
			(height ?from ?hfrom)
			(not (height ?to ?hfrom))
			(not (neighbor ?from ?to))
			(has_block)
			(succ ?hfrom ?hto)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (is_depot ?to)
			(not (succ ?hto ?hfrom))
			(not (is_depot ?from))
			(height ?from ?hto)
			(not (height ?to ?hto))
			(height ?to ?hfrom)
			(not (succ ?hfrom ?hto))
			(neighbor ?to ?from)
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (is_depot ?to)
			(not (at ?to))
			(is_depot ?from)
			(not (height ?from ?hto))
			(height ?from ?hfrom)
			(not (height ?to ?hfrom))
			(neighbor ?from ?to)
			(has_block)
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(succ ?hto ?hfrom)
			(height ?from ?hto)
			(not (height ?from ?hfrom))
			(at ?from)
			(not (neighbor ?from ?to))
			(not (has_block))
			(not (succ ?hfrom ?hto))
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (not (height ?bpos ?hafter))
			(neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
			(is_depot ?rpos)
			(not (height ?rpos ?hafter))
			(not (at ?rpos))
			(has_block)
			
    )
    :effect
    (and
        (is_depot ?bpos)
			(not (neighbor ?rpos ?bpos))
			(not (neighbor ?bpos ?rpos))
			(not (is_depot ?rpos))
			(not (height ?rpos ?hbefore))
			(height ?rpos ?hafter)
			(at ?rpos)
			(not (at ?bpos))
			(not (has_block))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (not (is_depot ?bpos))
			(neighbor ?rpos ?bpos)
			(neighbor ?bpos ?rpos)
			(not (is_depot ?rpos))
			(height ?rpos ?hafter)
			(not (at ?rpos))
			(at ?bpos)
			(has_block)
			
    )
    :effect
    (and
        (height ?bpos ?hbefore)
			(is_depot ?bpos)
			(succ ?hafter ?hbefore)
			(not (height ?bpos ?hafter))
			(not (neighbor ?bpos ?rpos))
			(not (succ ?hbefore ?hafter))
			(is_depot ?rpos)
			(height ?rpos ?hbefore)
			(not (height ?rpos ?hafter))
			(at ?rpos)
			(not (at ?bpos))
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (not (is_depot ?p))
			(at ?p)
			(has_block)
			
    )
    :effect
    (and
        (is_depot ?p)
			(not (at ?p))
			
    )
)

(:action destroy_block
    :parameters (?p - position)
    :precondition
    (and
        (at ?p)
			
    )
    :effect
    (and
        (not (is_depot ?p))
			(not (at ?p))
			(has_block)
			
    )
)

)

;; 
;; move_down action has changed: (height ?to ?hfrom), (height ?from ?hfrom), (height ?from ?hto), (at ?to), (succ ?hto ?hfrom), (neighbor ?to ?from), (has_block), (has_block), (succ ?hfrom ?hto), (neighbor ?from ?to), (is_depot ?to), (is_depot ?from), (is_depot ?to), (succ ?hfrom ?hto), (height ?to ?hto), (at ?to), (at ?from), (height ?from ?hto), (at ?from), 
;; place_block action has changed: (height ?rpos ?hbefore), (height ?bpos ?hbefore), (is_depot ?bpos), (neighbor ?rpos ?bpos), (neighbor ?bpos ?rpos), (succ ?hbefore ?hafter), (at ?bpos), (neighbor ?bpos ?rpos), (neighbor ?rpos ?bpos), (height ?bpos ?hafter), (is_depot ?rpos), (at ?rpos), (height ?rpos ?hbefore), (height ?bpos ?hafter), (at ?rpos), (height ?rpos ?hafter), (height ?bpos ?hbefore), (succ ?hafter ?hbefore), (height ?rpos ?hafter), (is_depot ?rpos), (is_depot ?bpos), 
;; move action has changed: (height ?from ?h), (is_depot ?from), (neighbor ?from ?to), (neighbor ?to ?from), (at ?to), (neighbor ?from ?to), (height ?to ?h), (has_block), (at ?from), (is_depot ?from), (at ?from), (is_depot ?to), (height ?from ?h), (height ?to ?h), 
;; remove_block action has changed: (is_depot ?rpos), (at ?bpos), (height ?rpos ?hafter), (height ?rpos ?hbefore), (is_depot ?bpos), (neighbor ?bpos ?rpos), (succ ?hbefore ?hafter), (at ?rpos), (succ ?hafter ?hbefore), (is_depot ?bpos), (at ?bpos), (neighbor ?bpos ?rpos), (height ?bpos ?hbefore), (height ?bpos ?hbefore), (is_depot ?rpos), (at ?rpos), (succ ?hbefore ?hafter), (height ?bpos ?hafter), (has_block), 
;; move_up action has changed: (is_depot ?to), (neighbor ?from ?to), (at ?to), (height ?to ?hto), (succ ?hfrom ?hto), (height ?from ?hto), (height ?to ?hfrom), (height ?to ?hfrom), (is_depot ?from), (has_block), (at ?to), (succ ?hfrom ?hto), (succ ?hto ?hfrom), (height ?from ?hto), (is_depot ?to), (neighbor ?to ?from), (is_depot ?from), (height ?to ?hto), (at ?from), (at ?from), (neighbor ?to ?from), 
;; create_block action has changed: (is_depot ?p), (is_depot ?p), (has_block), (at ?p), 
;; destroy_block action has changed: (has_block), (at ?p), (is_depot ?p), (is_depot ?p), (has_block), 
;; Last_reduced_capability_num_dropped_pals: None
