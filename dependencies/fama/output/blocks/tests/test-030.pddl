(define (problem blocks-6-2)
  (:domain blocks)
  (:objects f -  block e -  block d -  block b -  block c -  block a -  block )
  (:init (on f e) (ontable c) (on e c) (clear a) (ontable a) (clear d) (ontable d) (clear f) (clear b) (handempty ) (ontable b) )
  (:goal (and (ontable c)(clear a)(ontable a)(clear d)(ontable d)(clear b)(ontable b)(clear f)(ontable f)(holding e)(clear c))))