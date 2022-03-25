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
			(not (height ?to ?h))
			(not (at ?to))
			(is_depot ?from)
			(not (height ?from ?h))
			(not (neighbor ?from ?to))
			(has_block)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(height ?to ?h)
			(at ?to)
			(not (is_depot ?from))
			(not (at ?from))
			(height ?from ?h)
			(neighbor ?from ?to)
			(not (has_block))
			(neighbor ?to ?from)
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(not (at ?to))
			(not (succ ?hto ?hfrom))
			(is_depot ?from)
			(height ?from ?hto)
			(height ?to ?hfrom)
			(neighbor ?from ?to)
			(not (has_block))
			(succ ?hfrom ?hto)
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (is_depot ?to)
			(succ ?hto ?hfrom)
			(not (is_depot ?from))
			(not (height ?from ?hto))
			(not (height ?from ?hfrom))
			(not (height ?to ?hto))
			(not (height ?to ?hfrom))
			(at ?from)
			(not (neighbor ?from ?to))
			(has_block)
			(not (succ ?hfrom ?hto))
			(not (neighbor ?to ?from))
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (at ?to))
			(succ ?hto ?hfrom)
			(not (is_depot ?from))
			(height ?from ?hto)
			(not (height ?from ?hfrom))
			(height ?to ?hfrom)
			(not (neighbor ?from ?to))
			(has_block)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(not (succ ?hto ?hfrom))
			(is_depot ?from)
			(not (height ?from ?hto))
			(not (height ?to ?hto))
			(not (height ?to ?hfrom))
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
			(not (height ?bpos ?hafter))
			(neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
			(not (is_depot ?rpos))
			(not (height ?rpos ?hbefore))
			(not (height ?rpos ?hafter))
			(not (at ?rpos))
			(not (at ?bpos))
			
    )
    :effect
    (and
        (is_depot ?bpos)
			(succ ?hafter ?hbefore)
			(not (neighbor ?rpos ?bpos))
			(is_depot ?rpos)
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(at ?rpos)
			(at ?bpos)
			(has_block)
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (is_depot ?bpos)
			(succ ?hafter ?hbefore)
			(not (height ?bpos ?hafter))
			(neighbor ?bpos ?rpos)
			(not (succ ?hbefore ?hafter))
			(not (is_depot ?rpos))
			(not (height ?rpos ?hbefore))
			(height ?rpos ?hafter)
			(at ?rpos)
			(not (has_block))
			
    )
    :effect
    (and
        (height ?bpos ?hbefore)
			(not (is_depot ?bpos))
			(not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(not (neighbor ?bpos ?rpos))
			(succ ?hbefore ?hafter)
			(is_depot ?rpos)
			(height ?rpos ?hbefore)
			(not (at ?rpos))
			(not (at ?bpos))
			
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
			(not (at ?p))
			(not (has_block))
			
    )
)

(:action destroy_block
    :parameters (?p - position)
    :precondition
    (and
        (not (is_depot ?p))
			
    )
    :effect
    (and
        (is_depot ?p)
			(at ?p)
			(has_block)
			
    )
)

)

;; 
;; move_up action has changed: (succ ?hfrom ?hto), (height ?to ?hfrom), (height ?to ?hfrom), (is_depot ?from), (height ?from ?hfrom), (height ?from ?hfrom), (height ?to ?hto), (succ ?hto ?hfrom), (neighbor ?to ?from), (has_block), (is_depot ?to), (height ?to ?hto), (height ?from ?hto), (succ ?hfrom ?hto), (at ?to), (at ?from), (neighbor ?from ?to), (has_block), (succ ?hto ?hfrom), (height ?from ?hto), (is_depot ?to), (at ?to), (is_depot ?from), (neighbor ?to ?from), (at ?from), 
;; move action has changed: (height ?to ?h), (is_depot ?from), (at ?from), (at ?to), (height ?from ?h), (neighbor ?from ?to), (neighbor ?to ?from), (has_block), (has_block), (is_depot ?from), (is_depot ?to), (neighbor ?from ?to), (neighbor ?to ?from), (height ?to ?h), (is_depot ?to), (height ?from ?h), 
;; destroy_block action has changed: (at ?p), (has_block), (has_block), (is_depot ?p), (at ?p), (is_depot ?p), 
;; remove_block action has changed: (has_block), (height ?bpos ?hafter), (succ ?hafter ?hbefore), (has_block), (succ ?hbefore ?hafter), (succ ?hbefore ?hafter), (is_depot ?rpos), (neighbor ?rpos ?bpos), (at ?bpos), (height ?bpos ?hbefore), (at ?rpos), (is_depot ?bpos), (neighbor ?bpos ?rpos), (is_depot ?bpos), (height ?rpos ?hbefore), (height ?bpos ?hafter), (neighbor ?rpos ?bpos), (height ?rpos ?hbefore), (succ ?hafter ?hbefore), (height ?bpos ?hbefore), (is_depot ?rpos), (neighbor ?bpos ?rpos), 
;; place_block action has changed: (height ?bpos ?hbefore), (is_depot ?rpos), (neighbor ?rpos ?bpos), (height ?rpos ?hbefore), (at ?bpos), (succ ?hafter ?hbefore), (is_depot ?bpos), (is_depot ?bpos), (neighbor ?bpos ?rpos), (height ?bpos ?hafter), (height ?rpos ?hafter), (succ ?hbefore ?hafter), (at ?rpos), (at ?bpos), (height ?rpos ?hbefore), (height ?rpos ?hafter), (is_depot ?rpos), (height ?bpos ?hafter), (at ?rpos), (neighbor ?rpos ?bpos), (succ ?hafter ?hbefore), (has_block), (has_block), 
;; move_down action has changed: (neighbor ?to ?from), (has_block), (height ?from ?hto), (is_depot ?from), (has_block), (neighbor ?to ?from), (height ?to ?hfrom), (height ?from ?hfrom), (at ?from), (succ ?hto ?hfrom), (at ?to), (neighbor ?from ?to), (succ ?hto ?hfrom), (is_depot ?from), (height ?to ?hfrom), (height ?to ?hto), (succ ?hfrom ?hto), (succ ?hfrom ?hto), (at ?from), (at ?to), (is_depot ?to), (height ?from ?hto), (height ?to ?hto), 
;; create_block action has changed: (at ?p), (has_block), (is_depot ?p), (at ?p), (has_block), (is_depot ?p), 
;; Last_reduced_capability_num_dropped_pals: None
