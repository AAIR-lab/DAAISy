(define (problem blocks-6-2)
  (:domain blocks)
  (:objects f -  block e -  block d -  block b -  block c -  block a -  block )
  (:init (ontable d) (clear f) (ontable f) (clear e) (ontable e) (on c d) (clear b) (on b c) (holding a) )
  (:goal (and (ontable d)(clear e)(ontable e)(on c d)(on b c)(on a b)(clear f)(handempty )(on f a))))