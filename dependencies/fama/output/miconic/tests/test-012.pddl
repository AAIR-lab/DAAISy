(define (problem mixed-f4-p2-u0-v0-g0-a0-n0-a0-b0-n0-f0-r3)
  (:domain miconic)
  (:objects p0 -  passenger f0 -  floor p1 -  passenger f1 -  floor f2 -  floor f3 -  floor )
  (:init (above f0 f1) (above f1 f2) (origin p0 f1) (above f2 f3) (above f0 f2) (origin p1 f2) (destin p0 f3) (destin p1 f3) (above f1 f3) (above f0 f3) (boarded p0) (lift-at f2) )
  (:goal (and (above f0 f1)(above f1 f2)(origin p0 f1)(above f2 f3)(above f0 f2)(origin p1 f2)(destin p0 f3)(destin p1 f3)(above f1 f3)(above f0 f3)(boarded p1)(lift-at f3)(served p0))))