(define (problem mixed-f2-p1-u0-v0-g0-a0-n0-a0-b0-n0-f0-r2)
  (:domain miconic)
  (:objects p0 -  passenger f1 -  floor f0 -  floor )
  (:init (above f0 f1) (origin p0 f1) (destin p0 f0) (lift-at f0) )
  (:goal (and (above f0 f1)(origin p0 f1)(destin p0 f0)(boarded p0)(lift-at f0))))