(define (problem gripper-x-2)
  (:domain gripper)
  (:objects left -  gripper roomb -  room rooma -  room ball5 -  ball right -  gripper ball6 -  ball ball4 -  ball ball3 -  ball ball2 -  ball ball1 -  ball )
  (:init (at ball1 rooma) (at ball2 rooma) (at ball3 rooma) (at ball4 rooma) (at ball6 roomb) (free right) (at ball5 roomb) (free left) (at-robby rooma) )
  (:goal (and (at ball1 rooma)(at ball2 rooma)(at ball6 roomb)(at ball5 roomb)(carry ball4 right)(carry ball3 left)(at-robby roomb))))