(define (problem gripper-x-7)
  (:domain gripper)
  (:objects left -  gripper roomb -  room rooma -  room ball15 -  ball right -  gripper ball16 -  ball ball14 -  ball ball13 -  ball ball12 -  ball ball11 -  ball ball10 -  ball ball9 -  ball ball8 -  ball ball7 -  ball ball6 -  ball ball5 -  ball ball4 -  ball ball3 -  ball ball2 -  ball ball1 -  ball )
  (:init (at ball12 rooma) (at ball13 rooma) (at ball10 rooma) (at ball14 rooma) (at ball1 rooma) (at ball2 rooma) (at ball6 rooma) (at ball7 rooma) (at ball8 rooma) (at ball9 rooma) (at ball11 rooma) (at ball3 rooma) (at ball4 rooma) (at ball5 rooma) (at ball16 roomb) (free right) (at ball15 roomb) (free left) (at-robby rooma) )
  (:goal (and (at ball12 rooma)(at ball10 rooma)(at ball1 rooma)(at ball2 rooma)(at ball6 rooma)(at ball7 rooma)(at ball8 rooma)(at ball9 rooma)(at ball11 rooma)(at ball3 rooma)(at ball4 rooma)(at ball5 rooma)(at ball16 roomb)(at ball15 roomb)(carry ball14 right)(carry ball13 left)(at-robby roomb))))