(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (ontable d)(on c a)(handempty )(on b c)(on a d)(clear b))
(:goal (AND (ontable d)(on c a)(on a d)(clear c)(clear b)(handempty )(ontable b)))
)