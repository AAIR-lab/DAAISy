(define (domain gripper-typed)
(:requirements :strips :typing :conditional-effects :equality :negative-preconditions)
(:types room gripper ball)
(:predicates (at_robby_1  ?r0 - room)(at_robby_2  ?r0 - room)
             
             (at_1  ?b0 - ball ?r1 - room)(at_2  ?b0 - ball ?r1 - room)
             (free_1  ?g0 - gripper)(free_2  ?g0 - gripper)
             (carry_1  ?b0 - ball ?g1 - gripper)(carry_2  ?b0 - ball ?g1 - gripper)
             (unknown_1)(unknown_2)
             (dummy_pred_1)(dummy_pred_2))

(:action move
  :parameters (?room1 - room
               ?room2 - room
              )
  :precondition (and (not (= ?room1 ?room2)) 
                     (or 
                         (and 
                              (at_robby_1 ?room1)
                         )
                         (and 
                              (at_robby_2 ?room1)
                         )
                     )
                )
  :effect (and (when (and
                              (at_robby_1 ?room1)
                              (at_robby_2 ?room1)
                     )
                     (and 
                              (not (at_robby_1 ?room1))
                              (at_robby_1 ?room2)
                              (not (unknown_1))
                              (not (at_robby_2 ?room1))
                              (at_robby_2 ?room2)
                              (not (unknown_2))
                     )
               )
               (when (or 
                         (and 
                              (at_robby_1 ?room1)
                              (or 
                                  (not (at_robby_2 ?room1))
                              )
                         )
                         (and 
                              (at_robby_2 ?room1)
                              (or 
                                  (not (at_robby_1 ?room1))
                              )
                         )
                     )
                     (and 
                          (dummy_pred_1)
                          (not(dummy_pred_2))
                     ) 
               )
          )
)

(:action pick
  :parameters (?ball1 - ball
               ?room1 - room
               ?gripper1 - gripper
              )
  :precondition (and (not (= ?ball1 ?room1)) 
                     (not (= ?ball1 ?gripper1)) 
                     (not (= ?room1 ?gripper1)) 
                     (or 
                         (and 
                              (at_robby_1 ?room1)
                              (at_1 ?ball1 ?room1)
                              (free_1 ?gripper1)
                         )
                         (and 
                              (at_robby_2 ?room1)
                              (at_2 ?ball1 ?room1)
                              (free_2 ?gripper1)
                         )
                     )
                )
  :effect (and (when (and
                              (at_robby_1 ?room1)
                              (at_1 ?ball1 ?room1)
                              (free_1 ?gripper1)
                              (at_robby_2 ?room1)
                              (at_2 ?ball1 ?room1)
                              (free_2 ?gripper1)
                     )
                     (and 
                              (not (at_1 ?ball1 ?room1))
                              (not (free_1 ?gripper1))
                              (carry_1 ?ball1 ?gripper1)
                              (not (unknown_1))
                              (not (at_2 ?ball1 ?room1))
                              (not (free_2 ?gripper1))
                              (carry_2 ?ball1 ?gripper1)
                              (not (unknown_2))
                     )
               )
               (when (or 
                         (and 
                              (at_robby_1 ?room1)
                              (at_1 ?ball1 ?room1)
                              (free_1 ?gripper1)
                              (or 
                                  (not (at_robby_2 ?room1))
                                  (not (at_2 ?ball1 ?room1))
                                  (not (free_2 ?gripper1))
                              )
                         )
                         (and 
                              (at_robby_2 ?room1)
                              (at_2 ?ball1 ?room1)
                              (free_2 ?gripper1)
                              (or 
                                  (not (at_robby_1 ?room1))
                                  (not (at_1 ?ball1 ?room1))
                                  (not (free_1 ?gripper1))
                              )
                         )
                     )
                     (and 
                          (dummy_pred_1)
                          (not(dummy_pred_2))
                     ) 
               )
          )
)

(:action drop
  :parameters (?ball1 - ball
               ?room1 - room
               ?gripper1 - gripper
              )
  :precondition (and (not (= ?ball1 ?room1)) 
                     (not (= ?ball1 ?gripper1)) 
                     (not (= ?room1 ?gripper1)) 
                     (or 
                         (and 
                              (or (at_robby_1 ?room1)
                                  (unknown_1)
                              )
                         )
                         (and 
                              (or (not (at_robby_2 ?room1))
                                  (unknown_2)
                              )
                         )
                     )
                )
  :effect (and (when (and
                              (or (at_robby_1 ?room1)
                                  (unknown_1)
                              )
                              (or (not (at_robby_2 ?room1))
                                  (unknown_2)
                              )
                     )
                     (and 
                              (unknown_1)
                              (unknown_2)
                     )
               )
               (when (or 
                         (and 
                              (or (at_robby_1 ?room1)
                                  (unknown_1)
                              )
                              (or 
                                  (or (at_robby_2 ?room1)
                                      (unknown_2)
                                  )
                              )
                         )
                         (and 
                              (or (not (at_robby_2 ?room1))
                                  (unknown_2)
                              )
                              (or 
                                  (or (not (at_robby_1 ?room1))
                                      (unknown_1)
                                  )
                              )
                         )
                     )
                     (and 
                          (dummy_pred_1)
                          (not(dummy_pred_2))
                     ) 
               )
          )
)

)
