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
			(is_depot ?from)
			(not (height ?from ?h))
			(not (has_block))
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (is_depot ?to)
			(not (height ?to ?h))
			(not (is_depot ?from))
			(height ?from ?h)
			(not (neighbor ?from ?to))
			(has_block)
			(not (neighbor ?to ?from))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(not (at ?to))
			(not (succ ?hto ?hfrom))
			(not (is_depot ?from))
			(not (height ?from ?hto))
			(not (height ?to ?hfrom))
			(not (has_block))
			(succ ?hfrom ?hto)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (is_depot ?to)
			(succ ?hto ?hfrom)
			(is_depot ?from)
			(height ?from ?hto)
			(not (height ?from ?hfrom))
			(not (height ?to ?hto))
			(height ?to ?hfrom)
			(at ?from)
			(neighbor ?from ?to)
			(has_block)
			(not (succ ?hfrom ?hto))
			(neighbor ?to ?from)
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(not (at ?to))
			(not (succ ?hto ?hfrom))
			(not (is_depot ?from))
			(height ?from ?hto)
			(not (height ?to ?hto))
			(not (height ?to ?hfrom))
			(not (neighbor ?from ?to))
			(not (has_block))
			(not (succ ?hfrom ?hto))
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (is_depot ?to)
			(succ ?hto ?hfrom)
			(is_depot ?from)
			(not (height ?from ?hto))
			(height ?from ?hfrom)
			(height ?to ?hto)
			(height ?to ?hfrom)
			(at ?from)
			(neighbor ?from ?to)
			(has_block)
			(succ ?hfrom ?hto)
			(neighbor ?to ?from)
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (not (succ ?hafter ?hbefore))
			(not (height ?bpos ?hafter))
			(not (neighbor ?bpos ?rpos))
			(not (succ ?hbefore ?hafter))
			(not (is_depot ?rpos))
			(not (height ?rpos ?hbefore))
			(not (height ?rpos ?hafter))
			(not (at ?bpos))
			
    )
    :effect
    (and
        (height ?bpos ?hbefore)
			(is_depot ?bpos)
			(succ ?hafter ?hbefore)
			(neighbor ?rpos ?bpos)
			(neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
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
			(not (succ ?hafter ?hbefore))
			(not (height ?bpos ?hafter))
			(not (neighbor ?bpos ?rpos))
			(not (succ ?hbefore ?hafter))
			(is_depot ?rpos)
			(not (height ?rpos ?hbefore))
			(not (at ?rpos))
			(at ?bpos)
			(not (has_block))
			
    )
    :effect
    (and
        (height ?bpos ?hbefore)
			(not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(not (neighbor ?rpos ?bpos))
			(neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
			(not (is_depot ?rpos))
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(at ?rpos)
			(not (at ?bpos))
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (not (at ?p))
			
    )
    :effect
    (and
        (not (is_depot ?p))
			(at ?p)
			(not (has_block))
			
    )
)

(:action destroy_block
    :parameters (?p - position)
    :precondition
    (and
        (is_depot ?p)
			(not (at ?p))
			
    )
    :effect
    (and
        (not (is_depot ?p))
			(at ?p)
			
    )
)

)

;; 
;; move_down action has changed: (has_block), (at ?from), (height ?from ?hfrom), (at ?to), (succ ?hto ?hfrom), (height ?from ?hto), (succ ?hto ?hfrom), (height ?from ?hto), (height ?to ?hto), (at ?to), (neighbor ?to ?from), (succ ?hfrom ?hto), (neighbor ?from ?to), (neighbor ?to ?from), (succ ?hfrom ?hto), (is_depot ?from), (height ?to ?hfrom), (is_depot ?to), (is_depot ?to), (neighbor ?from ?to), (height ?to ?hfrom), (is_depot ?from), (has_block), (height ?from ?hfrom), (height ?to ?hto), (at ?from), 
;; create_block action has changed: (at ?p), (at ?p), (is_depot ?p), (is_depot ?p), (has_block), (has_block), 
;; destroy_block action has changed: (has_block), (is_depot ?p), (at ?p), (at ?p), (has_block), 
;; move_up action has changed: (succ ?hto ?hfrom), (height ?to ?hfrom), (neighbor ?from ?to), (succ ?hto ?hfrom), (height ?from ?hfrom), (height ?from ?hto), (at ?from), (height ?from ?hto), (neighbor ?from ?to), (at ?to), (height ?to ?hto), (succ ?hfrom ?hto), (height ?to ?hto), (at ?from), (height ?to ?hfrom), (neighbor ?to ?from), (is_depot ?from), (neighbor ?to ?from), (height ?from ?hfrom), (at ?to), (is_depot ?from), (is_depot ?to), (succ ?hfrom ?hto), (is_depot ?to), (has_block), (has_block), 
;; move action has changed: (at ?to), (at ?from), (height ?from ?h), (neighbor ?to ?from), (height ?from ?h), (neighbor ?from ?to), (is_depot ?from), (height ?to ?h), (at ?from), (height ?to ?h), (neighbor ?to ?from), (has_block), (is_depot ?from), (neighbor ?from ?to), (is_depot ?to), (at ?to), (is_depot ?to), (has_block), 
;; place_block action has changed: (is_depot ?rpos), (neighbor ?bpos ?rpos), (neighbor ?rpos ?bpos), (succ ?hafter ?hbefore), (height ?rpos ?hafter), (succ ?hbefore ?hafter), (has_block), (has_block), (height ?rpos ?hafter), (succ ?hbefore ?hafter), (at ?rpos), (is_depot ?bpos), (neighbor ?bpos ?rpos), (at ?bpos), (is_depot ?bpos), (height ?rpos ?hbefore), (at ?bpos), (neighbor ?rpos ?bpos), (height ?bpos ?hbefore), (height ?bpos ?hafter), (height ?bpos ?hafter), (is_depot ?rpos), (height ?bpos ?hbefore), (at ?rpos), (succ ?hafter ?hbefore), (height ?rpos ?hbefore), 
;; remove_block action has changed: (is_depot ?rpos), (at ?bpos), (neighbor ?rpos ?bpos), (height ?rpos ?hbefore), (height ?bpos ?hafter), (has_block), (is_depot ?bpos), (succ ?hbefore ?hafter), (is_depot ?bpos), (neighbor ?bpos ?rpos), (at ?bpos), (neighbor ?rpos ?bpos), (height ?bpos ?hbefore), (is_depot ?rpos), (height ?bpos ?hbefore), (succ ?hafter ?hbefore), (succ ?hbefore ?hafter), (height ?rpos ?hafter), (neighbor ?bpos ?rpos), (succ ?hafter ?hbefore), (at ?rpos), (height ?rpos ?hbefore), (height ?rpos ?hafter), (at ?rpos), (height ?bpos ?hafter), (has_block), 
;; Last_reduced_capability_num_dropped_pals: None
