(define (domain termes)
(:requirements :typing :negative-preconditions)
(:types
    numb - object
    position - object
)
(:predicates
    (height ?o1 - position ?o2 - numb)
    (at ?o1 - position)
    (has-block)
    (SUCC ?o1 - numb ?o2 - numb)
    (NEIGHBOR ?o1 - position ?o2 - position)
    (IS-DEPOT ?o1 - position)
)
(:action move
    :parameters (?o1 - position ?o2 - position ?o3 - numb)
    :precondition
    (and
        (at ?o1)
        (NEIGHBOR ?o1 ?o2)
        (height ?o1 ?o3)
        (height ?o2 ?o3)
    )
    :effect
    (and
        (not (at ?o1))
        (at ?o2)
    )
)

(:action move-up
    :parameters (?o1 - position ?o2 - numb ?o3 - position ?o4 - numb)
    :precondition
    (and
        (at ?o1)
        (NEIGHBOR ?o1 ?o3)
        (height ?o1 ?o2)
        (height ?o3 ?o4)
        (SUCC ?o4 ?o2)
    )
    :effect
    (and
        (not (at ?o1))
        (at ?o3)
    )
)

(:action move-down
    :parameters (?o1 - position ?o2 - numb ?o3 - position ?o4 - numb)
    :precondition
    (and
        (at ?o1)
        (NEIGHBOR ?o1 ?o3)
        (height ?o1 ?o2)
        (height ?o3 ?o4)
        (SUCC ?o2 ?o4)
    )
    :effect
    (and
        (not (at ?o1))
        (at ?o3)
    )
)

(:action place-block
    :parameters (?o1 - position ?o2 - position ?o3 - numb ?o4 - numb)
    :precondition
    (and
        (at ?o1)
        (NEIGHBOR ?o1 ?o2)
        (height ?o1 ?o3)
        (height ?o2 ?o3)
        (SUCC ?o4 ?o3)
        (has-block)
        (not (IS-DEPOT ?o2))
    )
    :effect
    (and
        (not (height ?o2 ?o3))
        (height ?o2 ?o4)
        (not (has-block))
    )
)

(:action remove-block
    :parameters (?o1 - position ?o2 - position ?o3 - numb ?o4 - numb)
    :precondition
    (and
        (at ?o1)
        (NEIGHBOR ?o1 ?o2)
        (height ?o1 ?o4)
        (height ?o2 ?o3)
        (SUCC ?o3 ?o4)
        (not (has-block))
    )
    :effect
    (and
        (not (height ?o2 ?o3))
        (height ?o2 ?o4)
        (has-block)
    )
)

(:action create-block
    :parameters (?o1 - position)
    :precondition
    (and
        (at ?o1)
        (not (has-block))
        (IS-DEPOT ?o1)
    )
    :effect
    (and
        (has-block)
    )
)

(:action destroy-block
    :parameters (?o1 - position)
    :precondition
    (and
        (at ?o1)
        (has-block)
        (IS-DEPOT ?o1)
    )
    :effect
    (and
        (not (has-block))
    )
)

)