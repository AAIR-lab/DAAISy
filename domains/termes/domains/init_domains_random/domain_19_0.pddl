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
			
    )
    :effect
    (and
        (at ?to)
			(not (is_depot ?from))
			(not (at ?from))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (height ?from ?hfrom)
			(height ?to ?hto)
			(at ?from)
			(neighbor ?from ?to)
			(not (has_block))
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (at ?to)
			(not (height ?from ?hto))
			(not (at ?from))
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (at ?to))
			(not (succ ?hto ?hfrom))
			(height ?from ?hfrom)
			(height ?to ?hto)
			(height ?to ?hfrom)
			(at ?from)
			(neighbor ?from ?to)
			(not (has_block))
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (at ?to)
			(succ ?hto ?hfrom)
			(not (height ?to ?hfrom))
			(not (at ?from))
			(not (succ ?hfrom ?hto))
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(neighbor ?rpos ?bpos)
			(height ?rpos ?hbefore)
			(at ?rpos)
			(has_block)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(not (succ ?hbefore ?hafter))
			(not (has_block))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (neighbor ?rpos ?bpos)
			(succ ?hbefore ?hafter)
			(height ?rpos ?hafter)
			(at ?rpos)
			(has_block)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(height ?bpos ?hafter)
			(is_depot ?rpos)
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
        (not (is_depot ?p))
			(not (has_block))
			
    )
)

)

;; 
;; move_down action has changed: (has_block), (at ?to), (succ ?hto ?hfrom), (succ ?hfrom ?hto), (succ ?hto ?hfrom), (height ?to ?hfrom), (height ?to ?hfrom), 
;; move_up action has changed: (succ ?hfrom ?hto), (has_block), (height ?from ?hto), (succ ?hto ?hfrom), 
;; remove_block action has changed: (height ?bpos ?hbefore), (is_depot ?rpos), 
;; place_block action has changed: (is_depot ?bpos), (succ ?hbefore ?hafter), (height ?bpos ?hafter), 
;; destroy_block action has changed: (is_depot ?p), 
;; create_block action has changed: (at ?p), 
;; move action has changed: (is_depot ?from), 
;; Last_reduced_capability_num_dropped_pals: None
