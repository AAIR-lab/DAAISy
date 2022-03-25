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
			(is_depot ?from)
			(at ?from)
			(height ?from ?h)
			(neighbor ?from ?to)
			
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
        (not (at ?to))
			(succ ?hto ?hfrom)
			(height ?from ?hfrom)
			(height ?to ?hto)
			(at ?from)
			(neighbor ?from ?to)
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (at ?to)
			(not (height ?from ?hfrom))
			(not (at ?from))
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?from))
			(height ?from ?hfrom)
			(not (height ?to ?hto))
			(at ?from)
			(neighbor ?from ?to)
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (at ?to)
			(not (height ?from ?hfrom))
			(has_block)
			
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
			(succ ?hbefore ?hafter)
			(height ?rpos ?hafter)
			(at ?rpos)
			
    )
    :effect
    (and
        (height ?bpos ?hafter)
			(not (at ?rpos))
			(not (has_block))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (not (succ ?hafter ?hbefore))
			(neighbor ?rpos ?bpos)
			(neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
			(height ?rpos ?hafter)
			(at ?rpos)
			(at ?bpos)
			(has_block)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(is_depot ?bpos)
			(height ?bpos ?hafter)
			(not (neighbor ?bpos ?rpos))
			(is_depot ?rpos)
			(not (height ?rpos ?hbefore))
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
;; move_down action has changed: (height ?to ?hto), (is_depot ?from), (at ?from), (height ?from ?hfrom), (has_block), 
;; move action has changed: (at ?to), (is_depot ?from), 
;; move_up action has changed: (at ?to), (neighbor ?to ?from), (height ?from ?hfrom), 
;; place_block action has changed: (succ ?hbefore ?hafter), (height ?rpos ?hafter), (height ?rpos ?hbefore), (has_block), (at ?rpos), (succ ?hafter ?hbefore), (height ?bpos ?hbefore), 
;; remove_block action has changed: (neighbor ?bpos ?rpos), (succ ?hafter ?hbefore), (height ?rpos ?hbefore), (neighbor ?bpos ?rpos), (at ?bpos), (is_depot ?rpos), (height ?bpos ?hbefore), (is_depot ?bpos), 
;; Last_reduced_capability_num_dropped_pals: None
