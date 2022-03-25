(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (ontable d)(ontable b)(clear d)(on a b)(clear c)(handempty )(on c a))
(:goal (AND (ontable b)(on a b)(clear c)(on c a)(holding d)))
)