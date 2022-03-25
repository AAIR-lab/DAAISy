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
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (is_depot ?to)
			(not (height ?to ?h))
			(at ?from)
			(neighbor ?to ?from)
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(not (succ ?hto ?hfrom))
			(is_depot ?from)
			(height ?from ?hto)
			(not (height ?from ?hfrom))
			(height ?to ?hfrom)
			(neighbor ?from ?to)
			(succ ?hfrom ?hto)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (is_depot ?to)
			(at ?to)
			(succ ?hto ?hfrom)
			(not (height ?from ?hto))
			(height ?to ?hto)
			(at ?from)
			(not (neighbor ?from ?to))
			(not (has_block))
			(not (succ ?hfrom ?hto))
			(neighbor ?to ?from)
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(not (at ?to))
			(not (succ ?hto ?hfrom))
			(not (is_depot ?from))
			(height ?from ?hto)
			(not (height ?to ?hto))
			(not (neighbor ?from ?to))
			(not (has_block))
			(succ ?hfrom ?hto)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (is_depot ?to)
			(at ?to)
			(succ ?hto ?hfrom)
			(is_depot ?from)
			(height ?to ?hto)
			(not (height ?to ?hfrom))
			(neighbor ?from ?to)
			(has_block)
			(not (succ ?hfrom ?hto))
			(neighbor ?to ?from)
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (neighbor ?bpos ?rpos)
			(is_depot ?rpos)
			(not (height ?rpos ?hbefore))
			(not (height ?rpos ?hafter))
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(is_depot ?bpos)
			(not (succ ?hafter ?hbefore))
			(neighbor ?rpos ?bpos)
			(succ ?hbefore ?hafter)
			(not (is_depot ?rpos))
			(height ?rpos ?hafter)
			(has_block)
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (not (is_depot ?bpos))
			(neighbor ?rpos ?bpos)
			(not (height ?bpos ?hafter))
			(neighbor ?bpos ?rpos)
			(not (is_depot ?rpos))
			(height ?rpos ?hbefore)
			(not (height ?rpos ?hafter))
			(not (at ?rpos))
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(is_depot ?bpos)
			(not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(not (neighbor ?bpos ?rpos))
			(succ ?hbefore ?hafter)
			(is_depot ?rpos)
			(height ?rpos ?hafter)
			(not (at ?bpos))
			(not (has_block))
			
    )
)

(:action create_block
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

(:action destroy_block
    :parameters (?p - position)
    :precondition
    (and
        (not (at ?p))
			
    )
    :effect
    (and
        (not (has_block))
			
    )
)

)

;; 
;; move_up action has changed: (succ ?hfrom ?hto), (height ?to ?hto), (is_depot ?to), (height ?from ?hto), (neighbor ?to ?from), (height ?from ?hfrom), (is_depot ?to), (succ ?hto ?hfrom), (has_block), (succ ?hto ?hfrom), (neighbor ?from ?to), (succ ?hfrom ?hto), (height ?to ?hto), (at ?from), (height ?from ?hto), (is_depot ?from), (at ?from), (neighbor ?to ?from), (height ?to ?hfrom), 
;; create_block action has changed: (has_block), (is_depot ?p), (at ?p), (has_block), (is_depot ?p), (at ?p), 
;; move_down action has changed: (height ?to ?hto), (neighbor ?to ?from), (height ?to ?hto), (at ?from), (has_block), (height ?from ?hfrom), (at ?from), (has_block), (height ?to ?hfrom), (is_depot ?from), (is_depot ?to), (is_depot ?from), (height ?from ?hto), (succ ?hfrom ?hto), (neighbor ?from ?to), (neighbor ?from ?to), (succ ?hto ?hfrom), (neighbor ?to ?from), (at ?to), (succ ?hto ?hfrom), (is_depot ?to), 
;; move action has changed: (neighbor ?to ?from), (neighbor ?to ?from), (at ?from), (is_depot ?to), (at ?from), (is_depot ?to), (at ?to), (at ?to), (neighbor ?from ?to), (height ?to ?h), 
;; place_block action has changed: (neighbor ?bpos ?rpos), (has_block), (height ?rpos ?hafter), (succ ?hafter ?hbefore), (height ?rpos ?hbefore), (height ?rpos ?hafter), (is_depot ?bpos), (is_depot ?rpos), (is_depot ?rpos), (has_block), (height ?bpos ?hbefore), (succ ?hbefore ?hafter), (succ ?hafter ?hbefore), (neighbor ?rpos ?bpos), (at ?rpos), (neighbor ?rpos ?bpos), (is_depot ?bpos), (height ?bpos ?hafter), 
;; destroy_block action has changed: (at ?p), (is_depot ?p), (has_block), 
;; remove_block action has changed: (height ?bpos ?hafter), (has_block), (is_depot ?rpos), (succ ?hbefore ?hafter), (at ?bpos), (height ?bpos ?hafter), (height ?rpos ?hbefore), (is_depot ?rpos), (is_depot ?bpos), (height ?rpos ?hafter), (height ?bpos ?hbefore), (has_block), (succ ?hbefore ?hafter), (neighbor ?rpos ?bpos), (neighbor ?bpos ?rpos), (is_depot ?bpos), (at ?rpos), (height ?rpos ?hafter), (neighbor ?bpos ?rpos), (succ ?hafter ?hbefore), 
;; Last_reduced_capability_num_dropped_pals: None
