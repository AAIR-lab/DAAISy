(define (problem blocks-7-2)
  (:domain blocks)
  (:objects g -  block e -  block d -  block c -  block f -  block b -  block a -  block )
  (:init (on e f) (ontable d) (ontable f) (clear b) (ontable b) (clear d) (clear e) (ontable g) (on c g) (clear a) (handempty ) (on a c) )
  (:goal (and (ontable f)(clear b)(ontable b)(ontable g)(on c g)(on a c)(clear d)(on d a)(holding e)(clear f))))