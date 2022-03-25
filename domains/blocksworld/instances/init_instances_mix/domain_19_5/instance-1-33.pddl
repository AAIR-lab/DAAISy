(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (ontable d)(clear b)(ontable b)(clear c)(ontable c)(holding a)(clear d))
(:goal (AND (ontable b)(on a b)(clear c)(on c a)(holding d)))
)