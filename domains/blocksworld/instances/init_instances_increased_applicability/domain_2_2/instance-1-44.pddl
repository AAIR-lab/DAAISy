(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (ontable d)(on c a)(clear b)(on b c)(handempty )(on a d))
(:goal (AND (ontable b)(on a b)(clear c)(on c a)(holding d)))
)