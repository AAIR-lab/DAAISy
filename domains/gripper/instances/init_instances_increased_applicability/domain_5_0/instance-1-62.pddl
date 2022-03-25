(define (problem gripper-x-1)
   (:domain gripper-typed)
   (:objects rooma roomb - room
   			 left right - gripper
             ball4 ball3 ball2 ball1 - ball)

(:INIT (at ball2 rooma)(free right)(at ball3 rooma)(at_robby rooma)(at ball4 rooma)(carry ball1 left))
(:goal (AND (at ball3 rooma)(at_robby rooma)(at ball4 rooma)(carry ball1 left)(carry ball2 right)))
)