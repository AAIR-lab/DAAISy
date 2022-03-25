(define (problem termes-00072-0048-4x3x4-random_towers_4x3_4_1_12)
(:domain termes)
; termes-00072-0048-4x3x4-random_towers_4x3_4_1_12
; Initial state:
;  0   0  R0D  0
;  0   0   0   0
;  0   0   0   0
; Goal state:
;  0   0   0   0
;  0   0   0   4
;  0   0   0   0
; Maximal height: 4
(:objects
    n0 - numb
    n1 - numb
    n2 - numb
    n3 - numb
    n4 - numb
    pos_0_0 - position
    pos_0_1 - position
    pos_0_2 - position
    pos_1_0 - position
    pos_1_1 - position
    pos_1_2 - position
    pos_2_0 - position
    pos_2_1 - position
    pos_2_2 - position
    pos_3_0 - position
    pos_3_1 - position
    pos_3_2 - position
)
(:init
    (height pos_0_0 n0)
    (height pos_0_1 n0)
    (height pos_0_2 n0)
    (height pos_1_0 n0)
    (height pos_1_1 n0)
    (height pos_1_2 n0)
    (height pos_2_0 n0)
    (height pos_2_1 n0)
    (height pos_2_2 n0)
    (height pos_3_0 n0)
    (height pos_3_1 n0)
    (height pos_3_2 n0)
    (at pos_2_0)
    (SUCC n1 n0)
    (SUCC n2 n1)
    (SUCC n3 n2)
    (SUCC n4 n3)
    (NEIGHBOR pos_0_0 pos_1_0)
    (NEIGHBOR pos_0_0 pos_0_1)
    (NEIGHBOR pos_0_1 pos_1_1)
    (NEIGHBOR pos_0_1 pos_0_0)
    (NEIGHBOR pos_0_1 pos_0_2)
    (NEIGHBOR pos_0_2 pos_1_2)
    (NEIGHBOR pos_0_2 pos_0_1)
    (NEIGHBOR pos_1_0 pos_0_0)
    (NEIGHBOR pos_1_0 pos_2_0)
    (NEIGHBOR pos_1_0 pos_1_1)
    (NEIGHBOR pos_1_1 pos_0_1)
    (NEIGHBOR pos_1_1 pos_2_1)
    (NEIGHBOR pos_1_1 pos_1_0)
    (NEIGHBOR pos_1_1 pos_1_2)
    (NEIGHBOR pos_1_2 pos_0_2)
    (NEIGHBOR pos_1_2 pos_2_2)
    (NEIGHBOR pos_1_2 pos_1_1)
    (NEIGHBOR pos_2_0 pos_1_0)
    (NEIGHBOR pos_2_0 pos_3_0)
    (NEIGHBOR pos_2_0 pos_2_1)
    (NEIGHBOR pos_2_1 pos_1_1)
    (NEIGHBOR pos_2_1 pos_3_1)
    (NEIGHBOR pos_2_1 pos_2_0)
    (NEIGHBOR pos_2_1 pos_2_2)
    (NEIGHBOR pos_2_2 pos_1_2)
    (NEIGHBOR pos_2_2 pos_3_2)
    (NEIGHBOR pos_2_2 pos_2_1)
    (NEIGHBOR pos_3_0 pos_2_0)
    (NEIGHBOR pos_3_0 pos_3_1)
    (NEIGHBOR pos_3_1 pos_2_1)
    (NEIGHBOR pos_3_1 pos_3_0)
    (NEIGHBOR pos_3_1 pos_3_2)
    (NEIGHBOR pos_3_2 pos_2_2)
    (NEIGHBOR pos_3_2 pos_3_1)
    (IS_DEPOT pos_2_0)
)
(:goal
(and
    (height pos_0_0 n0)
    (height pos_0_1 n0)
    (height pos_0_2 n0)
    (height pos_1_0 n0)
    (height pos_1_1 n0)
    (height pos_1_2 n0)
    (height pos_2_0 n0)
    (height pos_2_1 n0)
    (height pos_2_2 n0)
    (height pos_3_0 n0)
    (height pos_3_1 n4)
    (height pos_3_2 n0)
    (not (has_block))
)
)
)