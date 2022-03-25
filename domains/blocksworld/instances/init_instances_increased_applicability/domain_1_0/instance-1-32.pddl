(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (clear b)(handempty )(on c a)(ontable d)(on a d)(on b c))
(:goal (AND (ontable d)(clear b)(ontable b)(clear c)(ontable c)(holding a)(clear d)))
)