(define (problem gripper-x-1)
   (:domain gripper-typed)
   (:objects rooma roomb - room
   			 left right - gripper
             ball4 ball3 ball2 ball1 - ball)

(:INIT (at ball3 rooma)(at ball2 rooma)(at ball4 rooma)(at_robby rooma)(free right)(carry ball1 left))
(:goal (AND (at ball1 roomb)(at ball2 roomb)(at_robby roomb)(at ball3 roomb)(free left)(at ball4 roomb)(free right)))
)