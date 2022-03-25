(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (ontable d)(on c a)(on a d)(holding b)(clear c))
(:goal (AND (ontable d)(on c a)(on a d)(clear c)(clear b)(handempty )(ontable b)))
)