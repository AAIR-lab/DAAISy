(define (problem logistics-6-3)
  (:domain logistics)
  (:objects apt2 -  airport apn1 -  airplane pos2 -  location apt1 -  airport pos1 -  location cit1 -  city cit2 -  city tru2 -  truck tru1 -  truck obj23 -  package obj22 -  package obj21 -  package obj13 -  package obj12 -  package obj11 -  package )
  (:init (in-city apt1 cit1) (at apn1 apt2) (at obj21 pos2) (in-city apt2 cit2) (in-city pos2 cit2) (in-city pos1 cit1) (at obj12 pos1) (in obj22 tru2) (at tru1 apt1) (at obj13 apt1) (at obj11 apt1) (at tru2 apt2) (at obj23 apt2) )
  (:goal (and (in-city apt1 cit1)(at apn1 apt2)(at obj21 pos2)(in-city apt2 cit2)(in-city pos2 cit2)(in-city pos1 cit1)(at obj12 pos1)(at tru1 apt1)(at obj13 apt1)(at obj11 apt1)(at tru2 apt2)(in obj23 apn1)(in obj22 apn1))))