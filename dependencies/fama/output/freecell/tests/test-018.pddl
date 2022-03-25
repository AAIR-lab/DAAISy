(define (problem freecell-3-2)
  (:domain freecell)
  (:objects s3 -  card h3 -  card sa -  card s2 -  card c3 -  card s0 -  card h2 -  card ha -  card h0 -  card da -  card d2 -  card d0 -  card ca -  card c2 -  card c0 -  card n8 -  num n7 -  num n6 -  num n5 -  num n4 -  num n3 -  num n13 -  num n12 -  num n11 -  num n9 -  num n10 -  num n1 -  num n2 -  num n0 -  num s -  suit h -  suit d -  suit c -  suit d3 -  card )
  (:init (canstack s2 d3) (suit c2 c) (canstack h2 c3) (successor n2 n1) (canstack da s2) (value h2 n2) (on s2 c3) (successor n10 n9) (successor n12 n11) (value h0 n0) (bottomcol c3) (clear h2) (successor n1 n0) (bottomcol d2) (home d0) (clear d3) (canstack ca h2) (canstack s2 h3) (suit sa s) (clear s3) (successor n13 n12) (value c0 n0) (value d3 n3) (suit c0 c) (successor n11 n10) (clear da) (value sa n1) (canstack ca d2) (successor n6 n5) (successor n7 n6) (canstack c2 h3) (bottomcol c2) (suit c3 c) (value s2 n2) (successor n4 n3) (value s3 n3) (bottomcol s3) (successor n9 n8) (suit s3 s) (canstack c2 d3) (suit s2 s) (canstack sa d2) (suit h3 h) (value d2 n2) (bottomcol da) (successor n3 n2) (suit ca c) (home h0) (suit d2 d) (bottomcol ha) (cellspace n4) (canstack da c2) (clear c2) (value da n1) (value c3 n3) (on d3 s2) (suit s0 s) (value ha n1) (canstack h2 s3) (canstack sa h2) (value c2 n2) (canstack ha c2) (successor n8 n7) (successor n5 n4) (value s0 n0) (suit ha h) (suit h2 h) (value ca n1) (value d0 n0) (bottomcol h2) (suit d3 d) (value h3 n3) (canstack d2 c3) (suit da d) (canstack ha s2) (suit h0 h) (suit d0 d) (canstack d2 s3) (home sa) (clear h3) (bottomcol h3) (clear ha) (colspace n0) (home ca) (clear d2) )
  (:goal (and (canstack s2 d3)(suit c2 c)(canstack h2 c3)(successor n2 n1)(canstack da s2)(value h2 n2)(successor n10 n9)(successor n12 n11)(value h0 n0)(bottomcol c3)(clear h2)(successor n1 n0)(bottomcol d2)(canstack ca h2)(canstack s2 h3)(suit sa s)(clear s3)(successor n13 n12)(value c0 n0)(value d3 n3)(suit c0 c)(successor n11 n10)(value sa n1)(canstack ca d2)(successor n6 n5)(successor n7 n6)(canstack c2 h3)(bottomcol c2)(suit c3 c)(value s2 n2)(successor n4 n3)(value s3 n3)(bottomcol s3)(successor n9 n8)(suit s3 s)(canstack c2 d3)(suit s2 s)(canstack sa d2)(suit h3 h)(value d2 n2)(successor n3 n2)(suit ca c)(home h0)(suit d2 d)(bottomcol ha)(canstack da c2)(clear c2)(value da n1)(value c3 n3)(suit s0 s)(value ha n1)(canstack h2 s3)(canstack sa h2)(value c2 n2)(canstack ha c2)(successor n8 n7)(successor n5 n4)(value s0 n0)(suit ha h)(suit h2 h)(value ca n1)(value d0 n0)(bottomcol h2)(suit d3 d)(value h3 n3)(canstack d2 c3)(suit da d)(canstack ha s2)(suit h0 h)(suit d0 d)(canstack d2 s3)(clear h3)(bottomcol h3)(clear ha)(home ca)(clear d2)(incell d3)(cellspace n3)(home s2)(clear c3)(home da)(colspace n1))))