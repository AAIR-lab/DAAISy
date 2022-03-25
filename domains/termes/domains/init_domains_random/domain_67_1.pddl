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
        (at ?from)
			(height ?from ?h)
			(has_block)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (is_depot ?to)
			(not (height ?to ?h))
			(not (at ?to))
			(not (neighbor ?from ?to))
			(not (has_block))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (at ?to))
			(succ ?hto ?hfrom)
			(is_depot ?from)
			(not (height ?from ?hfrom))
			(height ?to ?hto)
			(not (height ?to ?hfrom))
			(neighbor ?from ?to)
			(not (has_block))
			(not (succ ?hfrom ?hto))
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (height ?to ?hfrom)
			(not (at ?from))
			(not (neighbor ?from ?to))
			(has_block)
			(not (neighbor ?to ?from))
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (at ?to))
			(is_depot ?from)
			(not (height ?from ?hfrom))
			(not (height ?to ?hto))
			(not (height ?to ?hfrom))
			(at ?from)
			(neighbor ?from ?to)
			(succ ?hfrom ?hto)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (not (succ ?hto ?hfrom))
			(height ?from ?hfrom)
			(height ?to ?hfrom)
			(has_block)
			(not (succ ?hfrom ?hto))
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(succ ?hafter ?hbefore)
			(neighbor ?rpos ?bpos)
			(not (neighbor ?bpos ?rpos))
			(is_depot ?rpos)
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(at ?rpos)
			
    )
    :effect
    (and
        (not (is_depot ?bpos))
			(not (succ ?hafter ?hbefore))
			(not (height ?bpos ?hafter))
			(succ ?hbefore ?hafter)
			(not (height ?rpos ?hafter))
			(not (at ?rpos))
			(has_block)
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (is_depot ?bpos)
			(succ ?hafter ?hbefore)
			(neighbor ?rpos ?bpos)
			(not (succ ?hbefore ?hafter))
			(at ?rpos)
			(has_block)
			
    )
    :effect
    (and
        (height ?bpos ?hbefore)
			(not (is_depot ?bpos))
			(not (succ ?hafter ?hbefore))
			(neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
			(height ?rpos ?hafter)
			(not (at ?rpos))
			(not (at ?bpos))
			(has_block)
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (is_depot ?p)
			(has_block)
			
    )
    :effect
    (and
        (at ?p)
			(has_block)
			
    )
)

(:action destroy_block
    :parameters (?p - position)
    :precondition
    (and
        (is_depot ?p)
			(at ?p)
			(has_block)
			
    )
    :effect
    (and
        (not (at ?p))
			
    )
)

)

;; 
;; move_up action has changed: (at ?to), (at ?to), (neighbor ?to ?from), (height ?to ?hfrom), (height ?to ?hfrom), (at ?from), (has_block), (neighbor ?to ?from), (neighbor ?from ?to), (height ?from ?hfrom), (is_depot ?from), (has_block), (succ ?hfrom ?hto), 
;; move action has changed: (neighbor ?from ?to), (at ?from), (height ?to ?h), (has_block), (has_block), (neighbor ?to ?from), (height ?to ?h), (neighbor ?from ?to), (is_depot ?to), (at ?to), 
;; move_down action has changed: (at ?to), (height ?to ?hto), (at ?from), (is_depot ?from), (has_block), (height ?from ?hfrom), (at ?to), (succ ?hto ?hfrom), (height ?to ?hfrom), (height ?to ?hfrom), (neighbor ?to ?from), (succ ?hfrom ?hto), (height ?from ?hfrom), 
;; place_block action has changed: (succ ?hafter ?hbefore), (height ?rpos ?hafter), (is_depot ?rpos), (is_depot ?bpos), (neighbor ?bpos ?rpos), (has_block), (height ?bpos ?hbefore), (succ ?hbefore ?hafter), (has_block), (at ?rpos), (height ?bpos ?hafter), (is_depot ?bpos), (height ?rpos ?hafter), 
;; remove_block action has changed: (height ?rpos ?hafter), (height ?bpos ?hbefore), (succ ?hafter ?hbefore), (neighbor ?bpos ?rpos), (height ?rpos ?hafter), (succ ?hbefore ?hafter), (is_depot ?bpos), (is_depot ?bpos), (at ?bpos), (height ?bpos ?hafter), (at ?rpos), (height ?bpos ?hbefore), (succ ?hbefore ?hafter), (succ ?hafter ?hbefore), 
;; destroy_block action has changed: (has_block), (at ?p), 
;; create_block action has changed: (at ?p), (at ?p), 
;; Last_reduced_capability_num_dropped_pals: None
