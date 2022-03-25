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
			(height ?from ?h)
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(at ?to)
			(at ?from)
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (is_depot ?to)
			(succ ?hto ?hfrom)
			(is_depot ?from)
			(height ?from ?hto)
			(not (height ?from ?hfrom))
			(height ?to ?hto)
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(at ?to)
			(not (height ?to ?hto))
			(not (at ?from))
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (is_depot ?from)
			(height ?from ?hto)
			(height ?from ?hfrom)
			(height ?to ?hto)
			(at ?from)
			(neighbor ?from ?to)
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (succ ?hto ?hfrom)
			(not (is_depot ?from))
			(not (at ?from))
			(has_block)
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(is_depot ?bpos)
			(succ ?hafter ?hbefore)
			(not (succ ?hbefore ?hafter))
			(at ?rpos)
			(has_block)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(neighbor ?rpos ?bpos)
			(height ?bpos ?hafter)
			(not (is_depot ?rpos))
			(not (at ?rpos))
			(not (has_block))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(not (height ?bpos ?hafter))
			(not (neighbor ?bpos ?rpos))
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(at ?rpos)
			(not (has_block))
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(not (neighbor ?rpos ?bpos))
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
			(not (has_block))
			
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
			
    )
    :effect
    (and
        (not (is_depot ?p))
			
    )
)

)

;; 
;; place_block action has changed: (is_depot ?rpos), (neighbor ?rpos ?bpos), (at ?rpos), (succ ?hbefore ?hafter), (height ?rpos ?hbefore), (neighbor ?rpos ?bpos), 
;; move_up action has changed: (is_depot ?to), (is_depot ?to), (height ?from ?hfrom), (at ?from), (neighbor ?from ?to), (height ?to ?hto), (is_depot ?from), (height ?from ?hto), 
;; destroy_block action has changed: (has_block), (is_depot ?p), (has_block), 
;; move action has changed: (neighbor ?from ?to), (is_depot ?to), (at ?to), (at ?from), (at ?from), 
;; move_down action has changed: (is_depot ?from), (succ ?hto ?hfrom), (at ?to), (is_depot ?from), (height ?from ?hto), (has_block), 
;; remove_block action has changed: (height ?bpos ?hafter), (neighbor ?rpos ?bpos), (succ ?hbefore ?hafter), (neighbor ?rpos ?bpos), (height ?rpos ?hbefore), (neighbor ?bpos ?rpos), (has_block), 
;; create_block action has changed: (at ?p), (has_block), 
;; Last_reduced_capability_num_dropped_pals: None
