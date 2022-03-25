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
			(not (height ?from ?h))
			(not (has_block))
			
    )
    :effect
    (and
        (not (height ?to ?h))
			(at ?to)
			(is_depot ?from)
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (at ?to))
			(is_depot ?from)
			(height ?from ?hfrom)
			(height ?to ?hfrom)
			(neighbor ?from ?to)
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (at ?to)
			(not (succ ?hto ?hfrom))
			(not (is_depot ?from))
			(height ?from ?hto)
			(not (height ?from ?hfrom))
			(height ?to ?hto)
			(has_block)
			(not (succ ?hfrom ?hto))
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (at ?to))
			(not (height ?from ?hto))
			(height ?from ?hfrom)
			(not (height ?to ?hto))
			(neighbor ?from ?to)
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (at ?to)
			(succ ?hto ?hfrom)
			(is_depot ?from)
			(not (height ?from ?hfrom))
			(height ?to ?hto)
			(not (neighbor ?from ?to))
			(has_block)
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (is_depot ?bpos)
			(succ ?hafter ?hbefore)
			(not (neighbor ?rpos ?bpos))
			(not (height ?bpos ?hafter))
			(not (height ?rpos ?hbefore))
			(height ?rpos ?hafter)
			(at ?rpos)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(not (is_depot ?bpos))
			(neighbor ?rpos ?bpos)
			(succ ?hbefore ?hafter)
			(height ?rpos ?hbefore)
			(not (has_block))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(not (neighbor ?rpos ?bpos))
			(not (height ?bpos ?hafter))
			(succ ?hbefore ?hafter)
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(at ?rpos)
			(not (at ?bpos))
			(not (has_block))
			
    )
    :effect
    (and
        (is_depot ?bpos)
			(not (succ ?hafter ?hbefore))
			(neighbor ?rpos ?bpos)
			(height ?bpos ?hafter)
			(not (height ?rpos ?hafter))
			(not (at ?rpos))
			
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
        (not (is_depot ?p))
			(at ?p)
			
    )
    :effect
    (and
        (not (has_block))
			
    )
)

)

;; 
;; move_down action has changed: (height ?to ?hto), (height ?from ?hto), (at ?from), (height ?to ?hto), (at ?from), (is_depot ?from), (at ?to), (neighbor ?from ?to), (succ ?hto ?hfrom), (height ?from ?hfrom), (has_block), 
;; move action has changed: (is_depot ?from), (at ?to), (at ?from), (neighbor ?from ?to), (height ?to ?h), (is_depot ?from), (height ?from ?h), (has_block), (at ?from), 
;; move_up action has changed: (at ?to), (has_block), (height ?from ?hfrom), (is_depot ?from), (succ ?hfrom ?hto), (at ?from), (height ?to ?hfrom), (at ?from), (height ?from ?hto), (succ ?hto ?hfrom), (is_depot ?from), (succ ?hto ?hfrom), (height ?to ?hto), (height ?to ?hto), (succ ?hfrom ?hto), 
;; place_block action has changed: (has_block), (height ?bpos ?hafter), (neighbor ?rpos ?bpos), (height ?rpos ?hbefore), (succ ?hbefore ?hafter), (is_depot ?bpos), (height ?rpos ?hafter), (neighbor ?rpos ?bpos), (height ?rpos ?hbefore), (height ?bpos ?hbefore), (height ?bpos ?hafter), 
;; remove_block action has changed: (has_block), (is_depot ?bpos), (height ?bpos ?hafter), (succ ?hafter ?hbefore), (neighbor ?rpos ?bpos), (at ?bpos), (height ?rpos ?hbefore), (neighbor ?rpos ?bpos), (height ?rpos ?hafter), (at ?rpos), (height ?bpos ?hbefore), (has_block), 
;; destroy_block action has changed: (is_depot ?p), (has_block), 
;; create_block action has changed: (has_block), 
;; Last_reduced_capability_num_dropped_pals: None
