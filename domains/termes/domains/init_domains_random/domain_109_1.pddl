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
        (not (at ?to))
			(not (is_depot ?from))
			(at ?from)
			(height ?from ?h)
			(has_block)
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(not (height ?from ?h))
			(neighbor ?from ?to)
			(not (has_block))
			(not (neighbor ?to ?from))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(not (at ?to))
			(not (succ ?hto ?hfrom))
			(not (is_depot ?from))
			(not (height ?from ?hto))
			(not (height ?from ?hfrom))
			(has_block)
			(not (succ ?hfrom ?hto))
			
    )
    :effect
    (and
        (is_depot ?to)
			(succ ?hto ?hfrom)
			(is_depot ?from)
			(height ?from ?hto)
			(height ?from ?hfrom)
			(height ?to ?hto)
			(height ?to ?hfrom)
			(neighbor ?from ?to)
			(not (has_block))
			(not (neighbor ?to ?from))
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(not (at ?to))
			(not (height ?from ?hto))
			(height ?from ?hfrom)
			(not (neighbor ?from ?to))
			(not (has_block))
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (is_depot ?to)
			(at ?to)
			(not (is_depot ?from))
			(height ?from ?hto)
			(not (height ?from ?hfrom))
			(height ?to ?hto)
			(height ?to ?hfrom)
			(at ?from)
			(neighbor ?from ?to)
			(has_block)
			(neighbor ?to ?from)
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (not (is_depot ?bpos))
			(not (succ ?hafter ?hbefore))
			(not (height ?bpos ?hafter))
			(neighbor ?bpos ?rpos)
			(not (succ ?hbefore ?hafter))
			(is_depot ?rpos)
			(not (height ?rpos ?hafter))
			(at ?rpos)
			(at ?bpos)
			
    )
    :effect
    (and
        (is_depot ?bpos)
			(succ ?hafter ?hbefore)
			(succ ?hbefore ?hafter)
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(not (at ?rpos))
			(not (at ?bpos))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(not (height ?bpos ?hafter))
			(neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
			(not (height ?rpos ?hbefore))
			(not (height ?rpos ?hafter))
			(not (at ?bpos))
			
    )
    :effect
    (and
        (height ?bpos ?hbefore)
			(is_depot ?bpos)
			(not (succ ?hafter ?hbefore))
			(neighbor ?rpos ?bpos)
			(not (neighbor ?bpos ?rpos))
			(not (succ ?hbefore ?hafter))
			(is_depot ?rpos)
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(at ?rpos)
			(not (has_block))
			
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
        (not (is_depot ?p))
			(not (at ?p))
			
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
;; remove_block action has changed: (height ?rpos ?hafter), (height ?bpos ?hbefore), (height ?rpos ?hafter), (at ?bpos), (height ?bpos ?hafter), (neighbor ?rpos ?bpos), (at ?rpos), (is_depot ?bpos), (neighbor ?bpos ?rpos), (height ?rpos ?hbefore), (has_block), (is_depot ?bpos), (succ ?hafter ?hbefore), (has_block), (at ?rpos), (neighbor ?rpos ?bpos), (neighbor ?bpos ?rpos), (is_depot ?rpos), (height ?bpos ?hafter), (succ ?hafter ?hbefore), (succ ?hbefore ?hafter), (height ?bpos ?hbefore), (height ?rpos ?hbefore), 
;; move_up action has changed: (is_depot ?from), (succ ?hto ?hfrom), (succ ?hfrom ?hto), (is_depot ?to), (height ?to ?hto), (succ ?hto ?hfrom), (height ?to ?hto), (height ?from ?hfrom), (at ?from), (height ?from ?hfrom), (has_block), (at ?from), (at ?to), (has_block), (is_depot ?to), (height ?from ?hto), (height ?to ?hfrom), (neighbor ?to ?from), (at ?to), (neighbor ?from ?to), (neighbor ?from ?to), (height ?from ?hto), (is_depot ?from), 
;; place_block action has changed: (is_depot ?bpos), (height ?bpos ?hafter), (succ ?hbefore ?hafter), (has_block), (at ?rpos), (height ?rpos ?hbefore), (neighbor ?rpos ?bpos), (height ?bpos ?hafter), (at ?bpos), (succ ?hafter ?hbefore), (has_block), (height ?rpos ?hbefore), (height ?bpos ?hbefore), (succ ?hbefore ?hafter), (neighbor ?bpos ?rpos), (is_depot ?bpos), (height ?bpos ?hbefore), (at ?bpos), (is_depot ?rpos), (height ?rpos ?hafter), (height ?rpos ?hafter), (succ ?hafter ?hbefore), 
;; move_down action has changed: (has_block), (height ?to ?hto), (height ?from ?hfrom), (neighbor ?from ?to), (is_depot ?to), (at ?from), (succ ?hfrom ?hto), (height ?to ?hto), (at ?from), (neighbor ?to ?from), (neighbor ?to ?from), (is_depot ?from), (height ?from ?hto), (has_block), (neighbor ?from ?to), (height ?to ?hfrom), (at ?to), (height ?from ?hto), (is_depot ?to), 
;; destroy_block action has changed: (at ?p), (is_depot ?p), (has_block), (has_block), (at ?p), (is_depot ?p), 
;; move action has changed: (has_block), (neighbor ?to ?from), (at ?from), (is_depot ?to), (at ?to), (has_block), (at ?to), (height ?to ?h), (height ?from ?h), (neighbor ?from ?to), (is_depot ?from), (neighbor ?from ?to), 
;; create_block action has changed: (has_block), (at ?p), (has_block), (is_depot ?p), 
;; Last_reduced_capability_num_dropped_pals: None
