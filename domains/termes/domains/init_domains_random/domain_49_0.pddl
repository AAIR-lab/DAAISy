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
			(height ?from ?h)
			(not (neighbor ?from ?to))
			(has_block)
			
    )
    :effect
    (and
        (not (at ?from))
			(neighbor ?from ?to)
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(height ?from ?hfrom)
			(height ?to ?hto)
			(neighbor ?from ?to)
			(succ ?hfrom ?hto)
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (is_depot ?to)
			(at ?to)
			(is_depot ?from)
			(not (height ?to ?hto))
			(not (at ?from))
			(not (neighbor ?to ?from))
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (succ ?hto ?hfrom))
			(is_depot ?from)
			(height ?to ?hto)
			(height ?to ?hfrom)
			(at ?from)
			(neighbor ?from ?to)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(at ?to)
			(height ?from ?hfrom)
			(not (height ?to ?hfrom))
			(not (at ?from))
			(has_block)
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(not (neighbor ?rpos ?bpos))
			(not (neighbor ?bpos ?rpos))
			(is_depot ?rpos)
			(at ?rpos)
			(at ?bpos)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(not (succ ?hafter ?hbefore))
			(neighbor ?rpos ?bpos)
			(height ?bpos ?hafter)
			(not (is_depot ?rpos))
			(has_block)
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (not (height ?rpos ?hafter))
			(at ?rpos)
			(has_block)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(is_depot ?bpos)
			(succ ?hafter ?hbefore)
			(height ?bpos ?hafter)
			(height ?rpos ?hbefore)
			(has_block)
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (is_depot ?p)
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
			(not (at ?p))
			(has_block)
			
    )
    :effect
    (and
        (is_depot ?p)
			(not (has_block))
			
    )
)

)

;; 
;; move_up action has changed: (is_depot ?to), (is_depot ?to), (succ ?hto ?hfrom), (neighbor ?to ?from), (neighbor ?to ?from), (at ?from), (is_depot ?from), (height ?to ?hto), (succ ?hfrom ?hto), 
;; place_block action has changed: (is_depot ?bpos), (height ?rpos ?hbefore), (has_block), (is_depot ?rpos), (height ?bpos ?hbefore), (neighbor ?bpos ?rpos), (is_depot ?rpos), (at ?bpos), (succ ?hafter ?hbefore), (has_block), (neighbor ?rpos ?bpos), (neighbor ?rpos ?bpos), 
;; remove_block action has changed: (succ ?hafter ?hbefore), (succ ?hbefore ?hafter), (is_depot ?bpos), (height ?rpos ?hafter), (neighbor ?rpos ?bpos), (height ?bpos ?hbefore), (height ?rpos ?hbefore), 
;; move action has changed: (neighbor ?from ?to), (at ?to), (neighbor ?from ?to), (has_block), (at ?to), (is_depot ?from), (at ?from), 
;; create_block action has changed: (at ?p), 
;; move_down action has changed: (succ ?hto ?hfrom), (height ?from ?hfrom), (height ?from ?hfrom), (has_block), (is_depot ?to), (neighbor ?to ?from), (height ?to ?hfrom), (is_depot ?from), (succ ?hfrom ?hto), (height ?to ?hfrom), 
;; destroy_block action has changed: (is_depot ?p), (is_depot ?p), (at ?p), 
;; Last_reduced_capability_num_dropped_pals: None
