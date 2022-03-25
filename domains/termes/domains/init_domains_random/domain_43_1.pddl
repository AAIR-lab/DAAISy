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
        (not (height ?to ?h))
			(at ?to)
			(not (at ?from))
			(not (height ?from ?h))
			(has_block)
			
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (succ ?hto ?hfrom)
			(is_depot ?from)
			(height ?from ?hfrom)
			(height ?to ?hto)
			(at ?from)
			(neighbor ?from ?to)
			(not (has_block))
			(not (neighbor ?to ?from))
			
    )
    :effect
    (and
        (not (is_depot ?to))
			(not (at ?to))
			(not (succ ?hto ?hfrom))
			(not (is_depot ?from))
			(not (at ?from))
			(not (neighbor ?from ?to))
			
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        (not (at ?to))
			(succ ?hto ?hfrom)
			(not (is_depot ?from))
			(height ?from ?hfrom)
			(height ?to ?hto)
			(not (height ?to ?hfrom))
			(at ?from)
			(neighbor ?from ?to)
			(succ ?hfrom ?hto)
			(neighbor ?to ?from)
			
    )
    :effect
    (and
        (not (succ ?hto ?hfrom))
			(is_depot ?from)
			(not (at ?from))
			(not (neighbor ?from ?to))
			(not (has_block))
			
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(not (is_depot ?bpos))
			(succ ?hafter ?hbefore)
			(not (neighbor ?rpos ?bpos))
			(not (height ?bpos ?hafter))
			(not (height ?rpos ?hbefore))
			(height ?rpos ?hafter)
			(not (at ?rpos))
			(at ?bpos)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(is_depot ?bpos)
			(not (succ ?hafter ?hbefore))
			(neighbor ?rpos ?bpos)
			(not (has_block))
			
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        (height ?bpos ?hbefore)
			(is_depot ?bpos)
			(not (succ ?hafter ?hbefore))
			(neighbor ?rpos ?bpos)
			(succ ?hbefore ?hafter)
			(is_depot ?rpos)
			(at ?rpos)
			(not (at ?bpos))
			(has_block)
			
    )
    :effect
    (and
        (not (height ?bpos ?hbefore))
			(succ ?hafter ?hbefore)
			(not (neighbor ?rpos ?bpos))
			(height ?bpos ?hafter)
			(not (succ ?hbefore ?hafter))
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
			(has_block)
			
    )
    :effect
    (and
        (not (at ?p))
			(not (has_block))
			
    )
)

)

;; 
;; move action has changed: (height ?to ?h), (height ?from ?h), (has_block), 
;; remove_block action has changed: (succ ?hafter ?hbefore), (is_depot ?bpos), (neighbor ?rpos ?bpos), (height ?rpos ?hafter), (succ ?hafter ?hbefore), (succ ?hbefore ?hafter), (at ?bpos), (is_depot ?rpos), 
;; place_block action has changed: (neighbor ?rpos ?bpos), (succ ?hafter ?hbefore), (neighbor ?rpos ?bpos), (at ?rpos), (is_depot ?bpos), (height ?rpos ?hafter), (is_depot ?bpos), (has_block), (height ?bpos ?hafter), (at ?bpos), (height ?rpos ?hbefore), (height ?bpos ?hafter), 
;; move_up action has changed: (is_depot ?from), (neighbor ?to ?from), (at ?to), (neighbor ?from ?to), (succ ?hto ?hfrom), (is_depot ?from), (is_depot ?to), (has_block), 
;; move_down action has changed: (succ ?hto ?hfrom), (succ ?hto ?hfrom), (at ?to), (at ?to), (neighbor ?to ?from), (height ?to ?hfrom), (is_depot ?from), (is_depot ?from), (has_block), (neighbor ?from ?to), 
;; destroy_block action has changed: (at ?p), (at ?p), 
;; Last_reduced_capability_num_dropped_pals: None
