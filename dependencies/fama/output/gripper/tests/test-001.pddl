(define (problem gripper-x-1)
  (:domain gripper)
  (:objects left -  gripper roomb -  room rooma -  room ball3 -  ball right -  gripper ball4 -  ball ball2 -  ball ball1 -  ball )
  (:init (at ball1 rooma) (at ball2 rooma) (carry ball4 right) (carry ball3 left) (at-robby roomb) )
  (:goal (and (at ball1 rooma)(at ball2 rooma)(at ball4 roomb)(free right)(at ball3 roomb)(free left)(at-robby rooma))))