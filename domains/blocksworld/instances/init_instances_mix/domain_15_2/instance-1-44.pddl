(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (ontable d)(on c a)(on a d)(clear c)(clear b)(handempty )(ontable b))
(:goal (AND (ontable d)(ontable b)(clear c)(ontable c)(clear d)(clear a)(handempty )(on a b)))
)