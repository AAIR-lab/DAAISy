(define (problem blocks-5-0)
  (:domain blocks)
  (:objects e -  block b -  block c -  block a -  block d -  block )
  (:init (ontable a) (ontable c) (on d c) (clear a) (clear b) (on b d) (holding e) )
  (:goal (and (ontable c)(on d c)(on b d)(on e b)(clear a)(handempty )(on a e))))