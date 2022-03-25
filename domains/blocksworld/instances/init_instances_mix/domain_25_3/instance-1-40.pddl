(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (ontable d)(on a d)(clear b)(ontable b)(clear a)(clear c)(handempty )(ontable c))
(:goal (AND (ontable d)(clear b)(ontable b)(clear c)(ontable c)(holding a)(clear d)))
)