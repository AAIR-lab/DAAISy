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
			(not (at ?to))
			(not (is_depot ?from))
			(not (neighbor ?from ?to))
			(not (has_block))
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (is_depot ?to)
			(height ?to ?h)
			(is_depot ?from)
			(at ?from)
			(height ?from ?h)
			(has_block)
			
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
			(not (height ?from ?hto))
			(not (height ?from ?hfrom))
			(not (height ?to ?hto))
			(height ?to ?hfrom)
			(not (neighbor ?from ?to))
			(not (has_block))
			(succ ?hfrom ?hto)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (is_depot ?to)
			(succ ?hto ?hfrom)
			(not (is_depot ?from))
			(height ?from ?hto)
			(height ?from ?hfrom)
			(height ?to ?hto)
			(not (height ?to ?hfrom))
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
        (is_depot ?to)
			(not (at ?to))
			(is_depot ?from)
			(height ?from ?hto)
			(not (height ?from ?hfrom))
			(not (height ?to ?hto))
			(height ?to ?hfrom)
			(has_block)
			(not (succ ?hfrom ?hto))
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(succ ?hto ?hfrom)
			(not (is_depot ?from))
			(not (height ?from ?hto))
			(height ?from ?hfrom)
			(height ?to ?hto)
			(neighbor ?from ?to)
			(not (has_block))
			(succ ?hfrom ?hto)
			(neighbor ?to ?from)
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (not (neighbor ?rpos ?bpos))
			(not (height ?bpos ?hafter))
			(not (neighbor ?bpos ?rpos))
			(not (succ ?hbefore ?hafter))
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
			(neighbor ?rpos ?bpos)
			(neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
			(is_depot ?rpos)
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(at ?rpos)
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(not (height ?bpos ?hafter))
			(not (neighbor ?bpos ?rpos))
			(not (succ ?hbefore ?hafter))
			(is_depot ?rpos)
			(height ?rpos ?hbefore)
			(not (at ?bpos))
			(not (has_block))
			
    )
    :effect
    (and
        (height ?bpos ?hbefore)
			(not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(neighbor ?rpos ?bpos)
			(neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
			(not (is_depot ?rpos))
			(not (height ?rpos ?hbefore))
			(not (height ?rpos ?hafter))
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
			(at ?p)
			(not (has_block))
			
    )
)

(:action destroy_block
    :parameters (?p - position)
    :precondition
    (and
        (not (at ?p))
			
    )
    :effect
    (and
        (at ?p)
			(has_block)
			
    )
)

)

;; 
;; move_up action has changed: (neighbor ?from ?to), (at ?from), (is_depot ?to), (is_depot ?from), (at ?to), (is_depot ?to), (is_depot ?from), (height ?from ?hto), (height ?to ?hto), (succ ?hto ?hfrom), (has_block), (neighbor ?from ?to), (succ ?hto ?hfrom), (height ?to ?hto), (at ?from), (succ ?hfrom ?hto), (at ?to), (neighbor ?to ?from), (height ?to ?hfrom), (succ ?hfrom ?hto), (has_block), (height ?from ?hto), (height ?from ?hfrom), (height ?to ?hfrom), (neighbor ?to ?from), (height ?from ?hfrom), 
;; remove_block action has changed: (height ?bpos ?hafter), (has_block), (has_block), (neighbor ?bpos ?rpos), (height ?rpos ?hafter), (height ?bpos ?hafter), (at ?bpos), (neighbor ?rpos ?bpos), (height ?bpos ?hbefore), (succ ?hbefore ?hafter), (at ?bpos), (height ?bpos ?hbefore), (height ?rpos ?hbefore), (is_depot ?rpos), (at ?rpos), (height ?rpos ?hbefore), (height ?rpos ?hafter), (neighbor ?bpos ?rpos), (is_depot ?rpos), (succ ?hafter ?hbefore), (is_depot ?bpos), (at ?rpos), (succ ?hbefore ?hafter), (succ ?hafter ?hbefore), (neighbor ?rpos ?bpos), 
;; move_down action has changed: (height ?to ?hto), (at ?from), (height ?from ?hfrom), (is_depot ?to), (at ?from), (height ?from ?hfrom), (height ?from ?hto), (succ ?hfrom ?hto), (at ?to), (neighbor ?from ?to), (height ?from ?hto), (height ?to ?hto), (is_depot ?from), (has_block), (succ ?hfrom ?hto), (at ?to), (is_depot ?from), (succ ?hto ?hfrom), (neighbor ?to ?from), (has_block), (is_depot ?to), (height ?to ?hfrom), (neighbor ?to ?from), (neighbor ?from ?to), 
;; place_block action has changed: (has_block), (height ?bpos ?hbefore), (neighbor ?bpos ?rpos), (neighbor ?rpos ?bpos), (succ ?hafter ?hbefore), (height ?rpos ?hafter), (height ?bpos ?hafter), (height ?rpos ?hbefore), (is_depot ?bpos), (neighbor ?bpos ?rpos), (has_block), (succ ?hbefore ?hafter), (neighbor ?rpos ?bpos), (is_depot ?bpos), (at ?bpos), (height ?bpos ?hbefore), (succ ?hafter ?hbefore), (height ?rpos ?hbefore), (height ?bpos ?hafter), (at ?rpos), (at ?rpos), (is_depot ?rpos), (is_depot ?rpos), (succ ?hbefore ?hafter), (height ?rpos ?hafter), 
;; move action has changed: (is_depot ?to), (at ?from), (at ?from), (height ?from ?h), (at ?to), (is_depot ?from), (height ?from ?h), (is_depot ?to), (at ?to), (is_depot ?from), (has_block), (height ?to ?h), (neighbor ?to ?from), (neighbor ?from ?to), (has_block), (height ?to ?h), 
;; create_block action has changed: (at ?p), (has_block), (is_depot ?p), (at ?p), (has_block), (is_depot ?p), 
;; destroy_block action has changed: (has_block), (at ?p), (has_block), (at ?p), (is_depot ?p), 
;; Last_reduced_capability_num_dropped_pals: None
