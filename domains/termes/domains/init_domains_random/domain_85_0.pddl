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
			(not (height ?to ?h))
			(not (at ?to))
			(not (height ?from ?h))
			(not (neighbor ?from ?to))
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (height ?to ?h)
			(at ?to)
			(neighbor ?from ?to)
			(not (has_block))
			(not (neighbor ?to ?from))
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (is_depot ?to)
			(not (is_depot ?from))
			(height ?from ?hto)
			(not (height ?from ?hfrom))
			(not (height ?to ?hfrom))
			(neighbor ?from ?to)
			(not (succ ?hfrom ?hto))
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(not (at ?to))
			(succ ?hto ?hfrom)
			(is_depot ?from)
			(height ?from ?hfrom)
			(at ?from)
			(not (neighbor ?from ?to))
			(has_block)
			(succ ?hfrom ?hto)
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (succ ?hto ?hfrom)
			(not (height ?from ?hfrom))
			(height ?to ?hto)
			(at ?from)
			(neighbor ?from ?to)
			(not (has_block))
			(succ ?hfrom ?hto)
			
    )
    :effect
    (and
        (not (at ?to))
			(not (succ ?hto ?hfrom))
			(not (is_depot ?from))
			(height ?from ?hfrom)
			(not (height ?to ?hto))
			(height ?to ?hfrom)
			(not (at ?from))
			(has_block)
			(not (succ ?hfrom ?hto))
			(neighbor ?to ?from)
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (is_depot ?bpos)
			(succ ?hafter ?hbefore)
			(not (height ?bpos ?hafter))
			(not (neighbor ?bpos ?rpos))
			(not (succ ?hbefore ?hafter))
			(not (height ?rpos ?hbefore))
			(at ?rpos)
			(has_block)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(not (is_depot ?bpos))
			(not (succ ?hafter ?hbefore))
			(neighbor ?rpos ?bpos)
			(neighbor ?bpos ?rpos)
			(not (is_depot ?rpos))
			(height ?rpos ?hbefore)
			(not (height ?rpos ?hafter))
			(not (at ?rpos))
			(not (at ?bpos))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (not (succ ?hafter ?hbefore))
			(not (neighbor ?rpos ?bpos))
			(not (height ?bpos ?hafter))
			(neighbor ?bpos ?rpos)
			(not (succ ?hbefore ?hafter))
			(not (height ?rpos ?hbefore))
			(not (height ?rpos ?hafter))
			(at ?rpos)
			(at ?bpos)
			
    )
    :effect
    (and
        (succ ?hafter ?hbefore)
			(neighbor ?rpos ?bpos)
			(not (neighbor ?bpos ?rpos))
			(succ ?hbefore ?hafter)
			(not (is_depot ?rpos))
			(height ?rpos ?hbefore)
			(not (at ?rpos))
			(has_block)
			
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        (not (is_depot ?p))
			(at ?p)
			
    )
    :effect
    (and
        (is_depot ?p)
			(has_block)
			
    )
)

(:action destroy_block
    :parameters (?p - position)
    :precondition
    (and
        (not (is_depot ?p))
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
;; create_block action has changed: (has_block), (is_depot ?p), (is_depot ?p), 
;; remove_block action has changed: (succ ?hbefore ?hafter), (has_block), (height ?bpos ?hafter), (succ ?hafter ?hbefore), (height ?bpos ?hafter), (at ?bpos), (neighbor ?bpos ?rpos), (height ?bpos ?hbefore), (is_depot ?rpos), (height ?rpos ?hbefore), (height ?rpos ?hbefore), (height ?bpos ?hbefore), (neighbor ?rpos ?bpos), (height ?rpos ?hafter), (neighbor ?bpos ?rpos), (at ?rpos), (neighbor ?rpos ?bpos), (succ ?hbefore ?hafter), (succ ?hafter ?hbefore), 
;; place_block action has changed: (neighbor ?bpos ?rpos), (height ?rpos ?hafter), (height ?bpos ?hafter), (height ?bpos ?hbefore), (succ ?hbefore ?hafter), (height ?bpos ?hafter), (neighbor ?bpos ?rpos), (at ?rpos), (neighbor ?rpos ?bpos), (has_block), (is_depot ?bpos), (succ ?hafter ?hbefore), (height ?rpos ?hbefore), (at ?bpos), (neighbor ?rpos ?bpos), (is_depot ?rpos), (height ?rpos ?hbefore), 
;; move action has changed: (neighbor ?to ?from), (is_depot ?to), (neighbor ?from ?to), (neighbor ?from ?to), (height ?to ?h), (at ?from), (neighbor ?to ?from), (height ?from ?h), (height ?to ?h), (at ?from), (has_block), (at ?to), 
;; move_up action has changed: (is_depot ?to), (has_block), (succ ?hto ?hfrom), (is_depot ?from), (succ ?hfrom ?hto), (height ?to ?hfrom), (neighbor ?to ?from), (succ ?hto ?hfrom), (is_depot ?from), (succ ?hfrom ?hto), (is_depot ?to), (height ?from ?hfrom), (at ?to), (height ?from ?hfrom), (height ?from ?hto), (at ?from), (neighbor ?from ?to), (height ?to ?hto), (at ?from), 
;; destroy_block action has changed: (is_depot ?p), (at ?p), (is_depot ?p), 
;; move_down action has changed: (has_block), (neighbor ?to ?from), (height ?from ?hfrom), (succ ?hto ?hfrom), (is_depot ?from), (height ?from ?hfrom), (height ?to ?hto), (succ ?hfrom ?hto), (succ ?hto ?hfrom), (has_block), (at ?to), (height ?to ?hfrom), 
;; Last_reduced_capability_num_dropped_pals: None
