(define (problem freecell-4-4)
  (:domain freecell)
  (:objects s4 -  card h4 -  card s3 -  card h3 -  card c4 -  card d3 -  card sa -  card c3 -  card s2 -  card s0 -  card ha -  card h2 -  card h0 -  card da -  card d2 -  card d0 -  card ca -  card c2 -  card c0 -  card n8 -  num n7 -  num n6 -  num n5 -  num n4 -  num n3 -  num n13 -  num n12 -  num n11 -  num n9 -  num n10 -  num n1 -  num n2 -  num n0 -  num s -  suit h -  suit d -  suit c -  suit d4 -  card )
  (:init (value d4 n4) (suit c2 c) (canstack h2 c3) (successor n2 n1) (canstack da s2) (value h2 n2) (clear h4) (canstack d3 s4) (canstack c3 h4) (successor n10 n9) (successor n12 n11) (value h0 n0) (successor n1 n0) (canstack ca h2) (canstack s2 h3) (suit sa s) (canstack h3 s4) (successor n13 n12) (clear s4) (value h4 n4) (value c0 n0) (suit s3 s) (suit s4 s) (value d3 n3) (suit s0 s) (successor n11 n10) (value sa n1) (canstack h3 c4) (canstack ca d2) (successor n6 n5) (successor n7 n6) (canstack c2 h3) (bottomcol d4) (value s2 n2) (successor n4 n3) (value s3 n3) (successor n9 n8) (value s4 n4) (canstack c2 d3) (suit s2 s) (canstack sa d2) (suit h3 h) (value d2 n2) (suit d4 d) (successor n3 n2) (canstack c3 d4) (suit ca c) (suit d2 d) (canstack d3 c4) (value da n1) (value c3 n3) (value c4 n4) (canstack s2 d3) (canstack ha s2) (canstack h2 s3) (canstack sa h2) (canstack s3 d4) (value c2 n2) (canstack ha c2) (successor n8 n7) (successor n5 n4) (value s0 n0) (suit c0 c) (suit ha h) (suit h2 h) (suit h4 h) (suit c4 c) (value ca n1) (canstack s3 h4) (value d0 n0) (canstack d2 s3) (canstack da c2) (suit d3 d) (value h3 n3) (canstack d2 c3) (suit da d) (value ha n1) (suit h0 h) (suit d0 d) (suit c3 c) (bottomcol h4) (bottomcol s4) (clear d4) (home h3) (cellspace n4) (home c4) (home d3) (home s3) (colspace n5) )
  (:goal (and (value d4 n4)(suit c2 c)(canstack h2 c3)(successor n2 n1)(canstack da s2)(value h2 n2)(canstack d3 s4)(canstack c3 h4)(successor n10 n9)(successor n12 n11)(value h0 n0)(successor n1 n0)(canstack ca h2)(canstack s2 h3)(suit sa s)(canstack h3 s4)(successor n13 n12)(value h4 n4)(value c0 n0)(suit s3 s)(suit s4 s)(value d3 n3)(suit s0 s)(successor n11 n10)(value sa n1)(canstack h3 c4)(canstack ca d2)(successor n6 n5)(successor n7 n6)(canstack c2 h3)(value s2 n2)(successor n4 n3)(value s3 n3)(successor n9 n8)(value s4 n4)(canstack c2 d3)(suit s2 s)(canstack sa d2)(suit h3 h)(value d2 n2)(suit d4 d)(successor n3 n2)(canstack c3 d4)(suit ca c)(suit d2 d)(canstack d3 c4)(value da n1)(value c3 n3)(value c4 n4)(canstack s2 d3)(canstack ha s2)(canstack h2 s3)(canstack sa h2)(canstack s3 d4)(value c2 n2)(canstack ha c2)(successor n8 n7)(successor n5 n4)(value s0 n0)(suit c0 c)(suit ha h)(suit h2 h)(suit h4 h)(suit c4 c)(value ca n1)(canstack s3 h4)(value d0 n0)(canstack d2 s3)(canstack da c2)(suit d3 d)(value h3 n3)(canstack d2 c3)(suit da d)(value ha n1)(suit h0 h)(suit d0 d)(suit c3 c)(cellspace n4)(home c4)(home d4)(home h4)(home s4)(colspace n8))))