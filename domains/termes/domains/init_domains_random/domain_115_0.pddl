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
			(is_depot ?from)
			(not (has_block))
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (is_depot ?to)
			(height ?to ?h)
			(not (is_depot ?from))
			(at ?from)
			(not (height ?from ?h))
			(neighbor ?from ?to)
			(neighbor ?to ?from)
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (is_depot ?to)
			(not (at ?to))
			(not (succ ?hto ?hfrom))
			(not (is_depot ?from))
			(not (height ?from ?hto))
			(height ?to ?hfrom)
			(has_block)
			(succ ?hfrom ?hto)
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(at ?to)
			(succ ?hto ?hfrom)
			(is_depot ?from)
			(height ?from ?hto)
			(not (height ?from ?hfrom))
			(not (height ?to ?hfrom))
			(neighbor ?from ?to)
			(not (has_block))
			(not (succ ?hfrom ?hto))
			(not (neighbor ?to ?from))
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(not (at ?to))
			(not (succ ?hto ?hfrom))
			(is_depot ?from)
			(not (height ?from ?hto))
			(not (height ?from ?hfrom))
			(height ?to ?hfrom)
			(neighbor ?from ?to)
			(not (has_block))
			(not (succ ?hfrom ?hto))
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (is_depot ?to)
			(at ?to)
			(succ ?hto ?hfrom)
			(height ?from ?hto)
			(height ?from ?hfrom)
			(not (height ?to ?hto))
			(not (height ?to ?hfrom))
			(has_block)
			(succ ?hfrom ?hto)
			(neighbor ?to ?from)
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(neighbor ?rpos ?bpos)
			(not (height ?bpos ?hafter))
			(not (neighbor ?bpos ?rpos))
			(succ ?hbefore ?hafter)
			(not (is_depot ?rpos))
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(not (at ?rpos))
			(not (at ?bpos))
			
    )
    :effect
    (and
        (is_depot ?bpos)
			(not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(neighbor ?bpos ?rpos)
			(is_depot ?rpos)
			(not (height ?rpos ?hbefore))
			(not (height ?rpos ?hafter))
			(at ?rpos)
			(not (has_block))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (is_depot ?bpos)
			(not (height ?bpos ?hafter))
			(not (succ ?hbefore ?hafter))
			(not (is_depot ?rpos))
			(at ?rpos)
			(at ?bpos)
			
    )
    :effect
    (and
        (height ?bpos ?hbefore)
			(not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(neighbor ?rpos ?bpos)
			(not (neighbor ?bpos ?rpos))
			(succ ?hbefore ?hafter)
			(is_depot ?rpos)
			(not (height ?rpos ?hbefore))
			(height ?rpos ?hafter)
			(not (at ?rpos))
			(not (at ?bpos))
			(not (has_block))
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (not (has_block))
			
    )
    :effect
    (and
        (is_depot ?p)
			(at ?p)
			
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
;; move_down action has changed: (height ?to ?hto), (has_block), (succ ?hfrom ?hto), (height ?from ?hto), (neighbor ?to ?from), (height ?from ?hfrom), (height ?from ?hto), (is_depot ?to), (height ?from ?hfrom), (height ?to ?hfrom), (succ ?hto ?hfrom), (is_depot ?to), (height ?to ?hto), (succ ?hto ?hfrom), (neighbor ?to ?from), (is_depot ?from), (has_block), (at ?from), (at ?to), (at ?from), (succ ?hfrom ?hto), (height ?to ?hfrom), 
;; move_up action has changed: (is_depot ?to), (at ?to), (height ?to ?hto), (height ?from ?hfrom), (height ?to ?hfrom), (height ?from ?hfrom), (has_block), (is_depot ?to), (succ ?hfrom ?hto), (at ?from), (height ?to ?hfrom), (neighbor ?from ?to), (neighbor ?from ?to), (height ?from ?hto), (height ?from ?hto), (at ?from), (neighbor ?to ?from), (is_depot ?from), (has_block), (succ ?hto ?hfrom), (succ ?hto ?hfrom), (succ ?hfrom ?hto), (neighbor ?to ?from), (is_depot ?from), 
;; place_block action has changed: (height ?bpos ?hafter), (height ?rpos ?hafter), (at ?rpos), (height ?bpos ?hbefore), (is_depot ?bpos), (height ?bpos ?hafter), (is_depot ?bpos), (is_depot ?rpos), (succ ?hbefore ?hafter), (neighbor ?rpos ?bpos), (has_block), (at ?rpos), (is_depot ?rpos), (succ ?hafter ?hbefore), (at ?bpos), (succ ?hafter ?hbefore), (height ?rpos ?hbefore), (neighbor ?bpos ?rpos), (neighbor ?bpos ?rpos), (height ?rpos ?hafter), 
;; move action has changed: (at ?from), (height ?to ?h), (at ?to), (neighbor ?to ?from), (at ?from), (is_depot ?to), (is_depot ?from), (has_block), (height ?from ?h), (neighbor ?from ?to), (neighbor ?to ?from), (neighbor ?from ?to), (at ?to), (height ?from ?h), (is_depot ?to), (height ?to ?h), (is_depot ?from), 
;; remove_block action has changed: (at ?rpos), (height ?bpos ?hbefore), (succ ?hbefore ?hafter), (is_depot ?rpos), (height ?rpos ?hbefore), (has_block), (neighbor ?rpos ?bpos), (is_depot ?rpos), (has_block), (height ?rpos ?hafter), (neighbor ?rpos ?bpos), (neighbor ?bpos ?rpos), (height ?bpos ?hbefore), (succ ?hbefore ?hafter), (at ?bpos), (succ ?hafter ?hbefore), (height ?bpos ?hafter), (is_depot ?bpos), (is_depot ?bpos), (at ?bpos), (height ?rpos ?hafter), (height ?bpos ?hafter), 
;; create_block action has changed: (at ?p), (has_block), (has_block), (at ?p), (is_depot ?p), (is_depot ?p), 
;; destroy_block action has changed: (has_block), (at ?p), (has_block), (is_depot ?p), 
;; Last_reduced_capability_num_dropped_pals: None
