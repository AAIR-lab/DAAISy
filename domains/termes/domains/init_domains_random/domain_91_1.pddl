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
			(not (at ?to))
			(not (is_depot ?from))
			(at ?from)
			(not (height ?from ?h))
			(not (has_block))
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (is_depot ?to)
			(at ?to)
			(neighbor ?from ?to)
			(not (neighbor ?to ?from))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (is_depot ?to)
			(not (at ?to))
			(succ ?hto ?hfrom)
			(height ?from ?hto)
			(not (height ?from ?hfrom))
			(not (height ?to ?hfrom))
			(neighbor ?from ?to)
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(not (is_depot ?from))
			(not (height ?to ?hto))
			(height ?to ?hfrom)
			(not (neighbor ?from ?to))
			(has_block)
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (at ?to))
			(not (succ ?hto ?hfrom))
			(not (is_depot ?from))
			(height ?to ?hto)
			(not (neighbor ?from ?to))
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (is_depot ?to)
			(at ?to)
			(is_depot ?from)
			(not (height ?from ?hfrom))
			(not (height ?to ?hto))
			(not (at ?from))
			(neighbor ?from ?to)
			(has_block)
			(neighbor ?to ?from)
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(is_depot ?bpos)
			(not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(not (height ?bpos ?hafter))
			(neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
			(is_depot ?rpos)
			(not (at ?rpos))
			(at ?bpos)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(neighbor ?rpos ?bpos)
			(not (neighbor ?bpos ?rpos))
			(not (is_depot ?rpos))
			(not (height ?rpos ?hbefore))
			(height ?rpos ?hafter)
			(not (at ?bpos))
			(has_block)
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(not (height ?bpos ?hafter))
			(not (is_depot ?rpos))
			(not (height ?rpos ?hbefore))
			(height ?rpos ?hafter)
			(not (at ?rpos))
			
    )
    :effect
    (and
        (is_depot ?bpos)
			(not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(neighbor ?bpos ?rpos)
			(is_depot ?rpos)
			(height ?rpos ?hbefore)
			(not (height ?rpos ?hafter))
			(at ?bpos)
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (is_depot ?p)
			(at ?p)
			(not (has_block))
			
    )
    :effect
    (and
        (not (is_depot ?p))
			
    )
)

(:action destroy_block
    :parameters (?p - position)
    :precondition
    (and
        (not (is_depot ?p))
			
    )
    :effect
    (and
        (is_depot ?p)
			(at ?p)
			
    )
)

)

;; 
;; remove_block action has changed: (has_block), (is_depot ?bpos), (is_depot ?bpos), (succ ?hafter ?hbefore), (height ?bpos ?hbefore), (neighbor ?bpos ?rpos), (height ?rpos ?hbefore), (neighbor ?rpos ?bpos), (height ?bpos ?hafter), (height ?bpos ?hafter), (height ?rpos ?hbefore), (at ?rpos), (height ?rpos ?hafter), (succ ?hbefore ?hafter), (height ?bpos ?hbefore), (neighbor ?rpos ?bpos), (at ?bpos), (succ ?hafter ?hbefore), (is_depot ?rpos), (is_depot ?rpos), (has_block), 
;; move action has changed: (neighbor ?from ?to), (height ?from ?h), (neighbor ?from ?to), (is_depot ?from), (at ?from), (neighbor ?to ?from), (neighbor ?to ?from), (is_depot ?to), (has_block), (at ?to), 
;; place_block action has changed: (height ?bpos ?hafter), (neighbor ?rpos ?bpos), (at ?bpos), (is_depot ?bpos), (height ?bpos ?hafter), (succ ?hafter ?hbefore), (succ ?hbefore ?hafter), (height ?rpos ?hbefore), (neighbor ?bpos ?rpos), (at ?bpos), (neighbor ?bpos ?rpos), (has_block), (height ?rpos ?hafter), (has_block), (succ ?hafter ?hbefore), (is_depot ?rpos), (at ?rpos), (is_depot ?rpos), (height ?rpos ?hbefore), (neighbor ?rpos ?bpos), 
;; destroy_block action has changed: (at ?p), (has_block), (is_depot ?p), (is_depot ?p), (at ?p), (has_block), 
;; move_down action has changed: (height ?from ?hfrom), (neighbor ?to ?from), (is_depot ?from), (is_depot ?from), (is_depot ?to), (at ?to), (succ ?hto ?hfrom), (succ ?hfrom ?hto), (height ?from ?hfrom), (height ?to ?hto), (neighbor ?from ?to), (neighbor ?from ?to), (at ?from), (has_block), (neighbor ?to ?from), 
;; move_up action has changed: (is_depot ?to), (height ?from ?hfrom), (is_depot ?to), (height ?to ?hfrom), (at ?to), (height ?to ?hfrom), (at ?from), (at ?from), (neighbor ?from ?to), (height ?to ?hto), (has_block), (neighbor ?to ?from), (at ?to), (height ?to ?hto), (is_depot ?from), (height ?from ?hto), 
;; create_block action has changed: (has_block), (has_block), (is_depot ?p), 
;; Last_reduced_capability_num_dropped_pals: None
