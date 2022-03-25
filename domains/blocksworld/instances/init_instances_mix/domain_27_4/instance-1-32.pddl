(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (ontable d)(ontable b)(clear c)(ontable c)(clear d)(clear a)(handempty )(on a b))
(:goal (AND (ontable d)(ontable b)(clear d)(on a b)(clear c)(handempty )(on c a)))
)