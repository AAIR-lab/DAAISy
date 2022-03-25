(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (on c a)(ontable d)(on a d)(holding b)(clear c))
(:goal (AND (ontable d)(on a d)(clear b)(ontable b)(clear a)(clear c)(handempty )(ontable c)))
)