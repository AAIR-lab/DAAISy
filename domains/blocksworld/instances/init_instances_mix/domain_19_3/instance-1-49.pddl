(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (ontable d)(on c a)(handempty )(on b c)(on a d)(clear b))
(:goal (AND (ontable d)(ontable b)(clear c)(ontable c)(clear d)(clear a)(handempty )(on a b)))
)