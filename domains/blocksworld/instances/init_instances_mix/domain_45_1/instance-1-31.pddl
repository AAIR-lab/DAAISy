(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (ontable d)(on c a)(handempty )(on b c)(on a d)(clear b))
(:goal (AND (ontable d)(clear b)(ontable b)(clear c)(ontable c)(holding a)(clear d)))
)