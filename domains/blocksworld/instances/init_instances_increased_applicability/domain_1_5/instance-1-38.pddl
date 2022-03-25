(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (ontable d)(on c a)(clear b)(on b c)(handempty )(on a d))
(:goal (AND (ontable d)(ontable b)(clear d)(clear a)(on a b)(holding c)))
)