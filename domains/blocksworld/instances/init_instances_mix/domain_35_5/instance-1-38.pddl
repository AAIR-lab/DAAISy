(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (ontable d)(on a d)(clear b)(ontable b)(holding c)(clear a))
(:goal (AND (ontable b)(on a b)(clear c)(on c a)(holding d)))
)