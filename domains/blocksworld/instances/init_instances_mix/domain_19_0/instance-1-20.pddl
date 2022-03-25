(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (ontable d)(on c a)(on a d)(clear c)(clear b)(handempty )(ontable b))
(:goal (AND (ontable d)(ontable b)(clear d)(clear a)(on a b)(holding c)))
)