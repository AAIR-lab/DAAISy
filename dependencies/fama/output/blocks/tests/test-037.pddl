(define (problem blocks-7-0)
  (:domain blocks)
  (:objects f -  block c -  block b -  block a -  block g -  block e -  block d -  block )
  (:init (on c d) (ontable d) (clear e) (ontable e) (clear g) (ontable g) (clear b) (ontable b) (clear a) (ontable a) (holding f) (clear c) )
  (:goal (and (ontable d)(ontable e)(clear g)(ontable g)(clear b)(ontable b)(clear a)(ontable a)(on f e)(clear d)(clear c)(handempty )(on c f))))