(define (problem termes-00112-0036-4x3x3-random_towers_4x3_3_2_8)
  (:domain termes)
  (:objects n3 -  numb n1 -  numb n0 -  numb n2 -  numb pos-0-1 -  position pos-0-0 -  position pos-0-2 -  position pos-1-0 -  position pos-1-1 -  position pos-1-2 -  position pos-2-0 -  position pos-2-1 -  position pos-2-2 -  position pos-3-0 -  position pos-3-1 -  position pos-3-2 -  position )
  (:init (neighbor pos-0-2 pos-0-1) (neighbor pos-2-0 pos-1-0) (neighbor pos-2-1 pos-3-1) (neighbor pos-0-2 pos-1-2) (neighbor pos-2-2 pos-2-1) (neighbor pos-0-1 pos-0-2) (height pos-2-2 n0) (neighbor pos-0-0 pos-0-1) (height pos-0-1 n0) (neighbor pos-1-1 pos-2-1) (height pos-1-0 n0) (neighbor pos-2-1 pos-2-2) (neighbor pos-3-2 pos-2-2) (neighbor pos-1-1 pos-1-0) (neighbor pos-3-1 pos-2-1) (height pos-3-2 n0) (neighbor pos-2-0 pos-3-0) (neighbor pos-1-0 pos-1-1) (succ n2 n1) (neighbor pos-1-0 pos-2-0) (neighbor pos-0-1 pos-0-0) (neighbor pos-3-0 pos-2-0) (neighbor pos-1-0 pos-0-0) (succ n3 n2) (neighbor pos-0-1 pos-1-1) (neighbor pos-3-2 pos-3-1) (neighbor pos-2-1 pos-2-0) (neighbor pos-2-1 pos-1-1) (neighbor pos-3-1 pos-3-2) (is-depot pos-2-0) (neighbor pos-2-2 pos-3-2) (neighbor pos-1-2 pos-1-1) (neighbor pos-2-0 pos-2-1) (neighbor pos-2-2 pos-1-2) (height pos-1-1 n0) (neighbor pos-0-0 pos-1-0) (succ n1 n0) (height pos-0-2 n0) (height pos-2-0 n0) (neighbor pos-1-2 pos-0-2) (neighbor pos-3-1 pos-3-0) (neighbor pos-1-1 pos-0-1) (height pos-1-2 n0) (neighbor pos-1-1 pos-1-2) (neighbor pos-3-0 pos-3-1) (neighbor pos-1-2 pos-2-2) (height pos-0-0 n0) (height pos-3-1 n1) (height pos-2-1 n2) (height pos-3-0 n1) (has-block ) (at pos-3-1) )
  (:goal (and (neighbor pos-0-2 pos-0-1)(neighbor pos-2-0 pos-1-0)(neighbor pos-2-1 pos-3-1)(neighbor pos-0-2 pos-1-2)(neighbor pos-2-2 pos-2-1)(neighbor pos-0-1 pos-0-2)(height pos-2-2 n0)(neighbor pos-0-0 pos-0-1)(height pos-0-1 n0)(neighbor pos-1-1 pos-2-1)(height pos-1-0 n0)(neighbor pos-2-1 pos-2-2)(neighbor pos-3-2 pos-2-2)(neighbor pos-1-1 pos-1-0)(neighbor pos-3-1 pos-2-1)(height pos-3-2 n0)(neighbor pos-2-0 pos-3-0)(neighbor pos-1-0 pos-1-1)(succ n2 n1)(neighbor pos-1-0 pos-2-0)(neighbor pos-0-1 pos-0-0)(neighbor pos-3-0 pos-2-0)(neighbor pos-1-0 pos-0-0)(succ n3 n2)(neighbor pos-0-1 pos-1-1)(neighbor pos-3-2 pos-3-1)(neighbor pos-2-1 pos-2-0)(neighbor pos-2-1 pos-1-1)(neighbor pos-3-1 pos-3-2)(is-depot pos-2-0)(neighbor pos-2-2 pos-3-2)(neighbor pos-1-2 pos-1-1)(neighbor pos-2-0 pos-2-1)(neighbor pos-2-2 pos-1-2)(height pos-1-1 n0)(neighbor pos-0-0 pos-1-0)(succ n1 n0)(height pos-0-2 n0)(height pos-2-0 n0)(neighbor pos-1-2 pos-0-2)(neighbor pos-3-1 pos-3-0)(neighbor pos-1-1 pos-0-1)(height pos-1-2 n0)(neighbor pos-1-1 pos-1-2)(neighbor pos-3-0 pos-3-1)(neighbor pos-1-2 pos-2-2)(height pos-0-0 n0)(height pos-3-1 n1)(height pos-3-0 n2)(height pos-2-1 n1)(has-block )(at pos-2-1))))