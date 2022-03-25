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
        (not (height ?to ?h))
			(not (at ?to))
			(is_depot ?from)
			(not (height ?from ?h))
			(not (neighbor ?from ?to))
			(has_block)
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (height ?to ?h)
			(not (at ?from))
			(height ?from ?h)
			(not (has_block))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (at ?to))
			(is_depot ?from)
			(not (height ?from ?hfrom))
			(height ?to ?hto)
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (is_depot ?to)
			(not (succ ?hto ?hfrom))
			(not (is_depot ?from))
			(not (height ?from ?hto))
			(not (height ?to ?hto))
			(not (at ?from))
			(not (succ ?hfrom ?hto))
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (at ?to))
			(not (succ ?hto ?hfrom))
			(is_depot ?from)
			(not (height ?to ?hfrom))
			(at ?from)
			(not (neighbor ?from ?to))
			(succ ?hfrom ?hto)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (height ?from ?hto)
			(height ?from ?hfrom)
			(not (has_block))
			(neighbor ?to ?from)
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (is_depot ?bpos)
			(not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(not (height ?bpos ?hafter))
			(succ ?hbefore ?hafter)
			(not (is_depot ?rpos))
			(not (height ?rpos ?hbefore))
			(at ?rpos)
			(at ?bpos)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(not (is_depot ?bpos))
			(neighbor ?bpos ?rpos)
			(not (succ ?hbefore ?hafter))
			(not (height ?rpos ?hafter))
			(not (at ?bpos))
			(not (has_block))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(succ ?hbefore ?hafter)
			(is_depot ?rpos)
			(height ?rpos ?hbefore)
			(not (height ?rpos ?hafter))
			(at ?bpos)
			(has_block)
			
    )
    :effect
    (and
        (not (is_depot ?bpos))
			(neighbor ?rpos ?bpos)
			(height ?bpos ?hafter)
			(not (neighbor ?bpos ?rpos))
			(not (at ?rpos))
			(not (at ?bpos))
			(has_block)
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
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
        (not (at ?p))
			
    )
    :effect
    (and
        (not (is_depot ?p))
			
    )
)

)

;; 
;; move_up action has changed: (succ ?hto ?hfrom), (succ ?hto ?hfrom), (is_depot ?from), (is_depot ?to), (height ?from ?hto), (at ?to), (at ?from), (height ?to ?hto), (succ ?hfrom ?hto), (neighbor ?from ?to), (is_depot ?from), (height ?from ?hfrom), (at ?to), (succ ?hfrom ?hto), 
;; place_block action has changed: (height ?bpos ?hafter), (has_block), (succ ?hafter ?hbefore), (neighbor ?bpos ?rpos), (height ?rpos ?hafter), (height ?bpos ?hbefore), (succ ?hbefore ?hafter), (neighbor ?rpos ?bpos), (at ?bpos), (at ?bpos), (succ ?hbefore ?hafter), (is_depot ?bpos), (is_depot ?rpos), (height ?bpos ?hafter), (height ?rpos ?hbefore), 
;; move_down action has changed: (at ?to), (succ ?hto ?hfrom), (neighbor ?to ?from), (height ?to ?hto), (height ?from ?hto), (at ?from), (neighbor ?to ?from), (height ?from ?hfrom), (height ?to ?hfrom), (height ?from ?hfrom), (neighbor ?from ?to), (is_depot ?from), (has_block), (at ?to), 
;; move action has changed: (has_block), (at ?from), (height ?from ?h), (has_block), (height ?from ?h), (neighbor ?to ?from), (height ?to ?h), (height ?to ?h), (at ?to), (at ?to), (is_depot ?from), (neighbor ?from ?to), 
;; destroy_block action has changed: (has_block), (has_block), (is_depot ?p), (is_depot ?p), (at ?p), 
;; remove_block action has changed: (at ?rpos), (at ?bpos), (neighbor ?rpos ?bpos), (succ ?hafter ?hbefore), (height ?bpos ?hbefore), (neighbor ?bpos ?rpos), (neighbor ?rpos ?bpos), (is_depot ?bpos), (height ?rpos ?hafter), (is_depot ?rpos), (at ?rpos), (height ?rpos ?hbefore), (at ?bpos), (height ?bpos ?hbefore), 
;; create_block action has changed: (is_depot ?p), (at ?p), (at ?p), (has_block), (has_block), 
;; Last_reduced_capability_num_dropped_pals: None
