(define (problem gripper-x-5)
  (:domain gripper)
  (:objects left -  gripper roomb -  room rooma -  room ball11 -  ball right -  gripper ball12 -  ball ball10 -  ball ball9 -  ball ball8 -  ball ball7 -  ball ball6 -  ball ball5 -  ball ball4 -  ball ball3 -  ball ball2 -  ball ball1 -  ball )
  (:init (at ball1 rooma) (at ball2 rooma) (at ball6 rooma) (at ball7 rooma) (at ball8 rooma) (at ball3 rooma) (at ball4 rooma) (at ball5 rooma) (at ball12 roomb) (at ball11 roomb) (at ball10 roomb) (free right) (at ball9 roomb) (free left) (at-robby rooma) )
  (:goal (and (at ball1 rooma)(at ball2 rooma)(at ball6 rooma)(at ball3 rooma)(at ball4 rooma)(at ball5 rooma)(at ball12 roomb)(at ball11 roomb)(at ball10 roomb)(at ball9 roomb)(carry ball8 right)(carry ball7 left)(at-robby roomb))))