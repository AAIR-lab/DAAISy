(define (problem gripper-x-1)
   (:domain gripper-typed)
   (:objects rooma roomb - room
   			 left right - gripper
             ball4 ball3 ball2 ball1 - ball)

(:INIT (at ball3 rooma)(at ball4 rooma)(carry ball2 right)(at_robby roomb)(at ball1 roomb)(free left))
(:goal (AND (at ball1 roomb)(at ball2 roomb)(carry ball3 left)(carry ball4 right)(at_robby roomb)))
)