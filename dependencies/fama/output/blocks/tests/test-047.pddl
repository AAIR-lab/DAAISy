(define (problem blocks-7-2)
  (:domain blocks)
  (:objects g -  block e -  block d -  block c -  block f -  block b -  block a -  block )
  (:init (handempty ) (on c g) (on a d) (on e f) (clear b) (on g e) (ontable d) (on b c) (ontable f) (clear a) )
  (:goal (and (on c g)(on e f)(on g e)(ontable d)(ontable f)(clear c)(clear b)(ontable b)(holding a)(clear d))))