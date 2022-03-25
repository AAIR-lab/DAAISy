(define (domain freecell)
 (:requirements :strips :typing)
 (:types object - None card - object num - object suit - object )
 (:predicates (bottomcol ?o1 - card) (canstack ?o1 - card ?o2 - card) (cellspace ?o1 - num) (clear ?o1 - card) (colspace ?o1 - num) (home ?o1 - card) (incell ?o1 - card) (on ?o1 - card ?o2 - card) (successor ?o1 - num ?o2 - num) (suit ?o1 - card ?o2 - suit) (value ?o1 - card ?o2 - num))

 (:action move
   :parameters (?o1 - card ?o2 - card ?o3 - card)
   :precondition (and (clear ?o1)(clear ?o3)(canstack ?o1 ?o3)(on ?o1 ?o2))
   :effect (and (on ?o1 ?o3)(clear ?o2)(not (on ?o1 ?o2))(not (clear ?o3))))

 (:action move-b
   :parameters (?o1 - card ?o2 - card ?o3 - num ?o4 - num)
   :precondition (and (clear ?o1)(bottomcol ?o1)(clear ?o2)(canstack ?o1 ?o2)(colspace ?o3)(successor ?o4 ?o3))
   :effect (and (on ?o1 ?o2)(colspace ?o4)(not (bottomcol ?o1))(not (clear ?o2))(not (colspace ?o3))))

 (:action sendtofree
   :parameters (?o1 - card ?o2 - card ?o3 - num ?o4 - num)
   :precondition (and (clear ?o1)(on ?o1 ?o2)(cellspace ?o3)(successor ?o3 ?o4))
   :effect (and (incell ?o1)(clear ?o2)(cellspace ?o4)(not (on ?o1 ?o2))(not (clear ?o1))(not (cellspace ?o3))))

 (:action sendtofree-b
   :parameters (?o1 - card ?o2 - num ?o3 - num ?o4 - num ?o5 - num)
   :precondition (and (clear ?o1)(bottomcol ?o1)(cellspace ?o2)(successor ?o2 ?o3)(colspace ?o4)(successor ?o5 ?o4))
   :effect (and (incell ?o1)(colspace ?o5)(cellspace ?o3)(not (bottomcol ?o1))(not (clear ?o1))(not (colspace ?o4))(not (cellspace ?o2))))

 (:action sendtonewcol
   :parameters (?o1 - card ?o2 - card ?o3 - num ?o4 - num)
   :precondition (and (clear ?o1)(colspace ?o3)(successor ?o3 ?o4)(on ?o1 ?o2))
   :effect (and (bottomcol ?o1)(clear ?o2)(colspace ?o4)(not (on ?o1 ?o2))(not (colspace ?o3))))

 (:action sendtohome
   :parameters (?o1 - card ?o2 - card ?o3 - suit ?o4 - num ?o5 - card ?o6 - num)
   :precondition (and (clear ?o1)(on ?o1 ?o2)(home ?o5)(suit ?o1 ?o3)(suit ?o5 ?o3)(value ?o1 ?o4)(value ?o5 ?o6)(successor ?o4 ?o6))
   :effect (and (home ?o1)(clear ?o2)(not (on ?o1 ?o2))(not (home ?o5))(not (clear ?o1))))

 (:action sendtohome-b
   :parameters (?o1 - card ?o2 - suit ?o3 - num ?o4 - card ?o5 - num ?o6 - num ?o7 - num)
   :precondition (and (clear ?o1)(bottomcol ?o1)(home ?o4)(suit ?o1 ?o2)(suit ?o4 ?o2)(value ?o1 ?o3)(value ?o4 ?o5)(successor ?o3 ?o5)(colspace ?o6)(successor ?o7 ?o6))
   :effect (and (home ?o1)(colspace ?o7)(not (home ?o4))(not (clear ?o1))(not (bottomcol ?o1))(not (colspace ?o6))))

 (:action homefromfreecell
   :parameters (?o1 - card ?o2 - suit ?o3 - num ?o4 - card ?o5 - num ?o6 - num ?o7 - num)
   :precondition (and (incell ?o1)(home ?o4)(suit ?o1 ?o2)(suit ?o4 ?o2)(value ?o1 ?o3)(value ?o4 ?o5)(successor ?o3 ?o5)(cellspace ?o6)(successor ?o7 ?o6))
   :effect (and (home ?o1)(cellspace ?o7)(not (incell ?o1))(not (cellspace ?o6))(not (home ?o4))))

 (:action colfromfreecell
   :parameters (?o1 - card ?o2 - card ?o3 - num ?o4 - num)
   :precondition (and (incell ?o1)(clear ?o2)(canstack ?o1 ?o2)(cellspace ?o3)(successor ?o4 ?o3))
   :effect (and (cellspace ?o4)(clear ?o1)(on ?o1 ?o2)(not (incell ?o1))(not (cellspace ?o3))(not (clear ?o2))))

 (:action newcolfromfreecell
   :parameters (?o1 - card ?o2 - num ?o3 - num ?o4 - num ?o5 - num)
   :precondition (and (incell ?o1)(colspace ?o2)(cellspace ?o4)(successor ?o2 ?o3)(successor ?o5 ?o4))
   :effect (and (bottomcol ?o1)(clear ?o1)(colspace ?o3)(cellspace ?o5)(not (incell ?o1))(not (colspace ?o2))(not (cellspace ?o4))))

)