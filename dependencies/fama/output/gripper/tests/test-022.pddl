(define (problem gripper-x-4)
  (:domain gripper)
  (:objects left -  gripper roomb -  room rooma -  room ball9 -  ball right -  gripper ball10 -  ball ball8 -  ball ball7 -  ball ball6 -  ball ball5 -  ball ball4 -  ball ball3 -  ball ball2 -  ball ball1 -  ball )
  (:init (at ball1 rooma) (at ball2 rooma) (at ball10 roomb) (at ball9 roomb) (at ball8 roomb) (at ball7 roomb) (at ball6 roomb) (at ball5 roomb) (carry ball4 right) (carry ball3 left) (at-robby roomb) )
  (:goal (and (at ball1 rooma)(at ball2 rooma)(at ball10 roomb)(at ball9 roomb)(at ball8 roomb)(at ball7 roomb)(at ball6 roomb)(at ball5 roomb)(at ball4 roomb)(free right)(at ball3 roomb)(free left)(at-robby rooma))))