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
			(at ?from)
			(not (neighbor ?from ?to))
			(has_block)
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (not (height ?from ?h))
			(not (neighbor ?to ?from))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(height ?from ?hto)
			(not (height ?from ?hfrom))
			(height ?to ?hto)
			(at ?from)
			(neighbor ?from ?to)
			(has_block)
			(not (succ ?hfrom ?hto))
			
    )
    :effect
    (and
        (is_depot ?to)
			(at ?to)
			(is_depot ?from)
			(not (height ?from ?hto))
			(height ?from ?hfrom)
			(not (at ?from))
			(not (neighbor ?from ?to))
			(not (has_block))
			(succ ?hfrom ?hto)
			(not (neighbor ?to ?from))
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (is_depot ?to)
			(not (at ?to))
			(not (succ ?hto ?hfrom))
			(not (is_depot ?from))
			(height ?from ?hto)
			(not (height ?from ?hfrom))
			(not (height ?to ?hto))
			(at ?from)
			(not (succ ?hfrom ?hto))
			(not (neighbor ?to ?from))
			
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
        (is_depot ?bpos)
			(succ ?hafter ?hbefore)
			(neighbor ?rpos ?bpos)
			(not (height ?bpos ?hafter))
			(not (neighbor ?bpos ?rpos))
			(succ ?hbefore ?hafter)
			(not (is_depot ?rpos))
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			
    )
    :effect
    (and
        (height ?bpos ?hbefore)
			(not (is_depot ?bpos))
			(not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(height ?bpos ?hafter)
			(neighbor ?bpos ?rpos)
			(not (succ ?hbefore ?hafter))
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
			(succ ?hafter ?hbefore)
			(neighbor ?rpos ?bpos)
			(not (height ?bpos ?hafter))
			(succ ?hbefore ?hafter)
			(not (is_depot ?rpos))
			(not (height ?rpos ?hbefore))
			(at ?bpos)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(not (is_depot ?bpos))
			(not (succ ?hafter ?hbefore))
			(height ?bpos ?hafter)
			(not (neighbor ?bpos ?rpos))
			(not (succ ?hbefore ?hafter))
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
        (is_depot ?p)
			(at ?p)
			(has_block)
			
    )
    :effect
    (and
        (not (is_depot ?p))
			(not (at ?p))
			
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
        (not (has_block))
			
    )
)

)

;; 
;; remove_block action has changed: (succ ?hafter ?hbefore), (is_depot ?bpos), (at ?bpos), (succ ?hafter ?hbefore), (succ ?hbefore ?hafter), (is_depot ?bpos), (has_block), (is_depot ?rpos), (at ?rpos), (height ?rpos ?hbefore), (neighbor ?bpos ?rpos), (height ?bpos ?hbefore), (height ?bpos ?hafter), (height ?rpos ?hafter), (at ?bpos), (at ?rpos), (height ?rpos ?hafter), (has_block), 
;; place_block action has changed: (height ?rpos ?hbefore), (is_depot ?bpos), (height ?bpos ?hafter), (at ?rpos), (height ?bpos ?hbefore), (succ ?hafter ?hbefore), (is_depot ?rpos), (at ?rpos), (height ?bpos ?hbefore), (neighbor ?bpos ?rpos), (height ?rpos ?hafter), (neighbor ?bpos ?rpos), (succ ?hbefore ?hafter), (succ ?hbefore ?hafter), (height ?rpos ?hafter), (has_block), (neighbor ?rpos ?bpos), (is_depot ?rpos), 
;; move_up action has changed: (is_depot ?to), (neighbor ?to ?from), (succ ?hto ?hfrom), (is_depot ?from), (succ ?hfrom ?hto), (height ?from ?hfrom), (height ?from ?hto), (succ ?hfrom ?hto), (height ?from ?hto), (neighbor ?from ?to), (height ?from ?hfrom), (has_block), (has_block), (is_depot ?to), 
;; move_down action has changed: (height ?from ?hto), (succ ?hto ?hfrom), (height ?from ?hto), (succ ?hfrom ?hto), (at ?to), (height ?from ?hfrom), (height ?to ?hto), (at ?to), (is_depot ?to), (succ ?hto ?hfrom), (height ?to ?hto), (is_depot ?to), (neighbor ?to ?from), (height ?to ?hfrom), (neighbor ?from ?to), (neighbor ?from ?to), (succ ?hfrom ?hto), (height ?from ?hfrom), (is_depot ?from), (is_depot ?from), (neighbor ?to ?from), (at ?from), (has_block), 
;; move action has changed: (height ?from ?h), (is_depot ?from), (height ?from ?h), (at ?to), (neighbor ?to ?from), (neighbor ?from ?to), (at ?from), (is_depot ?to), (height ?to ?h), (at ?to), (has_block), (neighbor ?to ?from), 
;; create_block action has changed: (is_depot ?p), (has_block), (at ?p), 
;; destroy_block action has changed: (at ?p), (has_block), (is_depot ?p), 
;; Last_reduced_capability_num_dropped_pals: None
