(define (problem parking)
  (:domain parking)
  (:objects car-00 -  car car-03 -  car car-02 -  car car-04 -  car car-01 -  car car-07 -  car car-05 -  car car-06 -  car car-08 -  car car-09 -  car car-10 -  car car-11 -  car car-12 -  car car-13 -  car car-14 -  car car-15 -  car car-16 -  car car-17 -  car car-18 -  car car-19 -  car car-20 -  car car-21 -  car curb-00 -  curb curb-01 -  curb curb-02 -  curb curb-03 -  curb curb-04 -  curb curb-05 -  curb curb-06 -  curb curb-07 -  curb curb-08 -  curb curb-09 -  curb curb-10 -  curb curb-11 -  curb )
  (:init (car-clear car-12) (at-curb-num car-20 curb-10) (car-clear car-14) (car-clear car-17) (behind-car car-02 car-11) (at-curb-num car-10 curb-08) (at-curb car-07) (car-clear car-13) (car-clear car-09) (at-curb-num car-19 curb-04) (behind-car car-06 car-10) (at-curb car-20) (at-curb car-10) (at-curb-num car-11 curb-01) (at-curb car-01) (car-clear car-02) (at-curb-num car-18 curb-00) (at-curb car-19) (behind-car car-13 car-18) (at-curb-num car-07 curb-02) (at-curb car-18) (at-curb-num car-05 curb-05) (at-curb car-05) (car-clear car-16) (at-curb car-11) (at-curb-num car-01 curb-07) (car-clear car-06) (at-curb-num car-04 curb-11) (at-curb car-04) (behind-car car-14 car-01) (behind-car car-16 car-04) (behind-car car-17 car-05) (car-clear car-15) (behind-car car-12 car-20) (at-curb-num car-03 curb-06) (at-curb car-03) (car-clear car-00) (behind-car car-15 car-03) (behind-car car-09 car-19) (behind-car car-00 car-07) (car-clear car-21) (at-curb-num car-08 curb-09) (at-curb car-08) (curb-clear curb-03) (behind-car car-21 car-08) )
  (:goal (and (car-clear car-12)(at-curb-num car-20 curb-10)(car-clear car-14)(car-clear car-17)(behind-car car-02 car-11)(at-curb-num car-10 curb-08)(at-curb car-07)(car-clear car-13)(behind-car car-06 car-10)(at-curb car-20)(at-curb car-10)(at-curb-num car-11 curb-01)(at-curb car-01)(car-clear car-02)(at-curb-num car-18 curb-00)(behind-car car-13 car-18)(at-curb-num car-07 curb-02)(at-curb car-18)(at-curb-num car-05 curb-05)(at-curb car-05)(car-clear car-16)(at-curb car-11)(at-curb-num car-01 curb-07)(car-clear car-06)(at-curb-num car-04 curb-11)(at-curb car-04)(behind-car car-14 car-01)(behind-car car-16 car-04)(behind-car car-17 car-05)(car-clear car-15)(behind-car car-12 car-20)(at-curb-num car-03 curb-06)(at-curb car-03)(car-clear car-00)(behind-car car-15 car-03)(car-clear car-21)(at-curb-num car-08 curb-09)(at-curb car-08)(behind-car car-21 car-08)(car-clear car-19)(at-curb-num car-09 curb-03)(at-curb car-09)(behind-car car-19 car-09)(car-clear car-07)(at-curb-num car-00 curb-04)(at-curb car-00))))