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
			(is_depot ?from)
			(at ?from)
			(not (neighbor ?from ?to))
			(not (has_block))
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(height ?to ?h)
			(not (at ?to))
			(not (is_depot ?from))
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
        (not (succ ?hto ?hfrom))
			(not (is_depot ?from))
			(height ?from ?hto)
			(not (height ?from ?hfrom))
			(not (height ?to ?hto))
			(not (neighbor ?from ?to))
			(not (has_block))
			(not (succ ?hfrom ?hto))
			
    )
    :effect
    (and
        (not (is_depot ?to))
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

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(not (at ?to))
			(succ ?hto ?hfrom)
			(not (is_depot ?from))
			(not (height ?to ?hto))
			(height ?to ?hfrom)
			(has_block)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (is_depot ?to)
			(not (succ ?hto ?hfrom))
			(is_depot ?from)
			(height ?from ?hto)
			(not (height ?from ?hfrom))
			(height ?to ?hto)
			(not (height ?to ?hfrom))
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
			(not (height ?bpos ?hafter))
			(not (neighbor ?bpos ?rpos))
			(succ ?hbefore ?hafter)
			(is_depot ?rpos)
			(height ?rpos ?hafter)
			(not (at ?bpos))
			
    )
    :effect
    (and
        (is_depot ?bpos)
			(not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(neighbor ?bpos ?rpos)
			(not (succ ?hbefore ?hafter))
			(not (is_depot ?rpos))
			(not (height ?rpos ?hbefore))
			(not (height ?rpos ?hafter))
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
			(not (is_depot ?rpos))
			(height ?rpos ?hbefore)
			(not (height ?rpos ?hafter))
			(not (at ?rpos))
			(at ?bpos)
			(has_block)
			
    )
    :effect
    (and
        (height ?bpos ?hbefore)
			(not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(not (neighbor ?rpos ?bpos))
			(height ?bpos ?hafter)
			(neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
			(is_depot ?rpos)
			(not (height ?rpos ?hbefore))
			(height ?rpos ?hafter)
			(at ?rpos)
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
			(has_block)
			
    )
)

)

;; 
;; remove_block action has changed: (height ?rpos ?hbefore), (is_depot ?bpos), (succ ?hbefore ?hafter), (neighbor ?bpos ?rpos), (neighbor ?rpos ?bpos), (height ?rpos ?hbefore), (at ?bpos), (neighbor ?bpos ?rpos), (succ ?hafter ?hbefore), (succ ?hafter ?hbefore), (neighbor ?rpos ?bpos), (is_depot ?rpos), (has_block), (is_depot ?bpos), (height ?rpos ?hafter), (is_depot ?rpos), (height ?bpos ?hafter), (height ?rpos ?hafter), (at ?bpos), (succ ?hbefore ?hafter), (at ?rpos), (height ?bpos ?hbefore), (height ?bpos ?hbefore), (at ?rpos), 
;; place_block action has changed: (succ ?hbefore ?hafter), (neighbor ?rpos ?bpos), (height ?bpos ?hafter), (at ?rpos), (is_depot ?bpos), (neighbor ?rpos ?bpos), (height ?bpos ?hafter), (height ?bpos ?hbefore), (is_depot ?rpos), (is_depot ?rpos), (succ ?hbefore ?hafter), (neighbor ?bpos ?rpos), (succ ?hafter ?hbefore), (has_block), (succ ?hafter ?hbefore), (at ?rpos), (at ?bpos), (at ?bpos), (height ?rpos ?hbefore), (has_block), (height ?rpos ?hafter), (is_depot ?bpos), (height ?rpos ?hbefore), (height ?rpos ?hafter), (neighbor ?bpos ?rpos), 
;; move_up action has changed: (is_depot ?from), (height ?to ?hfrom), (succ ?hto ?hfrom), (succ ?hfrom ?hto), (neighbor ?from ?to), (height ?from ?hfrom), (has_block), (at ?from), (height ?from ?hfrom), (at ?to), (neighbor ?from ?to), (succ ?hfrom ?hto), (is_depot ?to), (height ?to ?hto), (has_block), (is_depot ?from), (height ?to ?hto), (height ?from ?hto), (succ ?hto ?hfrom), (height ?from ?hto), (neighbor ?to ?from), (at ?from), 
;; move action has changed: (height ?from ?h), (has_block), (is_depot ?from), (at ?from), (height ?to ?h), (neighbor ?from ?to), (has_block), (is_depot ?to), (neighbor ?from ?to), (height ?to ?h), (neighbor ?to ?from), (at ?to), (is_depot ?to), (is_depot ?from), (height ?from ?h), 
;; move_down action has changed: (neighbor ?to ?from), (height ?to ?hfrom), (height ?to ?hfrom), (at ?to), (height ?from ?hto), (has_block), (neighbor ?from ?to), (height ?to ?hto), (succ ?hfrom ?hto), (neighbor ?from ?to), (at ?to), (at ?from), (succ ?hto ?hfrom), (height ?from ?hfrom), (is_depot ?to), (is_depot ?to), (at ?from), (neighbor ?to ?from), (has_block), (succ ?hfrom ?hto), (height ?from ?hfrom), (is_depot ?from), (height ?to ?hto), (is_depot ?from), (succ ?hto ?hfrom), 
;; create_block action has changed: (at ?p), (has_block), (is_depot ?p), (has_block), (is_depot ?p), 
;; destroy_block action has changed: (is_depot ?p), (at ?p), (has_block), (has_block), (at ?p), 
;; Last_reduced_capability_num_dropped_pals: None
