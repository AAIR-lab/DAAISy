(define (problem blocks-6-2)
  (:domain blocks)
  (:objects f -  block e -  block d -  block b -  block c -  block a -  block )
  (:init (on a d) (on d b) (on f e) (ontable c) (handempty ) (on b f) (on e c) (clear a) )
  (:goal (and (on f e)(ontable c)(on b f)(on e c)(clear a)(ontable a)(holding d)(clear b))))