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
			(not (has_block))
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(not (height ?to ?h))
			(not (is_depot ?from))
			(at ?from)
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
        (is_depot ?to)
			(not (at ?to))
			(not (succ ?hto ?hfrom))
			(not (height ?from ?hfrom))
			(not (height ?to ?hfrom))
			(not (neighbor ?from ?to))
			(has_block)
			(succ ?hfrom ?hto)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(is_depot ?from)
			(height ?from ?hto)
			(height ?to ?hfrom)
			(at ?from)
			(neighbor ?from ?to)
			(not (has_block))
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
			(succ ?hto ?hfrom)
			(height ?from ?hto)
			(not (height ?from ?hfrom))
			(height ?to ?hto)
			(height ?to ?hfrom)
			(neighbor ?from ?to)
			(not (succ ?hfrom ?hto))
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (not (succ ?hto ?hfrom))
			(not (height ?from ?hto))
			(height ?from ?hfrom)
			(not (height ?to ?hto))
			(not (height ?to ?hfrom))
			(at ?from)
			(not (neighbor ?from ?to))
			(has_block)
			(succ ?hfrom ?hto)
			(not (neighbor ?to ?from))
			
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
			(not (height ?rpos ?hbefore))
			(not (height ?rpos ?hafter))
			(at ?bpos)
			(has_block)
			
    )
    :effect
    (and
        (not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(not (neighbor ?rpos ?bpos))
			(neighbor ?bpos ?rpos)
			(is_depot ?rpos)
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(not (at ?rpos))
			(not (at ?bpos))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (not (succ ?hafter ?hbefore))
			(not (height ?bpos ?hafter))
			(neighbor ?bpos ?rpos)
			(not (succ ?hbefore ?hafter))
			(height ?rpos ?hbefore)
			(not (height ?rpos ?hafter))
			(not (at ?bpos))
			(not (has_block))
			
    )
    :effect
    (and
        (is_depot ?bpos)
			(succ ?hafter ?hbefore)
			(not (neighbor ?rpos ?bpos))
			(height ?bpos ?hafter)
			(not (neighbor ?bpos ?rpos))
			(succ ?hbefore ?hafter)
			(is_depot ?rpos)
			(not (height ?rpos ?hbefore))
			(height ?rpos ?hafter)
			(not (at ?rpos))
			(at ?bpos)
			(has_block)
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (is_depot ?p)
			(not (at ?p))
			(not (has_block))
			
    )
    :effect
    (and
        (at ?p)
			
    )
)

(:action destroy_block
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

)

;; 
;; place_block action has changed: (is_depot ?rpos), (height ?bpos ?hbefore), (at ?rpos), (at ?bpos), (has_block), (succ ?hbefore ?hafter), (height ?rpos ?hbefore), (height ?bpos ?hafter), (at ?rpos), (neighbor ?rpos ?bpos), (height ?rpos ?hafter), (is_depot ?bpos), (neighbor ?bpos ?rpos), (is_depot ?bpos), (succ ?hafter ?hbefore), (neighbor ?bpos ?rpos), (height ?bpos ?hafter), (height ?rpos ?hafter), (is_depot ?rpos), (height ?rpos ?hbefore), (at ?bpos), (succ ?hafter ?hbefore), 
;; move action has changed: (neighbor ?from ?to), (is_depot ?from), (has_block), (is_depot ?to), (height ?from ?h), (height ?from ?h), (neighbor ?to ?from), (height ?to ?h), (at ?from), (neighbor ?to ?from), (at ?to), (at ?from), (neighbor ?from ?to), (has_block), 
;; remove_block action has changed: (succ ?hbefore ?hafter), (height ?rpos ?hbefore), (height ?bpos ?hbefore), (succ ?hbefore ?hafter), (height ?rpos ?hafter), (neighbor ?bpos ?rpos), (height ?bpos ?hbefore), (at ?bpos), (neighbor ?rpos ?bpos), (succ ?hafter ?hbefore), (at ?rpos), (at ?bpos), (is_depot ?bpos), (neighbor ?rpos ?bpos), (at ?rpos), (succ ?hafter ?hbefore), (height ?bpos ?hafter), (has_block), (is_depot ?rpos), (neighbor ?bpos ?rpos), (height ?rpos ?hafter), (height ?rpos ?hbefore), 
;; move_up action has changed: (is_depot ?to), (succ ?hto ?hfrom), (neighbor ?from ?to), (at ?from), (at ?to), (neighbor ?to ?from), (height ?to ?hto), (height ?from ?hto), (height ?to ?hfrom), (at ?from), (at ?to), (succ ?hfrom ?hto), (has_block), (has_block), (height ?from ?hfrom), (neighbor ?from ?to), (is_depot ?from), (is_depot ?to), (neighbor ?to ?from), (height ?to ?hfrom), (succ ?hfrom ?hto), 
;; move_down action has changed: (is_depot ?to), (height ?from ?hto), (height ?to ?hfrom), (has_block), (height ?from ?hto), (at ?to), (neighbor ?to ?from), (height ?to ?hfrom), (succ ?hto ?hfrom), (at ?from), (succ ?hfrom ?hto), (at ?to), (height ?from ?hfrom), (neighbor ?from ?to), (succ ?hto ?hfrom), (neighbor ?to ?from), (height ?to ?hto), (succ ?hfrom ?hto), (at ?from), (height ?from ?hfrom), 
;; destroy_block action has changed: (is_depot ?p), (has_block), (is_depot ?p), (at ?p), (at ?p), (has_block), 
;; create_block action has changed: (at ?p), (has_block), (at ?p), (has_block), 
;; Last_reduced_capability_num_dropped_pals: None
