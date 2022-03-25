(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (ontable b)(on a b)(clear c)(on c a)(holding d))
(:goal (AND (ontable b)(on a b)(on c a)(clear d)(handempty )(on d c)))
)