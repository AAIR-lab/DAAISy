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
			(not (at ?to))
			(not (is_depot ?from))
			(not (neighbor ?from ?to))
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(is_depot ?from)
			(at ?from)
			(not (height ?from ?h))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?from))
			(not (height ?from ?hfrom))
			(height ?to ?hto)
			(height ?to ?hfrom)
			(neighbor ?from ?to)
			(has_block)
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(not (at ?to))
			(succ ?hto ?hfrom)
			(is_depot ?from)
			(not (height ?from ?hto))
			(not (height ?to ?hfrom))
			(not (neighbor ?from ?to))
			(not (succ ?hfrom ?hto))
			(neighbor ?to ?from)
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(not (succ ?hto ?hfrom))
			(height ?from ?hfrom)
			(at ?from)
			(not (neighbor ?from ?to))
			(has_block)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (is_depot ?to)
			(at ?to)
			(not (height ?from ?hfrom))
			(height ?to ?hto)
			(not (height ?to ?hfrom))
			(not (at ?from))
			(neighbor ?from ?to)
			(not (succ ?hfrom ?hto))
			(neighbor ?to ?from)
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (succ ?hafter ?hbefore)
			(not (neighbor ?rpos ?bpos))
			(not (height ?bpos ?hafter))
			(not (neighbor ?bpos ?rpos))
			(not (is_depot ?rpos))
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(at ?rpos)
			(not (at ?bpos))
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(is_depot ?bpos)
			(neighbor ?rpos ?bpos)
			(succ ?hbefore ?hafter)
			(is_depot ?rpos)
			(at ?bpos)
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
			(not (neighbor ?bpos ?rpos))
			(not (is_depot ?rpos))
			(not (height ?rpos ?hafter))
			(at ?rpos)
			(not (at ?bpos))
			(not (has_block))
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(not (is_depot ?bpos))
			(height ?bpos ?hafter)
			(neighbor ?bpos ?rpos)
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(not (at ?rpos))
			(at ?bpos)
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (is_depot ?p)
			(at ?p)
			
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
        (not (is_depot ?p))
			(not (at ?p))
			
    )
)

)

;; 
;; remove_block action has changed: (neighbor ?bpos ?rpos), (succ ?hbefore ?hafter), (is_depot ?rpos), (at ?bpos), (at ?bpos), (is_depot ?bpos), (has_block), (has_block), (at ?rpos), (height ?rpos ?hbefore), (neighbor ?bpos ?rpos), (height ?bpos ?hafter), (height ?rpos ?hafter), (is_depot ?bpos), (height ?bpos ?hbefore), (height ?rpos ?hafter), 
;; move_up action has changed: (neighbor ?from ?to), (neighbor ?to ?from), (height ?to ?hfrom), (height ?to ?hfrom), (height ?from ?hto), (is_depot ?from), (has_block), (succ ?hto ?hfrom), (is_depot ?to), (at ?to), (succ ?hto ?hfrom), (height ?from ?hfrom), (succ ?hfrom ?hto), (at ?from), (at ?from), (is_depot ?from), 
;; move action has changed: (is_depot ?to), (is_depot ?from), (at ?from), (is_depot ?to), (is_depot ?from), (neighbor ?from ?to), (at ?from), (at ?to), (height ?to ?h), (at ?to), (height ?from ?h), (height ?from ?h), 
;; destroy_block action has changed: (at ?p), (is_depot ?p), (has_block), (is_depot ?p), 
;; move_down action has changed: (succ ?hto ?hfrom), (height ?to ?hfrom), (is_depot ?to), (neighbor ?to ?from), (is_depot ?to), (height ?to ?hto), (neighbor ?from ?to), (height ?from ?hfrom), (height ?to ?hto), (succ ?hfrom ?hto), (neighbor ?to ?from), (neighbor ?from ?to), (has_block), (succ ?hfrom ?hto), 
;; place_block action has changed: (neighbor ?bpos ?rpos), (has_block), (at ?bpos), (is_depot ?rpos), (height ?bpos ?hafter), (height ?bpos ?hafter), (succ ?hbefore ?hafter), (neighbor ?rpos ?bpos), (height ?bpos ?hbefore), (neighbor ?rpos ?bpos), (is_depot ?bpos), (is_depot ?rpos), (is_depot ?bpos), (at ?bpos), (has_block), (height ?rpos ?hafter), 
;; create_block action has changed: (has_block), 
;; Last_reduced_capability_num_dropped_pals: None
