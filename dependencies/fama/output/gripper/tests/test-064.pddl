(define (problem gripper-x-8)
  (:domain gripper)
  (:objects left -  gripper roomb -  room rooma -  room ball17 -  ball right -  gripper ball18 -  ball ball16 -  ball ball15 -  ball ball14 -  ball ball13 -  ball ball12 -  ball ball11 -  ball ball10 -  ball ball9 -  ball ball8 -  ball ball7 -  ball ball6 -  ball ball5 -  ball ball4 -  ball ball3 -  ball ball2 -  ball ball1 -  ball )
  (:init (at ball12 rooma) (at ball13 rooma) (at ball10 rooma) (at ball14 rooma) (at ball15 rooma) (at ball1 rooma) (at ball2 rooma) (at ball6 rooma) (at ball7 rooma) (at ball8 rooma) (at ball9 rooma) (at ball16 rooma) (at ball11 rooma) (at ball3 rooma) (at ball4 rooma) (at ball5 rooma) (carry ball18 right) (carry ball17 left) (at-robby roomb) )
  (:goal (and (at ball12 rooma)(at ball13 rooma)(at ball10 rooma)(at ball14 rooma)(at ball15 rooma)(at ball1 rooma)(at ball2 rooma)(at ball6 rooma)(at ball7 rooma)(at ball8 rooma)(at ball9 rooma)(at ball16 rooma)(at ball11 rooma)(at ball3 rooma)(at ball4 rooma)(at ball5 rooma)(at ball18 roomb)(free right)(at ball17 roomb)(free left)(at-robby rooma))))