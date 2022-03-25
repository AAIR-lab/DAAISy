(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (clear b)(handempty )(on c a)(ontable d)(on a d)(on b c))
(:goal (AND (ontable b)(on a b)(clear c)(on c a)(holding d)))
)