(define (problem blocks-5-0)
  (:domain blocks)
  (:objects e -  block b -  block c -  block a -  block d -  block )
  (:init (ontable a) (on b a) (on e b) (clear e) (clear c) (ontable c) (holding d) )
  (:goal (and (ontable a)(on b a)(ontable c)(clear d)(on d c)(clear b)(clear e)(handempty )(ontable e))))