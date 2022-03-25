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
			(not (is_depot ?from))
			(has_block)
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (is_depot ?to)
			(at ?to)
			(not (at ?from))
			(not (height ?from ?h))
			(not (neighbor ?to ?from))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(succ ?hto ?hfrom)
			(height ?from ?hto)
			(not (height ?from ?hfrom))
			(not (height ?to ?hfrom))
			(neighbor ?from ?to)
			(not (has_block))
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (is_depot ?to)
			(not (at ?to))
			(not (is_depot ?from))
			(not (height ?from ?hto))
			(height ?from ?hfrom)
			(height ?to ?hto)
			(height ?to ?hfrom)
			(at ?from)
			(not (neighbor ?from ?to))
			(has_block)
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
			(succ ?hto ?hfrom)
			(not (height ?from ?hto))
			(height ?from ?hfrom)
			(not (height ?to ?hto))
			(not (height ?to ?hfrom))
			(neighbor ?from ?to)
			(has_block)
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(not (succ ?hto ?hfrom))
			(not (is_depot ?from))
			(height ?from ?hto)
			(not (height ?from ?hfrom))
			(height ?to ?hfrom)
			(at ?from)
			(not (neighbor ?from ?to))
			
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
			(is_depot ?rpos)
			(height ?rpos ?hafter)
			(has_block)
			
    )
    :effect
    (and
        (height ?bpos ?hbefore)
			(not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(neighbor ?rpos ?bpos)
			(neighbor ?bpos ?rpos)
			(not (is_depot ?rpos))
			(height ?rpos ?hbefore)
			(not (height ?rpos ?hafter))
			(not (at ?rpos))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (not (is_depot ?bpos))
			(not (succ ?hafter ?hbefore))
			(not (height ?bpos ?hafter))
			(not (neighbor ?bpos ?rpos))
			(succ ?hbefore ?hafter)
			(is_depot ?rpos)
			(not (at ?bpos))
			(has_block)
			
    )
    :effect
    (and
        (is_depot ?bpos)
			(neighbor ?bpos ?rpos)
			(not (succ ?hbefore ?hafter))
			(not (is_depot ?rpos))
			(not (height ?rpos ?hbefore))
			(not (height ?rpos ?hafter))
			(not (at ?rpos))
			(at ?bpos)
			
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
        (not (is_depot ?p))
			
    )
)

(:action destroy_block
    :parameters (?p - position)
    :precondition
    (and
        (not (is_depot ?p))
			(at ?p)
			
    )
    :effect
    (and
        (not (at ?p))
			(has_block)
			
    )
)

)

;; 
;; remove_block action has changed: (succ ?hafter ?hbefore), (neighbor ?rpos ?bpos), (is_depot ?bpos), (at ?bpos), (is_depot ?bpos), (succ ?hbefore ?hafter), (height ?bpos ?hbefore), (height ?bpos ?hafter), (is_depot ?rpos), (height ?rpos ?hafter), (at ?rpos), (at ?bpos), (neighbor ?bpos ?rpos), (is_depot ?rpos), (at ?rpos), (has_block), (height ?rpos ?hbefore), (height ?bpos ?hbefore), (neighbor ?bpos ?rpos), (height ?bpos ?hafter), (height ?rpos ?hafter), 
;; move_down action has changed: (at ?from), (has_block), (height ?to ?hfrom), (is_depot ?from), (succ ?hto ?hfrom), (neighbor ?to ?from), (succ ?hfrom ?hto), (at ?from), (is_depot ?to), (at ?to), (succ ?hto ?hfrom), (height ?to ?hfrom), (at ?to), (height ?from ?hto), (height ?from ?hfrom), (height ?from ?hto), (neighbor ?from ?to), (is_depot ?to), (height ?to ?hto), 
;; move action has changed: (height ?from ?h), (is_depot ?to), (neighbor ?from ?to), (neighbor ?to ?from), (at ?from), (is_depot ?to), (height ?from ?h), (is_depot ?from), (has_block), (neighbor ?to ?from), 
;; move_up action has changed: (neighbor ?from ?to), (height ?to ?hto), (height ?to ?hfrom), (at ?from), (is_depot ?to), (height ?to ?hfrom), (height ?from ?hfrom), (height ?to ?hto), (at ?from), (is_depot ?from), (has_block), (has_block), (neighbor ?to ?from), (height ?from ?hto), (height ?from ?hfrom), (at ?to), (neighbor ?to ?from), (is_depot ?to), (height ?from ?hto), (succ ?hfrom ?hto), 
;; place_block action has changed: (succ ?hbefore ?hafter), (is_depot ?bpos), (neighbor ?bpos ?rpos), (height ?rpos ?hafter), (at ?rpos), (is_depot ?rpos), (neighbor ?rpos ?bpos), (at ?rpos), (height ?rpos ?hbefore), (height ?rpos ?hafter), (height ?bpos ?hafter), (height ?bpos ?hbefore), (neighbor ?rpos ?bpos), (has_block), (height ?bpos ?hbefore), (height ?bpos ?hafter), (succ ?hafter ?hbefore), (is_depot ?rpos), (height ?rpos ?hbefore), (succ ?hafter ?hbefore), 
;; destroy_block action has changed: (has_block), (at ?p), (has_block), (is_depot ?p), 
;; create_block action has changed: (at ?p), (has_block), (is_depot ?p), 
;; Last_reduced_capability_num_dropped_pals: None
