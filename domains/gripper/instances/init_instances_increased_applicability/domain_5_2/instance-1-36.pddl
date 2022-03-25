(define (problem gripper-x-1)
   (:domain gripper-typed)
   (:objects rooma roomb - room
   			 left right - gripper
             ball4 ball3 ball2 ball1 - ball)

(:INIT (at ball2 rooma)(free right)(at ball3 rooma)(at ball1 rooma)(free left)(at_robby rooma)(at ball4 rooma))
(:goal (AND (at ball3 rooma)(at ball4 rooma)(at_robby roomb)(at ball1 roomb)(free left)(at ball2 roomb)(free right)))
)