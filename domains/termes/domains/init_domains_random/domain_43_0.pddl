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
			(neighbor ?from ?to)
			
    )
    :effect
    (and
        (not (height ?to ?h))
			(at ?to)
			(not (at ?from))
			(not (neighbor ?to ?from))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (is_depot ?to)
			(not (at ?to))
			(not (succ ?hto ?hfrom))
			(height ?from ?hto)
			(height ?from ?hfrom)
			(not (height ?to ?hto))
			(at ?from)
			(not (neighbor ?from ?to))
			(not (succ ?hfrom ?hto))
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (at ?to)
			(succ ?hto ?hfrom)
			(is_depot ?from)
			(height ?to ?hfrom)
			(not (at ?from))
			(neighbor ?from ?to)
			(succ ?hfrom ?hto)
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (succ ?hto ?hfrom)
			(not (is_depot ?from))
			(height ?from ?hfrom)
			(height ?to ?hto)
			(height ?to ?hfrom)
			(at ?from)
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (at ?to)
			(not (height ?to ?hto))
			(not (at ?from))
			(not (neighbor ?from ?to))
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(is_depot ?bpos)
			(not (succ ?hafter ?hbefore))
			(neighbor ?rpos ?bpos)
			(not (height ?bpos ?hafter))
			(height ?rpos ?hbefore)
			(at ?rpos)
			(not (at ?bpos))
			(has_block)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(height ?bpos ?hafter)
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(not (height ?bpos ?hafter))
			(not (succ ?hbefore ?hafter))
			(not (height ?rpos ?hafter))
			(at ?rpos)
			(at ?bpos)
			(not (has_block))
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(is_depot ?bpos)
			(not (succ ?hafter ?hbefore))
			(height ?bpos ?hafter)
			(succ ?hbefore ?hafter)
			(not (at ?bpos))
			(has_block)
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (at ?p)
			
    )
    :effect
    (and
        (is_depot ?p)
			
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
        (not (is_depot ?p))
			(not (has_block))
			
    )
)

)

;; 
;; move_down action has changed: (succ ?hto ?hfrom), (is_depot ?from), (neighbor ?from ?to), (neighbor ?from ?to), (height ?to ?hto), (height ?to ?hfrom), 
;; create_block action has changed: (is_depot ?p), (is_depot ?p), (has_block), (has_block), 
;; place_block action has changed: (at ?bpos), (has_block), (succ ?hafter ?hbefore), (height ?bpos ?hafter), 
;; destroy_block action has changed: (is_depot ?p), 
;; move_up action has changed: (height ?from ?hto), (succ ?hfrom ?hto), (at ?to), (neighbor ?from ?to), (neighbor ?to ?from), (height ?to ?hfrom), (height ?to ?hto), (is_depot ?from), (succ ?hto ?hfrom), (succ ?hto ?hfrom), (succ ?hfrom ?hto), (is_depot ?to), (neighbor ?from ?to), 
;; move action has changed: (neighbor ?to ?from), (height ?to ?h), (height ?to ?h), 
;; remove_block action has changed: (height ?bpos ?hafter), (height ?rpos ?hafter), (succ ?hafter ?hbefore), (succ ?hbefore ?hafter), (at ?bpos), (has_block), (neighbor ?rpos ?bpos), (succ ?hbefore ?hafter), (is_depot ?bpos), (at ?bpos), (is_depot ?bpos), (succ ?hafter ?hbefore), 
;; Last_reduced_capability_num_dropped_pals: None
