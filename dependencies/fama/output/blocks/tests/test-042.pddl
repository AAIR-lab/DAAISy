(define (problem blocks-7-1)
  (:domain blocks)
  (:objects b -  block e -  block f -  block d -  block g -  block a -  block c -  block )
  (:init (ontable g) (on e f) (ontable f) (on b e) (clear g) (clear a) (ontable a) (clear c) (ontable c) (clear b) (clear d) (handempty ) (ontable d) )
  (:goal (and (on e f)(ontable f)(on b e)(clear a)(ontable a)(clear b)(ontable d)(clear c)(on c d)(holding g))))