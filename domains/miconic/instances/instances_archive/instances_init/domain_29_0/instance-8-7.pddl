


(define (problem mixed-f4-p2-u0-v0-g0-a0-n0-A0-B0-N0-F0-r2)
   (:domain miconic)
   (:objects p0 p1 - passenger
             f0 f1 f2 f3 - floor)



(:INIT (above f0 f3)(above f0 f2)(above f1 f2)(above f0 f1)(destin p1 f2)(above f2 f3)(destin p0 f0)(origin p0 f3)(origin p1 f0)(above f1 f3)(boarded p1)(lift_at f2))
(:goal (AND (above f0 f3)(above f0 f2)(above f1 f2)(above f0 f1)(destin p1 f2)(above f2 f3)(destin p0 f0)(origin p0 f3)(origin p1 f0)(above f1 f3)(lift_at f2)(served p1)))
)