(define (problem BLOCKS-4-1)
(:domain BLOCKS)
(:objects A C D B - block)

(:INIT (ontable d)(clear b)(ontable b)(clear c)(ontable c)(holding a)(clear d))
(:goal (AND (ontable d)(ontable b)(clear d)(clear a)(on a b)(holding c)))
)