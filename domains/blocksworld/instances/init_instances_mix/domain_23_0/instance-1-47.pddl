(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (ontable d)(on c a)(handempty )(on b c)(on a d)(clear b))
(:goal (AND (ontable d)(on a d)(clear b)(ontable b)(clear a)(clear c)(handempty )(ontable c)))
)