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
			(at ?from)
			(height ?from ?h)
			(not (neighbor ?from ?to))
			(has_block)
			
    )
    :effect
    (and
        (not (height ?to ?h))
			(not (is_depot ?from))
			(not (at ?from))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(height ?from ?hto)
			(height ?from ?hfrom)
			(height ?to ?hto)
			(neighbor ?from ?to)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (not (at ?from))
			(neighbor ?to ?from)
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (height ?from ?hfrom)
			(height ?to ?hto)
			(at ?from)
			(neighbor ?from ?to)
			(has_block)
			
    )
    :effect
    (and
        (at ?to)
			(succ ?hto ?hfrom)
			(not (height ?from ?hfrom))
			(not (height ?to ?hfrom))
			(not (at ?from))
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(is_depot ?bpos)
			(succ ?hafter ?hbefore)
			(neighbor ?rpos ?bpos)
			(is_depot ?rpos)
			(height ?rpos ?hbefore)
			(not (height ?rpos ?hafter))
			(at ?rpos)
			(has_block)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(height ?bpos ?hafter)
			(neighbor ?bpos ?rpos)
			(not (height ?rpos ?hbefore))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(neighbor ?rpos ?bpos)
			(not (height ?bpos ?hafter))
			(succ ?hbefore ?hafter)
			(height ?rpos ?hafter)
			(at ?rpos)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(height ?bpos ?hafter)
			(neighbor ?bpos ?rpos)
			(not (succ ?hbefore ?hafter))
			(not (at ?rpos))
			(has_block)
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (at ?p)
			(has_block)
			
    )
    :effect
    (and
        (not (is_depot ?p))
			(has_block)
			
    )
)

(:action destroy_block
    :parameters (?p - position)
    :precondition
    (and
        (is_depot ?p)
			(has_block)
			
    )
    :effect
    (and
        (at ?p)
			(not (has_block))
			
    )
)

)

;; 
;; remove_block action has changed: (succ ?hbefore ?hafter), (has_block), (neighbor ?bpos ?rpos), (height ?bpos ?hafter), (at ?rpos), 
;; move_down action has changed: (height ?from ?hfrom), (height ?to ?hfrom), (succ ?hfrom ?hto), (has_block), (succ ?hto ?hfrom), 
;; move action has changed: (at ?to), (is_depot ?from), (height ?to ?h), (neighbor ?from ?to), (has_block), 
;; place_block action has changed: (height ?rpos ?hbefore), (neighbor ?bpos ?rpos), (has_block), (is_depot ?rpos), (height ?rpos ?hafter), 
;; destroy_block action has changed: (at ?p), (at ?p), 
;; move_up action has changed: (at ?from), (neighbor ?to ?from), (neighbor ?to ?from), (is_depot ?to), (succ ?hto ?hfrom), (height ?from ?hto), (at ?to), 
;; create_block action has changed: (is_depot ?p), (is_depot ?p), 
;; Last_reduced_capability_num_dropped_pals: None
