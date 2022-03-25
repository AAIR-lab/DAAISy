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
			(not (at ?to))
			(height ?from ?h)
			(neighbor ?from ?to)
			(has_block)
			
    )
    :effect
    (and
        (not (height ?to ?h))
			(not (is_depot ?from))
			(not (neighbor ?from ?to))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(not (at ?to))
			(succ ?hto ?hfrom)
			(is_depot ?from)
			(height ?from ?hfrom)
			(neighbor ?from ?to)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (is_depot ?to)
			(at ?to)
			(not (succ ?hto ?hfrom))
			(not (height ?from ?hto))
			(height ?to ?hto)
			(height ?to ?hfrom)
			(not (at ?from))
			(succ ?hfrom ?hto)
			(neighbor ?to ?from)
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (height ?from ?hfrom)
			(not (height ?to ?hto))
			(at ?from)
			(not (neighbor ?from ?to))
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (not (height ?from ?hto))
			(not (height ?from ?hfrom))
			(height ?to ?hto)
			(height ?to ?hfrom)
			(not (at ?from))
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(is_depot ?bpos)
			(neighbor ?rpos ?bpos)
			(not (neighbor ?bpos ?rpos))
			(height ?rpos ?hbefore)
			(not (height ?rpos ?hafter))
			(not (at ?rpos))
			(not (at ?bpos))
			
    )
    :effect
    (and
        (height ?bpos ?hafter)
			(neighbor ?bpos ?rpos)
			(not (height ?rpos ?hbefore))
			(height ?rpos ?hafter)
			(at ?bpos)
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(not (at ?rpos))
			(not (has_block))
			
    )
    :effect
    (and
        (is_depot ?bpos)
			(not (succ ?hbefore ?hafter))
			(not (height ?rpos ?hbefore))
			(not (at ?bpos))
			(has_block)
			
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
        (has_block)
			
    )
)

(:action destroy_block
    :parameters (?p - position)
    :precondition
    (and
        (at ?p)
			(has_block)
			
    )
    :effect
    (and
        (not (at ?p))
			(not (has_block))
			
    )
)

)

;; 
;; place_block action has changed: (at ?bpos), (has_block), (height ?rpos ?hafter), (height ?rpos ?hbefore), (has_block), (height ?bpos ?hbefore), (neighbor ?bpos ?rpos), (at ?bpos), (succ ?hafter ?hbefore), (at ?rpos), (neighbor ?bpos ?rpos), (height ?rpos ?hafter), 
;; remove_block action has changed: (height ?bpos ?hbefore), (succ ?hbefore ?hafter), (has_block), (height ?bpos ?hbefore), (is_depot ?bpos), (height ?rpos ?hbefore), (at ?rpos), (height ?rpos ?hbefore), (at ?bpos), (neighbor ?bpos ?rpos), (neighbor ?rpos ?bpos), (height ?bpos ?hafter), 
;; move_down action has changed: (height ?to ?hto), (height ?to ?hfrom), (neighbor ?from ?to), (height ?to ?hto), (height ?from ?hfrom), (height ?from ?hto), (at ?to), 
;; move_up action has changed: (at ?from), (neighbor ?to ?from), (is_depot ?to), (height ?from ?hto), (height ?to ?hto), (height ?to ?hto), (is_depot ?to), (neighbor ?to ?from), (is_depot ?from), (height ?to ?hfrom), (at ?to), (succ ?hto ?hfrom), (succ ?hfrom ?hto), 
;; move action has changed: (at ?to), (has_block), (neighbor ?from ?to), (at ?to), (height ?to ?h), (is_depot ?to), (is_depot ?from), (at ?from), (at ?from), 
;; destroy_block action has changed: (is_depot ?p), (at ?p), 
;; Last_reduced_capability_num_dropped_pals: None
