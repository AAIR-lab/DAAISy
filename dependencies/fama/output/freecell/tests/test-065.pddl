(define (problem freecell-4-5)
  (:domain freecell)
  (:objects s4 -  card h4 -  card s3 -  card h3 -  card c4 -  card d3 -  card sa -  card c3 -  card s2 -  card s0 -  card ha -  card h2 -  card h0 -  card da -  card d2 -  card d0 -  card ca -  card c2 -  card c0 -  card n8 -  num n7 -  num n6 -  num n5 -  num n4 -  num n3 -  num n13 -  num n12 -  num n11 -  num n9 -  num n10 -  num n1 -  num n2 -  num n0 -  num s -  suit h -  suit d -  suit c -  suit d4 -  card )
  (:init (canstack h2 s3) (canstack h2 c3) (successor n2 n1) (canstack da s2) (value h2 n2) (canstack d3 s4) (canstack c3 h4) (successor n10 n9) (successor n12 n11) (value h0 n0) (successor n1 n0) (bottomcol d2) (suit c0 c) (on c3 s2) (canstack ca h2) (canstack s2 h3) (suit sa s) (successor n13 n12) (suit c2 c) (value h4 n4) (value c0 n0) (suit s4 s) (value d3 n3) (canstack s2 d3) (successor n11 n10) (value sa n1) (canstack h3 c4) (canstack ca d2) (successor n6 n5) (bottomcol c4) (successor n7 n6) (canstack c2 h3) (bottomcol c2) (value s2 n2) (successor n4 n3) (bottomcol d3) (value s3 n3) (suit c4 c) (successor n9 n8) (value s4 n4) (suit s3 s) (suit s2 s) (canstack sa d2) (suit h3 h) (value d2 n2) (suit d4 d) (successor n3 n2) (canstack c3 d4) (suit ca c) (suit d2 d) (canstack d2 s3) (canstack da c2) (clear c2) (canstack d3 c4) (value da n1) (value c3 n3) (on d4 c4) (value c4 n4) (clear d4) (suit s0 s) (bottomcol h3) (canstack ha s2) (canstack sa h2) (bottomcol s2) (canstack s3 d4) (value c2 n2) (canstack ha c2) (successor n8 n7) (successor n5 n4) (value s0 n0) (suit ha h) (suit h2 h) (suit h4 h) (value d4 n4) (value ca n1) (canstack s3 h4) (clear d2) (value d0 n0) (canstack h3 s4) (suit d3 d) (value h3 n3) (clear h3) (canstack d2 c3) (suit da d) (value ha n1) (suit h0 h) (suit d0 d) (suit c3 c) (canstack c2 d3) (home da) (home ca) (incell h4) (clear c3) (incell s4) (clear d3) (home sa) (incell s3) (cellspace n1) (home h2) (colspace n2) )
  (:goal (and (canstack h2 s3)(canstack h2 c3)(successor n2 n1)(canstack da s2)(value h2 n2)(canstack d3 s4)(canstack c3 h4)(successor n10 n9)(successor n12 n11)(value h0 n0)(successor n1 n0)(bottomcol d2)(suit c0 c)(on c3 s2)(canstack ca h2)(canstack s2 h3)(suit sa s)(successor n13 n12)(suit c2 c)(value h4 n4)(value c0 n0)(suit s4 s)(value d3 n3)(canstack s2 d3)(successor n11 n10)(value sa n1)(canstack h3 c4)(canstack ca d2)(successor n6 n5)(bottomcol c4)(successor n7 n6)(canstack c2 h3)(value s2 n2)(successor n4 n3)(bottomcol d3)(value s3 n3)(suit c4 c)(successor n9 n8)(value s4 n4)(suit s3 s)(suit s2 s)(canstack sa d2)(suit h3 h)(value d2 n2)(suit d4 d)(successor n3 n2)(canstack c3 d4)(suit ca c)(suit d2 d)(canstack d2 s3)(canstack da c2)(canstack d3 c4)(value da n1)(value c3 n3)(on d4 c4)(value c4 n4)(clear d4)(suit s0 s)(canstack ha s2)(canstack sa h2)(bottomcol s2)(canstack s3 d4)(value c2 n2)(canstack ha c2)(successor n8 n7)(successor n5 n4)(value s0 n0)(suit ha h)(suit h2 h)(suit h4 h)(value d4 n4)(value ca n1)(canstack s3 h4)(clear d2)(value d0 n0)(canstack h3 s4)(suit d3 d)(value h3 n3)(canstack d2 c3)(suit da d)(value ha n1)(suit h0 h)(suit d0 d)(suit c3 c)(canstack c2 d3)(home da)(clear c3)(incell s4)(clear d3)(home sa)(incell s3)(home h4)(cellspace n2)(home c2)(colspace n4))))