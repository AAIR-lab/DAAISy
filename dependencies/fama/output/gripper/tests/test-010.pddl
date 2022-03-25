(define (problem gripper-x-3)
  (:domain gripper)
  (:objects left -  gripper roomb -  room rooma -  room ball7 -  ball right -  gripper ball8 -  ball ball6 -  ball ball5 -  ball ball4 -  ball ball3 -  ball ball2 -  ball ball1 -  ball )
  (:init (at ball1 rooma) (at ball2 rooma) (at ball6 rooma) (at ball3 rooma) (at ball4 rooma) (at ball5 rooma) (at ball8 roomb) (free right) (at ball7 roomb) (free left) (at-robby rooma) )
  (:goal (and (at ball1 rooma)(at ball2 rooma)(at ball3 rooma)(at ball4 rooma)(at ball8 roomb)(at ball7 roomb)(carry ball6 right)(carry ball5 left)(at-robby roomb))))