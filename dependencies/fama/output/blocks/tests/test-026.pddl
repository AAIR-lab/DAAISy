(define (problem blocks-6-1)
  (:domain blocks)
  (:objects d -  block f -  block e -  block c -  block b -  block a -  block )
  (:init (clear e) (ontable e) (ontable d) (clear c) (ontable f) (ontable c) (clear f) (clear a) (on a d) (holding b) )
  (:goal (and (clear e)(ontable e)(ontable d)(ontable f)(clear f)(on a d)(on b a)(clear c)(handempty )(on c b))))