(define (problem gripper-x-1)
   (:domain gripper-typed)
   (:objects rooma roomb - room
   			 left right - gripper
             ball4 ball3 ball2 ball1 - ball)

(:INIT (at ball3 rooma)(at ball4 rooma)(carry ball1 left)(carry ball2 right)(at_robby roomb))
(:goal (AND (at ball1 roomb)(at ball2 roomb)(at_robby rooma)(carry ball3 left)(carry ball4 right)))
)