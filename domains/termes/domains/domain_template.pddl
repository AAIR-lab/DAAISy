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
        %MOVE PRECONDITION%
    )
    :effect
    (and
        %MOVE EFFECTS%
    )
)

(:action move_up
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        %MOVE_UP PRECONDITION%
    )
    :effect
    (and
        %MOVE_UP EFFECTS%
    )
)

(:action move_down
    :parameters (?from - position ?hfrom - numb ?to - position ?hto - numb)
    :precondition
    (and
        %MOVE_DOWN PRECONDITION%
    )
    :effect
    (and
        %MOVE_DOWN EFFECTS%
    )
)

(:action place_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        %PLACE_BLOCK PRECONDITION%
    )
    :effect
    (and
        %PLACE_BLOCK EFFECTS%
    )
)

(:action remove_block
    :parameters (?rpos - position ?bpos - position ?hbefore - numb ?hafter - numb)
    :precondition
    (and
        %REMOVE_BLOCK PRECONDITION%
    )
    :effect
    (and
        %REMOVE_BLOCK EFFECTS%
    )
)

(:action create_block
    :parameters (?p - position)
    :precondition
    (and
        %CREATE_BLOCK PRECONDITION%
    )
    :effect
    (and
        %CREATE_BLOCK EFFECTS%
    )
)

(:action destroy_block
    :parameters (?p - position)
    :precondition
    (and
        %DESTROY_BLOCK PRECONDITION%
    )
    :effect
    (and
        %DESTROY_BLOCK EFFECTS%
    )
)

)

;; %INFO_STRING%