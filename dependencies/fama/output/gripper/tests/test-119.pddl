(define (problem gripper-x-10)
  (:domain gripper)
  (:objects left -  gripper roomb -  room rooma -  room ball21 -  ball right -  gripper ball22 -  ball ball20 -  ball ball19 -  ball ball18 -  ball ball17 -  ball ball16 -  ball ball15 -  ball ball14 -  ball ball13 -  ball ball12 -  ball ball11 -  ball ball10 -  ball ball9 -  ball ball8 -  ball ball7 -  ball ball6 -  ball ball5 -  ball ball4 -  ball ball3 -  ball ball2 -  ball ball1 -  ball )
  (:init (at ball2 rooma) (at ball1 rooma) (at ball22 roomb) (at ball21 roomb) (at ball20 roomb) (at ball19 roomb) (at ball18 roomb) (at ball17 roomb) (at ball16 roomb) (at ball15 roomb) (at ball14 roomb) (at ball13 roomb) (at ball12 roomb) (at ball11 roomb) (at ball10 roomb) (at ball9 roomb) (at ball8 roomb) (at ball7 roomb) (at ball6 roomb) (at ball5 roomb) (at ball4 roomb) (free right) (at ball3 roomb) (free left) (at-robby rooma) )
  (:goal (and (at ball22 roomb)(at ball21 roomb)(at ball20 roomb)(at ball19 roomb)(at ball18 roomb)(at ball17 roomb)(at ball16 roomb)(at ball15 roomb)(at ball14 roomb)(at ball13 roomb)(at ball12 roomb)(at ball11 roomb)(at ball10 roomb)(at ball9 roomb)(at ball8 roomb)(at ball7 roomb)(at ball6 roomb)(at ball5 roomb)(at ball4 roomb)(at ball3 roomb)(carry ball2 right)(carry ball1 left)(at-robby roomb))))