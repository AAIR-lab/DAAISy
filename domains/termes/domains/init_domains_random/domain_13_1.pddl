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
			(neighbor ?from ?to)
			(not (has_block))
			
    )
    :effect
    (and
        (at ?to)
			(not (at ?from))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (succ ?hto ?hfrom)
			(height ?from ?hto)
			(height ?from ?hfrom)
			(height ?to ?hto)
			(at ?from)
			(neighbor ?from ?to)
			
    )
    :effect
    (and
        (at ?to)
			(not (height ?from ?hfrom))
			(not (height ?to ?hto))
			(not (at ?from))
			
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
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (at ?to)
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
			(succ ?hbefore ?hafter)
			(not (is_depot ?rpos))
			(height ?rpos ?hbefore)
			(at ?rpos)
			(has_block)
			
    )
    :effect
    (and
        (not (succ ?hafter ?hbefore))
			(height ?bpos ?hafter)
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (neighbor ?rpos ?bpos)
			(not (succ ?hbefore ?hafter))
			(height ?rpos ?hafter)
			(at ?rpos)
			(has_block)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(height ?bpos ?hafter)
			(has_block)
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (is_depot ?p)
			(at ?p)
			(has_block)
			
    )
    :effect
    (and
        (not (at ?p))
			(has_block)
			
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
        (not (has_block))
			
    )
)

)

;; 
;; place_block action has changed: (is_depot ?rpos), (height ?bpos ?hbefore), (succ ?hafter ?hbefore), (succ ?hbefore ?hafter), (has_block), 
;; move_up action has changed: (height ?from ?hto), (height ?to ?hto), (height ?from ?hfrom), 
;; remove_block action has changed: (succ ?hbefore ?hafter), (height ?bpos ?hbefore), 
;; move_down action has changed: (height ?to ?hfrom), 
;; move action has changed: (has_block), 
;; create_block action has changed: (at ?p), 
;; Last_reduced_capability_num_dropped_pals: None
