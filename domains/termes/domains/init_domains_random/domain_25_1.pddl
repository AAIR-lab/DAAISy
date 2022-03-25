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
        (not (is_depot ?to))
			(height ?to ?h)
			(not (is_depot ?from))
			(height ?from ?h)
			(has_block)
			
    )
    :effect
    (and
        (at ?to)
			(at ?from)
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (succ ?hto ?hfrom)
			(height ?from ?hfrom)
			(height ?to ?hto)
			(at ?from)
			(neighbor ?from ?to)
			(not (has_block))
			(neighbor ?to ?from)
			
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
        (height ?from ?hfrom)
			(height ?to ?hto)
			(at ?from)
			(not (neighbor ?from ?to))
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (at ?to)
			(not (succ ?hto ?hfrom))
			(height ?from ?hto)
			(height ?to ?hfrom)
			(not (at ?from))
			(neighbor ?from ?to)
			
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
			(neighbor ?bpos ?rpos)
			(not (succ ?hbefore ?hafter))
			(not (is_depot ?rpos))
			(height ?rpos ?hbefore)
			(at ?rpos)
			(has_block)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(height ?bpos ?hafter)
			(is_depot ?rpos)
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
			(not (is_depot ?rpos))
			(height ?rpos ?hbefore)
			(height ?rpos ?hafter)
			(at ?rpos)
			(not (at ?bpos))
			(has_block)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(not (is_depot ?bpos))
			(height ?bpos ?hafter)
			(is_depot ?rpos)
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (not (is_depot ?p))
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
;; place_block action has changed: (is_depot ?rpos), (neighbor ?bpos ?rpos), (succ ?hbefore ?hafter), (is_depot ?rpos), 
;; remove_block action has changed: (height ?rpos ?hbefore), (is_depot ?bpos), (has_block), (at ?bpos), (is_depot ?rpos), (is_depot ?rpos), 
;; move_up action has changed: (has_block), (neighbor ?to ?from), (at ?from), 
;; move action has changed: (at ?from), (is_depot ?from), (is_depot ?to), (at ?from), (has_block), (neighbor ?from ?to), 
;; move_down action has changed: (neighbor ?from ?to), (height ?from ?hto), (height ?to ?hfrom), (succ ?hto ?hfrom), (neighbor ?from ?to), 
;; create_block action has changed: (is_depot ?p), 
;; Last_reduced_capability_num_dropped_pals: None
