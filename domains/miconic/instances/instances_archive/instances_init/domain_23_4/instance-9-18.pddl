


(define (problem mixed-f4-p2-u0-v0-g0-a0-n0-A0-B0-N0-F0-r3)
   (:domain miconic)
   (:objects p0 p1 - passenger
             f0 f1 f2 f3 - floor)



(:INIT (origin p1 f2)(above f0 f3)(destin p1 f3)(origin p0 f1)(above f0 f2)(above f1 f2)(above f0 f1)(destin p0 f3)(above f2 f3)(above f1 f3)(lift_at f1)(boarded p0))
(:goal (AND (origin p1 f2)(above f0 f3)(destin p1 f3)(origin p0 f1)(above f0 f2)(above f1 f2)(above f0 f1)(destin p0 f3)(above f2 f3)(above f1 f3)(lift_at f3)(served p1)(served p0)))
)