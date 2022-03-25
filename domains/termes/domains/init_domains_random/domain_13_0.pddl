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
			(is_depot ?from)
			(at ?from)
			(height ?from ?h)
			(neighbor ?from ?to)
			
    )
    :effect
    (and
        (at ?to)
			(not (at ?from))
			(not (neighbor ?to ?from))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(succ ?hto ?hfrom)
			(height ?from ?hfrom)
			(height ?to ?hto)
			(at ?from)
			
    )
    :effect
    (and
        (at ?to)
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (at ?to))
			(height ?from ?hfrom)
			(height ?to ?hto)
			(neighbor ?from ?to)
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (at ?to)
			(not (height ?to ?hto))
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
			(height ?rpos ?hbefore)
			(at ?rpos)
			(has_block)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(height ?bpos ?hafter)
			(not (succ ?hbefore ?hafter))
			(not (is_depot ?rpos))
			(not (has_block))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
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
        (at ?p)
			(has_block)
			
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
			(has_block)
			
    )
    :effect
    (and
        (not (has_block))
			
    )
)

)

;; 
;; move_down action has changed: (at ?to), (height ?to ?hto), (at ?from), 
;; destroy_block action has changed: (is_depot ?p), 
;; place_block action has changed: (succ ?hbefore ?hafter), (is_depot ?rpos), 
;; move_up action has changed: (at ?from), (is_depot ?to), (neighbor ?from ?to), 
;; move action has changed: (neighbor ?to ?from), (is_depot ?from), 
;; create_block action has changed: (is_depot ?p), 
;; remove_block action has changed: (is_depot ?rpos), 
;; Last_reduced_capability_num_dropped_pals: None
