(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (on c a)(ontable d)(on a d)(holding b)(clear c))
(:goal (AND (ontable d)(ontable b)(clear d)(on a b)(clear c)(handempty )(on c a)))
)