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
			(height ?to ?h)
			(at ?from)
			(height ?from ?h)
			(neighbor ?from ?to)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (at ?to)
			(not (at ?from))
			(not (height ?from ?h))
			(neighbor ?to ?from)
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (succ ?hto ?hfrom)
			(not (is_depot ?from))
			(not (height ?from ?hfrom))
			(at ?from)
			(neighbor ?from ?to)
			
    )
    :effect
    (and
        (not (at ?to))
			(height ?from ?hfrom)
			(not (height ?to ?hto))
			(height ?to ?hfrom)
			(neighbor ?to ?from)
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (height ?from ?hto))
			(height ?to ?hto)
			(height ?to ?hfrom)
			(at ?from)
			(neighbor ?from ?to)
			(has_block)
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (at ?to)
			(not (height ?to ?hfrom))
			(not (has_block))
			(not (succ ?hfrom ?hto))
			
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
			(not (is_depot ?rpos))
			(height ?rpos ?hbefore)
			(has_block)
			
    )
    :effect
    (and
        (not (is_depot ?bpos))
			(not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(not (succ ?hbefore ?hafter))
			(not (height ?rpos ?hbefore))
			(not (has_block))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(is_depot ?bpos)
			(not (neighbor ?bpos ?rpos))
			(not (is_depot ?rpos))
			(at ?rpos)
			(has_block)
			
    )
    :effect
    (and
        (not (neighbor ?rpos ?bpos))
			(height ?bpos ?hafter)
			(not (succ ?hbefore ?hafter))
			(not (height ?rpos ?hafter))
			(not (at ?rpos))
			(not (has_block))
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (not (is_depot ?p))
			(not (at ?p))
			(has_block)
			
    )
    :effect
    (and
        (has_block)
			
    )
)

(:action destroy_block
    :parameters (?p - position)
    :precondition
    (and
        (at ?p)
			
    )
    :effect
    (and
        (not (at ?p))
			(not (has_block))
			
    )
)

)

;; 
;; remove_block action has changed: (height ?rpos ?hafter), (is_depot ?bpos), (succ ?hbefore ?hafter), (is_depot ?rpos), (height ?bpos ?hbefore), (succ ?hbefore ?hafter), (neighbor ?rpos ?bpos), (height ?rpos ?hafter), (neighbor ?bpos ?rpos), (neighbor ?rpos ?bpos), (has_block), (at ?rpos), 
;; move_down action has changed: (has_block), (at ?from), (height ?to ?hfrom), (height ?to ?hfrom), (succ ?hfrom ?hto), (height ?from ?hto), (height ?from ?hfrom), (has_block), 
;; move_up action has changed: (at ?to), (neighbor ?to ?from), (height ?from ?hfrom), (height ?to ?hto), (is_depot ?from), (height ?to ?hfrom), (height ?from ?hfrom), (height ?to ?hto), (at ?from), 
;; place_block action has changed: (is_depot ?bpos), (succ ?hbefore ?hafter), (height ?bpos ?hbefore), (height ?rpos ?hbefore), (neighbor ?rpos ?bpos), (at ?rpos), (height ?bpos ?hafter), (height ?bpos ?hafter), (succ ?hafter ?hbefore), (height ?bpos ?hbefore), (is_depot ?rpos), 
;; create_block action has changed: (is_depot ?p), (at ?p), 
;; move action has changed: (height ?from ?h), (neighbor ?to ?from), (neighbor ?to ?from), (is_depot ?to), 
;; destroy_block action has changed: (has_block), (at ?p), (is_depot ?p), 
;; Last_reduced_capability_num_dropped_pals: None
