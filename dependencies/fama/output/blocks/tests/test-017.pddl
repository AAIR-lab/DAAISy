(define (problem blocks-5-1)
  (:domain blocks)
  (:objects d -  block a -  block e -  block c -  block b -  block )
  (:init (clear b) (on a d) (clear e) (ontable c) (handempty ) (ontable d) (clear c) (on b a) (ontable e) )
  (:goal (and (clear e)(ontable c)(ontable d)(clear c)(ontable e)(clear b)(ontable b)(holding a)(clear d))))