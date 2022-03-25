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
			(neighbor ?from ?to)
			(has_block)
			
    )
    :effect
    (and
        (is_depot ?to)
			(is_depot ?from)
			(not (at ?from))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (succ ?hto ?hfrom)
			(is_depot ?from)
			(height ?from ?hfrom)
			(height ?to ?hfrom)
			(at ?from)
			(neighbor ?from ?to)
			(not (succ ?hfrom ?hto))
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (is_depot ?to)
			(not (at ?to))
			(not (is_depot ?from))
			(not (height ?from ?hto))
			(not (height ?to ?hfrom))
			(not (has_block))
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (is_depot ?to)
			(is_depot ?from)
			(not (height ?from ?hfrom))
			(height ?to ?hto)
			(height ?to ?hfrom)
			(at ?from)
			(neighbor ?from ?to)
			(not (has_block))
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(not (succ ?hto ?hfrom))
			(height ?from ?hto)
			(not (at ?from))
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(neighbor ?rpos ?bpos)
			(succ ?hbefore ?hafter)
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(at ?rpos)
			(at ?bpos)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(not (is_depot ?bpos))
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
			(not (height ?bpos ?hafter))
			(not (is_depot ?rpos))
			(not (height ?rpos ?hafter))
			(not (at ?rpos))
			(at ?bpos)
			(not (has_block))
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(neighbor ?rpos ?bpos)
			(height ?bpos ?hafter)
			(neighbor ?bpos ?rpos)
			(is_depot ?rpos)
			(at ?rpos)
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (is_depot ?p)
			
    )
    :effect
    (and
        (not (has_block))
			
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
        (not (has_block))
			
    )
)

)

;; 
;; remove_block action has changed: (succ ?hbefore ?hafter), (has_block), (at ?rpos), (at ?rpos), (at ?bpos), (height ?bpos ?hafter), (height ?rpos ?hafter), (neighbor ?bpos ?rpos), (neighbor ?rpos ?bpos), (is_depot ?rpos), (neighbor ?rpos ?bpos), (has_block), (is_depot ?rpos), 
;; place_block action has changed: (at ?bpos), (neighbor ?rpos ?bpos), (is_depot ?bpos), (at ?rpos), (succ ?hafter ?hbefore), (neighbor ?bpos ?rpos), (height ?bpos ?hafter), (height ?rpos ?hafter), (succ ?hbefore ?hafter), (is_depot ?bpos), (has_block), 
;; move action has changed: (at ?from), (is_depot ?to), (is_depot ?from), (at ?to), (has_block), (at ?to), 
;; create_block action has changed: (has_block), (at ?p), (has_block), 
;; move_down action has changed: (is_depot ?to), (has_block), (height ?to ?hfrom), (succ ?hto ?hfrom), (is_depot ?from), (height ?from ?hto), (at ?to), (is_depot ?to), (height ?from ?hfrom), 
;; move_up action has changed: (height ?to ?hto), (is_depot ?from), (height ?to ?hfrom), (has_block), (is_depot ?from), (is_depot ?to), (height ?to ?hfrom), (succ ?hfrom ?hto), (height ?from ?hto), (at ?from), (at ?to), (neighbor ?to ?from), 
;; destroy_block action has changed: (has_block), 
;; Last_reduced_capability_num_dropped_pals: None
