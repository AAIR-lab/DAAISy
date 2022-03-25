


(define (problem mixed-f2-p1-u0-v0-g0-a0-n0-A0-B0-N0-F0-r1)
   (:domain miconic)
   (:objects p0 - passenger
             f0 f1 - floor)



(:INIT (above f0 f1)(origin p0 f0)(destin p0 f1)(boarded p0)(lift_at f1))
(:goal (AND (above f0 f1)(origin p0 f0)(destin p0 f1)(lift_at f1)(served p0)))
)