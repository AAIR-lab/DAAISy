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
			(not (at ?to))
			(is_depot ?from)
			(not (has_block))
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (not (height ?to ?h))
			(not (is_depot ?from))
			(height ?from ?h)
			(neighbor ?from ?to)
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
			(is_depot ?from)
			(not (height ?from ?hto))
			(not (height ?to ?hto))
			(not (height ?to ?hfrom))
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
			(height ?from ?hfrom)
			(height ?to ?hto)
			(height ?to ?hfrom)
			(not (neighbor ?from ?to))
			(not (has_block))
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
			(succ ?hto ?hfrom)
			(not (is_depot ?from))
			(not (height ?from ?hto))
			(not (height ?from ?hfrom))
			(height ?to ?hfrom)
			(at ?from)
			(has_block)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (is_depot ?to)
			(not (succ ?hto ?hfrom))
			(is_depot ?from)
			(height ?from ?hto)
			(height ?from ?hfrom)
			(not (height ?to ?hto))
			(not (height ?to ?hfrom))
			(not (neighbor ?from ?to))
			(not (has_block))
			(not (succ ?hfrom ?hto))
			(neighbor ?to ?from)
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (not (succ ?hafter ?hbefore))
			(not (height ?bpos ?hafter))
			(neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
			(is_depot ?rpos)
			(not (height ?rpos ?hbefore))
			(height ?rpos ?hafter)
			(not (at ?bpos))
			(has_block)
			
    )
    :effect
    (and
        (height ?bpos ?hbefore)
			(not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(neighbor ?rpos ?bpos)
			(not (neighbor ?bpos ?rpos))
			(not (succ ?hbefore ?hafter))
			(not (is_depot ?rpos))
			(height ?rpos ?hbefore)
			(not (height ?rpos ?hafter))
			(not (at ?rpos))
			(at ?bpos)
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(is_depot ?bpos)
			(not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(not (height ?bpos ?hafter))
			(neighbor ?bpos ?rpos)
			(not (succ ?hbefore ?hafter))
			(not (is_depot ?rpos))
			(not (height ?rpos ?hbefore))
			(not (height ?rpos ?hafter))
			(at ?bpos)
			
    )
    :effect
    (and
        (not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(neighbor ?rpos ?bpos)
			(not (neighbor ?bpos ?rpos))
			(succ ?hbefore ?hafter)
			(is_depot ?rpos)
			(height ?rpos ?hbefore)
			(not (at ?rpos))
			(not (at ?bpos))
			(not (has_block))
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (not (is_depot ?p))
			(not (at ?p))
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
        (not (at ?p))
			
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
;; remove_block action has changed: (succ ?hafter ?hbefore), (is_depot ?rpos), (neighbor ?bpos ?rpos), (at ?bpos), (height ?bpos ?hbefore), (at ?rpos), (succ ?hbefore ?hafter), (height ?bpos ?hafter), (height ?rpos ?hafter), (succ ?hbefore ?hafter), (height ?rpos ?hbefore), (at ?bpos), (succ ?hafter ?hbefore), (neighbor ?rpos ?bpos), (is_depot ?bpos), (neighbor ?rpos ?bpos), (is_depot ?rpos), (height ?bpos ?hafter), (height ?rpos ?hbefore), (has_block), (neighbor ?bpos ?rpos), (at ?rpos), (is_depot ?bpos), (has_block), 
;; place_block action has changed: (neighbor ?rpos ?bpos), (succ ?hbefore ?hafter), (neighbor ?rpos ?bpos), (succ ?hafter ?hbefore), (is_depot ?rpos), (height ?bpos ?hafter), (at ?rpos), (height ?bpos ?hbefore), (height ?rpos ?hafter), (at ?bpos), (has_block), (height ?rpos ?hbefore), (neighbor ?bpos ?rpos), (at ?bpos), (is_depot ?bpos), (at ?rpos), (height ?rpos ?hbefore), (is_depot ?rpos), (succ ?hbefore ?hafter), (height ?rpos ?hafter), (height ?bpos ?hafter), (is_depot ?bpos), (height ?bpos ?hbefore), (neighbor ?bpos ?rpos), (succ ?hafter ?hbefore), 
;; move_up action has changed: (is_depot ?from), (height ?to ?hto), (height ?to ?hfrom), (at ?from), (succ ?hfrom ?hto), (height ?from ?hfrom), (height ?from ?hto), (height ?from ?hto), (neighbor ?from ?to), (at ?to), (succ ?hfrom ?hto), (is_depot ?to), (is_depot ?to), (succ ?hto ?hfrom), (height ?to ?hto), (neighbor ?to ?from), (neighbor ?from ?to), (height ?to ?hfrom), (neighbor ?to ?from), (has_block), (has_block), (height ?from ?hfrom), (at ?to), (is_depot ?from), (at ?from), (succ ?hto ?hfrom), 
;; move_down action has changed: (at ?to), (height ?from ?hto), (height ?to ?hto), (is_depot ?from), (height ?from ?hfrom), (height ?to ?hfrom), (height ?to ?hfrom), (succ ?hfrom ?hto), (height ?from ?hto), (has_block), (has_block), (neighbor ?to ?from), (succ ?hto ?hfrom), (neighbor ?from ?to), (height ?from ?hfrom), (height ?to ?hto), (neighbor ?from ?to), (at ?to), (is_depot ?from), (is_depot ?to), (is_depot ?to), (neighbor ?to ?from), (at ?from), (succ ?hfrom ?hto), (succ ?hto ?hfrom), 
;; move action has changed: (is_depot ?from), (neighbor ?to ?from), (neighbor ?to ?from), (at ?from), (has_block), (height ?to ?h), (is_depot ?from), (has_block), (at ?to), (neighbor ?from ?to), (at ?to), (at ?from), (height ?from ?h), (height ?from ?h), (neighbor ?from ?to), 
;; create_block action has changed: (at ?p), (is_depot ?p), (is_depot ?p), (has_block), (at ?p), (has_block), 
;; destroy_block action has changed: (at ?p), (at ?p), (is_depot ?p), (has_block), (has_block), (is_depot ?p), 
;; Last_reduced_capability_num_dropped_pals: None
