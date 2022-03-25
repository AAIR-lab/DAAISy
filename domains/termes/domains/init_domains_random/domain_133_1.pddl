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
			(not (at ?to))
			(not (is_depot ?from))
			(not (neighbor ?from ?to))
			(not (has_block))
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(height ?to ?h)
			(is_depot ?from)
			(at ?from)
			(height ?from ?h)
			(neighbor ?from ?to)
			(has_block)
			(neighbor ?to ?from)
			
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
			(not (height ?from ?hfrom))
			(not (height ?to ?hto))
			(height ?to ?hfrom)
			(not (neighbor ?from ?to))
			(not (has_block))
			(succ ?hfrom ?hto)
			(neighbor ?to ?from)
			
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
			(neighbor ?from ?to)
			(has_block)
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
			(succ ?hto ?hfrom)
			(is_depot ?from)
			(height ?from ?hto)
			(not (height ?to ?hto))
			(not (height ?to ?hfrom))
			(has_block)
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (is_depot ?to)
			(not (succ ?hto ?hfrom))
			(not (is_depot ?from))
			(not (height ?from ?hto))
			(not (height ?from ?hfrom))
			(height ?to ?hto)
			(height ?to ?hfrom)
			(not (neighbor ?from ?to))
			(not (has_block))
			(not (succ ?hfrom ?hto))
			(not (neighbor ?to ?from))
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (not (is_depot ?bpos))
			(not (height ?bpos ?hafter))
			(neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
			(not (is_depot ?rpos))
			(height ?rpos ?hafter)
			(not (at ?bpos))
			
    )
    :effect
    (and
        (is_depot ?bpos)
			(succ ?hafter ?hbefore)
			(not (neighbor ?rpos ?bpos))
			(not (neighbor ?bpos ?rpos))
			(not (succ ?hbefore ?hafter))
			(is_depot ?rpos)
			(height ?rpos ?hbefore)
			(not (height ?rpos ?hafter))
			(not (at ?rpos))
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
			(not (is_depot ?rpos))
			(height ?rpos ?hbefore)
			(not (height ?rpos ?hafter))
			(at ?bpos)
			(not (has_block))
			
    )
    :effect
    (and
        (height ?bpos ?hbefore)
			(not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(neighbor ?rpos ?bpos)
			(neighbor ?bpos ?rpos)
			(not (succ ?hbefore ?hafter))
			(is_depot ?rpos)
			(not (height ?rpos ?hbefore))
			(height ?rpos ?hafter)
			(not (at ?rpos))
			(not (at ?bpos))
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (not (is_depot ?p))
			(not (at ?p))
			
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
        (has_block)
			
    )
    :effect
    (and
        (is_depot ?p)
			(not (at ?p))
			
    )
)

)

;; 
;; move_up action has changed: (height ?to ?hfrom), (at ?from), (height ?from ?hto), (is_depot ?from), (at ?to), (neighbor ?from ?to), (height ?from ?hto), (has_block), (succ ?hfrom ?hto), (succ ?hto ?hfrom), (height ?to ?hto), (height ?to ?hfrom), (has_block), (neighbor ?to ?from), (is_depot ?from), (is_depot ?to), (height ?from ?hfrom), (height ?from ?hfrom), (neighbor ?from ?to), (succ ?hto ?hfrom), (at ?to), (neighbor ?to ?from), (at ?from), (is_depot ?to), (height ?to ?hto), (succ ?hfrom ?hto), 
;; move action has changed: (neighbor ?from ?to), (height ?from ?h), (has_block), (is_depot ?from), (is_depot ?from), (neighbor ?from ?to), (at ?from), (is_depot ?to), (neighbor ?to ?from), (height ?from ?h), (has_block), (at ?to), (height ?to ?h), (height ?to ?h), (neighbor ?to ?from), (is_depot ?to), (at ?to), (at ?from), 
;; remove_block action has changed: (at ?rpos), (height ?rpos ?hbefore), (height ?bpos ?hafter), (neighbor ?rpos ?bpos), (succ ?hafter ?hbefore), (height ?rpos ?hafter), (height ?bpos ?hbefore), (has_block), (is_depot ?bpos), (succ ?hbefore ?hafter), (is_depot ?rpos), (is_depot ?bpos), (height ?bpos ?hbefore), (at ?rpos), (height ?rpos ?hafter), (neighbor ?rpos ?bpos), (succ ?hafter ?hbefore), (at ?bpos), (at ?bpos), (neighbor ?bpos ?rpos), (has_block), (succ ?hbefore ?hafter), (height ?rpos ?hbefore), (neighbor ?bpos ?rpos), (is_depot ?rpos), (height ?bpos ?hafter), 
;; move_down action has changed: (succ ?hto ?hfrom), (succ ?hfrom ?hto), (height ?from ?hto), (is_depot ?to), (at ?from), (height ?to ?hto), (is_depot ?to), (height ?from ?hfrom), (neighbor ?to ?from), (height ?from ?hfrom), (height ?from ?hto), (has_block), (height ?to ?hfrom), (succ ?hfrom ?hto), (height ?to ?hto), (neighbor ?to ?from), (at ?to), (height ?to ?hfrom), (is_depot ?from), (has_block), (neighbor ?from ?to), (succ ?hto ?hfrom), (at ?to), (at ?from), (is_depot ?from), (neighbor ?from ?to), 
;; place_block action has changed: (is_depot ?bpos), (neighbor ?rpos ?bpos), (is_depot ?rpos), (succ ?hafter ?hbefore), (at ?rpos), (height ?bpos ?hbefore), (is_depot ?bpos), (neighbor ?bpos ?rpos), (height ?bpos ?hafter), (height ?rpos ?hafter), (succ ?hbefore ?hafter), (height ?rpos ?hbefore), (height ?rpos ?hafter), (height ?bpos ?hafter), (at ?rpos), (at ?bpos), (neighbor ?rpos ?bpos), (neighbor ?bpos ?rpos), (height ?bpos ?hbefore), (succ ?hafter ?hbefore), (has_block), (succ ?hbefore ?hafter), (at ?bpos), (height ?rpos ?hbefore), (has_block), (is_depot ?rpos), 
;; destroy_block action has changed: (is_depot ?p), (at ?p), (is_depot ?p), (at ?p), (has_block), 
;; create_block action has changed: (is_depot ?p), (has_block), (at ?p), (at ?p), (has_block), (is_depot ?p), 
;; Last_reduced_capability_num_dropped_pals: None
