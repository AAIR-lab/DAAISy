(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (ontable d)(ontable b)(clear c)(ontable c)(clear d)(clear a)(handempty )(on a b))
(:goal (AND (ontable b)(on a b)(clear c)(on c a)(holding d)))
)