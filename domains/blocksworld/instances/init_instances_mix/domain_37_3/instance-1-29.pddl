(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (ontable d)(ontable b)(clear d)(clear a)(on a b)(holding c))
(:goal (AND (ontable b)(on a b)(clear c)(on c a)(holding d)))
)