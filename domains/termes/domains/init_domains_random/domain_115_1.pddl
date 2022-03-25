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
			(at ?from)
			(not (height ?from ?h))
			(not (neighbor ?from ?to))
			(not (has_block))
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(height ?to ?h)
			(not (is_depot ?from))
			(height ?from ?h)
			(neighbor ?from ?to)
			(has_block)
			(neighbor ?to ?from)
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (is_depot ?to)
			(not (succ ?hto ?hfrom))
			(not (is_depot ?from))
			(not (height ?from ?hto))
			(not (height ?from ?hfrom))
			(not (height ?to ?hfrom))
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(is_depot ?from)
			(height ?from ?hto)
			(height ?from ?hfrom)
			(height ?to ?hto)
			(height ?to ?hfrom)
			(not (at ?from))
			(neighbor ?from ?to)
			(has_block)
			(not (succ ?hfrom ?hto))
			(not (neighbor ?to ?from))
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(not (at ?to))
			(succ ?hto ?hfrom)
			(is_depot ?from)
			(height ?from ?hto)
			(not (height ?to ?hfrom))
			(not (has_block))
			(not (succ ?hfrom ?hto))
			
    )
    :effect
    (and
        (is_depot ?to)
			(not (succ ?hto ?hfrom))
			(not (height ?from ?hto))
			(height ?to ?hto)
			(height ?to ?hfrom)
			(at ?from)
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
        (height ?bpos ?hbefore)
			(not (succ ?hafter ?hbefore))
			(neighbor ?rpos ?bpos)
			(not (height ?bpos ?hafter))
			(neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
			(not (is_depot ?rpos))
			(not (height ?rpos ?hbefore))
			(height ?rpos ?hafter)
			(at ?rpos)
			(at ?bpos)
			(has_block)
			
    )
    :effect
    (and
        (not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(not (neighbor ?rpos ?bpos))
			(not (neighbor ?bpos ?rpos))
			(not (succ ?hbefore ?hafter))
			(is_depot ?rpos)
			(height ?rpos ?hbefore)
			(not (height ?rpos ?hafter))
			(not (at ?rpos))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (is_depot ?bpos)
			(not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(not (neighbor ?bpos ?rpos))
			(not (succ ?hbefore ?hafter))
			(is_depot ?rpos)
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(at ?bpos)
			
    )
    :effect
    (and
        (not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(neighbor ?rpos ?bpos)
			(not (height ?bpos ?hafter))
			(neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
			(not (height ?rpos ?hbefore))
			(not (height ?rpos ?hafter))
			(at ?rpos)
			(not (at ?bpos))
			(not (has_block))
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (not (is_depot ?p))
			
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
        (not (is_depot ?p))
			(not (at ?p))
			
    )
    :effect
    (and
        (is_depot ?p)
			(at ?p)
			
    )
)

)

;; 
;; move_down action has changed: (succ ?hto ?hfrom), (neighbor ?to ?from), (height ?to ?hto), (height ?to ?hfrom), (at ?from), (height ?to ?hfrom), (is_depot ?to), (height ?from ?hto), (at ?from), (has_block), (succ ?hfrom ?hto), (succ ?hfrom ?hto), (has_block), (is_depot ?from), (neighbor ?from ?to), (at ?to), (height ?to ?hto), (at ?to), (succ ?hto ?hfrom), (is_depot ?to), (neighbor ?from ?to), (height ?from ?hto), (height ?from ?hfrom), 
;; move_up action has changed: (neighbor ?from ?to), (is_depot ?to), (height ?from ?hfrom), (succ ?hto ?hfrom), (at ?to), (height ?from ?hto), (is_depot ?from), (has_block), (neighbor ?from ?to), (height ?to ?hto), (height ?to ?hfrom), (height ?to ?hfrom), (neighbor ?to ?from), (height ?from ?hfrom), (is_depot ?to), (height ?from ?hto), (succ ?hfrom ?hto), (at ?from), (succ ?hfrom ?hto), (height ?to ?hto), (is_depot ?from), 
;; place_block action has changed: (height ?rpos ?hafter), (height ?rpos ?hafter), (neighbor ?bpos ?rpos), (height ?rpos ?hbefore), (succ ?hafter ?hbefore), (is_depot ?bpos), (neighbor ?bpos ?rpos), (is_depot ?bpos), (succ ?hbefore ?hafter), (is_depot ?rpos), (is_depot ?rpos), (height ?bpos ?hafter), (succ ?hafter ?hbefore), (at ?bpos), (at ?rpos), (height ?rpos ?hbefore), (height ?bpos ?hbefore), (height ?bpos ?hafter), (has_block), (neighbor ?rpos ?bpos), (succ ?hbefore ?hafter), 
;; destroy_block action has changed: (has_block), (has_block), (is_depot ?p), (at ?p), (is_depot ?p), (at ?p), 
;; remove_block action has changed: (at ?bpos), (has_block), (height ?rpos ?hbefore), (height ?bpos ?hbefore), (is_depot ?rpos), (neighbor ?bpos ?rpos), (at ?rpos), (succ ?hafter ?hbefore), (at ?rpos), (has_block), (neighbor ?rpos ?bpos), (height ?bpos ?hbefore), (at ?bpos), (neighbor ?bpos ?rpos), (is_depot ?bpos), (succ ?hbefore ?hafter), (height ?rpos ?hbefore), (neighbor ?rpos ?bpos), (height ?rpos ?hafter), (is_depot ?bpos), (succ ?hafter ?hbefore), (height ?bpos ?hafter), (succ ?hbefore ?hafter), 
;; move action has changed: (neighbor ?from ?to), (at ?to), (has_block), (height ?from ?h), (is_depot ?to), (height ?from ?h), (at ?to), (neighbor ?to ?from), (at ?from), (height ?to ?h), (has_block), (neighbor ?to ?from), (height ?to ?h), (is_depot ?to), (neighbor ?from ?to), (is_depot ?from), 
;; create_block action has changed: (is_depot ?p), (has_block), (at ?p), (at ?p), (has_block), 
;; Last_reduced_capability_num_dropped_pals: None
