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
			(not (is_depot ?from))
			(at ?from)
			(height ?from ?h)
			(neighbor ?from ?to)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (is_depot ?to)
			(height ?to ?h)
			(is_depot ?from)
			(not (neighbor ?from ?to))
			(has_block)
			(neighbor ?to ?from)
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (is_depot ?to)
			(not (at ?to))
			(succ ?hto ?hfrom)
			(not (is_depot ?from))
			(height ?from ?hto)
			(not (height ?from ?hfrom))
			(not (height ?to ?hto))
			(not (height ?to ?hfrom))
			(not (neighbor ?from ?to))
			(not (has_block))
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(not (succ ?hto ?hfrom))
			(not (height ?from ?hto))
			(height ?to ?hto)
			(not (at ?from))
			(has_block)
			(succ ?hfrom ?hto)
			(not (neighbor ?to ?from))
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (at ?to))
			(not (succ ?hto ?hfrom))
			(is_depot ?from)
			(height ?from ?hto)
			(height ?from ?hfrom)
			(height ?to ?hto)
			(at ?from)
			(not (has_block))
			(not (succ ?hfrom ?hto))
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(succ ?hto ?hfrom)
			(not (is_depot ?from))
			(not (height ?from ?hto))
			(not (height ?from ?hfrom))
			(not (height ?to ?hto))
			(height ?to ?hfrom)
			(not (neighbor ?from ?to))
			(succ ?hfrom ?hto)
			(not (neighbor ?to ?from))
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (is_depot ?bpos)
			(not (height ?bpos ?hafter))
			(not (neighbor ?bpos ?rpos))
			(is_depot ?rpos)
			(not (height ?rpos ?hafter))
			(not (at ?bpos))
			
    )
    :effect
    (and
        (not (is_depot ?bpos))
			(not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(height ?bpos ?hafter)
			(neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
			(not (is_depot ?rpos))
			(not (height ?rpos ?hbefore))
			(height ?rpos ?hafter)
			(at ?bpos)
			
    )
)

(:action remove_block
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
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(at ?rpos)
			(at ?bpos)
			(has_block)
			
    )
    :effect
    (and
        (not (is_depot ?bpos))
			(neighbor ?rpos ?bpos)
			(not (neighbor ?bpos ?rpos))
			(not (succ ?hbefore ?hafter))
			(is_depot ?rpos)
			(not (height ?rpos ?hbefore))
			(not (height ?rpos ?hafter))
			(not (at ?rpos))
			(not (has_block))
			
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
        (not (is_depot ?p))
			(at ?p)
			
    )
)

(:action destroy_block
    :parameters (?p - position)
    :precondition
    (and
        (not (at ?p))
			(has_block)
			
    )
    :effect
    (and
        (not (is_depot ?p))
			(at ?p)
			
    )
)

)

;; 
;; remove_block action has changed: (height ?rpos ?hbefore), (height ?rpos ?hafter), (neighbor ?bpos ?rpos), (height ?bpos ?hafter), (succ ?hbefore ?hafter), (neighbor ?rpos ?bpos), (height ?bpos ?hbefore), (succ ?hafter ?hbefore), (height ?bpos ?hafter), (at ?bpos), (at ?rpos), (has_block), (is_depot ?bpos), (height ?rpos ?hbefore), (neighbor ?rpos ?bpos), (is_depot ?rpos), (neighbor ?bpos ?rpos), (is_depot ?bpos), 
;; move_up action has changed: (height ?to ?hfrom), (at ?from), (succ ?hto ?hfrom), (neighbor ?to ?from), (height ?to ?hto), (neighbor ?from ?to), (is_depot ?to), (is_depot ?from), (height ?from ?hto), (at ?to), (height ?to ?hto), (has_block), (has_block), (neighbor ?to ?from), (height ?from ?hto), (succ ?hfrom ?hto), (at ?to), (height ?from ?hfrom), (is_depot ?to), 
;; move_down action has changed: (height ?from ?hfrom), (height ?to ?hfrom), (succ ?hfrom ?hto), (at ?from), (at ?to), (is_depot ?from), (is_depot ?from), (succ ?hfrom ?hto), (neighbor ?to ?from), (neighbor ?to ?from), (neighbor ?from ?to), (height ?from ?hto), (is_depot ?to), (succ ?hto ?hfrom), (at ?to), (neighbor ?from ?to), (height ?to ?hto), (has_block), (height ?from ?hto), (succ ?hto ?hfrom), 
;; move action has changed: (at ?to), (at ?to), (at ?from), (neighbor ?to ?from), (neighbor ?to ?from), (is_depot ?to), (neighbor ?from ?to), (height ?to ?h), (is_depot ?from), (is_depot ?to), (is_depot ?from), (height ?to ?h), (has_block), 
;; place_block action has changed: (neighbor ?rpos ?bpos), (neighbor ?rpos ?bpos), (height ?bpos ?hafter), (height ?bpos ?hbefore), (height ?rpos ?hafter), (at ?bpos), (has_block), (is_depot ?rpos), (has_block), (succ ?hbefore ?hafter), (height ?bpos ?hbefore), (neighbor ?bpos ?rpos), (height ?rpos ?hafter), (height ?rpos ?hbefore), (is_depot ?bpos), (neighbor ?bpos ?rpos), (is_depot ?rpos), (at ?rpos), (succ ?hafter ?hbefore), (height ?rpos ?hbefore), (at ?bpos), (succ ?hafter ?hbefore), 
;; create_block action has changed: (at ?p), (is_depot ?p), (has_block), (is_depot ?p), (has_block), (at ?p), 
;; destroy_block action has changed: (at ?p), (has_block), (is_depot ?p), (is_depot ?p), (at ?p), 
;; Last_reduced_capability_num_dropped_pals: None
