(define (problem logistics-4-0)
  (:domain logistics)
  (:objects apt1 -  airport apn1 -  airplane pos2 -  location apt2 -  airport pos1 -  location cit1 -  city cit2 -  city tru2 -  truck tru1 -  truck obj23 -  package obj22 -  package obj21 -  package obj13 -  package obj12 -  package obj11 -  package )
  (:init (at obj13 pos1) (in-city apt1 cit1) (at obj22 pos2) (at tru1 pos1) (at apn1 apt2) (at obj21 pos2) (in-city apt2 cit2) (at obj11 pos1) (at tru2 pos2) (in-city pos2 cit2) (in-city pos1 cit1) (at obj12 pos1) (at obj23 pos2) )
  (:goal (and (at obj13 pos1)(in-city apt1 cit1)(at obj22 pos2)(at tru1 pos1)(at apn1 apt2)(in-city apt2 cit2)(at obj11 pos1)(in-city pos2 cit2)(in-city pos1 cit1)(at obj12 pos1)(in obj23 tru2)(in obj21 tru2)(at tru2 apt2))))