(define (problem blocks-4-1)
  (:domain blocks)
  (:objects c -  block a -  block b -  block d -  block )
  (:init (on a d) (ontable d) (clear b) (ontable b) (holding c) (clear a) )
  (:goal (and (ontable d)(ontable b)(clear c)(ontable c)(clear d)(clear a)(handempty )(on a b))))