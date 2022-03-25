(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (on c a)(ontable d)(on a d)(holding b)(clear c))
(:goal (AND (ontable b)(on a b)(on c a)(clear d)(handempty )(on d c)))
)