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
			(height ?from ?h)
			(neighbor ?from ?to)
			(not (has_block))
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (is_depot ?to)
			(at ?to)
			(not (at ?from))
			(not (height ?from ?h))
			(not (neighbor ?from ?to))
			(has_block)
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (is_depot ?to))
			(not (succ ?hto ?hfrom))
			(not (height ?from ?hfrom))
			(height ?to ?hto)
			(not (height ?to ?hfrom))
			(at ?from)
			(has_block)
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (succ ?hto ?hfrom)
			(not (is_depot ?from))
			(not (at ?from))
			(not (neighbor ?from ?to))
			(succ ?hfrom ?hto)
			(neighbor ?to ?from)
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (at ?to))
			(height ?to ?hto)
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (not (succ ?hto ?hfrom))
			(not (height ?to ?hto))
			(height ?to ?hfrom)
			(not (at ?from))
			(has_block)
			(not (succ ?hfrom ?hto))
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (is_depot ?bpos)
			(neighbor ?rpos ?bpos)
			(not (neighbor ?bpos ?rpos))
			(succ ?hbefore ?hafter)
			(not (height ?rpos ?hafter))
			(at ?rpos)
			(has_block)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(not (is_depot ?bpos))
			(not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(not (height ?bpos ?hafter))
			(neighbor ?bpos ?rpos)
			(not (at ?rpos))
			(not (has_block))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(not (neighbor ?rpos ?bpos))
			(neighbor ?bpos ?rpos)
			(succ ?hbefore ?hafter)
			(height ?rpos ?hafter)
			(at ?rpos)
			(at ?bpos)
			(not (has_block))
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(neighbor ?rpos ?bpos)
			(not (height ?bpos ?hafter))
			(not (succ ?hbefore ?hafter))
			(is_depot ?rpos)
			(not (height ?rpos ?hafter))
			(not (at ?bpos))
			(has_block)
			
    )
)

(:action create_block
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
			(has_block)
			
    )
)

(:action destroy_block
    :parameters (?p - position)
    :precondition
    (and
        (not (is_depot ?p))
			
    )
    :effect
    (and
        (is_depot ?p)
			(not (has_block))
			
    )
)

)

;; 
;; move_down action has changed: (height ?to ?hto), (succ ?hto ?hfrom), (at ?to), (at ?from), (has_block), (height ?to ?hfrom), (succ ?hfrom ?hto), (neighbor ?from ?to), (at ?to), (height ?from ?hfrom), 
;; place_block action has changed: (is_depot ?bpos), (height ?bpos ?hbefore), (neighbor ?bpos ?rpos), (neighbor ?rpos ?bpos), (succ ?hafter ?hbefore), (height ?rpos ?hbefore), (neighbor ?bpos ?rpos), (height ?bpos ?hafter), (at ?rpos), (succ ?hafter ?hbefore), (succ ?hbefore ?hafter), (height ?rpos ?hafter), 
;; destroy_block action has changed: (is_depot ?p), (at ?p), (has_block), (is_depot ?p), 
;; move_up action has changed: (height ?from ?hfrom), (succ ?hfrom ?hto), (has_block), (neighbor ?from ?to), (height ?to ?hfrom), (is_depot ?from), (succ ?hto ?hfrom), (is_depot ?to), (neighbor ?to ?from), (neighbor ?to ?from), (neighbor ?from ?to), (at ?to), (succ ?hto ?hfrom), 
;; remove_block action has changed: (succ ?hbefore ?hafter), (neighbor ?bpos ?rpos), (has_block), (neighbor ?rpos ?bpos), (is_depot ?rpos), (neighbor ?rpos ?bpos), (at ?bpos), (height ?rpos ?hafter), (at ?bpos), (height ?bpos ?hafter), 
;; move action has changed: (neighbor ?from ?to), (has_block), (neighbor ?to ?from), (has_block), (height ?from ?h), (is_depot ?to), (at ?from), 
;; create_block action has changed: (is_depot ?p), (at ?p), (is_depot ?p), (at ?p), (has_block), 
;; Last_reduced_capability_num_dropped_pals: None
