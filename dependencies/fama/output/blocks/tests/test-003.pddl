(define (problem blocks-6-0)
  (:domain blocks)
  (:objects a -  block e -  block c -  block b -  block f -  block d -  block )
  (:init (ontable b) (ontable c) (on a c) (clear b) (clear e) (ontable e) (clear a) (clear d) (ontable d) (holding f) )
  (:goal (and (ontable b)(ontable c)(clear b)(clear e)(ontable e)(ontable d)(clear f)(on f d)(clear c)(clear a)(handempty )(ontable a))))