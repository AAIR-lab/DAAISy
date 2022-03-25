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
			(at ?from)
			(height ?from ?h)
			(neighbor ?from ?to)
			(not (has_block))
			
    )
    :effect
    (and
        (is_depot ?to)
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
			(at ?from)
			(neighbor ?from ?to)
			(not (has_block))
			(not (succ ?hfrom ?hto))
			
    )
    :effect
    (and
        (not (at ?to))
			(height ?from ?hfrom)
			(not (height ?to ?hto))
			(height ?to ?hfrom)
			(not (at ?from))
			(not (neighbor ?from ?to))
			(succ ?hfrom ?hto)
			(neighbor ?to ?from)
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (at ?to))
			(is_depot ?from)
			(height ?from ?hto)
			(height ?from ?hfrom)
			(height ?to ?hto)
			(at ?from)
			(neighbor ?from ?to)
			(succ ?hfrom ?hto)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (is_depot ?to)
			(at ?to)
			(not (is_depot ?from))
			(not (height ?from ?hto))
			(not (height ?from ?hfrom))
			(not (height ?to ?hto))
			(not (at ?from))
			(not (neighbor ?from ?to))
			(not (succ ?hfrom ?hto))
			(neighbor ?to ?from)
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (is_depot ?bpos)
			(not (succ ?hafter ?hbefore))
			(neighbor ?rpos ?bpos)
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(at ?rpos)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(height ?bpos ?hafter)
			(neighbor ?bpos ?rpos)
			(not (is_depot ?rpos))
			(not (height ?rpos ?hbefore))
			(not (at ?rpos))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (neighbor ?rpos ?bpos)
			(not (height ?bpos ?hafter))
			(neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
			(height ?rpos ?hbefore)
			(not (height ?rpos ?hafter))
			(at ?rpos)
			(at ?bpos)
			(has_block)
			
    )
    :effect
    (and
        (height ?bpos ?hbefore)
			(not (succ ?hafter ?hbefore))
			(height ?bpos ?hafter)
			(is_depot ?rpos)
			(height ?rpos ?hafter)
			(not (at ?rpos))
			(not (has_block))
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (has_block)
			
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
        (has_block)
			
    )
    :effect
    (and
        (not (is_depot ?p))
			(at ?p)
			(not (has_block))
			
    )
)

)

;; 
;; move_up action has changed: (height ?to ?hto), (neighbor ?from ?to), (succ ?hfrom ?hto), (height ?from ?hfrom), (succ ?hfrom ?hto), (succ ?hto ?hfrom), (height ?from ?hfrom), (height ?from ?hto), (at ?to), (height ?to ?hto), (neighbor ?to ?from), (has_block), (height ?to ?hfrom), (is_depot ?from), 
;; destroy_block action has changed: (at ?p), (at ?p), (is_depot ?p), (is_depot ?p), 
;; create_block action has changed: (is_depot ?p), (has_block), (at ?p), (at ?p), 
;; move action has changed: (height ?to ?h), (has_block), (neighbor ?to ?from), (is_depot ?to), (at ?from), (is_depot ?to), (has_block), (at ?to), (is_depot ?from), (at ?to), 
;; place_block action has changed: (height ?bpos ?hbefore), (at ?rpos), (neighbor ?bpos ?rpos), (height ?rpos ?hbefore), (has_block), (succ ?hafter ?hbefore), (is_depot ?bpos), (height ?rpos ?hafter), (is_depot ?rpos), (succ ?hafter ?hbefore), (has_block), 
;; move_down action has changed: (height ?from ?hfrom), (neighbor ?from ?to), (at ?to), (height ?from ?hto), (height ?from ?hto), (is_depot ?from), (is_depot ?to), (neighbor ?to ?from), (is_depot ?from), (succ ?hfrom ?hto), (height ?to ?hto), (neighbor ?to ?from), 
;; remove_block action has changed: (height ?rpos ?hbefore), (height ?bpos ?hafter), (height ?rpos ?hafter), (at ?rpos), (has_block), (is_depot ?rpos), (neighbor ?bpos ?rpos), (height ?rpos ?hafter), (height ?bpos ?hbefore), (at ?bpos), (succ ?hafter ?hbefore), (height ?bpos ?hbefore), 
;; Last_reduced_capability_num_dropped_pals: None
