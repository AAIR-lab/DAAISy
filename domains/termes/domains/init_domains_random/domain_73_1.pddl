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
			(at ?from)
			(neighbor ?from ?to)
			
    )
    :effect
    (and
        (not (height ?from ?h))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (at ?to))
			(succ ?hto ?hfrom)
			(height ?from ?hto)
			(height ?to ?hfrom)
			(succ ?hfrom ?hto)
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(at ?to)
			(not (succ ?hto ?hfrom))
			(not (is_depot ?from))
			(height ?to ?hto)
			(not (height ?to ?hfrom))
			(not (neighbor ?from ?to))
			(not (has_block))
			(not (succ ?hfrom ?hto))
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(not (at ?to))
			(is_depot ?from)
			(height ?from ?hfrom)
			(not (height ?to ?hfrom))
			(neighbor ?from ?to)
			(not (succ ?hfrom ?hto))
			
    )
    :effect
    (and
        (is_depot ?to)
			(at ?to)
			(not (is_depot ?from))
			(at ?from)
			(neighbor ?to ?from)
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(not (height ?bpos ?hafter))
			(not (neighbor ?bpos ?rpos))
			(not (succ ?hbefore ?hafter))
			(not (is_depot ?rpos))
			(not (height ?rpos ?hbefore))
			
    )
    :effect
    (and
        (not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
			(is_depot ?rpos)
			(not (at ?bpos))
			(has_block)
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (is_depot ?bpos)
			(neighbor ?rpos ?bpos)
			(not (height ?bpos ?hafter))
			(succ ?hbefore ?hafter)
			(is_depot ?rpos)
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(at ?rpos)
			(at ?bpos)
			(not (has_block))
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(height ?bpos ?hafter)
			(not (neighbor ?bpos ?rpos))
			(not (height ?rpos ?hbefore))
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
			(not (at ?p))
			
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
;; remove_block action has changed: (height ?rpos ?hbefore), (neighbor ?bpos ?rpos), (succ ?hafter ?hbefore), (is_depot ?bpos), (at ?bpos), (neighbor ?rpos ?bpos), (height ?bpos ?hbefore), (has_block), (at ?bpos), (is_depot ?rpos), (height ?rpos ?hbefore), (height ?bpos ?hafter), (at ?rpos), 
;; place_block action has changed: (is_depot ?rpos), (at ?bpos), (succ ?hafter ?hbefore), (neighbor ?bpos ?rpos), (at ?rpos), (is_depot ?bpos), (height ?bpos ?hafter), (neighbor ?bpos ?rpos), (neighbor ?rpos ?bpos), (succ ?hbefore ?hafter), (is_depot ?rpos), (height ?bpos ?hafter), (height ?rpos ?hbefore), (neighbor ?rpos ?bpos), (has_block), (has_block), (succ ?hbefore ?hafter), (height ?bpos ?hbefore), 
;; move_up action has changed: (at ?from), (height ?to ?hto), (height ?to ?hfrom), (height ?to ?hto), (neighbor ?from ?to), (succ ?hfrom ?hto), (at ?to), (neighbor ?to ?from), (height ?from ?hfrom), (height ?from ?hto), (neighbor ?from ?to), (has_block), (succ ?hto ?hfrom), (height ?to ?hfrom), (at ?from), (is_depot ?from), (is_depot ?to), (succ ?hfrom ?hto), 
;; destroy_block action has changed: (is_depot ?p), (at ?p), 
;; create_block action has changed: (at ?p), (has_block), (at ?p), (has_block), 
;; move_down action has changed: (succ ?hfrom ?hto), (at ?to), (is_depot ?to), (height ?to ?hfrom), (neighbor ?to ?from), (is_depot ?from), (height ?to ?hto), (at ?from), (at ?from), (is_depot ?to), (is_depot ?from), 
;; move action has changed: (height ?from ?h), (at ?from), (at ?to), (at ?to), (height ?from ?h), (height ?to ?h), (is_depot ?to), 
;; Last_reduced_capability_num_dropped_pals: None
