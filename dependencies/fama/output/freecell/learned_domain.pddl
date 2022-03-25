(define (domain freecell)
 (:requirements :strips :typing)
 (:types object - None card - object num - object suit - object step - None )
 (:constants c -  suit c0 -  card c2 -  card ca -  card d -  suit d0 -  card d2 -  card da -  card h -  suit h0 -  card h2 -  card ha -  card i1 -  step i2 -  step i3 -  step i4 -  step n0 -  num n1 -  num n10 -  num n11 -  num n12 -  num n13 -  num n2 -  num n3 -  num n4 -  num n5 -  num n6 -  num n7 -  num n8 -  num n9 -  num s -  suit s0 -  card s2 -  card sa -  card)
 (:predicates (action_applied) (add_bottomcol_colfromfreecell_var1) (add_bottomcol_colfromfreecell_var2) (add_bottomcol_homefromfreecell_var1) (add_bottomcol_homefromfreecell_var4) (add_bottomcol_move-b_var1) (add_bottomcol_move-b_var2) (add_bottomcol_move_var1) (add_bottomcol_move_var2) (add_bottomcol_move_var3) (add_bottomcol_newcolfromfreecell_var1) (add_bottomcol_sendtofree-b_var1) (add_bottomcol_sendtofree_var1) (add_bottomcol_sendtofree_var2) (add_bottomcol_sendtohome-b_var1) (add_bottomcol_sendtohome-b_var4) (add_bottomcol_sendtohome_var1) (add_bottomcol_sendtohome_var2) (add_bottomcol_sendtohome_var5) (add_bottomcol_sendtonewcol_var1) (add_bottomcol_sendtonewcol_var2) (add_canstack_colfromfreecell_var1_var1) (add_canstack_colfromfreecell_var1_var2) (add_canstack_colfromfreecell_var2_var1) (add_canstack_colfromfreecell_var2_var2) (add_canstack_homefromfreecell_var1_var1) (add_canstack_homefromfreecell_var1_var4) (add_canstack_homefromfreecell_var4_var1) (add_canstack_homefromfreecell_var4_var4) (add_canstack_move-b_var1_var1) (add_canstack_move-b_var1_var2) (add_canstack_move-b_var2_var1) (add_canstack_move-b_var2_var2) (add_canstack_move_var1_var1) (add_canstack_move_var1_var2) (add_canstack_move_var1_var3) (add_canstack_move_var2_var1) (add_canstack_move_var2_var2) (add_canstack_move_var2_var3) (add_canstack_move_var3_var1) (add_canstack_move_var3_var2) (add_canstack_move_var3_var3) (add_canstack_newcolfromfreecell_var1_var1) (add_canstack_sendtofree-b_var1_var1) (add_canstack_sendtofree_var1_var1) (add_canstack_sendtofree_var1_var2) (add_canstack_sendtofree_var2_var1) (add_canstack_sendtofree_var2_var2) (add_canstack_sendtohome-b_var1_var1) (add_canstack_sendtohome-b_var1_var4) (add_canstack_sendtohome-b_var4_var1) (add_canstack_sendtohome-b_var4_var4) (add_canstack_sendtohome_var1_var1) (add_canstack_sendtohome_var1_var2) (add_canstack_sendtohome_var1_var5) (add_canstack_sendtohome_var2_var1) (add_canstack_sendtohome_var2_var2) (add_canstack_sendtohome_var2_var5) (add_canstack_sendtohome_var5_var1) (add_canstack_sendtohome_var5_var2) (add_canstack_sendtohome_var5_var5) (add_canstack_sendtonewcol_var1_var1) (add_canstack_sendtonewcol_var1_var2) (add_canstack_sendtonewcol_var2_var1) (add_canstack_sendtonewcol_var2_var2) (add_cellspace_colfromfreecell_var3) (add_cellspace_colfromfreecell_var4) (add_cellspace_homefromfreecell_var3) (add_cellspace_homefromfreecell_var5) (add_cellspace_homefromfreecell_var6) (add_cellspace_homefromfreecell_var7) (add_cellspace_move-b_var3) (add_cellspace_move-b_var4) (add_cellspace_newcolfromfreecell_var2) (add_cellspace_newcolfromfreecell_var3) (add_cellspace_newcolfromfreecell_var4) (add_cellspace_newcolfromfreecell_var5) (add_cellspace_sendtofree-b_var2) (add_cellspace_sendtofree-b_var3) (add_cellspace_sendtofree-b_var4) (add_cellspace_sendtofree-b_var5) (add_cellspace_sendtofree_var3) (add_cellspace_sendtofree_var4) (add_cellspace_sendtohome-b_var3) (add_cellspace_sendtohome-b_var5) (add_cellspace_sendtohome-b_var6) (add_cellspace_sendtohome-b_var7) (add_cellspace_sendtohome_var4) (add_cellspace_sendtohome_var6) (add_cellspace_sendtonewcol_var3) (add_cellspace_sendtonewcol_var4) (add_clear_colfromfreecell_var1) (add_clear_colfromfreecell_var2) (add_clear_homefromfreecell_var1) (add_clear_homefromfreecell_var4) (add_clear_move-b_var1) (add_clear_move-b_var2) (add_clear_move_var1) (add_clear_move_var2) (add_clear_move_var3) (add_clear_newcolfromfreecell_var1) (add_clear_sendtofree-b_var1) (add_clear_sendtofree_var1) (add_clear_sendtofree_var2) (add_clear_sendtohome-b_var1) (add_clear_sendtohome-b_var4) (add_clear_sendtohome_var1) (add_clear_sendtohome_var2) (add_clear_sendtohome_var5) (add_clear_sendtonewcol_var1) (add_clear_sendtonewcol_var2) (add_colspace_colfromfreecell_var3) (add_colspace_colfromfreecell_var4) (add_colspace_homefromfreecell_var3) (add_colspace_homefromfreecell_var5) (add_colspace_homefromfreecell_var6) (add_colspace_homefromfreecell_var7) (add_colspace_move-b_var3) (add_colspace_move-b_var4) (add_colspace_newcolfromfreecell_var2) (add_colspace_newcolfromfreecell_var3) (add_colspace_newcolfromfreecell_var4) (add_colspace_newcolfromfreecell_var5) (add_colspace_sendtofree-b_var2) (add_colspace_sendtofree-b_var3) (add_colspace_sendtofree-b_var4) (add_colspace_sendtofree-b_var5) (add_colspace_sendtofree_var3) (add_colspace_sendtofree_var4) (add_colspace_sendtohome-b_var3) (add_colspace_sendtohome-b_var5) (add_colspace_sendtohome-b_var6) (add_colspace_sendtohome-b_var7) (add_colspace_sendtohome_var4) (add_colspace_sendtohome_var6) (add_colspace_sendtonewcol_var3) (add_colspace_sendtonewcol_var4) (add_home_colfromfreecell_var1) (add_home_colfromfreecell_var2) (add_home_homefromfreecell_var1) (add_home_homefromfreecell_var4) (add_home_move-b_var1) (add_home_move-b_var2) (add_home_move_var1) (add_home_move_var2) (add_home_move_var3) (add_home_newcolfromfreecell_var1) (add_home_sendtofree-b_var1) (add_home_sendtofree_var1) (add_home_sendtofree_var2) (add_home_sendtohome-b_var1) (add_home_sendtohome-b_var4) (add_home_sendtohome_var1) (add_home_sendtohome_var2) (add_home_sendtohome_var5) (add_home_sendtonewcol_var1) (add_home_sendtonewcol_var2) (add_incell_colfromfreecell_var1) (add_incell_colfromfreecell_var2) (add_incell_homefromfreecell_var1) (add_incell_homefromfreecell_var4) (add_incell_move-b_var1) (add_incell_move-b_var2) (add_incell_move_var1) (add_incell_move_var2) (add_incell_move_var3) (add_incell_newcolfromfreecell_var1) (add_incell_sendtofree-b_var1) (add_incell_sendtofree_var1) (add_incell_sendtofree_var2) (add_incell_sendtohome-b_var1) (add_incell_sendtohome-b_var4) (add_incell_sendtohome_var1) (add_incell_sendtohome_var2) (add_incell_sendtohome_var5) (add_incell_sendtonewcol_var1) (add_incell_sendtonewcol_var2) (add_on_colfromfreecell_var1_var1) (add_on_colfromfreecell_var1_var2) (add_on_colfromfreecell_var2_var1) (add_on_colfromfreecell_var2_var2) (add_on_homefromfreecell_var1_var1) (add_on_homefromfreecell_var1_var4) (add_on_homefromfreecell_var4_var1) (add_on_homefromfreecell_var4_var4) (add_on_move-b_var1_var1) (add_on_move-b_var1_var2) (add_on_move-b_var2_var1) (add_on_move-b_var2_var2) (add_on_move_var1_var1) (add_on_move_var1_var2) (add_on_move_var1_var3) (add_on_move_var2_var1) (add_on_move_var2_var2) (add_on_move_var2_var3) (add_on_move_var3_var1) (add_on_move_var3_var2) (add_on_move_var3_var3) (add_on_newcolfromfreecell_var1_var1) (add_on_sendtofree-b_var1_var1) (add_on_sendtofree_var1_var1) (add_on_sendtofree_var1_var2) (add_on_sendtofree_var2_var1) (add_on_sendtofree_var2_var2) (add_on_sendtohome-b_var1_var1) (add_on_sendtohome-b_var1_var4) (add_on_sendtohome-b_var4_var1) (add_on_sendtohome-b_var4_var4) (add_on_sendtohome_var1_var1) (add_on_sendtohome_var1_var2) (add_on_sendtohome_var1_var5) (add_on_sendtohome_var2_var1) (add_on_sendtohome_var2_var2) (add_on_sendtohome_var2_var5) (add_on_sendtohome_var5_var1) (add_on_sendtohome_var5_var2) (add_on_sendtohome_var5_var5) (add_on_sendtonewcol_var1_var1) (add_on_sendtonewcol_var1_var2) (add_on_sendtonewcol_var2_var1) (add_on_sendtonewcol_var2_var2) (add_successor_colfromfreecell_var3_var3) (add_successor_colfromfreecell_var3_var4) (add_successor_colfromfreecell_var4_var3) (add_successor_colfromfreecell_var4_var4) (add_successor_homefromfreecell_var3_var3) (add_successor_homefromfreecell_var3_var5) (add_successor_homefromfreecell_var3_var6) (add_successor_homefromfreecell_var3_var7) (add_successor_homefromfreecell_var5_var3) (add_successor_homefromfreecell_var5_var5) (add_successor_homefromfreecell_var5_var6) (add_successor_homefromfreecell_var5_var7) (add_successor_homefromfreecell_var6_var3) (add_successor_homefromfreecell_var6_var5) (add_successor_homefromfreecell_var6_var6) (add_successor_homefromfreecell_var6_var7) (add_successor_homefromfreecell_var7_var3) (add_successor_homefromfreecell_var7_var5) (add_successor_homefromfreecell_var7_var6) (add_successor_homefromfreecell_var7_var7) (add_successor_move-b_var3_var3) (add_successor_move-b_var3_var4) (add_successor_move-b_var4_var3) (add_successor_move-b_var4_var4) (add_successor_newcolfromfreecell_var2_var2) (add_successor_newcolfromfreecell_var2_var3) (add_successor_newcolfromfreecell_var2_var4) (add_successor_newcolfromfreecell_var2_var5) (add_successor_newcolfromfreecell_var3_var2) (add_successor_newcolfromfreecell_var3_var3) (add_successor_newcolfromfreecell_var3_var4) (add_successor_newcolfromfreecell_var3_var5) (add_successor_newcolfromfreecell_var4_var2) (add_successor_newcolfromfreecell_var4_var3) (add_successor_newcolfromfreecell_var4_var4) (add_successor_newcolfromfreecell_var4_var5) (add_successor_newcolfromfreecell_var5_var2) (add_successor_newcolfromfreecell_var5_var3) (add_successor_newcolfromfreecell_var5_var4) (add_successor_newcolfromfreecell_var5_var5) (add_successor_sendtofree-b_var2_var2) (add_successor_sendtofree-b_var2_var3) (add_successor_sendtofree-b_var2_var4) (add_successor_sendtofree-b_var2_var5) (add_successor_sendtofree-b_var3_var2) (add_successor_sendtofree-b_var3_var3) (add_successor_sendtofree-b_var3_var4) (add_successor_sendtofree-b_var3_var5) (add_successor_sendtofree-b_var4_var2) (add_successor_sendtofree-b_var4_var3) (add_successor_sendtofree-b_var4_var4) (add_successor_sendtofree-b_var4_var5) (add_successor_sendtofree-b_var5_var2) (add_successor_sendtofree-b_var5_var3) (add_successor_sendtofree-b_var5_var4) (add_successor_sendtofree-b_var5_var5) (add_successor_sendtofree_var3_var3) (add_successor_sendtofree_var3_var4) (add_successor_sendtofree_var4_var3) (add_successor_sendtofree_var4_var4) (add_successor_sendtohome-b_var3_var3) (add_successor_sendtohome-b_var3_var5) (add_successor_sendtohome-b_var3_var6) (add_successor_sendtohome-b_var3_var7) (add_successor_sendtohome-b_var5_var3) (add_successor_sendtohome-b_var5_var5) (add_successor_sendtohome-b_var5_var6) (add_successor_sendtohome-b_var5_var7) (add_successor_sendtohome-b_var6_var3) (add_successor_sendtohome-b_var6_var5) (add_successor_sendtohome-b_var6_var6) (add_successor_sendtohome-b_var6_var7) (add_successor_sendtohome-b_var7_var3) (add_successor_sendtohome-b_var7_var5) (add_successor_sendtohome-b_var7_var6) (add_successor_sendtohome-b_var7_var7) (add_successor_sendtohome_var4_var4) (add_successor_sendtohome_var4_var6) (add_successor_sendtohome_var6_var4) (add_successor_sendtohome_var6_var6) (add_successor_sendtonewcol_var3_var3) (add_successor_sendtonewcol_var3_var4) (add_successor_sendtonewcol_var4_var3) (add_successor_sendtonewcol_var4_var4) (add_suit_homefromfreecell_var1_var2) (add_suit_homefromfreecell_var4_var2) (add_suit_sendtohome-b_var1_var2) (add_suit_sendtohome-b_var4_var2) (add_suit_sendtohome_var1_var3) (add_suit_sendtohome_var2_var3) (add_suit_sendtohome_var5_var3) (add_value_colfromfreecell_var1_var3) (add_value_colfromfreecell_var1_var4) (add_value_colfromfreecell_var2_var3) (add_value_colfromfreecell_var2_var4) (add_value_homefromfreecell_var1_var3) (add_value_homefromfreecell_var1_var5) (add_value_homefromfreecell_var1_var6) (add_value_homefromfreecell_var1_var7) (add_value_homefromfreecell_var4_var3) (add_value_homefromfreecell_var4_var5) (add_value_homefromfreecell_var4_var6) (add_value_homefromfreecell_var4_var7) (add_value_move-b_var1_var3) (add_value_move-b_var1_var4) (add_value_move-b_var2_var3) (add_value_move-b_var2_var4) (add_value_newcolfromfreecell_var1_var2) (add_value_newcolfromfreecell_var1_var3) (add_value_newcolfromfreecell_var1_var4) (add_value_newcolfromfreecell_var1_var5) (add_value_sendtofree-b_var1_var2) (add_value_sendtofree-b_var1_var3) (add_value_sendtofree-b_var1_var4) (add_value_sendtofree-b_var1_var5) (add_value_sendtofree_var1_var3) (add_value_sendtofree_var1_var4) (add_value_sendtofree_var2_var3) (add_value_sendtofree_var2_var4) (add_value_sendtohome-b_var1_var3) (add_value_sendtohome-b_var1_var5) (add_value_sendtohome-b_var1_var6) (add_value_sendtohome-b_var1_var7) (add_value_sendtohome-b_var4_var3) (add_value_sendtohome-b_var4_var5) (add_value_sendtohome-b_var4_var6) (add_value_sendtohome-b_var4_var7) (add_value_sendtohome_var1_var4) (add_value_sendtohome_var1_var6) (add_value_sendtohome_var2_var4) (add_value_sendtohome_var2_var6) (add_value_sendtohome_var5_var4) (add_value_sendtohome_var5_var6) (add_value_sendtonewcol_var1_var3) (add_value_sendtonewcol_var1_var4) (add_value_sendtonewcol_var2_var3) (add_value_sendtonewcol_var2_var4) (bottomcol ?o1 - card) (canstack ?o1 - card ?o2 - card) (cellspace ?o1 - num) (clear ?o1 - card) (colspace ?o1 - num) (current ?i - step) (del_bottomcol_colfromfreecell_var1) (del_bottomcol_colfromfreecell_var2) (del_bottomcol_homefromfreecell_var1) (del_bottomcol_homefromfreecell_var4) (del_bottomcol_move-b_var1) (del_bottomcol_move-b_var2) (del_bottomcol_move_var1) (del_bottomcol_move_var2) (del_bottomcol_move_var3) (del_bottomcol_newcolfromfreecell_var1) (del_bottomcol_sendtofree-b_var1) (del_bottomcol_sendtofree_var1) (del_bottomcol_sendtofree_var2) (del_bottomcol_sendtohome-b_var1) (del_bottomcol_sendtohome-b_var4) (del_bottomcol_sendtohome_var1) (del_bottomcol_sendtohome_var2) (del_bottomcol_sendtohome_var5) (del_bottomcol_sendtonewcol_var1) (del_bottomcol_sendtonewcol_var2) (del_canstack_colfromfreecell_var1_var1) (del_canstack_colfromfreecell_var1_var2) (del_canstack_colfromfreecell_var2_var1) (del_canstack_colfromfreecell_var2_var2) (del_canstack_homefromfreecell_var1_var1) (del_canstack_homefromfreecell_var1_var4) (del_canstack_homefromfreecell_var4_var1) (del_canstack_homefromfreecell_var4_var4) (del_canstack_move-b_var1_var1) (del_canstack_move-b_var1_var2) (del_canstack_move-b_var2_var1) (del_canstack_move-b_var2_var2) (del_canstack_move_var1_var1) (del_canstack_move_var1_var2) (del_canstack_move_var1_var3) (del_canstack_move_var2_var1) (del_canstack_move_var2_var2) (del_canstack_move_var2_var3) (del_canstack_move_var3_var1) (del_canstack_move_var3_var2) (del_canstack_move_var3_var3) (del_canstack_newcolfromfreecell_var1_var1) (del_canstack_sendtofree-b_var1_var1) (del_canstack_sendtofree_var1_var1) (del_canstack_sendtofree_var1_var2) (del_canstack_sendtofree_var2_var1) (del_canstack_sendtofree_var2_var2) (del_canstack_sendtohome-b_var1_var1) (del_canstack_sendtohome-b_var1_var4) (del_canstack_sendtohome-b_var4_var1) (del_canstack_sendtohome-b_var4_var4) (del_canstack_sendtohome_var1_var1) (del_canstack_sendtohome_var1_var2) (del_canstack_sendtohome_var1_var5) (del_canstack_sendtohome_var2_var1) (del_canstack_sendtohome_var2_var2) (del_canstack_sendtohome_var2_var5) (del_canstack_sendtohome_var5_var1) (del_canstack_sendtohome_var5_var2) (del_canstack_sendtohome_var5_var5) (del_canstack_sendtonewcol_var1_var1) (del_canstack_sendtonewcol_var1_var2) (del_canstack_sendtonewcol_var2_var1) (del_canstack_sendtonewcol_var2_var2) (del_cellspace_colfromfreecell_var3) (del_cellspace_colfromfreecell_var4) (del_cellspace_homefromfreecell_var3) (del_cellspace_homefromfreecell_var5) (del_cellspace_homefromfreecell_var6) (del_cellspace_homefromfreecell_var7) (del_cellspace_move-b_var3) (del_cellspace_move-b_var4) (del_cellspace_newcolfromfreecell_var2) (del_cellspace_newcolfromfreecell_var3) (del_cellspace_newcolfromfreecell_var4) (del_cellspace_newcolfromfreecell_var5) (del_cellspace_sendtofree-b_var2) (del_cellspace_sendtofree-b_var3) (del_cellspace_sendtofree-b_var4) (del_cellspace_sendtofree-b_var5) (del_cellspace_sendtofree_var3) (del_cellspace_sendtofree_var4) (del_cellspace_sendtohome-b_var3) (del_cellspace_sendtohome-b_var5) (del_cellspace_sendtohome-b_var6) (del_cellspace_sendtohome-b_var7) (del_cellspace_sendtohome_var4) (del_cellspace_sendtohome_var6) (del_cellspace_sendtonewcol_var3) (del_cellspace_sendtonewcol_var4) (del_clear_colfromfreecell_var1) (del_clear_colfromfreecell_var2) (del_clear_homefromfreecell_var1) (del_clear_homefromfreecell_var4) (del_clear_move-b_var1) (del_clear_move-b_var2) (del_clear_move_var1) (del_clear_move_var2) (del_clear_move_var3) (del_clear_newcolfromfreecell_var1) (del_clear_sendtofree-b_var1) (del_clear_sendtofree_var1) (del_clear_sendtofree_var2) (del_clear_sendtohome-b_var1) (del_clear_sendtohome-b_var4) (del_clear_sendtohome_var1) (del_clear_sendtohome_var2) (del_clear_sendtohome_var5) (del_clear_sendtonewcol_var1) (del_clear_sendtonewcol_var2) (del_colspace_colfromfreecell_var3) (del_colspace_colfromfreecell_var4) (del_colspace_homefromfreecell_var3) (del_colspace_homefromfreecell_var5) (del_colspace_homefromfreecell_var6) (del_colspace_homefromfreecell_var7) (del_colspace_move-b_var3) (del_colspace_move-b_var4) (del_colspace_newcolfromfreecell_var2) (del_colspace_newcolfromfreecell_var3) (del_colspace_newcolfromfreecell_var4) (del_colspace_newcolfromfreecell_var5) (del_colspace_sendtofree-b_var2) (del_colspace_sendtofree-b_var3) (del_colspace_sendtofree-b_var4) (del_colspace_sendtofree-b_var5) (del_colspace_sendtofree_var3) (del_colspace_sendtofree_var4) (del_colspace_sendtohome-b_var3) (del_colspace_sendtohome-b_var5) (del_colspace_sendtohome-b_var6) (del_colspace_sendtohome-b_var7) (del_colspace_sendtohome_var4) (del_colspace_sendtohome_var6) (del_colspace_sendtonewcol_var3) (del_colspace_sendtonewcol_var4) (del_home_colfromfreecell_var1) (del_home_colfromfreecell_var2) (del_home_homefromfreecell_var1) (del_home_homefromfreecell_var4) (del_home_move-b_var1) (del_home_move-b_var2) (del_home_move_var1) (del_home_move_var2) (del_home_move_var3) (del_home_newcolfromfreecell_var1) (del_home_sendtofree-b_var1) (del_home_sendtofree_var1) (del_home_sendtofree_var2) (del_home_sendtohome-b_var1) (del_home_sendtohome-b_var4) (del_home_sendtohome_var1) (del_home_sendtohome_var2) (del_home_sendtohome_var5) (del_home_sendtonewcol_var1) (del_home_sendtonewcol_var2) (del_incell_colfromfreecell_var1) (del_incell_colfromfreecell_var2) (del_incell_homefromfreecell_var1) (del_incell_homefromfreecell_var4) (del_incell_move-b_var1) (del_incell_move-b_var2) (del_incell_move_var1) (del_incell_move_var2) (del_incell_move_var3) (del_incell_newcolfromfreecell_var1) (del_incell_sendtofree-b_var1) (del_incell_sendtofree_var1) (del_incell_sendtofree_var2) (del_incell_sendtohome-b_var1) (del_incell_sendtohome-b_var4) (del_incell_sendtohome_var1) (del_incell_sendtohome_var2) (del_incell_sendtohome_var5) (del_incell_sendtonewcol_var1) (del_incell_sendtonewcol_var2) (del_on_colfromfreecell_var1_var1) (del_on_colfromfreecell_var1_var2) (del_on_colfromfreecell_var2_var1) (del_on_colfromfreecell_var2_var2) (del_on_homefromfreecell_var1_var1) (del_on_homefromfreecell_var1_var4) (del_on_homefromfreecell_var4_var1) (del_on_homefromfreecell_var4_var4) (del_on_move-b_var1_var1) (del_on_move-b_var1_var2) (del_on_move-b_var2_var1) (del_on_move-b_var2_var2) (del_on_move_var1_var1) (del_on_move_var1_var2) (del_on_move_var1_var3) (del_on_move_var2_var1) (del_on_move_var2_var2) (del_on_move_var2_var3) (del_on_move_var3_var1) (del_on_move_var3_var2) (del_on_move_var3_var3) (del_on_newcolfromfreecell_var1_var1) (del_on_sendtofree-b_var1_var1) (del_on_sendtofree_var1_var1) (del_on_sendtofree_var1_var2) (del_on_sendtofree_var2_var1) (del_on_sendtofree_var2_var2) (del_on_sendtohome-b_var1_var1) (del_on_sendtohome-b_var1_var4) (del_on_sendtohome-b_var4_var1) (del_on_sendtohome-b_var4_var4) (del_on_sendtohome_var1_var1) (del_on_sendtohome_var1_var2) (del_on_sendtohome_var1_var5) (del_on_sendtohome_var2_var1) (del_on_sendtohome_var2_var2) (del_on_sendtohome_var2_var5) (del_on_sendtohome_var5_var1) (del_on_sendtohome_var5_var2) (del_on_sendtohome_var5_var5) (del_on_sendtonewcol_var1_var1) (del_on_sendtonewcol_var1_var2) (del_on_sendtonewcol_var2_var1) (del_on_sendtonewcol_var2_var2) (del_successor_colfromfreecell_var3_var3) (del_successor_colfromfreecell_var3_var4) (del_successor_colfromfreecell_var4_var3) (del_successor_colfromfreecell_var4_var4) (del_successor_homefromfreecell_var3_var3) (del_successor_homefromfreecell_var3_var5) (del_successor_homefromfreecell_var3_var6) (del_successor_homefromfreecell_var3_var7) (del_successor_homefromfreecell_var5_var3) (del_successor_homefromfreecell_var5_var5) (del_successor_homefromfreecell_var5_var6) (del_successor_homefromfreecell_var5_var7) (del_successor_homefromfreecell_var6_var3) (del_successor_homefromfreecell_var6_var5) (del_successor_homefromfreecell_var6_var6) (del_successor_homefromfreecell_var6_var7) (del_successor_homefromfreecell_var7_var3) (del_successor_homefromfreecell_var7_var5) (del_successor_homefromfreecell_var7_var6) (del_successor_homefromfreecell_var7_var7) (del_successor_move-b_var3_var3) (del_successor_move-b_var3_var4) (del_successor_move-b_var4_var3) (del_successor_move-b_var4_var4) (del_successor_newcolfromfreecell_var2_var2) (del_successor_newcolfromfreecell_var2_var3) (del_successor_newcolfromfreecell_var2_var4) (del_successor_newcolfromfreecell_var2_var5) (del_successor_newcolfromfreecell_var3_var2) (del_successor_newcolfromfreecell_var3_var3) (del_successor_newcolfromfreecell_var3_var4) (del_successor_newcolfromfreecell_var3_var5) (del_successor_newcolfromfreecell_var4_var2) (del_successor_newcolfromfreecell_var4_var3) (del_successor_newcolfromfreecell_var4_var4) (del_successor_newcolfromfreecell_var4_var5) (del_successor_newcolfromfreecell_var5_var2) (del_successor_newcolfromfreecell_var5_var3) (del_successor_newcolfromfreecell_var5_var4) (del_successor_newcolfromfreecell_var5_var5) (del_successor_sendtofree-b_var2_var2) (del_successor_sendtofree-b_var2_var3) (del_successor_sendtofree-b_var2_var4) (del_successor_sendtofree-b_var2_var5) (del_successor_sendtofree-b_var3_var2) (del_successor_sendtofree-b_var3_var3) (del_successor_sendtofree-b_var3_var4) (del_successor_sendtofree-b_var3_var5) (del_successor_sendtofree-b_var4_var2) (del_successor_sendtofree-b_var4_var3) (del_successor_sendtofree-b_var4_var4) (del_successor_sendtofree-b_var4_var5) (del_successor_sendtofree-b_var5_var2) (del_successor_sendtofree-b_var5_var3) (del_successor_sendtofree-b_var5_var4) (del_successor_sendtofree-b_var5_var5) (del_successor_sendtofree_var3_var3) (del_successor_sendtofree_var3_var4) (del_successor_sendtofree_var4_var3) (del_successor_sendtofree_var4_var4) (del_successor_sendtohome-b_var3_var3) (del_successor_sendtohome-b_var3_var5) (del_successor_sendtohome-b_var3_var6) (del_successor_sendtohome-b_var3_var7) (del_successor_sendtohome-b_var5_var3) (del_successor_sendtohome-b_var5_var5) (del_successor_sendtohome-b_var5_var6) (del_successor_sendtohome-b_var5_var7) (del_successor_sendtohome-b_var6_var3) (del_successor_sendtohome-b_var6_var5) (del_successor_sendtohome-b_var6_var6) (del_successor_sendtohome-b_var6_var7) (del_successor_sendtohome-b_var7_var3) (del_successor_sendtohome-b_var7_var5) (del_successor_sendtohome-b_var7_var6) (del_successor_sendtohome-b_var7_var7) (del_successor_sendtohome_var4_var4) (del_successor_sendtohome_var4_var6) (del_successor_sendtohome_var6_var4) (del_successor_sendtohome_var6_var6) (del_successor_sendtonewcol_var3_var3) (del_successor_sendtonewcol_var3_var4) (del_successor_sendtonewcol_var4_var3) (del_successor_sendtonewcol_var4_var4) (del_suit_homefromfreecell_var1_var2) (del_suit_homefromfreecell_var4_var2) (del_suit_sendtohome-b_var1_var2) (del_suit_sendtohome-b_var4_var2) (del_suit_sendtohome_var1_var3) (del_suit_sendtohome_var2_var3) (del_suit_sendtohome_var5_var3) (del_value_colfromfreecell_var1_var3) (del_value_colfromfreecell_var1_var4) (del_value_colfromfreecell_var2_var3) (del_value_colfromfreecell_var2_var4) (del_value_homefromfreecell_var1_var3) (del_value_homefromfreecell_var1_var5) (del_value_homefromfreecell_var1_var6) (del_value_homefromfreecell_var1_var7) (del_value_homefromfreecell_var4_var3) (del_value_homefromfreecell_var4_var5) (del_value_homefromfreecell_var4_var6) (del_value_homefromfreecell_var4_var7) (del_value_move-b_var1_var3) (del_value_move-b_var1_var4) (del_value_move-b_var2_var3) (del_value_move-b_var2_var4) (del_value_newcolfromfreecell_var1_var2) (del_value_newcolfromfreecell_var1_var3) (del_value_newcolfromfreecell_var1_var4) (del_value_newcolfromfreecell_var1_var5) (del_value_sendtofree-b_var1_var2) (del_value_sendtofree-b_var1_var3) (del_value_sendtofree-b_var1_var4) (del_value_sendtofree-b_var1_var5) (del_value_sendtofree_var1_var3) (del_value_sendtofree_var1_var4) (del_value_sendtofree_var2_var3) (del_value_sendtofree_var2_var4) (del_value_sendtohome-b_var1_var3) (del_value_sendtohome-b_var1_var5) (del_value_sendtohome-b_var1_var6) (del_value_sendtohome-b_var1_var7) (del_value_sendtohome-b_var4_var3) (del_value_sendtohome-b_var4_var5) (del_value_sendtohome-b_var4_var6) (del_value_sendtohome-b_var4_var7) (del_value_sendtohome_var1_var4) (del_value_sendtohome_var1_var6) (del_value_sendtohome_var2_var4) (del_value_sendtohome_var2_var6) (del_value_sendtohome_var5_var4) (del_value_sendtohome_var5_var6) (del_value_sendtonewcol_var1_var3) (del_value_sendtonewcol_var1_var4) (del_value_sendtonewcol_var2_var3) (del_value_sendtonewcol_var2_var4) (home ?o1 - card) (incell ?o1 - card) (inext ?i1 - step ?i2 - step) (modeProg) (on ?o1 - card ?o2 - card) (plan-colfromfreecell ?i - step ?o1 - card ?o2 - card ?o3 - num ?o4 - num) (plan-homefromfreecell ?i - step ?o1 - card ?o2 - suit ?o3 - num ?o4 - card ?o5 - num ?o6 - num ?o7 - num) (plan-move ?i - step ?o1 - card ?o2 - card ?o3 - card) (plan-move-b ?i - step ?o1 - card ?o2 - card ?o3 - num ?o4 - num) (plan-newcolfromfreecell ?i - step ?o1 - card ?o2 - num ?o3 - num ?o4 - num ?o5 - num) (plan-sendtofree ?i - step ?o1 - card ?o2 - card ?o3 - num ?o4 - num) (plan-sendtofree-b ?i - step ?o1 - card ?o2 - num ?o3 - num ?o4 - num ?o5 - num) (plan-sendtohome ?i - step ?o1 - card ?o2 - card ?o3 - suit ?o4 - num ?o5 - card ?o6 - num) (plan-sendtohome-b ?i - step ?o1 - card ?o2 - suit ?o3 - num ?o4 - card ?o5 - num ?o6 - num ?o7 - num) (plan-sendtonewcol ?i - step ?o1 - card ?o2 - card ?o3 - num ?o4 - num) (pre_bottomcol_colfromfreecell_var1) (pre_bottomcol_colfromfreecell_var2) (pre_bottomcol_homefromfreecell_var1) (pre_bottomcol_homefromfreecell_var4) (pre_bottomcol_move-b_var1) (pre_bottomcol_move-b_var2) (pre_bottomcol_move_var1) (pre_bottomcol_move_var2) (pre_bottomcol_move_var3) (pre_bottomcol_newcolfromfreecell_var1) (pre_bottomcol_sendtofree-b_var1) (pre_bottomcol_sendtofree_var1) (pre_bottomcol_sendtofree_var2) (pre_bottomcol_sendtohome-b_var1) (pre_bottomcol_sendtohome-b_var4) (pre_bottomcol_sendtohome_var1) (pre_bottomcol_sendtohome_var2) (pre_bottomcol_sendtohome_var5) (pre_bottomcol_sendtonewcol_var1) (pre_bottomcol_sendtonewcol_var2) (pre_canstack_colfromfreecell_var1_var1) (pre_canstack_colfromfreecell_var1_var2) (pre_canstack_colfromfreecell_var2_var1) (pre_canstack_colfromfreecell_var2_var2) (pre_canstack_homefromfreecell_var1_var1) (pre_canstack_homefromfreecell_var1_var4) (pre_canstack_homefromfreecell_var4_var1) (pre_canstack_homefromfreecell_var4_var4) (pre_canstack_move-b_var1_var1) (pre_canstack_move-b_var1_var2) (pre_canstack_move-b_var2_var1) (pre_canstack_move-b_var2_var2) (pre_canstack_move_var1_var1) (pre_canstack_move_var1_var2) (pre_canstack_move_var1_var3) (pre_canstack_move_var2_var1) (pre_canstack_move_var2_var2) (pre_canstack_move_var2_var3) (pre_canstack_move_var3_var1) (pre_canstack_move_var3_var2) (pre_canstack_move_var3_var3) (pre_canstack_newcolfromfreecell_var1_var1) (pre_canstack_sendtofree-b_var1_var1) (pre_canstack_sendtofree_var1_var1) (pre_canstack_sendtofree_var1_var2) (pre_canstack_sendtofree_var2_var1) (pre_canstack_sendtofree_var2_var2) (pre_canstack_sendtohome-b_var1_var1) (pre_canstack_sendtohome-b_var1_var4) (pre_canstack_sendtohome-b_var4_var1) (pre_canstack_sendtohome-b_var4_var4) (pre_canstack_sendtohome_var1_var1) (pre_canstack_sendtohome_var1_var2) (pre_canstack_sendtohome_var1_var5) (pre_canstack_sendtohome_var2_var1) (pre_canstack_sendtohome_var2_var2) (pre_canstack_sendtohome_var2_var5) (pre_canstack_sendtohome_var5_var1) (pre_canstack_sendtohome_var5_var2) (pre_canstack_sendtohome_var5_var5) (pre_canstack_sendtonewcol_var1_var1) (pre_canstack_sendtonewcol_var1_var2) (pre_canstack_sendtonewcol_var2_var1) (pre_canstack_sendtonewcol_var2_var2) (pre_cellspace_colfromfreecell_var3) (pre_cellspace_colfromfreecell_var4) (pre_cellspace_homefromfreecell_var3) (pre_cellspace_homefromfreecell_var5) (pre_cellspace_homefromfreecell_var6) (pre_cellspace_homefromfreecell_var7) (pre_cellspace_move-b_var3) (pre_cellspace_move-b_var4) (pre_cellspace_newcolfromfreecell_var2) (pre_cellspace_newcolfromfreecell_var3) (pre_cellspace_newcolfromfreecell_var4) (pre_cellspace_newcolfromfreecell_var5) (pre_cellspace_sendtofree-b_var2) (pre_cellspace_sendtofree-b_var3) (pre_cellspace_sendtofree-b_var4) (pre_cellspace_sendtofree-b_var5) (pre_cellspace_sendtofree_var3) (pre_cellspace_sendtofree_var4) (pre_cellspace_sendtohome-b_var3) (pre_cellspace_sendtohome-b_var5) (pre_cellspace_sendtohome-b_var6) (pre_cellspace_sendtohome-b_var7) (pre_cellspace_sendtohome_var4) (pre_cellspace_sendtohome_var6) (pre_cellspace_sendtonewcol_var3) (pre_cellspace_sendtonewcol_var4) (pre_clear_colfromfreecell_var1) (pre_clear_colfromfreecell_var2) (pre_clear_homefromfreecell_var1) (pre_clear_homefromfreecell_var4) (pre_clear_move-b_var1) (pre_clear_move-b_var2) (pre_clear_move_var1) (pre_clear_move_var2) (pre_clear_move_var3) (pre_clear_newcolfromfreecell_var1) (pre_clear_sendtofree-b_var1) (pre_clear_sendtofree_var1) (pre_clear_sendtofree_var2) (pre_clear_sendtohome-b_var1) (pre_clear_sendtohome-b_var4) (pre_clear_sendtohome_var1) (pre_clear_sendtohome_var2) (pre_clear_sendtohome_var5) (pre_clear_sendtonewcol_var1) (pre_clear_sendtonewcol_var2) (pre_colspace_colfromfreecell_var3) (pre_colspace_colfromfreecell_var4) (pre_colspace_homefromfreecell_var3) (pre_colspace_homefromfreecell_var5) (pre_colspace_homefromfreecell_var6) (pre_colspace_homefromfreecell_var7) (pre_colspace_move-b_var3) (pre_colspace_move-b_var4) (pre_colspace_newcolfromfreecell_var2) (pre_colspace_newcolfromfreecell_var3) (pre_colspace_newcolfromfreecell_var4) (pre_colspace_newcolfromfreecell_var5) (pre_colspace_sendtofree-b_var2) (pre_colspace_sendtofree-b_var3) (pre_colspace_sendtofree-b_var4) (pre_colspace_sendtofree-b_var5) (pre_colspace_sendtofree_var3) (pre_colspace_sendtofree_var4) (pre_colspace_sendtohome-b_var3) (pre_colspace_sendtohome-b_var5) (pre_colspace_sendtohome-b_var6) (pre_colspace_sendtohome-b_var7) (pre_colspace_sendtohome_var4) (pre_colspace_sendtohome_var6) (pre_colspace_sendtonewcol_var3) (pre_colspace_sendtonewcol_var4) (pre_home_colfromfreecell_var1) (pre_home_colfromfreecell_var2) (pre_home_homefromfreecell_var1) (pre_home_homefromfreecell_var4) (pre_home_move-b_var1) (pre_home_move-b_var2) (pre_home_move_var1) (pre_home_move_var2) (pre_home_move_var3) (pre_home_newcolfromfreecell_var1) (pre_home_sendtofree-b_var1) (pre_home_sendtofree_var1) (pre_home_sendtofree_var2) (pre_home_sendtohome-b_var1) (pre_home_sendtohome-b_var4) (pre_home_sendtohome_var1) (pre_home_sendtohome_var2) (pre_home_sendtohome_var5) (pre_home_sendtonewcol_var1) (pre_home_sendtonewcol_var2) (pre_incell_colfromfreecell_var1) (pre_incell_colfromfreecell_var2) (pre_incell_homefromfreecell_var1) (pre_incell_homefromfreecell_var4) (pre_incell_move-b_var1) (pre_incell_move-b_var2) (pre_incell_move_var1) (pre_incell_move_var2) (pre_incell_move_var3) (pre_incell_newcolfromfreecell_var1) (pre_incell_sendtofree-b_var1) (pre_incell_sendtofree_var1) (pre_incell_sendtofree_var2) (pre_incell_sendtohome-b_var1) (pre_incell_sendtohome-b_var4) (pre_incell_sendtohome_var1) (pre_incell_sendtohome_var2) (pre_incell_sendtohome_var5) (pre_incell_sendtonewcol_var1) (pre_incell_sendtonewcol_var2) (pre_on_colfromfreecell_var1_var1) (pre_on_colfromfreecell_var1_var2) (pre_on_colfromfreecell_var2_var1) (pre_on_colfromfreecell_var2_var2) (pre_on_homefromfreecell_var1_var1) (pre_on_homefromfreecell_var1_var4) (pre_on_homefromfreecell_var4_var1) (pre_on_homefromfreecell_var4_var4) (pre_on_move-b_var1_var1) (pre_on_move-b_var1_var2) (pre_on_move-b_var2_var1) (pre_on_move-b_var2_var2) (pre_on_move_var1_var1) (pre_on_move_var1_var2) (pre_on_move_var1_var3) (pre_on_move_var2_var1) (pre_on_move_var2_var2) (pre_on_move_var2_var3) (pre_on_move_var3_var1) (pre_on_move_var3_var2) (pre_on_move_var3_var3) (pre_on_newcolfromfreecell_var1_var1) (pre_on_sendtofree-b_var1_var1) (pre_on_sendtofree_var1_var1) (pre_on_sendtofree_var1_var2) (pre_on_sendtofree_var2_var1) (pre_on_sendtofree_var2_var2) (pre_on_sendtohome-b_var1_var1) (pre_on_sendtohome-b_var1_var4) (pre_on_sendtohome-b_var4_var1) (pre_on_sendtohome-b_var4_var4) (pre_on_sendtohome_var1_var1) (pre_on_sendtohome_var1_var2) (pre_on_sendtohome_var1_var5) (pre_on_sendtohome_var2_var1) (pre_on_sendtohome_var2_var2) (pre_on_sendtohome_var2_var5) (pre_on_sendtohome_var5_var1) (pre_on_sendtohome_var5_var2) (pre_on_sendtohome_var5_var5) (pre_on_sendtonewcol_var1_var1) (pre_on_sendtonewcol_var1_var2) (pre_on_sendtonewcol_var2_var1) (pre_on_sendtonewcol_var2_var2) (pre_successor_colfromfreecell_var3_var3) (pre_successor_colfromfreecell_var3_var4) (pre_successor_colfromfreecell_var4_var3) (pre_successor_colfromfreecell_var4_var4) (pre_successor_homefromfreecell_var3_var3) (pre_successor_homefromfreecell_var3_var5) (pre_successor_homefromfreecell_var3_var6) (pre_successor_homefromfreecell_var3_var7) (pre_successor_homefromfreecell_var5_var3) (pre_successor_homefromfreecell_var5_var5) (pre_successor_homefromfreecell_var5_var6) (pre_successor_homefromfreecell_var5_var7) (pre_successor_homefromfreecell_var6_var3) (pre_successor_homefromfreecell_var6_var5) (pre_successor_homefromfreecell_var6_var6) (pre_successor_homefromfreecell_var6_var7) (pre_successor_homefromfreecell_var7_var3) (pre_successor_homefromfreecell_var7_var5) (pre_successor_homefromfreecell_var7_var6) (pre_successor_homefromfreecell_var7_var7) (pre_successor_move-b_var3_var3) (pre_successor_move-b_var3_var4) (pre_successor_move-b_var4_var3) (pre_successor_move-b_var4_var4) (pre_successor_newcolfromfreecell_var2_var2) (pre_successor_newcolfromfreecell_var2_var3) (pre_successor_newcolfromfreecell_var2_var4) (pre_successor_newcolfromfreecell_var2_var5) (pre_successor_newcolfromfreecell_var3_var2) (pre_successor_newcolfromfreecell_var3_var3) (pre_successor_newcolfromfreecell_var3_var4) (pre_successor_newcolfromfreecell_var3_var5) (pre_successor_newcolfromfreecell_var4_var2) (pre_successor_newcolfromfreecell_var4_var3) (pre_successor_newcolfromfreecell_var4_var4) (pre_successor_newcolfromfreecell_var4_var5) (pre_successor_newcolfromfreecell_var5_var2) (pre_successor_newcolfromfreecell_var5_var3) (pre_successor_newcolfromfreecell_var5_var4) (pre_successor_newcolfromfreecell_var5_var5) (pre_successor_sendtofree-b_var2_var2) (pre_successor_sendtofree-b_var2_var3) (pre_successor_sendtofree-b_var2_var4) (pre_successor_sendtofree-b_var2_var5) (pre_successor_sendtofree-b_var3_var2) (pre_successor_sendtofree-b_var3_var3) (pre_successor_sendtofree-b_var3_var4) (pre_successor_sendtofree-b_var3_var5) (pre_successor_sendtofree-b_var4_var2) (pre_successor_sendtofree-b_var4_var3) (pre_successor_sendtofree-b_var4_var4) (pre_successor_sendtofree-b_var4_var5) (pre_successor_sendtofree-b_var5_var2) (pre_successor_sendtofree-b_var5_var3) (pre_successor_sendtofree-b_var5_var4) (pre_successor_sendtofree-b_var5_var5) (pre_successor_sendtofree_var3_var3) (pre_successor_sendtofree_var3_var4) (pre_successor_sendtofree_var4_var3) (pre_successor_sendtofree_var4_var4) (pre_successor_sendtohome-b_var3_var3) (pre_successor_sendtohome-b_var3_var5) (pre_successor_sendtohome-b_var3_var6) (pre_successor_sendtohome-b_var3_var7) (pre_successor_sendtohome-b_var5_var3) (pre_successor_sendtohome-b_var5_var5) (pre_successor_sendtohome-b_var5_var6) (pre_successor_sendtohome-b_var5_var7) (pre_successor_sendtohome-b_var6_var3) (pre_successor_sendtohome-b_var6_var5) (pre_successor_sendtohome-b_var6_var6) (pre_successor_sendtohome-b_var6_var7) (pre_successor_sendtohome-b_var7_var3) (pre_successor_sendtohome-b_var7_var5) (pre_successor_sendtohome-b_var7_var6) (pre_successor_sendtohome-b_var7_var7) (pre_successor_sendtohome_var4_var4) (pre_successor_sendtohome_var4_var6) (pre_successor_sendtohome_var6_var4) (pre_successor_sendtohome_var6_var6) (pre_successor_sendtonewcol_var3_var3) (pre_successor_sendtonewcol_var3_var4) (pre_successor_sendtonewcol_var4_var3) (pre_successor_sendtonewcol_var4_var4) (pre_suit_homefromfreecell_var1_var2) (pre_suit_homefromfreecell_var4_var2) (pre_suit_sendtohome-b_var1_var2) (pre_suit_sendtohome-b_var4_var2) (pre_suit_sendtohome_var1_var3) (pre_suit_sendtohome_var2_var3) (pre_suit_sendtohome_var5_var3) (pre_value_colfromfreecell_var1_var3) (pre_value_colfromfreecell_var1_var4) (pre_value_colfromfreecell_var2_var3) (pre_value_colfromfreecell_var2_var4) (pre_value_homefromfreecell_var1_var3) (pre_value_homefromfreecell_var1_var5) (pre_value_homefromfreecell_var1_var6) (pre_value_homefromfreecell_var1_var7) (pre_value_homefromfreecell_var4_var3) (pre_value_homefromfreecell_var4_var5) (pre_value_homefromfreecell_var4_var6) (pre_value_homefromfreecell_var4_var7) (pre_value_move-b_var1_var3) (pre_value_move-b_var1_var4) (pre_value_move-b_var2_var3) (pre_value_move-b_var2_var4) (pre_value_newcolfromfreecell_var1_var2) (pre_value_newcolfromfreecell_var1_var3) (pre_value_newcolfromfreecell_var1_var4) (pre_value_newcolfromfreecell_var1_var5) (pre_value_sendtofree-b_var1_var2) (pre_value_sendtofree-b_var1_var3) (pre_value_sendtofree-b_var1_var4) (pre_value_sendtofree-b_var1_var5) (pre_value_sendtofree_var1_var3) (pre_value_sendtofree_var1_var4) (pre_value_sendtofree_var2_var3) (pre_value_sendtofree_var2_var4) (pre_value_sendtohome-b_var1_var3) (pre_value_sendtohome-b_var1_var5) (pre_value_sendtohome-b_var1_var6) (pre_value_sendtohome-b_var1_var7) (pre_value_sendtohome-b_var4_var3) (pre_value_sendtohome-b_var4_var5) (pre_value_sendtohome-b_var4_var6) (pre_value_sendtohome-b_var4_var7) (pre_value_sendtohome_var1_var4) (pre_value_sendtohome_var1_var6) (pre_value_sendtohome_var2_var4) (pre_value_sendtohome_var2_var6) (pre_value_sendtohome_var5_var4) (pre_value_sendtohome_var5_var6) (pre_value_sendtonewcol_var1_var3) (pre_value_sendtonewcol_var1_var4) (pre_value_sendtonewcol_var2_var3) (pre_value_sendtonewcol_var2_var4) (successor ?o1 - num ?o2 - num) (suit ?o1 - card ?o2 - suit) (test1) (test10) (test11) (test12) (test13) (test14) (test15) (test16) (test17) (test18) (test19) (test2) (test20) (test21) (test22) (test23) (test24) (test25) (test26) (test27) (test28) (test3) (test4) (test5) (test6) (test7) (test8) (test9) (value ?o1 - card ?o2 - num))

 (:action move
   :parameters (?o1 - card ?o2 - card ?o3 - card ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(or (not (pre_on_move_var1_var1 ))(on ?o1 ?o1))(or (not (pre_on_move_var1_var2 ))(on ?o1 ?o2))(or (not (pre_on_move_var1_var3 ))(on ?o1 ?o3))(or (not (pre_on_move_var2_var1 ))(on ?o2 ?o1))(or (not (pre_on_move_var2_var2 ))(on ?o2 ?o2))(or (not (pre_on_move_var2_var3 ))(on ?o2 ?o3))(or (not (pre_on_move_var3_var1 ))(on ?o3 ?o1))(or (not (pre_on_move_var3_var2 ))(on ?o3 ?o2))(or (not (pre_on_move_var3_var3 ))(on ?o3 ?o3))(or (not (pre_incell_move_var1 ))(incell ?o1))(or (not (pre_incell_move_var2 ))(incell ?o2))(or (not (pre_incell_move_var3 ))(incell ?o3))(or (not (pre_clear_move_var1 ))(clear ?o1))(or (not (pre_clear_move_var2 ))(clear ?o2))(or (not (pre_clear_move_var3 ))(clear ?o3))(or (not (pre_home_move_var1 ))(home ?o1))(or (not (pre_home_move_var2 ))(home ?o2))(or (not (pre_home_move_var3 ))(home ?o3))(or (not (pre_bottomcol_move_var1 ))(bottomcol ?o1))(or (not (pre_bottomcol_move_var2 ))(bottomcol ?o2))(or (not (pre_bottomcol_move_var3 ))(bottomcol ?o3))(or (not (pre_canstack_move_var1_var1 ))(canstack ?o1 ?o1))(or (not (pre_canstack_move_var1_var2 ))(canstack ?o1 ?o2))(or (not (pre_canstack_move_var1_var3 ))(canstack ?o1 ?o3))(or (not (pre_canstack_move_var2_var1 ))(canstack ?o2 ?o1))(or (not (pre_canstack_move_var2_var2 ))(canstack ?o2 ?o2))(or (not (pre_canstack_move_var2_var3 ))(canstack ?o2 ?o3))(or (not (pre_canstack_move_var3_var1 ))(canstack ?o3 ?o1))(or (not (pre_canstack_move_var3_var2 ))(canstack ?o3 ?o2))(or (not (pre_canstack_move_var3_var3 ))(canstack ?o3 ?o3))(current ?i1)(inext ?i1 ?i2)(plan-move ?i1 ?o1 ?o2 ?o3))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)(when (and (del_on_move_var1_var1 ))(not (on ?o1 ?o1)))(when (and (add_on_move_var1_var1 ))(on ?o1 ?o1))(when (and (del_on_move_var1_var2 ))(not (on ?o1 ?o2)))(when (and (add_on_move_var1_var2 ))(on ?o1 ?o2))(when (and (del_on_move_var1_var3 ))(not (on ?o1 ?o3)))(when (and (add_on_move_var1_var3 ))(on ?o1 ?o3))(when (and (del_on_move_var2_var1 ))(not (on ?o2 ?o1)))(when (and (add_on_move_var2_var1 ))(on ?o2 ?o1))(when (and (del_on_move_var2_var2 ))(not (on ?o2 ?o2)))(when (and (add_on_move_var2_var2 ))(on ?o2 ?o2))(when (and (del_on_move_var2_var3 ))(not (on ?o2 ?o3)))(when (and (add_on_move_var2_var3 ))(on ?o2 ?o3))(when (and (del_on_move_var3_var1 ))(not (on ?o3 ?o1)))(when (and (add_on_move_var3_var1 ))(on ?o3 ?o1))(when (and (del_on_move_var3_var2 ))(not (on ?o3 ?o2)))(when (and (add_on_move_var3_var2 ))(on ?o3 ?o2))(when (and (del_on_move_var3_var3 ))(not (on ?o3 ?o3)))(when (and (add_on_move_var3_var3 ))(on ?o3 ?o3))(when (and (del_incell_move_var1 ))(not (incell ?o1)))(when (and (add_incell_move_var1 ))(incell ?o1))(when (and (del_incell_move_var2 ))(not (incell ?o2)))(when (and (add_incell_move_var2 ))(incell ?o2))(when (and (del_incell_move_var3 ))(not (incell ?o3)))(when (and (add_incell_move_var3 ))(incell ?o3))(when (and (del_clear_move_var1 ))(not (clear ?o1)))(when (and (add_clear_move_var1 ))(clear ?o1))(when (and (del_clear_move_var2 ))(not (clear ?o2)))(when (and (add_clear_move_var2 ))(clear ?o2))(when (and (del_clear_move_var3 ))(not (clear ?o3)))(when (and (add_clear_move_var3 ))(clear ?o3))(when (and (del_home_move_var1 ))(not (home ?o1)))(when (and (add_home_move_var1 ))(home ?o1))(when (and (del_home_move_var2 ))(not (home ?o2)))(when (and (add_home_move_var2 ))(home ?o2))(when (and (del_home_move_var3 ))(not (home ?o3)))(when (and (add_home_move_var3 ))(home ?o3))(when (and (del_bottomcol_move_var1 ))(not (bottomcol ?o1)))(when (and (add_bottomcol_move_var1 ))(bottomcol ?o1))(when (and (del_bottomcol_move_var2 ))(not (bottomcol ?o2)))(when (and (add_bottomcol_move_var2 ))(bottomcol ?o2))(when (and (del_bottomcol_move_var3 ))(not (bottomcol ?o3)))(when (and (add_bottomcol_move_var3 ))(bottomcol ?o3))(when (and (del_canstack_move_var1_var1 ))(not (canstack ?o1 ?o1)))(when (and (add_canstack_move_var1_var1 ))(canstack ?o1 ?o1))(when (and (del_canstack_move_var1_var2 ))(not (canstack ?o1 ?o2)))(when (and (add_canstack_move_var1_var2 ))(canstack ?o1 ?o2))(when (and (del_canstack_move_var1_var3 ))(not (canstack ?o1 ?o3)))(when (and (add_canstack_move_var1_var3 ))(canstack ?o1 ?o3))(when (and (del_canstack_move_var2_var1 ))(not (canstack ?o2 ?o1)))(when (and (add_canstack_move_var2_var1 ))(canstack ?o2 ?o1))(when (and (del_canstack_move_var2_var2 ))(not (canstack ?o2 ?o2)))(when (and (add_canstack_move_var2_var2 ))(canstack ?o2 ?o2))(when (and (del_canstack_move_var2_var3 ))(not (canstack ?o2 ?o3)))(when (and (add_canstack_move_var2_var3 ))(canstack ?o2 ?o3))(when (and (del_canstack_move_var3_var1 ))(not (canstack ?o3 ?o1)))(when (and (add_canstack_move_var3_var1 ))(canstack ?o3 ?o1))(when (and (del_canstack_move_var3_var2 ))(not (canstack ?o3 ?o2)))(when (and (add_canstack_move_var3_var2 ))(canstack ?o3 ?o2))(when (and (del_canstack_move_var3_var3 ))(not (canstack ?o3 ?o3)))(when (and (add_canstack_move_var3_var3 ))(canstack ?o3 ?o3))))

 (:action move-b
   :parameters (?o1 - card ?o2 - card ?o3 - num ?o4 - num ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(or (not (pre_on_move-b_var1_var1 ))(on ?o1 ?o1))(or (not (pre_on_move-b_var1_var2 ))(on ?o1 ?o2))(or (not (pre_on_move-b_var2_var1 ))(on ?o2 ?o1))(or (not (pre_on_move-b_var2_var2 ))(on ?o2 ?o2))(or (not (pre_incell_move-b_var1 ))(incell ?o1))(or (not (pre_incell_move-b_var2 ))(incell ?o2))(or (not (pre_clear_move-b_var1 ))(clear ?o1))(or (not (pre_clear_move-b_var2 ))(clear ?o2))(or (not (pre_cellspace_move-b_var3 ))(cellspace ?o3))(or (not (pre_cellspace_move-b_var4 ))(cellspace ?o4))(or (not (pre_colspace_move-b_var3 ))(colspace ?o3))(or (not (pre_colspace_move-b_var4 ))(colspace ?o4))(or (not (pre_home_move-b_var1 ))(home ?o1))(or (not (pre_home_move-b_var2 ))(home ?o2))(or (not (pre_bottomcol_move-b_var1 ))(bottomcol ?o1))(or (not (pre_bottomcol_move-b_var2 ))(bottomcol ?o2))(or (not (pre_canstack_move-b_var1_var1 ))(canstack ?o1 ?o1))(or (not (pre_canstack_move-b_var1_var2 ))(canstack ?o1 ?o2))(or (not (pre_canstack_move-b_var2_var1 ))(canstack ?o2 ?o1))(or (not (pre_canstack_move-b_var2_var2 ))(canstack ?o2 ?o2))(or (not (pre_value_move-b_var1_var3 ))(value ?o1 ?o3))(or (not (pre_value_move-b_var1_var4 ))(value ?o1 ?o4))(or (not (pre_value_move-b_var2_var3 ))(value ?o2 ?o3))(or (not (pre_value_move-b_var2_var4 ))(value ?o2 ?o4))(or (not (pre_successor_move-b_var3_var3 ))(successor ?o3 ?o3))(or (not (pre_successor_move-b_var3_var4 ))(successor ?o3 ?o4))(or (not (pre_successor_move-b_var4_var3 ))(successor ?o4 ?o3))(or (not (pre_successor_move-b_var4_var4 ))(successor ?o4 ?o4))(current ?i1)(inext ?i1 ?i2)(plan-move-b ?i1 ?o1 ?o2 ?o3 ?o4))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)(when (and (del_on_move-b_var1_var1 ))(not (on ?o1 ?o1)))(when (and (add_on_move-b_var1_var1 ))(on ?o1 ?o1))(when (and (del_on_move-b_var1_var2 ))(not (on ?o1 ?o2)))(when (and (add_on_move-b_var1_var2 ))(on ?o1 ?o2))(when (and (del_on_move-b_var2_var1 ))(not (on ?o2 ?o1)))(when (and (add_on_move-b_var2_var1 ))(on ?o2 ?o1))(when (and (del_on_move-b_var2_var2 ))(not (on ?o2 ?o2)))(when (and (add_on_move-b_var2_var2 ))(on ?o2 ?o2))(when (and (del_incell_move-b_var1 ))(not (incell ?o1)))(when (and (add_incell_move-b_var1 ))(incell ?o1))(when (and (del_incell_move-b_var2 ))(not (incell ?o2)))(when (and (add_incell_move-b_var2 ))(incell ?o2))(when (and (del_clear_move-b_var1 ))(not (clear ?o1)))(when (and (add_clear_move-b_var1 ))(clear ?o1))(when (and (del_clear_move-b_var2 ))(not (clear ?o2)))(when (and (add_clear_move-b_var2 ))(clear ?o2))(when (and (del_cellspace_move-b_var3 ))(not (cellspace ?o3)))(when (and (add_cellspace_move-b_var3 ))(cellspace ?o3))(when (and (del_cellspace_move-b_var4 ))(not (cellspace ?o4)))(when (and (add_cellspace_move-b_var4 ))(cellspace ?o4))(when (and (del_colspace_move-b_var3 ))(not (colspace ?o3)))(when (and (add_colspace_move-b_var3 ))(colspace ?o3))(when (and (del_colspace_move-b_var4 ))(not (colspace ?o4)))(when (and (add_colspace_move-b_var4 ))(colspace ?o4))(when (and (del_home_move-b_var1 ))(not (home ?o1)))(when (and (add_home_move-b_var1 ))(home ?o1))(when (and (del_home_move-b_var2 ))(not (home ?o2)))(when (and (add_home_move-b_var2 ))(home ?o2))(when (and (del_bottomcol_move-b_var1 ))(not (bottomcol ?o1)))(when (and (add_bottomcol_move-b_var1 ))(bottomcol ?o1))(when (and (del_bottomcol_move-b_var2 ))(not (bottomcol ?o2)))(when (and (add_bottomcol_move-b_var2 ))(bottomcol ?o2))(when (and (del_canstack_move-b_var1_var1 ))(not (canstack ?o1 ?o1)))(when (and (add_canstack_move-b_var1_var1 ))(canstack ?o1 ?o1))(when (and (del_canstack_move-b_var1_var2 ))(not (canstack ?o1 ?o2)))(when (and (add_canstack_move-b_var1_var2 ))(canstack ?o1 ?o2))(when (and (del_canstack_move-b_var2_var1 ))(not (canstack ?o2 ?o1)))(when (and (add_canstack_move-b_var2_var1 ))(canstack ?o2 ?o1))(when (and (del_canstack_move-b_var2_var2 ))(not (canstack ?o2 ?o2)))(when (and (add_canstack_move-b_var2_var2 ))(canstack ?o2 ?o2))(when (and (del_value_move-b_var1_var3 ))(not (value ?o1 ?o3)))(when (and (add_value_move-b_var1_var3 ))(value ?o1 ?o3))(when (and (del_value_move-b_var1_var4 ))(not (value ?o1 ?o4)))(when (and (add_value_move-b_var1_var4 ))(value ?o1 ?o4))(when (and (del_value_move-b_var2_var3 ))(not (value ?o2 ?o3)))(when (and (add_value_move-b_var2_var3 ))(value ?o2 ?o3))(when (and (del_value_move-b_var2_var4 ))(not (value ?o2 ?o4)))(when (and (add_value_move-b_var2_var4 ))(value ?o2 ?o4))(when (and (del_successor_move-b_var3_var3 ))(not (successor ?o3 ?o3)))(when (and (add_successor_move-b_var3_var3 ))(successor ?o3 ?o3))(when (and (del_successor_move-b_var3_var4 ))(not (successor ?o3 ?o4)))(when (and (add_successor_move-b_var3_var4 ))(successor ?o3 ?o4))(when (and (del_successor_move-b_var4_var3 ))(not (successor ?o4 ?o3)))(when (and (add_successor_move-b_var4_var3 ))(successor ?o4 ?o3))(when (and (del_successor_move-b_var4_var4 ))(not (successor ?o4 ?o4)))(when (and (add_successor_move-b_var4_var4 ))(successor ?o4 ?o4))))

 (:action sendtofree
   :parameters (?o1 - card ?o2 - card ?o3 - num ?o4 - num ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(or (not (pre_on_sendtofree_var1_var1 ))(on ?o1 ?o1))(or (not (pre_on_sendtofree_var1_var2 ))(on ?o1 ?o2))(or (not (pre_on_sendtofree_var2_var1 ))(on ?o2 ?o1))(or (not (pre_on_sendtofree_var2_var2 ))(on ?o2 ?o2))(or (not (pre_incell_sendtofree_var1 ))(incell ?o1))(or (not (pre_incell_sendtofree_var2 ))(incell ?o2))(or (not (pre_clear_sendtofree_var1 ))(clear ?o1))(or (not (pre_clear_sendtofree_var2 ))(clear ?o2))(or (not (pre_cellspace_sendtofree_var3 ))(cellspace ?o3))(or (not (pre_cellspace_sendtofree_var4 ))(cellspace ?o4))(or (not (pre_colspace_sendtofree_var3 ))(colspace ?o3))(or (not (pre_colspace_sendtofree_var4 ))(colspace ?o4))(or (not (pre_home_sendtofree_var1 ))(home ?o1))(or (not (pre_home_sendtofree_var2 ))(home ?o2))(or (not (pre_bottomcol_sendtofree_var1 ))(bottomcol ?o1))(or (not (pre_bottomcol_sendtofree_var2 ))(bottomcol ?o2))(or (not (pre_canstack_sendtofree_var1_var1 ))(canstack ?o1 ?o1))(or (not (pre_canstack_sendtofree_var1_var2 ))(canstack ?o1 ?o2))(or (not (pre_canstack_sendtofree_var2_var1 ))(canstack ?o2 ?o1))(or (not (pre_canstack_sendtofree_var2_var2 ))(canstack ?o2 ?o2))(or (not (pre_value_sendtofree_var1_var3 ))(value ?o1 ?o3))(or (not (pre_value_sendtofree_var1_var4 ))(value ?o1 ?o4))(or (not (pre_value_sendtofree_var2_var3 ))(value ?o2 ?o3))(or (not (pre_value_sendtofree_var2_var4 ))(value ?o2 ?o4))(or (not (pre_successor_sendtofree_var3_var3 ))(successor ?o3 ?o3))(or (not (pre_successor_sendtofree_var3_var4 ))(successor ?o3 ?o4))(or (not (pre_successor_sendtofree_var4_var3 ))(successor ?o4 ?o3))(or (not (pre_successor_sendtofree_var4_var4 ))(successor ?o4 ?o4))(current ?i1)(inext ?i1 ?i2)(plan-sendtofree ?i1 ?o1 ?o2 ?o3 ?o4))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)(when (and (del_on_sendtofree_var1_var1 ))(not (on ?o1 ?o1)))(when (and (add_on_sendtofree_var1_var1 ))(on ?o1 ?o1))(when (and (del_on_sendtofree_var1_var2 ))(not (on ?o1 ?o2)))(when (and (add_on_sendtofree_var1_var2 ))(on ?o1 ?o2))(when (and (del_on_sendtofree_var2_var1 ))(not (on ?o2 ?o1)))(when (and (add_on_sendtofree_var2_var1 ))(on ?o2 ?o1))(when (and (del_on_sendtofree_var2_var2 ))(not (on ?o2 ?o2)))(when (and (add_on_sendtofree_var2_var2 ))(on ?o2 ?o2))(when (and (del_incell_sendtofree_var1 ))(not (incell ?o1)))(when (and (add_incell_sendtofree_var1 ))(incell ?o1))(when (and (del_incell_sendtofree_var2 ))(not (incell ?o2)))(when (and (add_incell_sendtofree_var2 ))(incell ?o2))(when (and (del_clear_sendtofree_var1 ))(not (clear ?o1)))(when (and (add_clear_sendtofree_var1 ))(clear ?o1))(when (and (del_clear_sendtofree_var2 ))(not (clear ?o2)))(when (and (add_clear_sendtofree_var2 ))(clear ?o2))(when (and (del_cellspace_sendtofree_var3 ))(not (cellspace ?o3)))(when (and (add_cellspace_sendtofree_var3 ))(cellspace ?o3))(when (and (del_cellspace_sendtofree_var4 ))(not (cellspace ?o4)))(when (and (add_cellspace_sendtofree_var4 ))(cellspace ?o4))(when (and (del_colspace_sendtofree_var3 ))(not (colspace ?o3)))(when (and (add_colspace_sendtofree_var3 ))(colspace ?o3))(when (and (del_colspace_sendtofree_var4 ))(not (colspace ?o4)))(when (and (add_colspace_sendtofree_var4 ))(colspace ?o4))(when (and (del_home_sendtofree_var1 ))(not (home ?o1)))(when (and (add_home_sendtofree_var1 ))(home ?o1))(when (and (del_home_sendtofree_var2 ))(not (home ?o2)))(when (and (add_home_sendtofree_var2 ))(home ?o2))(when (and (del_bottomcol_sendtofree_var1 ))(not (bottomcol ?o1)))(when (and (add_bottomcol_sendtofree_var1 ))(bottomcol ?o1))(when (and (del_bottomcol_sendtofree_var2 ))(not (bottomcol ?o2)))(when (and (add_bottomcol_sendtofree_var2 ))(bottomcol ?o2))(when (and (del_canstack_sendtofree_var1_var1 ))(not (canstack ?o1 ?o1)))(when (and (add_canstack_sendtofree_var1_var1 ))(canstack ?o1 ?o1))(when (and (del_canstack_sendtofree_var1_var2 ))(not (canstack ?o1 ?o2)))(when (and (add_canstack_sendtofree_var1_var2 ))(canstack ?o1 ?o2))(when (and (del_canstack_sendtofree_var2_var1 ))(not (canstack ?o2 ?o1)))(when (and (add_canstack_sendtofree_var2_var1 ))(canstack ?o2 ?o1))(when (and (del_canstack_sendtofree_var2_var2 ))(not (canstack ?o2 ?o2)))(when (and (add_canstack_sendtofree_var2_var2 ))(canstack ?o2 ?o2))(when (and (del_value_sendtofree_var1_var3 ))(not (value ?o1 ?o3)))(when (and (add_value_sendtofree_var1_var3 ))(value ?o1 ?o3))(when (and (del_value_sendtofree_var1_var4 ))(not (value ?o1 ?o4)))(when (and (add_value_sendtofree_var1_var4 ))(value ?o1 ?o4))(when (and (del_value_sendtofree_var2_var3 ))(not (value ?o2 ?o3)))(when (and (add_value_sendtofree_var2_var3 ))(value ?o2 ?o3))(when (and (del_value_sendtofree_var2_var4 ))(not (value ?o2 ?o4)))(when (and (add_value_sendtofree_var2_var4 ))(value ?o2 ?o4))(when (and (del_successor_sendtofree_var3_var3 ))(not (successor ?o3 ?o3)))(when (and (add_successor_sendtofree_var3_var3 ))(successor ?o3 ?o3))(when (and (del_successor_sendtofree_var3_var4 ))(not (successor ?o3 ?o4)))(when (and (add_successor_sendtofree_var3_var4 ))(successor ?o3 ?o4))(when (and (del_successor_sendtofree_var4_var3 ))(not (successor ?o4 ?o3)))(when (and (add_successor_sendtofree_var4_var3 ))(successor ?o4 ?o3))(when (and (del_successor_sendtofree_var4_var4 ))(not (successor ?o4 ?o4)))(when (and (add_successor_sendtofree_var4_var4 ))(successor ?o4 ?o4))))

 (:action sendtofree-b
   :parameters (?o1 - card ?o2 - num ?o3 - num ?o4 - num ?o5 - num ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(or (not (pre_on_sendtofree-b_var1_var1 ))(on ?o1 ?o1))(or (not (pre_incell_sendtofree-b_var1 ))(incell ?o1))(or (not (pre_clear_sendtofree-b_var1 ))(clear ?o1))(or (not (pre_cellspace_sendtofree-b_var2 ))(cellspace ?o2))(or (not (pre_cellspace_sendtofree-b_var3 ))(cellspace ?o3))(or (not (pre_cellspace_sendtofree-b_var4 ))(cellspace ?o4))(or (not (pre_cellspace_sendtofree-b_var5 ))(cellspace ?o5))(or (not (pre_colspace_sendtofree-b_var2 ))(colspace ?o2))(or (not (pre_colspace_sendtofree-b_var3 ))(colspace ?o3))(or (not (pre_colspace_sendtofree-b_var4 ))(colspace ?o4))(or (not (pre_colspace_sendtofree-b_var5 ))(colspace ?o5))(or (not (pre_home_sendtofree-b_var1 ))(home ?o1))(or (not (pre_bottomcol_sendtofree-b_var1 ))(bottomcol ?o1))(or (not (pre_canstack_sendtofree-b_var1_var1 ))(canstack ?o1 ?o1))(or (not (pre_value_sendtofree-b_var1_var2 ))(value ?o1 ?o2))(or (not (pre_value_sendtofree-b_var1_var3 ))(value ?o1 ?o3))(or (not (pre_value_sendtofree-b_var1_var4 ))(value ?o1 ?o4))(or (not (pre_value_sendtofree-b_var1_var5 ))(value ?o1 ?o5))(or (not (pre_successor_sendtofree-b_var2_var2 ))(successor ?o2 ?o2))(or (not (pre_successor_sendtofree-b_var2_var3 ))(successor ?o2 ?o3))(or (not (pre_successor_sendtofree-b_var2_var4 ))(successor ?o2 ?o4))(or (not (pre_successor_sendtofree-b_var2_var5 ))(successor ?o2 ?o5))(or (not (pre_successor_sendtofree-b_var3_var2 ))(successor ?o3 ?o2))(or (not (pre_successor_sendtofree-b_var3_var3 ))(successor ?o3 ?o3))(or (not (pre_successor_sendtofree-b_var3_var4 ))(successor ?o3 ?o4))(or (not (pre_successor_sendtofree-b_var3_var5 ))(successor ?o3 ?o5))(or (not (pre_successor_sendtofree-b_var4_var2 ))(successor ?o4 ?o2))(or (not (pre_successor_sendtofree-b_var4_var3 ))(successor ?o4 ?o3))(or (not (pre_successor_sendtofree-b_var4_var4 ))(successor ?o4 ?o4))(or (not (pre_successor_sendtofree-b_var4_var5 ))(successor ?o4 ?o5))(or (not (pre_successor_sendtofree-b_var5_var2 ))(successor ?o5 ?o2))(or (not (pre_successor_sendtofree-b_var5_var3 ))(successor ?o5 ?o3))(or (not (pre_successor_sendtofree-b_var5_var4 ))(successor ?o5 ?o4))(or (not (pre_successor_sendtofree-b_var5_var5 ))(successor ?o5 ?o5))(current ?i1)(inext ?i1 ?i2)(plan-sendtofree-b ?i1 ?o1 ?o2 ?o3 ?o4 ?o5))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)(when (and (del_on_sendtofree-b_var1_var1 ))(not (on ?o1 ?o1)))(when (and (add_on_sendtofree-b_var1_var1 ))(on ?o1 ?o1))(when (and (del_incell_sendtofree-b_var1 ))(not (incell ?o1)))(when (and (add_incell_sendtofree-b_var1 ))(incell ?o1))(when (and (del_clear_sendtofree-b_var1 ))(not (clear ?o1)))(when (and (add_clear_sendtofree-b_var1 ))(clear ?o1))(when (and (del_cellspace_sendtofree-b_var2 ))(not (cellspace ?o2)))(when (and (add_cellspace_sendtofree-b_var2 ))(cellspace ?o2))(when (and (del_cellspace_sendtofree-b_var3 ))(not (cellspace ?o3)))(when (and (add_cellspace_sendtofree-b_var3 ))(cellspace ?o3))(when (and (del_cellspace_sendtofree-b_var4 ))(not (cellspace ?o4)))(when (and (add_cellspace_sendtofree-b_var4 ))(cellspace ?o4))(when (and (del_cellspace_sendtofree-b_var5 ))(not (cellspace ?o5)))(when (and (add_cellspace_sendtofree-b_var5 ))(cellspace ?o5))(when (and (del_colspace_sendtofree-b_var2 ))(not (colspace ?o2)))(when (and (add_colspace_sendtofree-b_var2 ))(colspace ?o2))(when (and (del_colspace_sendtofree-b_var3 ))(not (colspace ?o3)))(when (and (add_colspace_sendtofree-b_var3 ))(colspace ?o3))(when (and (del_colspace_sendtofree-b_var4 ))(not (colspace ?o4)))(when (and (add_colspace_sendtofree-b_var4 ))(colspace ?o4))(when (and (del_colspace_sendtofree-b_var5 ))(not (colspace ?o5)))(when (and (add_colspace_sendtofree-b_var5 ))(colspace ?o5))(when (and (del_home_sendtofree-b_var1 ))(not (home ?o1)))(when (and (add_home_sendtofree-b_var1 ))(home ?o1))(when (and (del_bottomcol_sendtofree-b_var1 ))(not (bottomcol ?o1)))(when (and (add_bottomcol_sendtofree-b_var1 ))(bottomcol ?o1))(when (and (del_canstack_sendtofree-b_var1_var1 ))(not (canstack ?o1 ?o1)))(when (and (add_canstack_sendtofree-b_var1_var1 ))(canstack ?o1 ?o1))(when (and (del_value_sendtofree-b_var1_var2 ))(not (value ?o1 ?o2)))(when (and (add_value_sendtofree-b_var1_var2 ))(value ?o1 ?o2))(when (and (del_value_sendtofree-b_var1_var3 ))(not (value ?o1 ?o3)))(when (and (add_value_sendtofree-b_var1_var3 ))(value ?o1 ?o3))(when (and (del_value_sendtofree-b_var1_var4 ))(not (value ?o1 ?o4)))(when (and (add_value_sendtofree-b_var1_var4 ))(value ?o1 ?o4))(when (and (del_value_sendtofree-b_var1_var5 ))(not (value ?o1 ?o5)))(when (and (add_value_sendtofree-b_var1_var5 ))(value ?o1 ?o5))(when (and (del_successor_sendtofree-b_var2_var2 ))(not (successor ?o2 ?o2)))(when (and (add_successor_sendtofree-b_var2_var2 ))(successor ?o2 ?o2))(when (and (del_successor_sendtofree-b_var2_var3 ))(not (successor ?o2 ?o3)))(when (and (add_successor_sendtofree-b_var2_var3 ))(successor ?o2 ?o3))(when (and (del_successor_sendtofree-b_var2_var4 ))(not (successor ?o2 ?o4)))(when (and (add_successor_sendtofree-b_var2_var4 ))(successor ?o2 ?o4))(when (and (del_successor_sendtofree-b_var2_var5 ))(not (successor ?o2 ?o5)))(when (and (add_successor_sendtofree-b_var2_var5 ))(successor ?o2 ?o5))(when (and (del_successor_sendtofree-b_var3_var2 ))(not (successor ?o3 ?o2)))(when (and (add_successor_sendtofree-b_var3_var2 ))(successor ?o3 ?o2))(when (and (del_successor_sendtofree-b_var3_var3 ))(not (successor ?o3 ?o3)))(when (and (add_successor_sendtofree-b_var3_var3 ))(successor ?o3 ?o3))(when (and (del_successor_sendtofree-b_var3_var4 ))(not (successor ?o3 ?o4)))(when (and (add_successor_sendtofree-b_var3_var4 ))(successor ?o3 ?o4))(when (and (del_successor_sendtofree-b_var3_var5 ))(not (successor ?o3 ?o5)))(when (and (add_successor_sendtofree-b_var3_var5 ))(successor ?o3 ?o5))(when (and (del_successor_sendtofree-b_var4_var2 ))(not (successor ?o4 ?o2)))(when (and (add_successor_sendtofree-b_var4_var2 ))(successor ?o4 ?o2))(when (and (del_successor_sendtofree-b_var4_var3 ))(not (successor ?o4 ?o3)))(when (and (add_successor_sendtofree-b_var4_var3 ))(successor ?o4 ?o3))(when (and (del_successor_sendtofree-b_var4_var4 ))(not (successor ?o4 ?o4)))(when (and (add_successor_sendtofree-b_var4_var4 ))(successor ?o4 ?o4))(when (and (del_successor_sendtofree-b_var4_var5 ))(not (successor ?o4 ?o5)))(when (and (add_successor_sendtofree-b_var4_var5 ))(successor ?o4 ?o5))(when (and (del_successor_sendtofree-b_var5_var2 ))(not (successor ?o5 ?o2)))(when (and (add_successor_sendtofree-b_var5_var2 ))(successor ?o5 ?o2))(when (and (del_successor_sendtofree-b_var5_var3 ))(not (successor ?o5 ?o3)))(when (and (add_successor_sendtofree-b_var5_var3 ))(successor ?o5 ?o3))(when (and (del_successor_sendtofree-b_var5_var4 ))(not (successor ?o5 ?o4)))(when (and (add_successor_sendtofree-b_var5_var4 ))(successor ?o5 ?o4))(when (and (del_successor_sendtofree-b_var5_var5 ))(not (successor ?o5 ?o5)))(when (and (add_successor_sendtofree-b_var5_var5 ))(successor ?o5 ?o5))))

 (:action sendtonewcol
   :parameters (?o1 - card ?o2 - card ?o3 - num ?o4 - num ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(or (not (pre_on_sendtonewcol_var1_var1 ))(on ?o1 ?o1))(or (not (pre_on_sendtonewcol_var1_var2 ))(on ?o1 ?o2))(or (not (pre_on_sendtonewcol_var2_var1 ))(on ?o2 ?o1))(or (not (pre_on_sendtonewcol_var2_var2 ))(on ?o2 ?o2))(or (not (pre_incell_sendtonewcol_var1 ))(incell ?o1))(or (not (pre_incell_sendtonewcol_var2 ))(incell ?o2))(or (not (pre_clear_sendtonewcol_var1 ))(clear ?o1))(or (not (pre_clear_sendtonewcol_var2 ))(clear ?o2))(or (not (pre_cellspace_sendtonewcol_var3 ))(cellspace ?o3))(or (not (pre_cellspace_sendtonewcol_var4 ))(cellspace ?o4))(or (not (pre_colspace_sendtonewcol_var3 ))(colspace ?o3))(or (not (pre_colspace_sendtonewcol_var4 ))(colspace ?o4))(or (not (pre_home_sendtonewcol_var1 ))(home ?o1))(or (not (pre_home_sendtonewcol_var2 ))(home ?o2))(or (not (pre_bottomcol_sendtonewcol_var1 ))(bottomcol ?o1))(or (not (pre_bottomcol_sendtonewcol_var2 ))(bottomcol ?o2))(or (not (pre_canstack_sendtonewcol_var1_var1 ))(canstack ?o1 ?o1))(or (not (pre_canstack_sendtonewcol_var1_var2 ))(canstack ?o1 ?o2))(or (not (pre_canstack_sendtonewcol_var2_var1 ))(canstack ?o2 ?o1))(or (not (pre_canstack_sendtonewcol_var2_var2 ))(canstack ?o2 ?o2))(or (not (pre_value_sendtonewcol_var1_var3 ))(value ?o1 ?o3))(or (not (pre_value_sendtonewcol_var1_var4 ))(value ?o1 ?o4))(or (not (pre_value_sendtonewcol_var2_var3 ))(value ?o2 ?o3))(or (not (pre_value_sendtonewcol_var2_var4 ))(value ?o2 ?o4))(or (not (pre_successor_sendtonewcol_var3_var3 ))(successor ?o3 ?o3))(or (not (pre_successor_sendtonewcol_var3_var4 ))(successor ?o3 ?o4))(or (not (pre_successor_sendtonewcol_var4_var3 ))(successor ?o4 ?o3))(or (not (pre_successor_sendtonewcol_var4_var4 ))(successor ?o4 ?o4))(current ?i1)(inext ?i1 ?i2)(plan-sendtonewcol ?i1 ?o1 ?o2 ?o3 ?o4))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)(when (and (del_on_sendtonewcol_var1_var1 ))(not (on ?o1 ?o1)))(when (and (add_on_sendtonewcol_var1_var1 ))(on ?o1 ?o1))(when (and (del_on_sendtonewcol_var1_var2 ))(not (on ?o1 ?o2)))(when (and (add_on_sendtonewcol_var1_var2 ))(on ?o1 ?o2))(when (and (del_on_sendtonewcol_var2_var1 ))(not (on ?o2 ?o1)))(when (and (add_on_sendtonewcol_var2_var1 ))(on ?o2 ?o1))(when (and (del_on_sendtonewcol_var2_var2 ))(not (on ?o2 ?o2)))(when (and (add_on_sendtonewcol_var2_var2 ))(on ?o2 ?o2))(when (and (del_incell_sendtonewcol_var1 ))(not (incell ?o1)))(when (and (add_incell_sendtonewcol_var1 ))(incell ?o1))(when (and (del_incell_sendtonewcol_var2 ))(not (incell ?o2)))(when (and (add_incell_sendtonewcol_var2 ))(incell ?o2))(when (and (del_clear_sendtonewcol_var1 ))(not (clear ?o1)))(when (and (add_clear_sendtonewcol_var1 ))(clear ?o1))(when (and (del_clear_sendtonewcol_var2 ))(not (clear ?o2)))(when (and (add_clear_sendtonewcol_var2 ))(clear ?o2))(when (and (del_cellspace_sendtonewcol_var3 ))(not (cellspace ?o3)))(when (and (add_cellspace_sendtonewcol_var3 ))(cellspace ?o3))(when (and (del_cellspace_sendtonewcol_var4 ))(not (cellspace ?o4)))(when (and (add_cellspace_sendtonewcol_var4 ))(cellspace ?o4))(when (and (del_colspace_sendtonewcol_var3 ))(not (colspace ?o3)))(when (and (add_colspace_sendtonewcol_var3 ))(colspace ?o3))(when (and (del_colspace_sendtonewcol_var4 ))(not (colspace ?o4)))(when (and (add_colspace_sendtonewcol_var4 ))(colspace ?o4))(when (and (del_home_sendtonewcol_var1 ))(not (home ?o1)))(when (and (add_home_sendtonewcol_var1 ))(home ?o1))(when (and (del_home_sendtonewcol_var2 ))(not (home ?o2)))(when (and (add_home_sendtonewcol_var2 ))(home ?o2))(when (and (del_bottomcol_sendtonewcol_var1 ))(not (bottomcol ?o1)))(when (and (add_bottomcol_sendtonewcol_var1 ))(bottomcol ?o1))(when (and (del_bottomcol_sendtonewcol_var2 ))(not (bottomcol ?o2)))(when (and (add_bottomcol_sendtonewcol_var2 ))(bottomcol ?o2))(when (and (del_canstack_sendtonewcol_var1_var1 ))(not (canstack ?o1 ?o1)))(when (and (add_canstack_sendtonewcol_var1_var1 ))(canstack ?o1 ?o1))(when (and (del_canstack_sendtonewcol_var1_var2 ))(not (canstack ?o1 ?o2)))(when (and (add_canstack_sendtonewcol_var1_var2 ))(canstack ?o1 ?o2))(when (and (del_canstack_sendtonewcol_var2_var1 ))(not (canstack ?o2 ?o1)))(when (and (add_canstack_sendtonewcol_var2_var1 ))(canstack ?o2 ?o1))(when (and (del_canstack_sendtonewcol_var2_var2 ))(not (canstack ?o2 ?o2)))(when (and (add_canstack_sendtonewcol_var2_var2 ))(canstack ?o2 ?o2))(when (and (del_value_sendtonewcol_var1_var3 ))(not (value ?o1 ?o3)))(when (and (add_value_sendtonewcol_var1_var3 ))(value ?o1 ?o3))(when (and (del_value_sendtonewcol_var1_var4 ))(not (value ?o1 ?o4)))(when (and (add_value_sendtonewcol_var1_var4 ))(value ?o1 ?o4))(when (and (del_value_sendtonewcol_var2_var3 ))(not (value ?o2 ?o3)))(when (and (add_value_sendtonewcol_var2_var3 ))(value ?o2 ?o3))(when (and (del_value_sendtonewcol_var2_var4 ))(not (value ?o2 ?o4)))(when (and (add_value_sendtonewcol_var2_var4 ))(value ?o2 ?o4))(when (and (del_successor_sendtonewcol_var3_var3 ))(not (successor ?o3 ?o3)))(when (and (add_successor_sendtonewcol_var3_var3 ))(successor ?o3 ?o3))(when (and (del_successor_sendtonewcol_var3_var4 ))(not (successor ?o3 ?o4)))(when (and (add_successor_sendtonewcol_var3_var4 ))(successor ?o3 ?o4))(when (and (del_successor_sendtonewcol_var4_var3 ))(not (successor ?o4 ?o3)))(when (and (add_successor_sendtonewcol_var4_var3 ))(successor ?o4 ?o3))(when (and (del_successor_sendtonewcol_var4_var4 ))(not (successor ?o4 ?o4)))(when (and (add_successor_sendtonewcol_var4_var4 ))(successor ?o4 ?o4))))

 (:action sendtohome
   :parameters (?o1 - card ?o2 - card ?o3 - suit ?o4 - num ?o5 - card ?o6 - num ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(or (not (pre_on_sendtohome_var1_var1 ))(on ?o1 ?o1))(or (not (pre_on_sendtohome_var1_var2 ))(on ?o1 ?o2))(or (not (pre_on_sendtohome_var1_var5 ))(on ?o1 ?o5))(or (not (pre_on_sendtohome_var2_var1 ))(on ?o2 ?o1))(or (not (pre_on_sendtohome_var2_var2 ))(on ?o2 ?o2))(or (not (pre_on_sendtohome_var2_var5 ))(on ?o2 ?o5))(or (not (pre_on_sendtohome_var5_var1 ))(on ?o5 ?o1))(or (not (pre_on_sendtohome_var5_var2 ))(on ?o5 ?o2))(or (not (pre_on_sendtohome_var5_var5 ))(on ?o5 ?o5))(or (not (pre_incell_sendtohome_var1 ))(incell ?o1))(or (not (pre_incell_sendtohome_var2 ))(incell ?o2))(or (not (pre_incell_sendtohome_var5 ))(incell ?o5))(or (not (pre_clear_sendtohome_var1 ))(clear ?o1))(or (not (pre_clear_sendtohome_var2 ))(clear ?o2))(or (not (pre_clear_sendtohome_var5 ))(clear ?o5))(or (not (pre_cellspace_sendtohome_var4 ))(cellspace ?o4))(or (not (pre_cellspace_sendtohome_var6 ))(cellspace ?o6))(or (not (pre_colspace_sendtohome_var4 ))(colspace ?o4))(or (not (pre_colspace_sendtohome_var6 ))(colspace ?o6))(or (not (pre_home_sendtohome_var1 ))(home ?o1))(or (not (pre_home_sendtohome_var2 ))(home ?o2))(or (not (pre_home_sendtohome_var5 ))(home ?o5))(or (not (pre_bottomcol_sendtohome_var1 ))(bottomcol ?o1))(or (not (pre_bottomcol_sendtohome_var2 ))(bottomcol ?o2))(or (not (pre_bottomcol_sendtohome_var5 ))(bottomcol ?o5))(or (not (pre_canstack_sendtohome_var1_var1 ))(canstack ?o1 ?o1))(or (not (pre_canstack_sendtohome_var1_var2 ))(canstack ?o1 ?o2))(or (not (pre_canstack_sendtohome_var1_var5 ))(canstack ?o1 ?o5))(or (not (pre_canstack_sendtohome_var2_var1 ))(canstack ?o2 ?o1))(or (not (pre_canstack_sendtohome_var2_var2 ))(canstack ?o2 ?o2))(or (not (pre_canstack_sendtohome_var2_var5 ))(canstack ?o2 ?o5))(or (not (pre_canstack_sendtohome_var5_var1 ))(canstack ?o5 ?o1))(or (not (pre_canstack_sendtohome_var5_var2 ))(canstack ?o5 ?o2))(or (not (pre_canstack_sendtohome_var5_var5 ))(canstack ?o5 ?o5))(or (not (pre_suit_sendtohome_var1_var3 ))(suit ?o1 ?o3))(or (not (pre_suit_sendtohome_var2_var3 ))(suit ?o2 ?o3))(or (not (pre_suit_sendtohome_var5_var3 ))(suit ?o5 ?o3))(or (not (pre_value_sendtohome_var1_var4 ))(value ?o1 ?o4))(or (not (pre_value_sendtohome_var1_var6 ))(value ?o1 ?o6))(or (not (pre_value_sendtohome_var2_var4 ))(value ?o2 ?o4))(or (not (pre_value_sendtohome_var2_var6 ))(value ?o2 ?o6))(or (not (pre_value_sendtohome_var5_var4 ))(value ?o5 ?o4))(or (not (pre_value_sendtohome_var5_var6 ))(value ?o5 ?o6))(or (not (pre_successor_sendtohome_var4_var4 ))(successor ?o4 ?o4))(or (not (pre_successor_sendtohome_var4_var6 ))(successor ?o4 ?o6))(or (not (pre_successor_sendtohome_var6_var4 ))(successor ?o6 ?o4))(or (not (pre_successor_sendtohome_var6_var6 ))(successor ?o6 ?o6))(current ?i1)(inext ?i1 ?i2)(plan-sendtohome ?i1 ?o1 ?o2 ?o3 ?o4 ?o5 ?o6))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)(when (and (del_on_sendtohome_var1_var1 ))(not (on ?o1 ?o1)))(when (and (add_on_sendtohome_var1_var1 ))(on ?o1 ?o1))(when (and (del_on_sendtohome_var1_var2 ))(not (on ?o1 ?o2)))(when (and (add_on_sendtohome_var1_var2 ))(on ?o1 ?o2))(when (and (del_on_sendtohome_var1_var5 ))(not (on ?o1 ?o5)))(when (and (add_on_sendtohome_var1_var5 ))(on ?o1 ?o5))(when (and (del_on_sendtohome_var2_var1 ))(not (on ?o2 ?o1)))(when (and (add_on_sendtohome_var2_var1 ))(on ?o2 ?o1))(when (and (del_on_sendtohome_var2_var2 ))(not (on ?o2 ?o2)))(when (and (add_on_sendtohome_var2_var2 ))(on ?o2 ?o2))(when (and (del_on_sendtohome_var2_var5 ))(not (on ?o2 ?o5)))(when (and (add_on_sendtohome_var2_var5 ))(on ?o2 ?o5))(when (and (del_on_sendtohome_var5_var1 ))(not (on ?o5 ?o1)))(when (and (add_on_sendtohome_var5_var1 ))(on ?o5 ?o1))(when (and (del_on_sendtohome_var5_var2 ))(not (on ?o5 ?o2)))(when (and (add_on_sendtohome_var5_var2 ))(on ?o5 ?o2))(when (and (del_on_sendtohome_var5_var5 ))(not (on ?o5 ?o5)))(when (and (add_on_sendtohome_var5_var5 ))(on ?o5 ?o5))(when (and (del_incell_sendtohome_var1 ))(not (incell ?o1)))(when (and (add_incell_sendtohome_var1 ))(incell ?o1))(when (and (del_incell_sendtohome_var2 ))(not (incell ?o2)))(when (and (add_incell_sendtohome_var2 ))(incell ?o2))(when (and (del_incell_sendtohome_var5 ))(not (incell ?o5)))(when (and (add_incell_sendtohome_var5 ))(incell ?o5))(when (and (del_clear_sendtohome_var1 ))(not (clear ?o1)))(when (and (add_clear_sendtohome_var1 ))(clear ?o1))(when (and (del_clear_sendtohome_var2 ))(not (clear ?o2)))(when (and (add_clear_sendtohome_var2 ))(clear ?o2))(when (and (del_clear_sendtohome_var5 ))(not (clear ?o5)))(when (and (add_clear_sendtohome_var5 ))(clear ?o5))(when (and (del_cellspace_sendtohome_var4 ))(not (cellspace ?o4)))(when (and (add_cellspace_sendtohome_var4 ))(cellspace ?o4))(when (and (del_cellspace_sendtohome_var6 ))(not (cellspace ?o6)))(when (and (add_cellspace_sendtohome_var6 ))(cellspace ?o6))(when (and (del_colspace_sendtohome_var4 ))(not (colspace ?o4)))(when (and (add_colspace_sendtohome_var4 ))(colspace ?o4))(when (and (del_colspace_sendtohome_var6 ))(not (colspace ?o6)))(when (and (add_colspace_sendtohome_var6 ))(colspace ?o6))(when (and (del_home_sendtohome_var1 ))(not (home ?o1)))(when (and (add_home_sendtohome_var1 ))(home ?o1))(when (and (del_home_sendtohome_var2 ))(not (home ?o2)))(when (and (add_home_sendtohome_var2 ))(home ?o2))(when (and (del_home_sendtohome_var5 ))(not (home ?o5)))(when (and (add_home_sendtohome_var5 ))(home ?o5))(when (and (del_bottomcol_sendtohome_var1 ))(not (bottomcol ?o1)))(when (and (add_bottomcol_sendtohome_var1 ))(bottomcol ?o1))(when (and (del_bottomcol_sendtohome_var2 ))(not (bottomcol ?o2)))(when (and (add_bottomcol_sendtohome_var2 ))(bottomcol ?o2))(when (and (del_bottomcol_sendtohome_var5 ))(not (bottomcol ?o5)))(when (and (add_bottomcol_sendtohome_var5 ))(bottomcol ?o5))(when (and (del_canstack_sendtohome_var1_var1 ))(not (canstack ?o1 ?o1)))(when (and (add_canstack_sendtohome_var1_var1 ))(canstack ?o1 ?o1))(when (and (del_canstack_sendtohome_var1_var2 ))(not (canstack ?o1 ?o2)))(when (and (add_canstack_sendtohome_var1_var2 ))(canstack ?o1 ?o2))(when (and (del_canstack_sendtohome_var1_var5 ))(not (canstack ?o1 ?o5)))(when (and (add_canstack_sendtohome_var1_var5 ))(canstack ?o1 ?o5))(when (and (del_canstack_sendtohome_var2_var1 ))(not (canstack ?o2 ?o1)))(when (and (add_canstack_sendtohome_var2_var1 ))(canstack ?o2 ?o1))(when (and (del_canstack_sendtohome_var2_var2 ))(not (canstack ?o2 ?o2)))(when (and (add_canstack_sendtohome_var2_var2 ))(canstack ?o2 ?o2))(when (and (del_canstack_sendtohome_var2_var5 ))(not (canstack ?o2 ?o5)))(when (and (add_canstack_sendtohome_var2_var5 ))(canstack ?o2 ?o5))(when (and (del_canstack_sendtohome_var5_var1 ))(not (canstack ?o5 ?o1)))(when (and (add_canstack_sendtohome_var5_var1 ))(canstack ?o5 ?o1))(when (and (del_canstack_sendtohome_var5_var2 ))(not (canstack ?o5 ?o2)))(when (and (add_canstack_sendtohome_var5_var2 ))(canstack ?o5 ?o2))(when (and (del_canstack_sendtohome_var5_var5 ))(not (canstack ?o5 ?o5)))(when (and (add_canstack_sendtohome_var5_var5 ))(canstack ?o5 ?o5))(when (and (del_suit_sendtohome_var1_var3 ))(not (suit ?o1 ?o3)))(when (and (add_suit_sendtohome_var1_var3 ))(suit ?o1 ?o3))(when (and (del_suit_sendtohome_var2_var3 ))(not (suit ?o2 ?o3)))(when (and (add_suit_sendtohome_var2_var3 ))(suit ?o2 ?o3))(when (and (del_suit_sendtohome_var5_var3 ))(not (suit ?o5 ?o3)))(when (and (add_suit_sendtohome_var5_var3 ))(suit ?o5 ?o3))(when (and (del_value_sendtohome_var1_var4 ))(not (value ?o1 ?o4)))(when (and (add_value_sendtohome_var1_var4 ))(value ?o1 ?o4))(when (and (del_value_sendtohome_var1_var6 ))(not (value ?o1 ?o6)))(when (and (add_value_sendtohome_var1_var6 ))(value ?o1 ?o6))(when (and (del_value_sendtohome_var2_var4 ))(not (value ?o2 ?o4)))(when (and (add_value_sendtohome_var2_var4 ))(value ?o2 ?o4))(when (and (del_value_sendtohome_var2_var6 ))(not (value ?o2 ?o6)))(when (and (add_value_sendtohome_var2_var6 ))(value ?o2 ?o6))(when (and (del_value_sendtohome_var5_var4 ))(not (value ?o5 ?o4)))(when (and (add_value_sendtohome_var5_var4 ))(value ?o5 ?o4))(when (and (del_value_sendtohome_var5_var6 ))(not (value ?o5 ?o6)))(when (and (add_value_sendtohome_var5_var6 ))(value ?o5 ?o6))(when (and (del_successor_sendtohome_var4_var4 ))(not (successor ?o4 ?o4)))(when (and (add_successor_sendtohome_var4_var4 ))(successor ?o4 ?o4))(when (and (del_successor_sendtohome_var4_var6 ))(not (successor ?o4 ?o6)))(when (and (add_successor_sendtohome_var4_var6 ))(successor ?o4 ?o6))(when (and (del_successor_sendtohome_var6_var4 ))(not (successor ?o6 ?o4)))(when (and (add_successor_sendtohome_var6_var4 ))(successor ?o6 ?o4))(when (and (del_successor_sendtohome_var6_var6 ))(not (successor ?o6 ?o6)))(when (and (add_successor_sendtohome_var6_var6 ))(successor ?o6 ?o6))))

 (:action sendtohome-b
   :parameters (?o1 - card ?o2 - suit ?o3 - num ?o4 - card ?o5 - num ?o6 - num ?o7 - num ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(or (not (pre_on_sendtohome-b_var1_var1 ))(on ?o1 ?o1))(or (not (pre_on_sendtohome-b_var1_var4 ))(on ?o1 ?o4))(or (not (pre_on_sendtohome-b_var4_var1 ))(on ?o4 ?o1))(or (not (pre_on_sendtohome-b_var4_var4 ))(on ?o4 ?o4))(or (not (pre_incell_sendtohome-b_var1 ))(incell ?o1))(or (not (pre_incell_sendtohome-b_var4 ))(incell ?o4))(or (not (pre_clear_sendtohome-b_var1 ))(clear ?o1))(or (not (pre_clear_sendtohome-b_var4 ))(clear ?o4))(or (not (pre_cellspace_sendtohome-b_var3 ))(cellspace ?o3))(or (not (pre_cellspace_sendtohome-b_var5 ))(cellspace ?o5))(or (not (pre_cellspace_sendtohome-b_var6 ))(cellspace ?o6))(or (not (pre_cellspace_sendtohome-b_var7 ))(cellspace ?o7))(or (not (pre_colspace_sendtohome-b_var3 ))(colspace ?o3))(or (not (pre_colspace_sendtohome-b_var5 ))(colspace ?o5))(or (not (pre_colspace_sendtohome-b_var6 ))(colspace ?o6))(or (not (pre_colspace_sendtohome-b_var7 ))(colspace ?o7))(or (not (pre_home_sendtohome-b_var1 ))(home ?o1))(or (not (pre_home_sendtohome-b_var4 ))(home ?o4))(or (not (pre_bottomcol_sendtohome-b_var1 ))(bottomcol ?o1))(or (not (pre_bottomcol_sendtohome-b_var4 ))(bottomcol ?o4))(or (not (pre_canstack_sendtohome-b_var1_var1 ))(canstack ?o1 ?o1))(or (not (pre_canstack_sendtohome-b_var1_var4 ))(canstack ?o1 ?o4))(or (not (pre_canstack_sendtohome-b_var4_var1 ))(canstack ?o4 ?o1))(or (not (pre_canstack_sendtohome-b_var4_var4 ))(canstack ?o4 ?o4))(or (not (pre_suit_sendtohome-b_var1_var2 ))(suit ?o1 ?o2))(or (not (pre_suit_sendtohome-b_var4_var2 ))(suit ?o4 ?o2))(or (not (pre_value_sendtohome-b_var1_var3 ))(value ?o1 ?o3))(or (not (pre_value_sendtohome-b_var1_var5 ))(value ?o1 ?o5))(or (not (pre_value_sendtohome-b_var1_var6 ))(value ?o1 ?o6))(or (not (pre_value_sendtohome-b_var1_var7 ))(value ?o1 ?o7))(or (not (pre_value_sendtohome-b_var4_var3 ))(value ?o4 ?o3))(or (not (pre_value_sendtohome-b_var4_var5 ))(value ?o4 ?o5))(or (not (pre_value_sendtohome-b_var4_var6 ))(value ?o4 ?o6))(or (not (pre_value_sendtohome-b_var4_var7 ))(value ?o4 ?o7))(or (not (pre_successor_sendtohome-b_var3_var3 ))(successor ?o3 ?o3))(or (not (pre_successor_sendtohome-b_var3_var5 ))(successor ?o3 ?o5))(or (not (pre_successor_sendtohome-b_var3_var6 ))(successor ?o3 ?o6))(or (not (pre_successor_sendtohome-b_var3_var7 ))(successor ?o3 ?o7))(or (not (pre_successor_sendtohome-b_var5_var3 ))(successor ?o5 ?o3))(or (not (pre_successor_sendtohome-b_var5_var5 ))(successor ?o5 ?o5))(or (not (pre_successor_sendtohome-b_var5_var6 ))(successor ?o5 ?o6))(or (not (pre_successor_sendtohome-b_var5_var7 ))(successor ?o5 ?o7))(or (not (pre_successor_sendtohome-b_var6_var3 ))(successor ?o6 ?o3))(or (not (pre_successor_sendtohome-b_var6_var5 ))(successor ?o6 ?o5))(or (not (pre_successor_sendtohome-b_var6_var6 ))(successor ?o6 ?o6))(or (not (pre_successor_sendtohome-b_var6_var7 ))(successor ?o6 ?o7))(or (not (pre_successor_sendtohome-b_var7_var3 ))(successor ?o7 ?o3))(or (not (pre_successor_sendtohome-b_var7_var5 ))(successor ?o7 ?o5))(or (not (pre_successor_sendtohome-b_var7_var6 ))(successor ?o7 ?o6))(or (not (pre_successor_sendtohome-b_var7_var7 ))(successor ?o7 ?o7))(current ?i1)(inext ?i1 ?i2)(plan-sendtohome-b ?i1 ?o1 ?o2 ?o3 ?o4 ?o5 ?o6 ?o7))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)(when (and (del_on_sendtohome-b_var1_var1 ))(not (on ?o1 ?o1)))(when (and (add_on_sendtohome-b_var1_var1 ))(on ?o1 ?o1))(when (and (del_on_sendtohome-b_var1_var4 ))(not (on ?o1 ?o4)))(when (and (add_on_sendtohome-b_var1_var4 ))(on ?o1 ?o4))(when (and (del_on_sendtohome-b_var4_var1 ))(not (on ?o4 ?o1)))(when (and (add_on_sendtohome-b_var4_var1 ))(on ?o4 ?o1))(when (and (del_on_sendtohome-b_var4_var4 ))(not (on ?o4 ?o4)))(when (and (add_on_sendtohome-b_var4_var4 ))(on ?o4 ?o4))(when (and (del_incell_sendtohome-b_var1 ))(not (incell ?o1)))(when (and (add_incell_sendtohome-b_var1 ))(incell ?o1))(when (and (del_incell_sendtohome-b_var4 ))(not (incell ?o4)))(when (and (add_incell_sendtohome-b_var4 ))(incell ?o4))(when (and (del_clear_sendtohome-b_var1 ))(not (clear ?o1)))(when (and (add_clear_sendtohome-b_var1 ))(clear ?o1))(when (and (del_clear_sendtohome-b_var4 ))(not (clear ?o4)))(when (and (add_clear_sendtohome-b_var4 ))(clear ?o4))(when (and (del_cellspace_sendtohome-b_var3 ))(not (cellspace ?o3)))(when (and (add_cellspace_sendtohome-b_var3 ))(cellspace ?o3))(when (and (del_cellspace_sendtohome-b_var5 ))(not (cellspace ?o5)))(when (and (add_cellspace_sendtohome-b_var5 ))(cellspace ?o5))(when (and (del_cellspace_sendtohome-b_var6 ))(not (cellspace ?o6)))(when (and (add_cellspace_sendtohome-b_var6 ))(cellspace ?o6))(when (and (del_cellspace_sendtohome-b_var7 ))(not (cellspace ?o7)))(when (and (add_cellspace_sendtohome-b_var7 ))(cellspace ?o7))(when (and (del_colspace_sendtohome-b_var3 ))(not (colspace ?o3)))(when (and (add_colspace_sendtohome-b_var3 ))(colspace ?o3))(when (and (del_colspace_sendtohome-b_var5 ))(not (colspace ?o5)))(when (and (add_colspace_sendtohome-b_var5 ))(colspace ?o5))(when (and (del_colspace_sendtohome-b_var6 ))(not (colspace ?o6)))(when (and (add_colspace_sendtohome-b_var6 ))(colspace ?o6))(when (and (del_colspace_sendtohome-b_var7 ))(not (colspace ?o7)))(when (and (add_colspace_sendtohome-b_var7 ))(colspace ?o7))(when (and (del_home_sendtohome-b_var1 ))(not (home ?o1)))(when (and (add_home_sendtohome-b_var1 ))(home ?o1))(when (and (del_home_sendtohome-b_var4 ))(not (home ?o4)))(when (and (add_home_sendtohome-b_var4 ))(home ?o4))(when (and (del_bottomcol_sendtohome-b_var1 ))(not (bottomcol ?o1)))(when (and (add_bottomcol_sendtohome-b_var1 ))(bottomcol ?o1))(when (and (del_bottomcol_sendtohome-b_var4 ))(not (bottomcol ?o4)))(when (and (add_bottomcol_sendtohome-b_var4 ))(bottomcol ?o4))(when (and (del_canstack_sendtohome-b_var1_var1 ))(not (canstack ?o1 ?o1)))(when (and (add_canstack_sendtohome-b_var1_var1 ))(canstack ?o1 ?o1))(when (and (del_canstack_sendtohome-b_var1_var4 ))(not (canstack ?o1 ?o4)))(when (and (add_canstack_sendtohome-b_var1_var4 ))(canstack ?o1 ?o4))(when (and (del_canstack_sendtohome-b_var4_var1 ))(not (canstack ?o4 ?o1)))(when (and (add_canstack_sendtohome-b_var4_var1 ))(canstack ?o4 ?o1))(when (and (del_canstack_sendtohome-b_var4_var4 ))(not (canstack ?o4 ?o4)))(when (and (add_canstack_sendtohome-b_var4_var4 ))(canstack ?o4 ?o4))(when (and (del_suit_sendtohome-b_var1_var2 ))(not (suit ?o1 ?o2)))(when (and (add_suit_sendtohome-b_var1_var2 ))(suit ?o1 ?o2))(when (and (del_suit_sendtohome-b_var4_var2 ))(not (suit ?o4 ?o2)))(when (and (add_suit_sendtohome-b_var4_var2 ))(suit ?o4 ?o2))(when (and (del_value_sendtohome-b_var1_var3 ))(not (value ?o1 ?o3)))(when (and (add_value_sendtohome-b_var1_var3 ))(value ?o1 ?o3))(when (and (del_value_sendtohome-b_var1_var5 ))(not (value ?o1 ?o5)))(when (and (add_value_sendtohome-b_var1_var5 ))(value ?o1 ?o5))(when (and (del_value_sendtohome-b_var1_var6 ))(not (value ?o1 ?o6)))(when (and (add_value_sendtohome-b_var1_var6 ))(value ?o1 ?o6))(when (and (del_value_sendtohome-b_var1_var7 ))(not (value ?o1 ?o7)))(when (and (add_value_sendtohome-b_var1_var7 ))(value ?o1 ?o7))(when (and (del_value_sendtohome-b_var4_var3 ))(not (value ?o4 ?o3)))(when (and (add_value_sendtohome-b_var4_var3 ))(value ?o4 ?o3))(when (and (del_value_sendtohome-b_var4_var5 ))(not (value ?o4 ?o5)))(when (and (add_value_sendtohome-b_var4_var5 ))(value ?o4 ?o5))(when (and (del_value_sendtohome-b_var4_var6 ))(not (value ?o4 ?o6)))(when (and (add_value_sendtohome-b_var4_var6 ))(value ?o4 ?o6))(when (and (del_value_sendtohome-b_var4_var7 ))(not (value ?o4 ?o7)))(when (and (add_value_sendtohome-b_var4_var7 ))(value ?o4 ?o7))(when (and (del_successor_sendtohome-b_var3_var3 ))(not (successor ?o3 ?o3)))(when (and (add_successor_sendtohome-b_var3_var3 ))(successor ?o3 ?o3))(when (and (del_successor_sendtohome-b_var3_var5 ))(not (successor ?o3 ?o5)))(when (and (add_successor_sendtohome-b_var3_var5 ))(successor ?o3 ?o5))(when (and (del_successor_sendtohome-b_var3_var6 ))(not (successor ?o3 ?o6)))(when (and (add_successor_sendtohome-b_var3_var6 ))(successor ?o3 ?o6))(when (and (del_successor_sendtohome-b_var3_var7 ))(not (successor ?o3 ?o7)))(when (and (add_successor_sendtohome-b_var3_var7 ))(successor ?o3 ?o7))(when (and (del_successor_sendtohome-b_var5_var3 ))(not (successor ?o5 ?o3)))(when (and (add_successor_sendtohome-b_var5_var3 ))(successor ?o5 ?o3))(when (and (del_successor_sendtohome-b_var5_var5 ))(not (successor ?o5 ?o5)))(when (and (add_successor_sendtohome-b_var5_var5 ))(successor ?o5 ?o5))(when (and (del_successor_sendtohome-b_var5_var6 ))(not (successor ?o5 ?o6)))(when (and (add_successor_sendtohome-b_var5_var6 ))(successor ?o5 ?o6))(when (and (del_successor_sendtohome-b_var5_var7 ))(not (successor ?o5 ?o7)))(when (and (add_successor_sendtohome-b_var5_var7 ))(successor ?o5 ?o7))(when (and (del_successor_sendtohome-b_var6_var3 ))(not (successor ?o6 ?o3)))(when (and (add_successor_sendtohome-b_var6_var3 ))(successor ?o6 ?o3))(when (and (del_successor_sendtohome-b_var6_var5 ))(not (successor ?o6 ?o5)))(when (and (add_successor_sendtohome-b_var6_var5 ))(successor ?o6 ?o5))(when (and (del_successor_sendtohome-b_var6_var6 ))(not (successor ?o6 ?o6)))(when (and (add_successor_sendtohome-b_var6_var6 ))(successor ?o6 ?o6))(when (and (del_successor_sendtohome-b_var6_var7 ))(not (successor ?o6 ?o7)))(when (and (add_successor_sendtohome-b_var6_var7 ))(successor ?o6 ?o7))(when (and (del_successor_sendtohome-b_var7_var3 ))(not (successor ?o7 ?o3)))(when (and (add_successor_sendtohome-b_var7_var3 ))(successor ?o7 ?o3))(when (and (del_successor_sendtohome-b_var7_var5 ))(not (successor ?o7 ?o5)))(when (and (add_successor_sendtohome-b_var7_var5 ))(successor ?o7 ?o5))(when (and (del_successor_sendtohome-b_var7_var6 ))(not (successor ?o7 ?o6)))(when (and (add_successor_sendtohome-b_var7_var6 ))(successor ?o7 ?o6))(when (and (del_successor_sendtohome-b_var7_var7 ))(not (successor ?o7 ?o7)))(when (and (add_successor_sendtohome-b_var7_var7 ))(successor ?o7 ?o7))))

 (:action homefromfreecell
   :parameters (?o1 - card ?o2 - suit ?o3 - num ?o4 - card ?o5 - num ?o6 - num ?o7 - num ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(or (not (pre_on_homefromfreecell_var1_var1 ))(on ?o1 ?o1))(or (not (pre_on_homefromfreecell_var1_var4 ))(on ?o1 ?o4))(or (not (pre_on_homefromfreecell_var4_var1 ))(on ?o4 ?o1))(or (not (pre_on_homefromfreecell_var4_var4 ))(on ?o4 ?o4))(or (not (pre_incell_homefromfreecell_var1 ))(incell ?o1))(or (not (pre_incell_homefromfreecell_var4 ))(incell ?o4))(or (not (pre_clear_homefromfreecell_var1 ))(clear ?o1))(or (not (pre_clear_homefromfreecell_var4 ))(clear ?o4))(or (not (pre_cellspace_homefromfreecell_var3 ))(cellspace ?o3))(or (not (pre_cellspace_homefromfreecell_var5 ))(cellspace ?o5))(or (not (pre_cellspace_homefromfreecell_var6 ))(cellspace ?o6))(or (not (pre_cellspace_homefromfreecell_var7 ))(cellspace ?o7))(or (not (pre_colspace_homefromfreecell_var3 ))(colspace ?o3))(or (not (pre_colspace_homefromfreecell_var5 ))(colspace ?o5))(or (not (pre_colspace_homefromfreecell_var6 ))(colspace ?o6))(or (not (pre_colspace_homefromfreecell_var7 ))(colspace ?o7))(or (not (pre_home_homefromfreecell_var1 ))(home ?o1))(or (not (pre_home_homefromfreecell_var4 ))(home ?o4))(or (not (pre_bottomcol_homefromfreecell_var1 ))(bottomcol ?o1))(or (not (pre_bottomcol_homefromfreecell_var4 ))(bottomcol ?o4))(or (not (pre_canstack_homefromfreecell_var1_var1 ))(canstack ?o1 ?o1))(or (not (pre_canstack_homefromfreecell_var1_var4 ))(canstack ?o1 ?o4))(or (not (pre_canstack_homefromfreecell_var4_var1 ))(canstack ?o4 ?o1))(or (not (pre_canstack_homefromfreecell_var4_var4 ))(canstack ?o4 ?o4))(or (not (pre_suit_homefromfreecell_var1_var2 ))(suit ?o1 ?o2))(or (not (pre_suit_homefromfreecell_var4_var2 ))(suit ?o4 ?o2))(or (not (pre_value_homefromfreecell_var1_var3 ))(value ?o1 ?o3))(or (not (pre_value_homefromfreecell_var1_var5 ))(value ?o1 ?o5))(or (not (pre_value_homefromfreecell_var1_var6 ))(value ?o1 ?o6))(or (not (pre_value_homefromfreecell_var1_var7 ))(value ?o1 ?o7))(or (not (pre_value_homefromfreecell_var4_var3 ))(value ?o4 ?o3))(or (not (pre_value_homefromfreecell_var4_var5 ))(value ?o4 ?o5))(or (not (pre_value_homefromfreecell_var4_var6 ))(value ?o4 ?o6))(or (not (pre_value_homefromfreecell_var4_var7 ))(value ?o4 ?o7))(or (not (pre_successor_homefromfreecell_var3_var3 ))(successor ?o3 ?o3))(or (not (pre_successor_homefromfreecell_var3_var5 ))(successor ?o3 ?o5))(or (not (pre_successor_homefromfreecell_var3_var6 ))(successor ?o3 ?o6))(or (not (pre_successor_homefromfreecell_var3_var7 ))(successor ?o3 ?o7))(or (not (pre_successor_homefromfreecell_var5_var3 ))(successor ?o5 ?o3))(or (not (pre_successor_homefromfreecell_var5_var5 ))(successor ?o5 ?o5))(or (not (pre_successor_homefromfreecell_var5_var6 ))(successor ?o5 ?o6))(or (not (pre_successor_homefromfreecell_var5_var7 ))(successor ?o5 ?o7))(or (not (pre_successor_homefromfreecell_var6_var3 ))(successor ?o6 ?o3))(or (not (pre_successor_homefromfreecell_var6_var5 ))(successor ?o6 ?o5))(or (not (pre_successor_homefromfreecell_var6_var6 ))(successor ?o6 ?o6))(or (not (pre_successor_homefromfreecell_var6_var7 ))(successor ?o6 ?o7))(or (not (pre_successor_homefromfreecell_var7_var3 ))(successor ?o7 ?o3))(or (not (pre_successor_homefromfreecell_var7_var5 ))(successor ?o7 ?o5))(or (not (pre_successor_homefromfreecell_var7_var6 ))(successor ?o7 ?o6))(or (not (pre_successor_homefromfreecell_var7_var7 ))(successor ?o7 ?o7))(current ?i1)(inext ?i1 ?i2)(plan-homefromfreecell ?i1 ?o1 ?o2 ?o3 ?o4 ?o5 ?o6 ?o7))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)(when (and (del_on_homefromfreecell_var1_var1 ))(not (on ?o1 ?o1)))(when (and (add_on_homefromfreecell_var1_var1 ))(on ?o1 ?o1))(when (and (del_on_homefromfreecell_var1_var4 ))(not (on ?o1 ?o4)))(when (and (add_on_homefromfreecell_var1_var4 ))(on ?o1 ?o4))(when (and (del_on_homefromfreecell_var4_var1 ))(not (on ?o4 ?o1)))(when (and (add_on_homefromfreecell_var4_var1 ))(on ?o4 ?o1))(when (and (del_on_homefromfreecell_var4_var4 ))(not (on ?o4 ?o4)))(when (and (add_on_homefromfreecell_var4_var4 ))(on ?o4 ?o4))(when (and (del_incell_homefromfreecell_var1 ))(not (incell ?o1)))(when (and (add_incell_homefromfreecell_var1 ))(incell ?o1))(when (and (del_incell_homefromfreecell_var4 ))(not (incell ?o4)))(when (and (add_incell_homefromfreecell_var4 ))(incell ?o4))(when (and (del_clear_homefromfreecell_var1 ))(not (clear ?o1)))(when (and (add_clear_homefromfreecell_var1 ))(clear ?o1))(when (and (del_clear_homefromfreecell_var4 ))(not (clear ?o4)))(when (and (add_clear_homefromfreecell_var4 ))(clear ?o4))(when (and (del_cellspace_homefromfreecell_var3 ))(not (cellspace ?o3)))(when (and (add_cellspace_homefromfreecell_var3 ))(cellspace ?o3))(when (and (del_cellspace_homefromfreecell_var5 ))(not (cellspace ?o5)))(when (and (add_cellspace_homefromfreecell_var5 ))(cellspace ?o5))(when (and (del_cellspace_homefromfreecell_var6 ))(not (cellspace ?o6)))(when (and (add_cellspace_homefromfreecell_var6 ))(cellspace ?o6))(when (and (del_cellspace_homefromfreecell_var7 ))(not (cellspace ?o7)))(when (and (add_cellspace_homefromfreecell_var7 ))(cellspace ?o7))(when (and (del_colspace_homefromfreecell_var3 ))(not (colspace ?o3)))(when (and (add_colspace_homefromfreecell_var3 ))(colspace ?o3))(when (and (del_colspace_homefromfreecell_var5 ))(not (colspace ?o5)))(when (and (add_colspace_homefromfreecell_var5 ))(colspace ?o5))(when (and (del_colspace_homefromfreecell_var6 ))(not (colspace ?o6)))(when (and (add_colspace_homefromfreecell_var6 ))(colspace ?o6))(when (and (del_colspace_homefromfreecell_var7 ))(not (colspace ?o7)))(when (and (add_colspace_homefromfreecell_var7 ))(colspace ?o7))(when (and (del_home_homefromfreecell_var1 ))(not (home ?o1)))(when (and (add_home_homefromfreecell_var1 ))(home ?o1))(when (and (del_home_homefromfreecell_var4 ))(not (home ?o4)))(when (and (add_home_homefromfreecell_var4 ))(home ?o4))(when (and (del_bottomcol_homefromfreecell_var1 ))(not (bottomcol ?o1)))(when (and (add_bottomcol_homefromfreecell_var1 ))(bottomcol ?o1))(when (and (del_bottomcol_homefromfreecell_var4 ))(not (bottomcol ?o4)))(when (and (add_bottomcol_homefromfreecell_var4 ))(bottomcol ?o4))(when (and (del_canstack_homefromfreecell_var1_var1 ))(not (canstack ?o1 ?o1)))(when (and (add_canstack_homefromfreecell_var1_var1 ))(canstack ?o1 ?o1))(when (and (del_canstack_homefromfreecell_var1_var4 ))(not (canstack ?o1 ?o4)))(when (and (add_canstack_homefromfreecell_var1_var4 ))(canstack ?o1 ?o4))(when (and (del_canstack_homefromfreecell_var4_var1 ))(not (canstack ?o4 ?o1)))(when (and (add_canstack_homefromfreecell_var4_var1 ))(canstack ?o4 ?o1))(when (and (del_canstack_homefromfreecell_var4_var4 ))(not (canstack ?o4 ?o4)))(when (and (add_canstack_homefromfreecell_var4_var4 ))(canstack ?o4 ?o4))(when (and (del_suit_homefromfreecell_var1_var2 ))(not (suit ?o1 ?o2)))(when (and (add_suit_homefromfreecell_var1_var2 ))(suit ?o1 ?o2))(when (and (del_suit_homefromfreecell_var4_var2 ))(not (suit ?o4 ?o2)))(when (and (add_suit_homefromfreecell_var4_var2 ))(suit ?o4 ?o2))(when (and (del_value_homefromfreecell_var1_var3 ))(not (value ?o1 ?o3)))(when (and (add_value_homefromfreecell_var1_var3 ))(value ?o1 ?o3))(when (and (del_value_homefromfreecell_var1_var5 ))(not (value ?o1 ?o5)))(when (and (add_value_homefromfreecell_var1_var5 ))(value ?o1 ?o5))(when (and (del_value_homefromfreecell_var1_var6 ))(not (value ?o1 ?o6)))(when (and (add_value_homefromfreecell_var1_var6 ))(value ?o1 ?o6))(when (and (del_value_homefromfreecell_var1_var7 ))(not (value ?o1 ?o7)))(when (and (add_value_homefromfreecell_var1_var7 ))(value ?o1 ?o7))(when (and (del_value_homefromfreecell_var4_var3 ))(not (value ?o4 ?o3)))(when (and (add_value_homefromfreecell_var4_var3 ))(value ?o4 ?o3))(when (and (del_value_homefromfreecell_var4_var5 ))(not (value ?o4 ?o5)))(when (and (add_value_homefromfreecell_var4_var5 ))(value ?o4 ?o5))(when (and (del_value_homefromfreecell_var4_var6 ))(not (value ?o4 ?o6)))(when (and (add_value_homefromfreecell_var4_var6 ))(value ?o4 ?o6))(when (and (del_value_homefromfreecell_var4_var7 ))(not (value ?o4 ?o7)))(when (and (add_value_homefromfreecell_var4_var7 ))(value ?o4 ?o7))(when (and (del_successor_homefromfreecell_var3_var3 ))(not (successor ?o3 ?o3)))(when (and (add_successor_homefromfreecell_var3_var3 ))(successor ?o3 ?o3))(when (and (del_successor_homefromfreecell_var3_var5 ))(not (successor ?o3 ?o5)))(when (and (add_successor_homefromfreecell_var3_var5 ))(successor ?o3 ?o5))(when (and (del_successor_homefromfreecell_var3_var6 ))(not (successor ?o3 ?o6)))(when (and (add_successor_homefromfreecell_var3_var6 ))(successor ?o3 ?o6))(when (and (del_successor_homefromfreecell_var3_var7 ))(not (successor ?o3 ?o7)))(when (and (add_successor_homefromfreecell_var3_var7 ))(successor ?o3 ?o7))(when (and (del_successor_homefromfreecell_var5_var3 ))(not (successor ?o5 ?o3)))(when (and (add_successor_homefromfreecell_var5_var3 ))(successor ?o5 ?o3))(when (and (del_successor_homefromfreecell_var5_var5 ))(not (successor ?o5 ?o5)))(when (and (add_successor_homefromfreecell_var5_var5 ))(successor ?o5 ?o5))(when (and (del_successor_homefromfreecell_var5_var6 ))(not (successor ?o5 ?o6)))(when (and (add_successor_homefromfreecell_var5_var6 ))(successor ?o5 ?o6))(when (and (del_successor_homefromfreecell_var5_var7 ))(not (successor ?o5 ?o7)))(when (and (add_successor_homefromfreecell_var5_var7 ))(successor ?o5 ?o7))(when (and (del_successor_homefromfreecell_var6_var3 ))(not (successor ?o6 ?o3)))(when (and (add_successor_homefromfreecell_var6_var3 ))(successor ?o6 ?o3))(when (and (del_successor_homefromfreecell_var6_var5 ))(not (successor ?o6 ?o5)))(when (and (add_successor_homefromfreecell_var6_var5 ))(successor ?o6 ?o5))(when (and (del_successor_homefromfreecell_var6_var6 ))(not (successor ?o6 ?o6)))(when (and (add_successor_homefromfreecell_var6_var6 ))(successor ?o6 ?o6))(when (and (del_successor_homefromfreecell_var6_var7 ))(not (successor ?o6 ?o7)))(when (and (add_successor_homefromfreecell_var6_var7 ))(successor ?o6 ?o7))(when (and (del_successor_homefromfreecell_var7_var3 ))(not (successor ?o7 ?o3)))(when (and (add_successor_homefromfreecell_var7_var3 ))(successor ?o7 ?o3))(when (and (del_successor_homefromfreecell_var7_var5 ))(not (successor ?o7 ?o5)))(when (and (add_successor_homefromfreecell_var7_var5 ))(successor ?o7 ?o5))(when (and (del_successor_homefromfreecell_var7_var6 ))(not (successor ?o7 ?o6)))(when (and (add_successor_homefromfreecell_var7_var6 ))(successor ?o7 ?o6))(when (and (del_successor_homefromfreecell_var7_var7 ))(not (successor ?o7 ?o7)))(when (and (add_successor_homefromfreecell_var7_var7 ))(successor ?o7 ?o7))))

 (:action colfromfreecell
   :parameters (?o1 - card ?o2 - card ?o3 - num ?o4 - num ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(or (not (pre_on_colfromfreecell_var1_var1 ))(on ?o1 ?o1))(or (not (pre_on_colfromfreecell_var1_var2 ))(on ?o1 ?o2))(or (not (pre_on_colfromfreecell_var2_var1 ))(on ?o2 ?o1))(or (not (pre_on_colfromfreecell_var2_var2 ))(on ?o2 ?o2))(or (not (pre_incell_colfromfreecell_var1 ))(incell ?o1))(or (not (pre_incell_colfromfreecell_var2 ))(incell ?o2))(or (not (pre_clear_colfromfreecell_var1 ))(clear ?o1))(or (not (pre_clear_colfromfreecell_var2 ))(clear ?o2))(or (not (pre_cellspace_colfromfreecell_var3 ))(cellspace ?o3))(or (not (pre_cellspace_colfromfreecell_var4 ))(cellspace ?o4))(or (not (pre_colspace_colfromfreecell_var3 ))(colspace ?o3))(or (not (pre_colspace_colfromfreecell_var4 ))(colspace ?o4))(or (not (pre_home_colfromfreecell_var1 ))(home ?o1))(or (not (pre_home_colfromfreecell_var2 ))(home ?o2))(or (not (pre_bottomcol_colfromfreecell_var1 ))(bottomcol ?o1))(or (not (pre_bottomcol_colfromfreecell_var2 ))(bottomcol ?o2))(or (not (pre_canstack_colfromfreecell_var1_var1 ))(canstack ?o1 ?o1))(or (not (pre_canstack_colfromfreecell_var1_var2 ))(canstack ?o1 ?o2))(or (not (pre_canstack_colfromfreecell_var2_var1 ))(canstack ?o2 ?o1))(or (not (pre_canstack_colfromfreecell_var2_var2 ))(canstack ?o2 ?o2))(or (not (pre_value_colfromfreecell_var1_var3 ))(value ?o1 ?o3))(or (not (pre_value_colfromfreecell_var1_var4 ))(value ?o1 ?o4))(or (not (pre_value_colfromfreecell_var2_var3 ))(value ?o2 ?o3))(or (not (pre_value_colfromfreecell_var2_var4 ))(value ?o2 ?o4))(or (not (pre_successor_colfromfreecell_var3_var3 ))(successor ?o3 ?o3))(or (not (pre_successor_colfromfreecell_var3_var4 ))(successor ?o3 ?o4))(or (not (pre_successor_colfromfreecell_var4_var3 ))(successor ?o4 ?o3))(or (not (pre_successor_colfromfreecell_var4_var4 ))(successor ?o4 ?o4))(current ?i1)(inext ?i1 ?i2)(plan-colfromfreecell ?i1 ?o1 ?o2 ?o3 ?o4))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)(when (and (del_on_colfromfreecell_var1_var1 ))(not (on ?o1 ?o1)))(when (and (add_on_colfromfreecell_var1_var1 ))(on ?o1 ?o1))(when (and (del_on_colfromfreecell_var1_var2 ))(not (on ?o1 ?o2)))(when (and (add_on_colfromfreecell_var1_var2 ))(on ?o1 ?o2))(when (and (del_on_colfromfreecell_var2_var1 ))(not (on ?o2 ?o1)))(when (and (add_on_colfromfreecell_var2_var1 ))(on ?o2 ?o1))(when (and (del_on_colfromfreecell_var2_var2 ))(not (on ?o2 ?o2)))(when (and (add_on_colfromfreecell_var2_var2 ))(on ?o2 ?o2))(when (and (del_incell_colfromfreecell_var1 ))(not (incell ?o1)))(when (and (add_incell_colfromfreecell_var1 ))(incell ?o1))(when (and (del_incell_colfromfreecell_var2 ))(not (incell ?o2)))(when (and (add_incell_colfromfreecell_var2 ))(incell ?o2))(when (and (del_clear_colfromfreecell_var1 ))(not (clear ?o1)))(when (and (add_clear_colfromfreecell_var1 ))(clear ?o1))(when (and (del_clear_colfromfreecell_var2 ))(not (clear ?o2)))(when (and (add_clear_colfromfreecell_var2 ))(clear ?o2))(when (and (del_cellspace_colfromfreecell_var3 ))(not (cellspace ?o3)))(when (and (add_cellspace_colfromfreecell_var3 ))(cellspace ?o3))(when (and (del_cellspace_colfromfreecell_var4 ))(not (cellspace ?o4)))(when (and (add_cellspace_colfromfreecell_var4 ))(cellspace ?o4))(when (and (del_colspace_colfromfreecell_var3 ))(not (colspace ?o3)))(when (and (add_colspace_colfromfreecell_var3 ))(colspace ?o3))(when (and (del_colspace_colfromfreecell_var4 ))(not (colspace ?o4)))(when (and (add_colspace_colfromfreecell_var4 ))(colspace ?o4))(when (and (del_home_colfromfreecell_var1 ))(not (home ?o1)))(when (and (add_home_colfromfreecell_var1 ))(home ?o1))(when (and (del_home_colfromfreecell_var2 ))(not (home ?o2)))(when (and (add_home_colfromfreecell_var2 ))(home ?o2))(when (and (del_bottomcol_colfromfreecell_var1 ))(not (bottomcol ?o1)))(when (and (add_bottomcol_colfromfreecell_var1 ))(bottomcol ?o1))(when (and (del_bottomcol_colfromfreecell_var2 ))(not (bottomcol ?o2)))(when (and (add_bottomcol_colfromfreecell_var2 ))(bottomcol ?o2))(when (and (del_canstack_colfromfreecell_var1_var1 ))(not (canstack ?o1 ?o1)))(when (and (add_canstack_colfromfreecell_var1_var1 ))(canstack ?o1 ?o1))(when (and (del_canstack_colfromfreecell_var1_var2 ))(not (canstack ?o1 ?o2)))(when (and (add_canstack_colfromfreecell_var1_var2 ))(canstack ?o1 ?o2))(when (and (del_canstack_colfromfreecell_var2_var1 ))(not (canstack ?o2 ?o1)))(when (and (add_canstack_colfromfreecell_var2_var1 ))(canstack ?o2 ?o1))(when (and (del_canstack_colfromfreecell_var2_var2 ))(not (canstack ?o2 ?o2)))(when (and (add_canstack_colfromfreecell_var2_var2 ))(canstack ?o2 ?o2))(when (and (del_value_colfromfreecell_var1_var3 ))(not (value ?o1 ?o3)))(when (and (add_value_colfromfreecell_var1_var3 ))(value ?o1 ?o3))(when (and (del_value_colfromfreecell_var1_var4 ))(not (value ?o1 ?o4)))(when (and (add_value_colfromfreecell_var1_var4 ))(value ?o1 ?o4))(when (and (del_value_colfromfreecell_var2_var3 ))(not (value ?o2 ?o3)))(when (and (add_value_colfromfreecell_var2_var3 ))(value ?o2 ?o3))(when (and (del_value_colfromfreecell_var2_var4 ))(not (value ?o2 ?o4)))(when (and (add_value_colfromfreecell_var2_var4 ))(value ?o2 ?o4))(when (and (del_successor_colfromfreecell_var3_var3 ))(not (successor ?o3 ?o3)))(when (and (add_successor_colfromfreecell_var3_var3 ))(successor ?o3 ?o3))(when (and (del_successor_colfromfreecell_var3_var4 ))(not (successor ?o3 ?o4)))(when (and (add_successor_colfromfreecell_var3_var4 ))(successor ?o3 ?o4))(when (and (del_successor_colfromfreecell_var4_var3 ))(not (successor ?o4 ?o3)))(when (and (add_successor_colfromfreecell_var4_var3 ))(successor ?o4 ?o3))(when (and (del_successor_colfromfreecell_var4_var4 ))(not (successor ?o4 ?o4)))(when (and (add_successor_colfromfreecell_var4_var4 ))(successor ?o4 ?o4))))

 (:action newcolfromfreecell
   :parameters (?o1 - card ?o2 - num ?o3 - num ?o4 - num ?o5 - num ?i1 - step ?i2 - step)
   :precondition (and (not (modeProg ))(or (not (pre_on_newcolfromfreecell_var1_var1 ))(on ?o1 ?o1))(or (not (pre_incell_newcolfromfreecell_var1 ))(incell ?o1))(or (not (pre_clear_newcolfromfreecell_var1 ))(clear ?o1))(or (not (pre_cellspace_newcolfromfreecell_var2 ))(cellspace ?o2))(or (not (pre_cellspace_newcolfromfreecell_var3 ))(cellspace ?o3))(or (not (pre_cellspace_newcolfromfreecell_var4 ))(cellspace ?o4))(or (not (pre_cellspace_newcolfromfreecell_var5 ))(cellspace ?o5))(or (not (pre_colspace_newcolfromfreecell_var2 ))(colspace ?o2))(or (not (pre_colspace_newcolfromfreecell_var3 ))(colspace ?o3))(or (not (pre_colspace_newcolfromfreecell_var4 ))(colspace ?o4))(or (not (pre_colspace_newcolfromfreecell_var5 ))(colspace ?o5))(or (not (pre_home_newcolfromfreecell_var1 ))(home ?o1))(or (not (pre_bottomcol_newcolfromfreecell_var1 ))(bottomcol ?o1))(or (not (pre_canstack_newcolfromfreecell_var1_var1 ))(canstack ?o1 ?o1))(or (not (pre_value_newcolfromfreecell_var1_var2 ))(value ?o1 ?o2))(or (not (pre_value_newcolfromfreecell_var1_var3 ))(value ?o1 ?o3))(or (not (pre_value_newcolfromfreecell_var1_var4 ))(value ?o1 ?o4))(or (not (pre_value_newcolfromfreecell_var1_var5 ))(value ?o1 ?o5))(or (not (pre_successor_newcolfromfreecell_var2_var2 ))(successor ?o2 ?o2))(or (not (pre_successor_newcolfromfreecell_var2_var3 ))(successor ?o2 ?o3))(or (not (pre_successor_newcolfromfreecell_var2_var4 ))(successor ?o2 ?o4))(or (not (pre_successor_newcolfromfreecell_var2_var5 ))(successor ?o2 ?o5))(or (not (pre_successor_newcolfromfreecell_var3_var2 ))(successor ?o3 ?o2))(or (not (pre_successor_newcolfromfreecell_var3_var3 ))(successor ?o3 ?o3))(or (not (pre_successor_newcolfromfreecell_var3_var4 ))(successor ?o3 ?o4))(or (not (pre_successor_newcolfromfreecell_var3_var5 ))(successor ?o3 ?o5))(or (not (pre_successor_newcolfromfreecell_var4_var2 ))(successor ?o4 ?o2))(or (not (pre_successor_newcolfromfreecell_var4_var3 ))(successor ?o4 ?o3))(or (not (pre_successor_newcolfromfreecell_var4_var4 ))(successor ?o4 ?o4))(or (not (pre_successor_newcolfromfreecell_var4_var5 ))(successor ?o4 ?o5))(or (not (pre_successor_newcolfromfreecell_var5_var2 ))(successor ?o5 ?o2))(or (not (pre_successor_newcolfromfreecell_var5_var3 ))(successor ?o5 ?o3))(or (not (pre_successor_newcolfromfreecell_var5_var4 ))(successor ?o5 ?o4))(or (not (pre_successor_newcolfromfreecell_var5_var5 ))(successor ?o5 ?o5))(current ?i1)(inext ?i1 ?i2)(plan-newcolfromfreecell ?i1 ?o1 ?o2 ?o3 ?o4 ?o5))
   :effect (and (action_applied )(not (current ?i1))(current ?i2)(when (and (del_on_newcolfromfreecell_var1_var1 ))(not (on ?o1 ?o1)))(when (and (add_on_newcolfromfreecell_var1_var1 ))(on ?o1 ?o1))(when (and (del_incell_newcolfromfreecell_var1 ))(not (incell ?o1)))(when (and (add_incell_newcolfromfreecell_var1 ))(incell ?o1))(when (and (del_clear_newcolfromfreecell_var1 ))(not (clear ?o1)))(when (and (add_clear_newcolfromfreecell_var1 ))(clear ?o1))(when (and (del_cellspace_newcolfromfreecell_var2 ))(not (cellspace ?o2)))(when (and (add_cellspace_newcolfromfreecell_var2 ))(cellspace ?o2))(when (and (del_cellspace_newcolfromfreecell_var3 ))(not (cellspace ?o3)))(when (and (add_cellspace_newcolfromfreecell_var3 ))(cellspace ?o3))(when (and (del_cellspace_newcolfromfreecell_var4 ))(not (cellspace ?o4)))(when (and (add_cellspace_newcolfromfreecell_var4 ))(cellspace ?o4))(when (and (del_cellspace_newcolfromfreecell_var5 ))(not (cellspace ?o5)))(when (and (add_cellspace_newcolfromfreecell_var5 ))(cellspace ?o5))(when (and (del_colspace_newcolfromfreecell_var2 ))(not (colspace ?o2)))(when (and (add_colspace_newcolfromfreecell_var2 ))(colspace ?o2))(when (and (del_colspace_newcolfromfreecell_var3 ))(not (colspace ?o3)))(when (and (add_colspace_newcolfromfreecell_var3 ))(colspace ?o3))(when (and (del_colspace_newcolfromfreecell_var4 ))(not (colspace ?o4)))(when (and (add_colspace_newcolfromfreecell_var4 ))(colspace ?o4))(when (and (del_colspace_newcolfromfreecell_var5 ))(not (colspace ?o5)))(when (and (add_colspace_newcolfromfreecell_var5 ))(colspace ?o5))(when (and (del_home_newcolfromfreecell_var1 ))(not (home ?o1)))(when (and (add_home_newcolfromfreecell_var1 ))(home ?o1))(when (and (del_bottomcol_newcolfromfreecell_var1 ))(not (bottomcol ?o1)))(when (and (add_bottomcol_newcolfromfreecell_var1 ))(bottomcol ?o1))(when (and (del_canstack_newcolfromfreecell_var1_var1 ))(not (canstack ?o1 ?o1)))(when (and (add_canstack_newcolfromfreecell_var1_var1 ))(canstack ?o1 ?o1))(when (and (del_value_newcolfromfreecell_var1_var2 ))(not (value ?o1 ?o2)))(when (and (add_value_newcolfromfreecell_var1_var2 ))(value ?o1 ?o2))(when (and (del_value_newcolfromfreecell_var1_var3 ))(not (value ?o1 ?o3)))(when (and (add_value_newcolfromfreecell_var1_var3 ))(value ?o1 ?o3))(when (and (del_value_newcolfromfreecell_var1_var4 ))(not (value ?o1 ?o4)))(when (and (add_value_newcolfromfreecell_var1_var4 ))(value ?o1 ?o4))(when (and (del_value_newcolfromfreecell_var1_var5 ))(not (value ?o1 ?o5)))(when (and (add_value_newcolfromfreecell_var1_var5 ))(value ?o1 ?o5))(when (and (del_successor_newcolfromfreecell_var2_var2 ))(not (successor ?o2 ?o2)))(when (and (add_successor_newcolfromfreecell_var2_var2 ))(successor ?o2 ?o2))(when (and (del_successor_newcolfromfreecell_var2_var3 ))(not (successor ?o2 ?o3)))(when (and (add_successor_newcolfromfreecell_var2_var3 ))(successor ?o2 ?o3))(when (and (del_successor_newcolfromfreecell_var2_var4 ))(not (successor ?o2 ?o4)))(when (and (add_successor_newcolfromfreecell_var2_var4 ))(successor ?o2 ?o4))(when (and (del_successor_newcolfromfreecell_var2_var5 ))(not (successor ?o2 ?o5)))(when (and (add_successor_newcolfromfreecell_var2_var5 ))(successor ?o2 ?o5))(when (and (del_successor_newcolfromfreecell_var3_var2 ))(not (successor ?o3 ?o2)))(when (and (add_successor_newcolfromfreecell_var3_var2 ))(successor ?o3 ?o2))(when (and (del_successor_newcolfromfreecell_var3_var3 ))(not (successor ?o3 ?o3)))(when (and (add_successor_newcolfromfreecell_var3_var3 ))(successor ?o3 ?o3))(when (and (del_successor_newcolfromfreecell_var3_var4 ))(not (successor ?o3 ?o4)))(when (and (add_successor_newcolfromfreecell_var3_var4 ))(successor ?o3 ?o4))(when (and (del_successor_newcolfromfreecell_var3_var5 ))(not (successor ?o3 ?o5)))(when (and (add_successor_newcolfromfreecell_var3_var5 ))(successor ?o3 ?o5))(when (and (del_successor_newcolfromfreecell_var4_var2 ))(not (successor ?o4 ?o2)))(when (and (add_successor_newcolfromfreecell_var4_var2 ))(successor ?o4 ?o2))(when (and (del_successor_newcolfromfreecell_var4_var3 ))(not (successor ?o4 ?o3)))(when (and (add_successor_newcolfromfreecell_var4_var3 ))(successor ?o4 ?o3))(when (and (del_successor_newcolfromfreecell_var4_var4 ))(not (successor ?o4 ?o4)))(when (and (add_successor_newcolfromfreecell_var4_var4 ))(successor ?o4 ?o4))(when (and (del_successor_newcolfromfreecell_var4_var5 ))(not (successor ?o4 ?o5)))(when (and (add_successor_newcolfromfreecell_var4_var5 ))(successor ?o4 ?o5))(when (and (del_successor_newcolfromfreecell_var5_var2 ))(not (successor ?o5 ?o2)))(when (and (add_successor_newcolfromfreecell_var5_var2 ))(successor ?o5 ?o2))(when (and (del_successor_newcolfromfreecell_var5_var3 ))(not (successor ?o5 ?o3)))(when (and (add_successor_newcolfromfreecell_var5_var3 ))(successor ?o5 ?o3))(when (and (del_successor_newcolfromfreecell_var5_var4 ))(not (successor ?o5 ?o4)))(when (and (add_successor_newcolfromfreecell_var5_var4 ))(successor ?o5 ?o4))(when (and (del_successor_newcolfromfreecell_var5_var5 ))(not (successor ?o5 ?o5)))(when (and (add_successor_newcolfromfreecell_var5_var5 ))(successor ?o5 ?o5))))

 (:action program_pre_on_move_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_move_var1_var1 ))(not (del_on_move_var1_var1 ))(not (add_on_move_var1_var1 )))
   :effect (and (pre_on_move_var1_var1 )))

 (:action program_eff_on_move_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_move_var1_var1 ))(not (add_on_move_var1_var1 )))
   :effect (and (when (pre_on_move_var1_var1 )(del_on_move_var1_var1 ))(when (not (pre_on_move_var1_var1 ))(add_on_move_var1_var1 ))))

 (:action program_pre_on_move_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_move_var1_var2 ))(not (del_on_move_var1_var2 ))(not (add_on_move_var1_var2 )))
   :effect (and (pre_on_move_var1_var2 )))

 (:action program_eff_on_move_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_on_move_var1_var2 ))(not (add_on_move_var1_var2 )))
   :effect (and (when (pre_on_move_var1_var2 )(del_on_move_var1_var2 ))(when (not (pre_on_move_var1_var2 ))(add_on_move_var1_var2 ))))

 (:action program_pre_on_move_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_move_var1_var3 ))(not (del_on_move_var1_var3 ))(not (add_on_move_var1_var3 )))
   :effect (and (pre_on_move_var1_var3 )))

 (:action program_eff_on_move_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_on_move_var1_var3 ))(not (add_on_move_var1_var3 )))
   :effect (and (when (pre_on_move_var1_var3 )(del_on_move_var1_var3 ))(when (not (pre_on_move_var1_var3 ))(add_on_move_var1_var3 ))))

 (:action program_pre_on_move_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_move_var2_var1 ))(not (del_on_move_var2_var1 ))(not (add_on_move_var2_var1 )))
   :effect (and (pre_on_move_var2_var1 )))

 (:action program_eff_on_move_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_move_var2_var1 ))(not (add_on_move_var2_var1 )))
   :effect (and (when (pre_on_move_var2_var1 )(del_on_move_var2_var1 ))(when (not (pre_on_move_var2_var1 ))(add_on_move_var2_var1 ))))

 (:action program_pre_on_move_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_move_var2_var2 ))(not (del_on_move_var2_var2 ))(not (add_on_move_var2_var2 )))
   :effect (and (pre_on_move_var2_var2 )))

 (:action program_eff_on_move_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_on_move_var2_var2 ))(not (add_on_move_var2_var2 )))
   :effect (and (when (pre_on_move_var2_var2 )(del_on_move_var2_var2 ))(when (not (pre_on_move_var2_var2 ))(add_on_move_var2_var2 ))))

 (:action program_pre_on_move_var2_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_move_var2_var3 ))(not (del_on_move_var2_var3 ))(not (add_on_move_var2_var3 )))
   :effect (and (pre_on_move_var2_var3 )))

 (:action program_eff_on_move_var2_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_on_move_var2_var3 ))(not (add_on_move_var2_var3 )))
   :effect (and (when (pre_on_move_var2_var3 )(del_on_move_var2_var3 ))(when (not (pre_on_move_var2_var3 ))(add_on_move_var2_var3 ))))

 (:action program_pre_on_move_var3_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_move_var3_var1 ))(not (del_on_move_var3_var1 ))(not (add_on_move_var3_var1 )))
   :effect (and (pre_on_move_var3_var1 )))

 (:action program_eff_on_move_var3_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_move_var3_var1 ))(not (add_on_move_var3_var1 )))
   :effect (and (when (pre_on_move_var3_var1 )(del_on_move_var3_var1 ))(when (not (pre_on_move_var3_var1 ))(add_on_move_var3_var1 ))))

 (:action program_pre_on_move_var3_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_move_var3_var2 ))(not (del_on_move_var3_var2 ))(not (add_on_move_var3_var2 )))
   :effect (and (pre_on_move_var3_var2 )))

 (:action program_eff_on_move_var3_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_on_move_var3_var2 ))(not (add_on_move_var3_var2 )))
   :effect (and (when (pre_on_move_var3_var2 )(del_on_move_var3_var2 ))(when (not (pre_on_move_var3_var2 ))(add_on_move_var3_var2 ))))

 (:action program_pre_on_move_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_move_var3_var3 ))(not (del_on_move_var3_var3 ))(not (add_on_move_var3_var3 )))
   :effect (and (pre_on_move_var3_var3 )))

 (:action program_eff_on_move_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_on_move_var3_var3 ))(not (add_on_move_var3_var3 )))
   :effect (and (when (pre_on_move_var3_var3 )(del_on_move_var3_var3 ))(when (not (pre_on_move_var3_var3 ))(add_on_move_var3_var3 ))))

 (:action program_pre_incell_move_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_move_var1 ))(not (del_incell_move_var1 ))(not (add_incell_move_var1 )))
   :effect (and (pre_incell_move_var1 )))

 (:action program_eff_incell_move_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_move_var1 ))(not (add_incell_move_var1 )))
   :effect (and (when (pre_incell_move_var1 )(del_incell_move_var1 ))(when (not (pre_incell_move_var1 ))(add_incell_move_var1 ))))

 (:action program_pre_incell_move_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_move_var2 ))(not (del_incell_move_var2 ))(not (add_incell_move_var2 )))
   :effect (and (pre_incell_move_var2 )))

 (:action program_eff_incell_move_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_move_var2 ))(not (add_incell_move_var2 )))
   :effect (and (when (pre_incell_move_var2 )(del_incell_move_var2 ))(when (not (pre_incell_move_var2 ))(add_incell_move_var2 ))))

 (:action program_pre_incell_move_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_move_var3 ))(not (del_incell_move_var3 ))(not (add_incell_move_var3 )))
   :effect (and (pre_incell_move_var3 )))

 (:action program_eff_incell_move_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_move_var3 ))(not (add_incell_move_var3 )))
   :effect (and (when (pre_incell_move_var3 )(del_incell_move_var3 ))(when (not (pre_incell_move_var3 ))(add_incell_move_var3 ))))

 (:action program_pre_clear_move_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_move_var1 ))(not (del_clear_move_var1 ))(not (add_clear_move_var1 )))
   :effect (and (pre_clear_move_var1 )))

 (:action program_eff_clear_move_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_move_var1 ))(not (add_clear_move_var1 )))
   :effect (and (when (pre_clear_move_var1 )(del_clear_move_var1 ))(when (not (pre_clear_move_var1 ))(add_clear_move_var1 ))))

 (:action program_pre_clear_move_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_move_var2 ))(not (del_clear_move_var2 ))(not (add_clear_move_var2 )))
   :effect (and (pre_clear_move_var2 )))

 (:action program_eff_clear_move_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_move_var2 ))(not (add_clear_move_var2 )))
   :effect (and (when (pre_clear_move_var2 )(del_clear_move_var2 ))(when (not (pre_clear_move_var2 ))(add_clear_move_var2 ))))

 (:action program_pre_clear_move_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_move_var3 ))(not (del_clear_move_var3 ))(not (add_clear_move_var3 )))
   :effect (and (pre_clear_move_var3 )))

 (:action program_eff_clear_move_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_move_var3 ))(not (add_clear_move_var3 )))
   :effect (and (when (pre_clear_move_var3 )(del_clear_move_var3 ))(when (not (pre_clear_move_var3 ))(add_clear_move_var3 ))))

 (:action program_pre_home_move_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_move_var1 ))(not (del_home_move_var1 ))(not (add_home_move_var1 )))
   :effect (and (pre_home_move_var1 )))

 (:action program_eff_home_move_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_home_move_var1 ))(not (add_home_move_var1 )))
   :effect (and (when (pre_home_move_var1 )(del_home_move_var1 ))(when (not (pre_home_move_var1 ))(add_home_move_var1 ))))

 (:action program_pre_home_move_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_move_var2 ))(not (del_home_move_var2 ))(not (add_home_move_var2 )))
   :effect (and (pre_home_move_var2 )))

 (:action program_eff_home_move_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_home_move_var2 ))(not (add_home_move_var2 )))
   :effect (and (when (pre_home_move_var2 )(del_home_move_var2 ))(when (not (pre_home_move_var2 ))(add_home_move_var2 ))))

 (:action program_pre_home_move_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_move_var3 ))(not (del_home_move_var3 ))(not (add_home_move_var3 )))
   :effect (and (pre_home_move_var3 )))

 (:action program_eff_home_move_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_home_move_var3 ))(not (add_home_move_var3 )))
   :effect (and (when (pre_home_move_var3 )(del_home_move_var3 ))(when (not (pre_home_move_var3 ))(add_home_move_var3 ))))

 (:action program_pre_bottomcol_move_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_move_var1 ))(not (del_bottomcol_move_var1 ))(not (add_bottomcol_move_var1 )))
   :effect (and (pre_bottomcol_move_var1 )))

 (:action program_eff_bottomcol_move_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_move_var1 ))(not (add_bottomcol_move_var1 )))
   :effect (and (when (pre_bottomcol_move_var1 )(del_bottomcol_move_var1 ))(when (not (pre_bottomcol_move_var1 ))(add_bottomcol_move_var1 ))))

 (:action program_pre_bottomcol_move_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_move_var2 ))(not (del_bottomcol_move_var2 ))(not (add_bottomcol_move_var2 )))
   :effect (and (pre_bottomcol_move_var2 )))

 (:action program_eff_bottomcol_move_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_move_var2 ))(not (add_bottomcol_move_var2 )))
   :effect (and (when (pre_bottomcol_move_var2 )(del_bottomcol_move_var2 ))(when (not (pre_bottomcol_move_var2 ))(add_bottomcol_move_var2 ))))

 (:action program_pre_bottomcol_move_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_move_var3 ))(not (del_bottomcol_move_var3 ))(not (add_bottomcol_move_var3 )))
   :effect (and (pre_bottomcol_move_var3 )))

 (:action program_eff_bottomcol_move_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_move_var3 ))(not (add_bottomcol_move_var3 )))
   :effect (and (when (pre_bottomcol_move_var3 )(del_bottomcol_move_var3 ))(when (not (pre_bottomcol_move_var3 ))(add_bottomcol_move_var3 ))))

 (:action program_pre_canstack_move_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_move_var1_var1 ))(not (del_canstack_move_var1_var1 ))(not (add_canstack_move_var1_var1 )))
   :effect (and (pre_canstack_move_var1_var1 )))

 (:action program_eff_canstack_move_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_move_var1_var1 ))(not (add_canstack_move_var1_var1 )))
   :effect (and (when (pre_canstack_move_var1_var1 )(del_canstack_move_var1_var1 ))(when (not (pre_canstack_move_var1_var1 ))(add_canstack_move_var1_var1 ))))

 (:action program_pre_canstack_move_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_move_var1_var2 ))(not (del_canstack_move_var1_var2 ))(not (add_canstack_move_var1_var2 )))
   :effect (and (pre_canstack_move_var1_var2 )))

 (:action program_eff_canstack_move_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_move_var1_var2 ))(not (add_canstack_move_var1_var2 )))
   :effect (and (when (pre_canstack_move_var1_var2 )(del_canstack_move_var1_var2 ))(when (not (pre_canstack_move_var1_var2 ))(add_canstack_move_var1_var2 ))))

 (:action program_pre_canstack_move_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_move_var1_var3 ))(not (del_canstack_move_var1_var3 ))(not (add_canstack_move_var1_var3 )))
   :effect (and (pre_canstack_move_var1_var3 )))

 (:action program_eff_canstack_move_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_move_var1_var3 ))(not (add_canstack_move_var1_var3 )))
   :effect (and (when (pre_canstack_move_var1_var3 )(del_canstack_move_var1_var3 ))(when (not (pre_canstack_move_var1_var3 ))(add_canstack_move_var1_var3 ))))

 (:action program_pre_canstack_move_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_move_var2_var1 ))(not (del_canstack_move_var2_var1 ))(not (add_canstack_move_var2_var1 )))
   :effect (and (pre_canstack_move_var2_var1 )))

 (:action program_eff_canstack_move_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_move_var2_var1 ))(not (add_canstack_move_var2_var1 )))
   :effect (and (when (pre_canstack_move_var2_var1 )(del_canstack_move_var2_var1 ))(when (not (pre_canstack_move_var2_var1 ))(add_canstack_move_var2_var1 ))))

 (:action program_pre_canstack_move_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_move_var2_var2 ))(not (del_canstack_move_var2_var2 ))(not (add_canstack_move_var2_var2 )))
   :effect (and (pre_canstack_move_var2_var2 )))

 (:action program_eff_canstack_move_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_move_var2_var2 ))(not (add_canstack_move_var2_var2 )))
   :effect (and (when (pre_canstack_move_var2_var2 )(del_canstack_move_var2_var2 ))(when (not (pre_canstack_move_var2_var2 ))(add_canstack_move_var2_var2 ))))

 (:action program_pre_canstack_move_var2_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_move_var2_var3 ))(not (del_canstack_move_var2_var3 ))(not (add_canstack_move_var2_var3 )))
   :effect (and (pre_canstack_move_var2_var3 )))

 (:action program_eff_canstack_move_var2_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_move_var2_var3 ))(not (add_canstack_move_var2_var3 )))
   :effect (and (when (pre_canstack_move_var2_var3 )(del_canstack_move_var2_var3 ))(when (not (pre_canstack_move_var2_var3 ))(add_canstack_move_var2_var3 ))))

 (:action program_pre_canstack_move_var3_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_move_var3_var1 ))(not (del_canstack_move_var3_var1 ))(not (add_canstack_move_var3_var1 )))
   :effect (and (pre_canstack_move_var3_var1 )))

 (:action program_eff_canstack_move_var3_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_move_var3_var1 ))(not (add_canstack_move_var3_var1 )))
   :effect (and (when (pre_canstack_move_var3_var1 )(del_canstack_move_var3_var1 ))(when (not (pre_canstack_move_var3_var1 ))(add_canstack_move_var3_var1 ))))

 (:action program_pre_canstack_move_var3_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_move_var3_var2 ))(not (del_canstack_move_var3_var2 ))(not (add_canstack_move_var3_var2 )))
   :effect (and (pre_canstack_move_var3_var2 )))

 (:action program_eff_canstack_move_var3_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_move_var3_var2 ))(not (add_canstack_move_var3_var2 )))
   :effect (and (when (pre_canstack_move_var3_var2 )(del_canstack_move_var3_var2 ))(when (not (pre_canstack_move_var3_var2 ))(add_canstack_move_var3_var2 ))))

 (:action program_pre_canstack_move_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_move_var3_var3 ))(not (del_canstack_move_var3_var3 ))(not (add_canstack_move_var3_var3 )))
   :effect (and (pre_canstack_move_var3_var3 )))

 (:action program_eff_canstack_move_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_move_var3_var3 ))(not (add_canstack_move_var3_var3 )))
   :effect (and (when (pre_canstack_move_var3_var3 )(del_canstack_move_var3_var3 ))(when (not (pre_canstack_move_var3_var3 ))(add_canstack_move_var3_var3 ))))

 (:action program_pre_on_move-b_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_move-b_var1_var1 ))(not (del_on_move-b_var1_var1 ))(not (add_on_move-b_var1_var1 )))
   :effect (and (pre_on_move-b_var1_var1 )))

 (:action program_eff_on_move-b_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_move-b_var1_var1 ))(not (add_on_move-b_var1_var1 )))
   :effect (and (when (pre_on_move-b_var1_var1 )(del_on_move-b_var1_var1 ))(when (not (pre_on_move-b_var1_var1 ))(add_on_move-b_var1_var1 ))))

 (:action program_pre_on_move-b_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_move-b_var1_var2 ))(not (del_on_move-b_var1_var2 ))(not (add_on_move-b_var1_var2 )))
   :effect (and (pre_on_move-b_var1_var2 )))

 (:action program_eff_on_move-b_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_on_move-b_var1_var2 ))(not (add_on_move-b_var1_var2 )))
   :effect (and (when (pre_on_move-b_var1_var2 )(del_on_move-b_var1_var2 ))(when (not (pre_on_move-b_var1_var2 ))(add_on_move-b_var1_var2 ))))

 (:action program_pre_on_move-b_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_move-b_var2_var1 ))(not (del_on_move-b_var2_var1 ))(not (add_on_move-b_var2_var1 )))
   :effect (and (pre_on_move-b_var2_var1 )))

 (:action program_eff_on_move-b_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_move-b_var2_var1 ))(not (add_on_move-b_var2_var1 )))
   :effect (and (when (pre_on_move-b_var2_var1 )(del_on_move-b_var2_var1 ))(when (not (pre_on_move-b_var2_var1 ))(add_on_move-b_var2_var1 ))))

 (:action program_pre_on_move-b_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_move-b_var2_var2 ))(not (del_on_move-b_var2_var2 ))(not (add_on_move-b_var2_var2 )))
   :effect (and (pre_on_move-b_var2_var2 )))

 (:action program_eff_on_move-b_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_on_move-b_var2_var2 ))(not (add_on_move-b_var2_var2 )))
   :effect (and (when (pre_on_move-b_var2_var2 )(del_on_move-b_var2_var2 ))(when (not (pre_on_move-b_var2_var2 ))(add_on_move-b_var2_var2 ))))

 (:action program_pre_incell_move-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_move-b_var1 ))(not (del_incell_move-b_var1 ))(not (add_incell_move-b_var1 )))
   :effect (and (pre_incell_move-b_var1 )))

 (:action program_eff_incell_move-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_move-b_var1 ))(not (add_incell_move-b_var1 )))
   :effect (and (when (pre_incell_move-b_var1 )(del_incell_move-b_var1 ))(when (not (pre_incell_move-b_var1 ))(add_incell_move-b_var1 ))))

 (:action program_pre_incell_move-b_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_move-b_var2 ))(not (del_incell_move-b_var2 ))(not (add_incell_move-b_var2 )))
   :effect (and (pre_incell_move-b_var2 )))

 (:action program_eff_incell_move-b_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_move-b_var2 ))(not (add_incell_move-b_var2 )))
   :effect (and (when (pre_incell_move-b_var2 )(del_incell_move-b_var2 ))(when (not (pre_incell_move-b_var2 ))(add_incell_move-b_var2 ))))

 (:action program_pre_clear_move-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_move-b_var1 ))(not (del_clear_move-b_var1 ))(not (add_clear_move-b_var1 )))
   :effect (and (pre_clear_move-b_var1 )))

 (:action program_eff_clear_move-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_move-b_var1 ))(not (add_clear_move-b_var1 )))
   :effect (and (when (pre_clear_move-b_var1 )(del_clear_move-b_var1 ))(when (not (pre_clear_move-b_var1 ))(add_clear_move-b_var1 ))))

 (:action program_pre_clear_move-b_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_move-b_var2 ))(not (del_clear_move-b_var2 ))(not (add_clear_move-b_var2 )))
   :effect (and (pre_clear_move-b_var2 )))

 (:action program_eff_clear_move-b_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_move-b_var2 ))(not (add_clear_move-b_var2 )))
   :effect (and (when (pre_clear_move-b_var2 )(del_clear_move-b_var2 ))(when (not (pre_clear_move-b_var2 ))(add_clear_move-b_var2 ))))

 (:action program_pre_cellspace_move-b_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_move-b_var3 ))(not (del_cellspace_move-b_var3 ))(not (add_cellspace_move-b_var3 )))
   :effect (and (pre_cellspace_move-b_var3 )))

 (:action program_eff_cellspace_move-b_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_move-b_var3 ))(not (add_cellspace_move-b_var3 )))
   :effect (and (when (pre_cellspace_move-b_var3 )(del_cellspace_move-b_var3 ))(when (not (pre_cellspace_move-b_var3 ))(add_cellspace_move-b_var3 ))))

 (:action program_pre_cellspace_move-b_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_move-b_var4 ))(not (del_cellspace_move-b_var4 ))(not (add_cellspace_move-b_var4 )))
   :effect (and (pre_cellspace_move-b_var4 )))

 (:action program_eff_cellspace_move-b_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_move-b_var4 ))(not (add_cellspace_move-b_var4 )))
   :effect (and (when (pre_cellspace_move-b_var4 )(del_cellspace_move-b_var4 ))(when (not (pre_cellspace_move-b_var4 ))(add_cellspace_move-b_var4 ))))

 (:action program_pre_colspace_move-b_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_move-b_var3 ))(not (del_colspace_move-b_var3 ))(not (add_colspace_move-b_var3 )))
   :effect (and (pre_colspace_move-b_var3 )))

 (:action program_eff_colspace_move-b_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_move-b_var3 ))(not (add_colspace_move-b_var3 )))
   :effect (and (when (pre_colspace_move-b_var3 )(del_colspace_move-b_var3 ))(when (not (pre_colspace_move-b_var3 ))(add_colspace_move-b_var3 ))))

 (:action program_pre_colspace_move-b_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_move-b_var4 ))(not (del_colspace_move-b_var4 ))(not (add_colspace_move-b_var4 )))
   :effect (and (pre_colspace_move-b_var4 )))

 (:action program_eff_colspace_move-b_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_move-b_var4 ))(not (add_colspace_move-b_var4 )))
   :effect (and (when (pre_colspace_move-b_var4 )(del_colspace_move-b_var4 ))(when (not (pre_colspace_move-b_var4 ))(add_colspace_move-b_var4 ))))

 (:action program_pre_home_move-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_move-b_var1 ))(not (del_home_move-b_var1 ))(not (add_home_move-b_var1 )))
   :effect (and (pre_home_move-b_var1 )))

 (:action program_eff_home_move-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_home_move-b_var1 ))(not (add_home_move-b_var1 )))
   :effect (and (when (pre_home_move-b_var1 )(del_home_move-b_var1 ))(when (not (pre_home_move-b_var1 ))(add_home_move-b_var1 ))))

 (:action program_pre_home_move-b_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_move-b_var2 ))(not (del_home_move-b_var2 ))(not (add_home_move-b_var2 )))
   :effect (and (pre_home_move-b_var2 )))

 (:action program_eff_home_move-b_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_home_move-b_var2 ))(not (add_home_move-b_var2 )))
   :effect (and (when (pre_home_move-b_var2 )(del_home_move-b_var2 ))(when (not (pre_home_move-b_var2 ))(add_home_move-b_var2 ))))

 (:action program_pre_bottomcol_move-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_move-b_var1 ))(not (del_bottomcol_move-b_var1 ))(not (add_bottomcol_move-b_var1 )))
   :effect (and (pre_bottomcol_move-b_var1 )))

 (:action program_eff_bottomcol_move-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_move-b_var1 ))(not (add_bottomcol_move-b_var1 )))
   :effect (and (when (pre_bottomcol_move-b_var1 )(del_bottomcol_move-b_var1 ))(when (not (pre_bottomcol_move-b_var1 ))(add_bottomcol_move-b_var1 ))))

 (:action program_pre_bottomcol_move-b_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_move-b_var2 ))(not (del_bottomcol_move-b_var2 ))(not (add_bottomcol_move-b_var2 )))
   :effect (and (pre_bottomcol_move-b_var2 )))

 (:action program_eff_bottomcol_move-b_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_move-b_var2 ))(not (add_bottomcol_move-b_var2 )))
   :effect (and (when (pre_bottomcol_move-b_var2 )(del_bottomcol_move-b_var2 ))(when (not (pre_bottomcol_move-b_var2 ))(add_bottomcol_move-b_var2 ))))

 (:action program_pre_canstack_move-b_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_move-b_var1_var1 ))(not (del_canstack_move-b_var1_var1 ))(not (add_canstack_move-b_var1_var1 )))
   :effect (and (pre_canstack_move-b_var1_var1 )))

 (:action program_eff_canstack_move-b_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_move-b_var1_var1 ))(not (add_canstack_move-b_var1_var1 )))
   :effect (and (when (pre_canstack_move-b_var1_var1 )(del_canstack_move-b_var1_var1 ))(when (not (pre_canstack_move-b_var1_var1 ))(add_canstack_move-b_var1_var1 ))))

 (:action program_pre_canstack_move-b_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_move-b_var1_var2 ))(not (del_canstack_move-b_var1_var2 ))(not (add_canstack_move-b_var1_var2 )))
   :effect (and (pre_canstack_move-b_var1_var2 )))

 (:action program_eff_canstack_move-b_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_move-b_var1_var2 ))(not (add_canstack_move-b_var1_var2 )))
   :effect (and (when (pre_canstack_move-b_var1_var2 )(del_canstack_move-b_var1_var2 ))(when (not (pre_canstack_move-b_var1_var2 ))(add_canstack_move-b_var1_var2 ))))

 (:action program_pre_canstack_move-b_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_move-b_var2_var1 ))(not (del_canstack_move-b_var2_var1 ))(not (add_canstack_move-b_var2_var1 )))
   :effect (and (pre_canstack_move-b_var2_var1 )))

 (:action program_eff_canstack_move-b_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_move-b_var2_var1 ))(not (add_canstack_move-b_var2_var1 )))
   :effect (and (when (pre_canstack_move-b_var2_var1 )(del_canstack_move-b_var2_var1 ))(when (not (pre_canstack_move-b_var2_var1 ))(add_canstack_move-b_var2_var1 ))))

 (:action program_pre_canstack_move-b_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_move-b_var2_var2 ))(not (del_canstack_move-b_var2_var2 ))(not (add_canstack_move-b_var2_var2 )))
   :effect (and (pre_canstack_move-b_var2_var2 )))

 (:action program_eff_canstack_move-b_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_move-b_var2_var2 ))(not (add_canstack_move-b_var2_var2 )))
   :effect (and (when (pre_canstack_move-b_var2_var2 )(del_canstack_move-b_var2_var2 ))(when (not (pre_canstack_move-b_var2_var2 ))(add_canstack_move-b_var2_var2 ))))

 (:action program_pre_value_move-b_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_move-b_var1_var3 ))(not (del_value_move-b_var1_var3 ))(not (add_value_move-b_var1_var3 )))
   :effect (and (pre_value_move-b_var1_var3 )))

 (:action program_eff_value_move-b_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_value_move-b_var1_var3 ))(not (add_value_move-b_var1_var3 )))
   :effect (and (when (pre_value_move-b_var1_var3 )(del_value_move-b_var1_var3 ))(when (not (pre_value_move-b_var1_var3 ))(add_value_move-b_var1_var3 ))))

 (:action program_pre_value_move-b_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_move-b_var1_var4 ))(not (del_value_move-b_var1_var4 ))(not (add_value_move-b_var1_var4 )))
   :effect (and (pre_value_move-b_var1_var4 )))

 (:action program_eff_value_move-b_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_value_move-b_var1_var4 ))(not (add_value_move-b_var1_var4 )))
   :effect (and (when (pre_value_move-b_var1_var4 )(del_value_move-b_var1_var4 ))(when (not (pre_value_move-b_var1_var4 ))(add_value_move-b_var1_var4 ))))

 (:action program_pre_value_move-b_var2_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_move-b_var2_var3 ))(not (del_value_move-b_var2_var3 ))(not (add_value_move-b_var2_var3 )))
   :effect (and (pre_value_move-b_var2_var3 )))

 (:action program_eff_value_move-b_var2_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_value_move-b_var2_var3 ))(not (add_value_move-b_var2_var3 )))
   :effect (and (when (pre_value_move-b_var2_var3 )(del_value_move-b_var2_var3 ))(when (not (pre_value_move-b_var2_var3 ))(add_value_move-b_var2_var3 ))))

 (:action program_pre_value_move-b_var2_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_move-b_var2_var4 ))(not (del_value_move-b_var2_var4 ))(not (add_value_move-b_var2_var4 )))
   :effect (and (pre_value_move-b_var2_var4 )))

 (:action program_eff_value_move-b_var2_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_value_move-b_var2_var4 ))(not (add_value_move-b_var2_var4 )))
   :effect (and (when (pre_value_move-b_var2_var4 )(del_value_move-b_var2_var4 ))(when (not (pre_value_move-b_var2_var4 ))(add_value_move-b_var2_var4 ))))

 (:action program_pre_successor_move-b_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_move-b_var3_var3 ))(not (del_successor_move-b_var3_var3 ))(not (add_successor_move-b_var3_var3 )))
   :effect (and (pre_successor_move-b_var3_var3 )))

 (:action program_eff_successor_move-b_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_move-b_var3_var3 ))(not (add_successor_move-b_var3_var3 )))
   :effect (and (when (pre_successor_move-b_var3_var3 )(del_successor_move-b_var3_var3 ))(when (not (pre_successor_move-b_var3_var3 ))(add_successor_move-b_var3_var3 ))))

 (:action program_pre_successor_move-b_var3_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_move-b_var3_var4 ))(not (del_successor_move-b_var3_var4 ))(not (add_successor_move-b_var3_var4 )))
   :effect (and (pre_successor_move-b_var3_var4 )))

 (:action program_eff_successor_move-b_var3_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_move-b_var3_var4 ))(not (add_successor_move-b_var3_var4 )))
   :effect (and (when (pre_successor_move-b_var3_var4 )(del_successor_move-b_var3_var4 ))(when (not (pre_successor_move-b_var3_var4 ))(add_successor_move-b_var3_var4 ))))

 (:action program_pre_successor_move-b_var4_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_move-b_var4_var3 ))(not (del_successor_move-b_var4_var3 ))(not (add_successor_move-b_var4_var3 )))
   :effect (and (pre_successor_move-b_var4_var3 )))

 (:action program_eff_successor_move-b_var4_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_move-b_var4_var3 ))(not (add_successor_move-b_var4_var3 )))
   :effect (and (when (pre_successor_move-b_var4_var3 )(del_successor_move-b_var4_var3 ))(when (not (pre_successor_move-b_var4_var3 ))(add_successor_move-b_var4_var3 ))))

 (:action program_pre_successor_move-b_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_move-b_var4_var4 ))(not (del_successor_move-b_var4_var4 ))(not (add_successor_move-b_var4_var4 )))
   :effect (and (pre_successor_move-b_var4_var4 )))

 (:action program_eff_successor_move-b_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_move-b_var4_var4 ))(not (add_successor_move-b_var4_var4 )))
   :effect (and (when (pre_successor_move-b_var4_var4 )(del_successor_move-b_var4_var4 ))(when (not (pre_successor_move-b_var4_var4 ))(add_successor_move-b_var4_var4 ))))

 (:action program_pre_on_sendtofree_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtofree_var1_var1 ))(not (del_on_sendtofree_var1_var1 ))(not (add_on_sendtofree_var1_var1 )))
   :effect (and (pre_on_sendtofree_var1_var1 )))

 (:action program_eff_on_sendtofree_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtofree_var1_var1 ))(not (add_on_sendtofree_var1_var1 )))
   :effect (and (when (pre_on_sendtofree_var1_var1 )(del_on_sendtofree_var1_var1 ))(when (not (pre_on_sendtofree_var1_var1 ))(add_on_sendtofree_var1_var1 ))))

 (:action program_pre_on_sendtofree_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtofree_var1_var2 ))(not (del_on_sendtofree_var1_var2 ))(not (add_on_sendtofree_var1_var2 )))
   :effect (and (pre_on_sendtofree_var1_var2 )))

 (:action program_eff_on_sendtofree_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtofree_var1_var2 ))(not (add_on_sendtofree_var1_var2 )))
   :effect (and (when (pre_on_sendtofree_var1_var2 )(del_on_sendtofree_var1_var2 ))(when (not (pre_on_sendtofree_var1_var2 ))(add_on_sendtofree_var1_var2 ))))

 (:action program_pre_on_sendtofree_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtofree_var2_var1 ))(not (del_on_sendtofree_var2_var1 ))(not (add_on_sendtofree_var2_var1 )))
   :effect (and (pre_on_sendtofree_var2_var1 )))

 (:action program_eff_on_sendtofree_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtofree_var2_var1 ))(not (add_on_sendtofree_var2_var1 )))
   :effect (and (when (pre_on_sendtofree_var2_var1 )(del_on_sendtofree_var2_var1 ))(when (not (pre_on_sendtofree_var2_var1 ))(add_on_sendtofree_var2_var1 ))))

 (:action program_pre_on_sendtofree_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtofree_var2_var2 ))(not (del_on_sendtofree_var2_var2 ))(not (add_on_sendtofree_var2_var2 )))
   :effect (and (pre_on_sendtofree_var2_var2 )))

 (:action program_eff_on_sendtofree_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtofree_var2_var2 ))(not (add_on_sendtofree_var2_var2 )))
   :effect (and (when (pre_on_sendtofree_var2_var2 )(del_on_sendtofree_var2_var2 ))(when (not (pre_on_sendtofree_var2_var2 ))(add_on_sendtofree_var2_var2 ))))

 (:action program_pre_incell_sendtofree_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_sendtofree_var1 ))(not (del_incell_sendtofree_var1 ))(not (add_incell_sendtofree_var1 )))
   :effect (and (pre_incell_sendtofree_var1 )))

 (:action program_eff_incell_sendtofree_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_sendtofree_var1 ))(not (add_incell_sendtofree_var1 )))
   :effect (and (when (pre_incell_sendtofree_var1 )(del_incell_sendtofree_var1 ))(when (not (pre_incell_sendtofree_var1 ))(add_incell_sendtofree_var1 ))))

 (:action program_pre_incell_sendtofree_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_sendtofree_var2 ))(not (del_incell_sendtofree_var2 ))(not (add_incell_sendtofree_var2 )))
   :effect (and (pre_incell_sendtofree_var2 )))

 (:action program_eff_incell_sendtofree_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_sendtofree_var2 ))(not (add_incell_sendtofree_var2 )))
   :effect (and (when (pre_incell_sendtofree_var2 )(del_incell_sendtofree_var2 ))(when (not (pre_incell_sendtofree_var2 ))(add_incell_sendtofree_var2 ))))

 (:action program_pre_clear_sendtofree_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_sendtofree_var1 ))(not (del_clear_sendtofree_var1 ))(not (add_clear_sendtofree_var1 )))
   :effect (and (pre_clear_sendtofree_var1 )))

 (:action program_eff_clear_sendtofree_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_sendtofree_var1 ))(not (add_clear_sendtofree_var1 )))
   :effect (and (when (pre_clear_sendtofree_var1 )(del_clear_sendtofree_var1 ))(when (not (pre_clear_sendtofree_var1 ))(add_clear_sendtofree_var1 ))))

 (:action program_pre_clear_sendtofree_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_sendtofree_var2 ))(not (del_clear_sendtofree_var2 ))(not (add_clear_sendtofree_var2 )))
   :effect (and (pre_clear_sendtofree_var2 )))

 (:action program_eff_clear_sendtofree_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_sendtofree_var2 ))(not (add_clear_sendtofree_var2 )))
   :effect (and (when (pre_clear_sendtofree_var2 )(del_clear_sendtofree_var2 ))(when (not (pre_clear_sendtofree_var2 ))(add_clear_sendtofree_var2 ))))

 (:action program_pre_cellspace_sendtofree_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_sendtofree_var3 ))(not (del_cellspace_sendtofree_var3 ))(not (add_cellspace_sendtofree_var3 )))
   :effect (and (pre_cellspace_sendtofree_var3 )))

 (:action program_eff_cellspace_sendtofree_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_sendtofree_var3 ))(not (add_cellspace_sendtofree_var3 )))
   :effect (and (when (pre_cellspace_sendtofree_var3 )(del_cellspace_sendtofree_var3 ))(when (not (pre_cellspace_sendtofree_var3 ))(add_cellspace_sendtofree_var3 ))))

 (:action program_pre_cellspace_sendtofree_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_sendtofree_var4 ))(not (del_cellspace_sendtofree_var4 ))(not (add_cellspace_sendtofree_var4 )))
   :effect (and (pre_cellspace_sendtofree_var4 )))

 (:action program_eff_cellspace_sendtofree_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_sendtofree_var4 ))(not (add_cellspace_sendtofree_var4 )))
   :effect (and (when (pre_cellspace_sendtofree_var4 )(del_cellspace_sendtofree_var4 ))(when (not (pre_cellspace_sendtofree_var4 ))(add_cellspace_sendtofree_var4 ))))

 (:action program_pre_colspace_sendtofree_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_sendtofree_var3 ))(not (del_colspace_sendtofree_var3 ))(not (add_colspace_sendtofree_var3 )))
   :effect (and (pre_colspace_sendtofree_var3 )))

 (:action program_eff_colspace_sendtofree_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_sendtofree_var3 ))(not (add_colspace_sendtofree_var3 )))
   :effect (and (when (pre_colspace_sendtofree_var3 )(del_colspace_sendtofree_var3 ))(when (not (pre_colspace_sendtofree_var3 ))(add_colspace_sendtofree_var3 ))))

 (:action program_pre_colspace_sendtofree_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_sendtofree_var4 ))(not (del_colspace_sendtofree_var4 ))(not (add_colspace_sendtofree_var4 )))
   :effect (and (pre_colspace_sendtofree_var4 )))

 (:action program_eff_colspace_sendtofree_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_sendtofree_var4 ))(not (add_colspace_sendtofree_var4 )))
   :effect (and (when (pre_colspace_sendtofree_var4 )(del_colspace_sendtofree_var4 ))(when (not (pre_colspace_sendtofree_var4 ))(add_colspace_sendtofree_var4 ))))

 (:action program_pre_home_sendtofree_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_sendtofree_var1 ))(not (del_home_sendtofree_var1 ))(not (add_home_sendtofree_var1 )))
   :effect (and (pre_home_sendtofree_var1 )))

 (:action program_eff_home_sendtofree_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_home_sendtofree_var1 ))(not (add_home_sendtofree_var1 )))
   :effect (and (when (pre_home_sendtofree_var1 )(del_home_sendtofree_var1 ))(when (not (pre_home_sendtofree_var1 ))(add_home_sendtofree_var1 ))))

 (:action program_pre_home_sendtofree_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_sendtofree_var2 ))(not (del_home_sendtofree_var2 ))(not (add_home_sendtofree_var2 )))
   :effect (and (pre_home_sendtofree_var2 )))

 (:action program_eff_home_sendtofree_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_home_sendtofree_var2 ))(not (add_home_sendtofree_var2 )))
   :effect (and (when (pre_home_sendtofree_var2 )(del_home_sendtofree_var2 ))(when (not (pre_home_sendtofree_var2 ))(add_home_sendtofree_var2 ))))

 (:action program_pre_bottomcol_sendtofree_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_sendtofree_var1 ))(not (del_bottomcol_sendtofree_var1 ))(not (add_bottomcol_sendtofree_var1 )))
   :effect (and (pre_bottomcol_sendtofree_var1 )))

 (:action program_eff_bottomcol_sendtofree_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_sendtofree_var1 ))(not (add_bottomcol_sendtofree_var1 )))
   :effect (and (when (pre_bottomcol_sendtofree_var1 )(del_bottomcol_sendtofree_var1 ))(when (not (pre_bottomcol_sendtofree_var1 ))(add_bottomcol_sendtofree_var1 ))))

 (:action program_pre_bottomcol_sendtofree_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_sendtofree_var2 ))(not (del_bottomcol_sendtofree_var2 ))(not (add_bottomcol_sendtofree_var2 )))
   :effect (and (pre_bottomcol_sendtofree_var2 )))

 (:action program_eff_bottomcol_sendtofree_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_sendtofree_var2 ))(not (add_bottomcol_sendtofree_var2 )))
   :effect (and (when (pre_bottomcol_sendtofree_var2 )(del_bottomcol_sendtofree_var2 ))(when (not (pre_bottomcol_sendtofree_var2 ))(add_bottomcol_sendtofree_var2 ))))

 (:action program_pre_canstack_sendtofree_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtofree_var1_var1 ))(not (del_canstack_sendtofree_var1_var1 ))(not (add_canstack_sendtofree_var1_var1 )))
   :effect (and (pre_canstack_sendtofree_var1_var1 )))

 (:action program_eff_canstack_sendtofree_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtofree_var1_var1 ))(not (add_canstack_sendtofree_var1_var1 )))
   :effect (and (when (pre_canstack_sendtofree_var1_var1 )(del_canstack_sendtofree_var1_var1 ))(when (not (pre_canstack_sendtofree_var1_var1 ))(add_canstack_sendtofree_var1_var1 ))))

 (:action program_pre_canstack_sendtofree_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtofree_var1_var2 ))(not (del_canstack_sendtofree_var1_var2 ))(not (add_canstack_sendtofree_var1_var2 )))
   :effect (and (pre_canstack_sendtofree_var1_var2 )))

 (:action program_eff_canstack_sendtofree_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtofree_var1_var2 ))(not (add_canstack_sendtofree_var1_var2 )))
   :effect (and (when (pre_canstack_sendtofree_var1_var2 )(del_canstack_sendtofree_var1_var2 ))(when (not (pre_canstack_sendtofree_var1_var2 ))(add_canstack_sendtofree_var1_var2 ))))

 (:action program_pre_canstack_sendtofree_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtofree_var2_var1 ))(not (del_canstack_sendtofree_var2_var1 ))(not (add_canstack_sendtofree_var2_var1 )))
   :effect (and (pre_canstack_sendtofree_var2_var1 )))

 (:action program_eff_canstack_sendtofree_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtofree_var2_var1 ))(not (add_canstack_sendtofree_var2_var1 )))
   :effect (and (when (pre_canstack_sendtofree_var2_var1 )(del_canstack_sendtofree_var2_var1 ))(when (not (pre_canstack_sendtofree_var2_var1 ))(add_canstack_sendtofree_var2_var1 ))))

 (:action program_pre_canstack_sendtofree_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtofree_var2_var2 ))(not (del_canstack_sendtofree_var2_var2 ))(not (add_canstack_sendtofree_var2_var2 )))
   :effect (and (pre_canstack_sendtofree_var2_var2 )))

 (:action program_eff_canstack_sendtofree_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtofree_var2_var2 ))(not (add_canstack_sendtofree_var2_var2 )))
   :effect (and (when (pre_canstack_sendtofree_var2_var2 )(del_canstack_sendtofree_var2_var2 ))(when (not (pre_canstack_sendtofree_var2_var2 ))(add_canstack_sendtofree_var2_var2 ))))

 (:action program_pre_value_sendtofree_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtofree_var1_var3 ))(not (del_value_sendtofree_var1_var3 ))(not (add_value_sendtofree_var1_var3 )))
   :effect (and (pre_value_sendtofree_var1_var3 )))

 (:action program_eff_value_sendtofree_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtofree_var1_var3 ))(not (add_value_sendtofree_var1_var3 )))
   :effect (and (when (pre_value_sendtofree_var1_var3 )(del_value_sendtofree_var1_var3 ))(when (not (pre_value_sendtofree_var1_var3 ))(add_value_sendtofree_var1_var3 ))))

 (:action program_pre_value_sendtofree_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtofree_var1_var4 ))(not (del_value_sendtofree_var1_var4 ))(not (add_value_sendtofree_var1_var4 )))
   :effect (and (pre_value_sendtofree_var1_var4 )))

 (:action program_eff_value_sendtofree_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtofree_var1_var4 ))(not (add_value_sendtofree_var1_var4 )))
   :effect (and (when (pre_value_sendtofree_var1_var4 )(del_value_sendtofree_var1_var4 ))(when (not (pre_value_sendtofree_var1_var4 ))(add_value_sendtofree_var1_var4 ))))

 (:action program_pre_value_sendtofree_var2_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtofree_var2_var3 ))(not (del_value_sendtofree_var2_var3 ))(not (add_value_sendtofree_var2_var3 )))
   :effect (and (pre_value_sendtofree_var2_var3 )))

 (:action program_eff_value_sendtofree_var2_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtofree_var2_var3 ))(not (add_value_sendtofree_var2_var3 )))
   :effect (and (when (pre_value_sendtofree_var2_var3 )(del_value_sendtofree_var2_var3 ))(when (not (pre_value_sendtofree_var2_var3 ))(add_value_sendtofree_var2_var3 ))))

 (:action program_pre_value_sendtofree_var2_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtofree_var2_var4 ))(not (del_value_sendtofree_var2_var4 ))(not (add_value_sendtofree_var2_var4 )))
   :effect (and (pre_value_sendtofree_var2_var4 )))

 (:action program_eff_value_sendtofree_var2_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtofree_var2_var4 ))(not (add_value_sendtofree_var2_var4 )))
   :effect (and (when (pre_value_sendtofree_var2_var4 )(del_value_sendtofree_var2_var4 ))(when (not (pre_value_sendtofree_var2_var4 ))(add_value_sendtofree_var2_var4 ))))

 (:action program_pre_successor_sendtofree_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree_var3_var3 ))(not (del_successor_sendtofree_var3_var3 ))(not (add_successor_sendtofree_var3_var3 )))
   :effect (and (pre_successor_sendtofree_var3_var3 )))

 (:action program_eff_successor_sendtofree_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree_var3_var3 ))(not (add_successor_sendtofree_var3_var3 )))
   :effect (and (when (pre_successor_sendtofree_var3_var3 )(del_successor_sendtofree_var3_var3 ))(when (not (pre_successor_sendtofree_var3_var3 ))(add_successor_sendtofree_var3_var3 ))))

 (:action program_pre_successor_sendtofree_var3_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree_var3_var4 ))(not (del_successor_sendtofree_var3_var4 ))(not (add_successor_sendtofree_var3_var4 )))
   :effect (and (pre_successor_sendtofree_var3_var4 )))

 (:action program_eff_successor_sendtofree_var3_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree_var3_var4 ))(not (add_successor_sendtofree_var3_var4 )))
   :effect (and (when (pre_successor_sendtofree_var3_var4 )(del_successor_sendtofree_var3_var4 ))(when (not (pre_successor_sendtofree_var3_var4 ))(add_successor_sendtofree_var3_var4 ))))

 (:action program_pre_successor_sendtofree_var4_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree_var4_var3 ))(not (del_successor_sendtofree_var4_var3 ))(not (add_successor_sendtofree_var4_var3 )))
   :effect (and (pre_successor_sendtofree_var4_var3 )))

 (:action program_eff_successor_sendtofree_var4_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree_var4_var3 ))(not (add_successor_sendtofree_var4_var3 )))
   :effect (and (when (pre_successor_sendtofree_var4_var3 )(del_successor_sendtofree_var4_var3 ))(when (not (pre_successor_sendtofree_var4_var3 ))(add_successor_sendtofree_var4_var3 ))))

 (:action program_pre_successor_sendtofree_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree_var4_var4 ))(not (del_successor_sendtofree_var4_var4 ))(not (add_successor_sendtofree_var4_var4 )))
   :effect (and (pre_successor_sendtofree_var4_var4 )))

 (:action program_eff_successor_sendtofree_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree_var4_var4 ))(not (add_successor_sendtofree_var4_var4 )))
   :effect (and (when (pre_successor_sendtofree_var4_var4 )(del_successor_sendtofree_var4_var4 ))(when (not (pre_successor_sendtofree_var4_var4 ))(add_successor_sendtofree_var4_var4 ))))

 (:action program_pre_on_sendtofree-b_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtofree-b_var1_var1 ))(not (del_on_sendtofree-b_var1_var1 ))(not (add_on_sendtofree-b_var1_var1 )))
   :effect (and (pre_on_sendtofree-b_var1_var1 )))

 (:action program_eff_on_sendtofree-b_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtofree-b_var1_var1 ))(not (add_on_sendtofree-b_var1_var1 )))
   :effect (and (when (pre_on_sendtofree-b_var1_var1 )(del_on_sendtofree-b_var1_var1 ))(when (not (pre_on_sendtofree-b_var1_var1 ))(add_on_sendtofree-b_var1_var1 ))))

 (:action program_pre_incell_sendtofree-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_sendtofree-b_var1 ))(not (del_incell_sendtofree-b_var1 ))(not (add_incell_sendtofree-b_var1 )))
   :effect (and (pre_incell_sendtofree-b_var1 )))

 (:action program_eff_incell_sendtofree-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_sendtofree-b_var1 ))(not (add_incell_sendtofree-b_var1 )))
   :effect (and (when (pre_incell_sendtofree-b_var1 )(del_incell_sendtofree-b_var1 ))(when (not (pre_incell_sendtofree-b_var1 ))(add_incell_sendtofree-b_var1 ))))

 (:action program_pre_clear_sendtofree-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_sendtofree-b_var1 ))(not (del_clear_sendtofree-b_var1 ))(not (add_clear_sendtofree-b_var1 )))
   :effect (and (pre_clear_sendtofree-b_var1 )))

 (:action program_eff_clear_sendtofree-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_sendtofree-b_var1 ))(not (add_clear_sendtofree-b_var1 )))
   :effect (and (when (pre_clear_sendtofree-b_var1 )(del_clear_sendtofree-b_var1 ))(when (not (pre_clear_sendtofree-b_var1 ))(add_clear_sendtofree-b_var1 ))))

 (:action program_pre_cellspace_sendtofree-b_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_sendtofree-b_var2 ))(not (del_cellspace_sendtofree-b_var2 ))(not (add_cellspace_sendtofree-b_var2 )))
   :effect (and (pre_cellspace_sendtofree-b_var2 )))

 (:action program_eff_cellspace_sendtofree-b_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_sendtofree-b_var2 ))(not (add_cellspace_sendtofree-b_var2 )))
   :effect (and (when (pre_cellspace_sendtofree-b_var2 )(del_cellspace_sendtofree-b_var2 ))(when (not (pre_cellspace_sendtofree-b_var2 ))(add_cellspace_sendtofree-b_var2 ))))

 (:action program_pre_cellspace_sendtofree-b_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_sendtofree-b_var3 ))(not (del_cellspace_sendtofree-b_var3 ))(not (add_cellspace_sendtofree-b_var3 )))
   :effect (and (pre_cellspace_sendtofree-b_var3 )))

 (:action program_eff_cellspace_sendtofree-b_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_sendtofree-b_var3 ))(not (add_cellspace_sendtofree-b_var3 )))
   :effect (and (when (pre_cellspace_sendtofree-b_var3 )(del_cellspace_sendtofree-b_var3 ))(when (not (pre_cellspace_sendtofree-b_var3 ))(add_cellspace_sendtofree-b_var3 ))))

 (:action program_pre_cellspace_sendtofree-b_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_sendtofree-b_var4 ))(not (del_cellspace_sendtofree-b_var4 ))(not (add_cellspace_sendtofree-b_var4 )))
   :effect (and (pre_cellspace_sendtofree-b_var4 )))

 (:action program_eff_cellspace_sendtofree-b_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_sendtofree-b_var4 ))(not (add_cellspace_sendtofree-b_var4 )))
   :effect (and (when (pre_cellspace_sendtofree-b_var4 )(del_cellspace_sendtofree-b_var4 ))(when (not (pre_cellspace_sendtofree-b_var4 ))(add_cellspace_sendtofree-b_var4 ))))

 (:action program_pre_cellspace_sendtofree-b_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_sendtofree-b_var5 ))(not (del_cellspace_sendtofree-b_var5 ))(not (add_cellspace_sendtofree-b_var5 )))
   :effect (and (pre_cellspace_sendtofree-b_var5 )))

 (:action program_eff_cellspace_sendtofree-b_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_sendtofree-b_var5 ))(not (add_cellspace_sendtofree-b_var5 )))
   :effect (and (when (pre_cellspace_sendtofree-b_var5 )(del_cellspace_sendtofree-b_var5 ))(when (not (pre_cellspace_sendtofree-b_var5 ))(add_cellspace_sendtofree-b_var5 ))))

 (:action program_pre_colspace_sendtofree-b_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_sendtofree-b_var2 ))(not (del_colspace_sendtofree-b_var2 ))(not (add_colspace_sendtofree-b_var2 )))
   :effect (and (pre_colspace_sendtofree-b_var2 )))

 (:action program_eff_colspace_sendtofree-b_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_sendtofree-b_var2 ))(not (add_colspace_sendtofree-b_var2 )))
   :effect (and (when (pre_colspace_sendtofree-b_var2 )(del_colspace_sendtofree-b_var2 ))(when (not (pre_colspace_sendtofree-b_var2 ))(add_colspace_sendtofree-b_var2 ))))

 (:action program_pre_colspace_sendtofree-b_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_sendtofree-b_var3 ))(not (del_colspace_sendtofree-b_var3 ))(not (add_colspace_sendtofree-b_var3 )))
   :effect (and (pre_colspace_sendtofree-b_var3 )))

 (:action program_eff_colspace_sendtofree-b_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_sendtofree-b_var3 ))(not (add_colspace_sendtofree-b_var3 )))
   :effect (and (when (pre_colspace_sendtofree-b_var3 )(del_colspace_sendtofree-b_var3 ))(when (not (pre_colspace_sendtofree-b_var3 ))(add_colspace_sendtofree-b_var3 ))))

 (:action program_pre_colspace_sendtofree-b_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_sendtofree-b_var4 ))(not (del_colspace_sendtofree-b_var4 ))(not (add_colspace_sendtofree-b_var4 )))
   :effect (and (pre_colspace_sendtofree-b_var4 )))

 (:action program_eff_colspace_sendtofree-b_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_sendtofree-b_var4 ))(not (add_colspace_sendtofree-b_var4 )))
   :effect (and (when (pre_colspace_sendtofree-b_var4 )(del_colspace_sendtofree-b_var4 ))(when (not (pre_colspace_sendtofree-b_var4 ))(add_colspace_sendtofree-b_var4 ))))

 (:action program_pre_colspace_sendtofree-b_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_sendtofree-b_var5 ))(not (del_colspace_sendtofree-b_var5 ))(not (add_colspace_sendtofree-b_var5 )))
   :effect (and (pre_colspace_sendtofree-b_var5 )))

 (:action program_eff_colspace_sendtofree-b_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_sendtofree-b_var5 ))(not (add_colspace_sendtofree-b_var5 )))
   :effect (and (when (pre_colspace_sendtofree-b_var5 )(del_colspace_sendtofree-b_var5 ))(when (not (pre_colspace_sendtofree-b_var5 ))(add_colspace_sendtofree-b_var5 ))))

 (:action program_pre_home_sendtofree-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_sendtofree-b_var1 ))(not (del_home_sendtofree-b_var1 ))(not (add_home_sendtofree-b_var1 )))
   :effect (and (pre_home_sendtofree-b_var1 )))

 (:action program_eff_home_sendtofree-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_home_sendtofree-b_var1 ))(not (add_home_sendtofree-b_var1 )))
   :effect (and (when (pre_home_sendtofree-b_var1 )(del_home_sendtofree-b_var1 ))(when (not (pre_home_sendtofree-b_var1 ))(add_home_sendtofree-b_var1 ))))

 (:action program_pre_bottomcol_sendtofree-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_sendtofree-b_var1 ))(not (del_bottomcol_sendtofree-b_var1 ))(not (add_bottomcol_sendtofree-b_var1 )))
   :effect (and (pre_bottomcol_sendtofree-b_var1 )))

 (:action program_eff_bottomcol_sendtofree-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_sendtofree-b_var1 ))(not (add_bottomcol_sendtofree-b_var1 )))
   :effect (and (when (pre_bottomcol_sendtofree-b_var1 )(del_bottomcol_sendtofree-b_var1 ))(when (not (pre_bottomcol_sendtofree-b_var1 ))(add_bottomcol_sendtofree-b_var1 ))))

 (:action program_pre_canstack_sendtofree-b_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtofree-b_var1_var1 ))(not (del_canstack_sendtofree-b_var1_var1 ))(not (add_canstack_sendtofree-b_var1_var1 )))
   :effect (and (pre_canstack_sendtofree-b_var1_var1 )))

 (:action program_eff_canstack_sendtofree-b_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtofree-b_var1_var1 ))(not (add_canstack_sendtofree-b_var1_var1 )))
   :effect (and (when (pre_canstack_sendtofree-b_var1_var1 )(del_canstack_sendtofree-b_var1_var1 ))(when (not (pre_canstack_sendtofree-b_var1_var1 ))(add_canstack_sendtofree-b_var1_var1 ))))

 (:action program_pre_value_sendtofree-b_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtofree-b_var1_var2 ))(not (del_value_sendtofree-b_var1_var2 ))(not (add_value_sendtofree-b_var1_var2 )))
   :effect (and (pre_value_sendtofree-b_var1_var2 )))

 (:action program_eff_value_sendtofree-b_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtofree-b_var1_var2 ))(not (add_value_sendtofree-b_var1_var2 )))
   :effect (and (when (pre_value_sendtofree-b_var1_var2 )(del_value_sendtofree-b_var1_var2 ))(when (not (pre_value_sendtofree-b_var1_var2 ))(add_value_sendtofree-b_var1_var2 ))))

 (:action program_pre_value_sendtofree-b_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtofree-b_var1_var3 ))(not (del_value_sendtofree-b_var1_var3 ))(not (add_value_sendtofree-b_var1_var3 )))
   :effect (and (pre_value_sendtofree-b_var1_var3 )))

 (:action program_eff_value_sendtofree-b_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtofree-b_var1_var3 ))(not (add_value_sendtofree-b_var1_var3 )))
   :effect (and (when (pre_value_sendtofree-b_var1_var3 )(del_value_sendtofree-b_var1_var3 ))(when (not (pre_value_sendtofree-b_var1_var3 ))(add_value_sendtofree-b_var1_var3 ))))

 (:action program_pre_value_sendtofree-b_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtofree-b_var1_var4 ))(not (del_value_sendtofree-b_var1_var4 ))(not (add_value_sendtofree-b_var1_var4 )))
   :effect (and (pre_value_sendtofree-b_var1_var4 )))

 (:action program_eff_value_sendtofree-b_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtofree-b_var1_var4 ))(not (add_value_sendtofree-b_var1_var4 )))
   :effect (and (when (pre_value_sendtofree-b_var1_var4 )(del_value_sendtofree-b_var1_var4 ))(when (not (pre_value_sendtofree-b_var1_var4 ))(add_value_sendtofree-b_var1_var4 ))))

 (:action program_pre_value_sendtofree-b_var1_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtofree-b_var1_var5 ))(not (del_value_sendtofree-b_var1_var5 ))(not (add_value_sendtofree-b_var1_var5 )))
   :effect (and (pre_value_sendtofree-b_var1_var5 )))

 (:action program_eff_value_sendtofree-b_var1_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtofree-b_var1_var5 ))(not (add_value_sendtofree-b_var1_var5 )))
   :effect (and (when (pre_value_sendtofree-b_var1_var5 )(del_value_sendtofree-b_var1_var5 ))(when (not (pre_value_sendtofree-b_var1_var5 ))(add_value_sendtofree-b_var1_var5 ))))

 (:action program_pre_successor_sendtofree-b_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree-b_var2_var2 ))(not (del_successor_sendtofree-b_var2_var2 ))(not (add_successor_sendtofree-b_var2_var2 )))
   :effect (and (pre_successor_sendtofree-b_var2_var2 )))

 (:action program_eff_successor_sendtofree-b_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree-b_var2_var2 ))(not (add_successor_sendtofree-b_var2_var2 )))
   :effect (and (when (pre_successor_sendtofree-b_var2_var2 )(del_successor_sendtofree-b_var2_var2 ))(when (not (pre_successor_sendtofree-b_var2_var2 ))(add_successor_sendtofree-b_var2_var2 ))))

 (:action program_pre_successor_sendtofree-b_var2_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree-b_var2_var3 ))(not (del_successor_sendtofree-b_var2_var3 ))(not (add_successor_sendtofree-b_var2_var3 )))
   :effect (and (pre_successor_sendtofree-b_var2_var3 )))

 (:action program_eff_successor_sendtofree-b_var2_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree-b_var2_var3 ))(not (add_successor_sendtofree-b_var2_var3 )))
   :effect (and (when (pre_successor_sendtofree-b_var2_var3 )(del_successor_sendtofree-b_var2_var3 ))(when (not (pre_successor_sendtofree-b_var2_var3 ))(add_successor_sendtofree-b_var2_var3 ))))

 (:action program_pre_successor_sendtofree-b_var2_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree-b_var2_var4 ))(not (del_successor_sendtofree-b_var2_var4 ))(not (add_successor_sendtofree-b_var2_var4 )))
   :effect (and (pre_successor_sendtofree-b_var2_var4 )))

 (:action program_eff_successor_sendtofree-b_var2_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree-b_var2_var4 ))(not (add_successor_sendtofree-b_var2_var4 )))
   :effect (and (when (pre_successor_sendtofree-b_var2_var4 )(del_successor_sendtofree-b_var2_var4 ))(when (not (pre_successor_sendtofree-b_var2_var4 ))(add_successor_sendtofree-b_var2_var4 ))))

 (:action program_pre_successor_sendtofree-b_var2_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree-b_var2_var5 ))(not (del_successor_sendtofree-b_var2_var5 ))(not (add_successor_sendtofree-b_var2_var5 )))
   :effect (and (pre_successor_sendtofree-b_var2_var5 )))

 (:action program_eff_successor_sendtofree-b_var2_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree-b_var2_var5 ))(not (add_successor_sendtofree-b_var2_var5 )))
   :effect (and (when (pre_successor_sendtofree-b_var2_var5 )(del_successor_sendtofree-b_var2_var5 ))(when (not (pre_successor_sendtofree-b_var2_var5 ))(add_successor_sendtofree-b_var2_var5 ))))

 (:action program_pre_successor_sendtofree-b_var3_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree-b_var3_var2 ))(not (del_successor_sendtofree-b_var3_var2 ))(not (add_successor_sendtofree-b_var3_var2 )))
   :effect (and (pre_successor_sendtofree-b_var3_var2 )))

 (:action program_eff_successor_sendtofree-b_var3_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree-b_var3_var2 ))(not (add_successor_sendtofree-b_var3_var2 )))
   :effect (and (when (pre_successor_sendtofree-b_var3_var2 )(del_successor_sendtofree-b_var3_var2 ))(when (not (pre_successor_sendtofree-b_var3_var2 ))(add_successor_sendtofree-b_var3_var2 ))))

 (:action program_pre_successor_sendtofree-b_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree-b_var3_var3 ))(not (del_successor_sendtofree-b_var3_var3 ))(not (add_successor_sendtofree-b_var3_var3 )))
   :effect (and (pre_successor_sendtofree-b_var3_var3 )))

 (:action program_eff_successor_sendtofree-b_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree-b_var3_var3 ))(not (add_successor_sendtofree-b_var3_var3 )))
   :effect (and (when (pre_successor_sendtofree-b_var3_var3 )(del_successor_sendtofree-b_var3_var3 ))(when (not (pre_successor_sendtofree-b_var3_var3 ))(add_successor_sendtofree-b_var3_var3 ))))

 (:action program_pre_successor_sendtofree-b_var3_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree-b_var3_var4 ))(not (del_successor_sendtofree-b_var3_var4 ))(not (add_successor_sendtofree-b_var3_var4 )))
   :effect (and (pre_successor_sendtofree-b_var3_var4 )))

 (:action program_eff_successor_sendtofree-b_var3_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree-b_var3_var4 ))(not (add_successor_sendtofree-b_var3_var4 )))
   :effect (and (when (pre_successor_sendtofree-b_var3_var4 )(del_successor_sendtofree-b_var3_var4 ))(when (not (pre_successor_sendtofree-b_var3_var4 ))(add_successor_sendtofree-b_var3_var4 ))))

 (:action program_pre_successor_sendtofree-b_var3_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree-b_var3_var5 ))(not (del_successor_sendtofree-b_var3_var5 ))(not (add_successor_sendtofree-b_var3_var5 )))
   :effect (and (pre_successor_sendtofree-b_var3_var5 )))

 (:action program_eff_successor_sendtofree-b_var3_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree-b_var3_var5 ))(not (add_successor_sendtofree-b_var3_var5 )))
   :effect (and (when (pre_successor_sendtofree-b_var3_var5 )(del_successor_sendtofree-b_var3_var5 ))(when (not (pre_successor_sendtofree-b_var3_var5 ))(add_successor_sendtofree-b_var3_var5 ))))

 (:action program_pre_successor_sendtofree-b_var4_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree-b_var4_var2 ))(not (del_successor_sendtofree-b_var4_var2 ))(not (add_successor_sendtofree-b_var4_var2 )))
   :effect (and (pre_successor_sendtofree-b_var4_var2 )))

 (:action program_eff_successor_sendtofree-b_var4_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree-b_var4_var2 ))(not (add_successor_sendtofree-b_var4_var2 )))
   :effect (and (when (pre_successor_sendtofree-b_var4_var2 )(del_successor_sendtofree-b_var4_var2 ))(when (not (pre_successor_sendtofree-b_var4_var2 ))(add_successor_sendtofree-b_var4_var2 ))))

 (:action program_pre_successor_sendtofree-b_var4_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree-b_var4_var3 ))(not (del_successor_sendtofree-b_var4_var3 ))(not (add_successor_sendtofree-b_var4_var3 )))
   :effect (and (pre_successor_sendtofree-b_var4_var3 )))

 (:action program_eff_successor_sendtofree-b_var4_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree-b_var4_var3 ))(not (add_successor_sendtofree-b_var4_var3 )))
   :effect (and (when (pre_successor_sendtofree-b_var4_var3 )(del_successor_sendtofree-b_var4_var3 ))(when (not (pre_successor_sendtofree-b_var4_var3 ))(add_successor_sendtofree-b_var4_var3 ))))

 (:action program_pre_successor_sendtofree-b_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree-b_var4_var4 ))(not (del_successor_sendtofree-b_var4_var4 ))(not (add_successor_sendtofree-b_var4_var4 )))
   :effect (and (pre_successor_sendtofree-b_var4_var4 )))

 (:action program_eff_successor_sendtofree-b_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree-b_var4_var4 ))(not (add_successor_sendtofree-b_var4_var4 )))
   :effect (and (when (pre_successor_sendtofree-b_var4_var4 )(del_successor_sendtofree-b_var4_var4 ))(when (not (pre_successor_sendtofree-b_var4_var4 ))(add_successor_sendtofree-b_var4_var4 ))))

 (:action program_pre_successor_sendtofree-b_var4_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree-b_var4_var5 ))(not (del_successor_sendtofree-b_var4_var5 ))(not (add_successor_sendtofree-b_var4_var5 )))
   :effect (and (pre_successor_sendtofree-b_var4_var5 )))

 (:action program_eff_successor_sendtofree-b_var4_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree-b_var4_var5 ))(not (add_successor_sendtofree-b_var4_var5 )))
   :effect (and (when (pre_successor_sendtofree-b_var4_var5 )(del_successor_sendtofree-b_var4_var5 ))(when (not (pre_successor_sendtofree-b_var4_var5 ))(add_successor_sendtofree-b_var4_var5 ))))

 (:action program_pre_successor_sendtofree-b_var5_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree-b_var5_var2 ))(not (del_successor_sendtofree-b_var5_var2 ))(not (add_successor_sendtofree-b_var5_var2 )))
   :effect (and (pre_successor_sendtofree-b_var5_var2 )))

 (:action program_eff_successor_sendtofree-b_var5_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree-b_var5_var2 ))(not (add_successor_sendtofree-b_var5_var2 )))
   :effect (and (when (pre_successor_sendtofree-b_var5_var2 )(del_successor_sendtofree-b_var5_var2 ))(when (not (pre_successor_sendtofree-b_var5_var2 ))(add_successor_sendtofree-b_var5_var2 ))))

 (:action program_pre_successor_sendtofree-b_var5_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree-b_var5_var3 ))(not (del_successor_sendtofree-b_var5_var3 ))(not (add_successor_sendtofree-b_var5_var3 )))
   :effect (and (pre_successor_sendtofree-b_var5_var3 )))

 (:action program_eff_successor_sendtofree-b_var5_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree-b_var5_var3 ))(not (add_successor_sendtofree-b_var5_var3 )))
   :effect (and (when (pre_successor_sendtofree-b_var5_var3 )(del_successor_sendtofree-b_var5_var3 ))(when (not (pre_successor_sendtofree-b_var5_var3 ))(add_successor_sendtofree-b_var5_var3 ))))

 (:action program_pre_successor_sendtofree-b_var5_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree-b_var5_var4 ))(not (del_successor_sendtofree-b_var5_var4 ))(not (add_successor_sendtofree-b_var5_var4 )))
   :effect (and (pre_successor_sendtofree-b_var5_var4 )))

 (:action program_eff_successor_sendtofree-b_var5_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree-b_var5_var4 ))(not (add_successor_sendtofree-b_var5_var4 )))
   :effect (and (when (pre_successor_sendtofree-b_var5_var4 )(del_successor_sendtofree-b_var5_var4 ))(when (not (pre_successor_sendtofree-b_var5_var4 ))(add_successor_sendtofree-b_var5_var4 ))))

 (:action program_pre_successor_sendtofree-b_var5_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtofree-b_var5_var5 ))(not (del_successor_sendtofree-b_var5_var5 ))(not (add_successor_sendtofree-b_var5_var5 )))
   :effect (and (pre_successor_sendtofree-b_var5_var5 )))

 (:action program_eff_successor_sendtofree-b_var5_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtofree-b_var5_var5 ))(not (add_successor_sendtofree-b_var5_var5 )))
   :effect (and (when (pre_successor_sendtofree-b_var5_var5 )(del_successor_sendtofree-b_var5_var5 ))(when (not (pre_successor_sendtofree-b_var5_var5 ))(add_successor_sendtofree-b_var5_var5 ))))

 (:action program_pre_on_sendtonewcol_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtonewcol_var1_var1 ))(not (del_on_sendtonewcol_var1_var1 ))(not (add_on_sendtonewcol_var1_var1 )))
   :effect (and (pre_on_sendtonewcol_var1_var1 )))

 (:action program_eff_on_sendtonewcol_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtonewcol_var1_var1 ))(not (add_on_sendtonewcol_var1_var1 )))
   :effect (and (when (pre_on_sendtonewcol_var1_var1 )(del_on_sendtonewcol_var1_var1 ))(when (not (pre_on_sendtonewcol_var1_var1 ))(add_on_sendtonewcol_var1_var1 ))))

 (:action program_pre_on_sendtonewcol_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtonewcol_var1_var2 ))(not (del_on_sendtonewcol_var1_var2 ))(not (add_on_sendtonewcol_var1_var2 )))
   :effect (and (pre_on_sendtonewcol_var1_var2 )))

 (:action program_eff_on_sendtonewcol_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtonewcol_var1_var2 ))(not (add_on_sendtonewcol_var1_var2 )))
   :effect (and (when (pre_on_sendtonewcol_var1_var2 )(del_on_sendtonewcol_var1_var2 ))(when (not (pre_on_sendtonewcol_var1_var2 ))(add_on_sendtonewcol_var1_var2 ))))

 (:action program_pre_on_sendtonewcol_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtonewcol_var2_var1 ))(not (del_on_sendtonewcol_var2_var1 ))(not (add_on_sendtonewcol_var2_var1 )))
   :effect (and (pre_on_sendtonewcol_var2_var1 )))

 (:action program_eff_on_sendtonewcol_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtonewcol_var2_var1 ))(not (add_on_sendtonewcol_var2_var1 )))
   :effect (and (when (pre_on_sendtonewcol_var2_var1 )(del_on_sendtonewcol_var2_var1 ))(when (not (pre_on_sendtonewcol_var2_var1 ))(add_on_sendtonewcol_var2_var1 ))))

 (:action program_pre_on_sendtonewcol_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtonewcol_var2_var2 ))(not (del_on_sendtonewcol_var2_var2 ))(not (add_on_sendtonewcol_var2_var2 )))
   :effect (and (pre_on_sendtonewcol_var2_var2 )))

 (:action program_eff_on_sendtonewcol_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtonewcol_var2_var2 ))(not (add_on_sendtonewcol_var2_var2 )))
   :effect (and (when (pre_on_sendtonewcol_var2_var2 )(del_on_sendtonewcol_var2_var2 ))(when (not (pre_on_sendtonewcol_var2_var2 ))(add_on_sendtonewcol_var2_var2 ))))

 (:action program_pre_incell_sendtonewcol_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_sendtonewcol_var1 ))(not (del_incell_sendtonewcol_var1 ))(not (add_incell_sendtonewcol_var1 )))
   :effect (and (pre_incell_sendtonewcol_var1 )))

 (:action program_eff_incell_sendtonewcol_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_sendtonewcol_var1 ))(not (add_incell_sendtonewcol_var1 )))
   :effect (and (when (pre_incell_sendtonewcol_var1 )(del_incell_sendtonewcol_var1 ))(when (not (pre_incell_sendtonewcol_var1 ))(add_incell_sendtonewcol_var1 ))))

 (:action program_pre_incell_sendtonewcol_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_sendtonewcol_var2 ))(not (del_incell_sendtonewcol_var2 ))(not (add_incell_sendtonewcol_var2 )))
   :effect (and (pre_incell_sendtonewcol_var2 )))

 (:action program_eff_incell_sendtonewcol_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_sendtonewcol_var2 ))(not (add_incell_sendtonewcol_var2 )))
   :effect (and (when (pre_incell_sendtonewcol_var2 )(del_incell_sendtonewcol_var2 ))(when (not (pre_incell_sendtonewcol_var2 ))(add_incell_sendtonewcol_var2 ))))

 (:action program_pre_clear_sendtonewcol_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_sendtonewcol_var1 ))(not (del_clear_sendtonewcol_var1 ))(not (add_clear_sendtonewcol_var1 )))
   :effect (and (pre_clear_sendtonewcol_var1 )))

 (:action program_eff_clear_sendtonewcol_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_sendtonewcol_var1 ))(not (add_clear_sendtonewcol_var1 )))
   :effect (and (when (pre_clear_sendtonewcol_var1 )(del_clear_sendtonewcol_var1 ))(when (not (pre_clear_sendtonewcol_var1 ))(add_clear_sendtonewcol_var1 ))))

 (:action program_pre_clear_sendtonewcol_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_sendtonewcol_var2 ))(not (del_clear_sendtonewcol_var2 ))(not (add_clear_sendtonewcol_var2 )))
   :effect (and (pre_clear_sendtonewcol_var2 )))

 (:action program_eff_clear_sendtonewcol_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_sendtonewcol_var2 ))(not (add_clear_sendtonewcol_var2 )))
   :effect (and (when (pre_clear_sendtonewcol_var2 )(del_clear_sendtonewcol_var2 ))(when (not (pre_clear_sendtonewcol_var2 ))(add_clear_sendtonewcol_var2 ))))

 (:action program_pre_cellspace_sendtonewcol_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_sendtonewcol_var3 ))(not (del_cellspace_sendtonewcol_var3 ))(not (add_cellspace_sendtonewcol_var3 )))
   :effect (and (pre_cellspace_sendtonewcol_var3 )))

 (:action program_eff_cellspace_sendtonewcol_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_sendtonewcol_var3 ))(not (add_cellspace_sendtonewcol_var3 )))
   :effect (and (when (pre_cellspace_sendtonewcol_var3 )(del_cellspace_sendtonewcol_var3 ))(when (not (pre_cellspace_sendtonewcol_var3 ))(add_cellspace_sendtonewcol_var3 ))))

 (:action program_pre_cellspace_sendtonewcol_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_sendtonewcol_var4 ))(not (del_cellspace_sendtonewcol_var4 ))(not (add_cellspace_sendtonewcol_var4 )))
   :effect (and (pre_cellspace_sendtonewcol_var4 )))

 (:action program_eff_cellspace_sendtonewcol_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_sendtonewcol_var4 ))(not (add_cellspace_sendtonewcol_var4 )))
   :effect (and (when (pre_cellspace_sendtonewcol_var4 )(del_cellspace_sendtonewcol_var4 ))(when (not (pre_cellspace_sendtonewcol_var4 ))(add_cellspace_sendtonewcol_var4 ))))

 (:action program_pre_colspace_sendtonewcol_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_sendtonewcol_var3 ))(not (del_colspace_sendtonewcol_var3 ))(not (add_colspace_sendtonewcol_var3 )))
   :effect (and (pre_colspace_sendtonewcol_var3 )))

 (:action program_eff_colspace_sendtonewcol_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_sendtonewcol_var3 ))(not (add_colspace_sendtonewcol_var3 )))
   :effect (and (when (pre_colspace_sendtonewcol_var3 )(del_colspace_sendtonewcol_var3 ))(when (not (pre_colspace_sendtonewcol_var3 ))(add_colspace_sendtonewcol_var3 ))))

 (:action program_pre_colspace_sendtonewcol_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_sendtonewcol_var4 ))(not (del_colspace_sendtonewcol_var4 ))(not (add_colspace_sendtonewcol_var4 )))
   :effect (and (pre_colspace_sendtonewcol_var4 )))

 (:action program_eff_colspace_sendtonewcol_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_sendtonewcol_var4 ))(not (add_colspace_sendtonewcol_var4 )))
   :effect (and (when (pre_colspace_sendtonewcol_var4 )(del_colspace_sendtonewcol_var4 ))(when (not (pre_colspace_sendtonewcol_var4 ))(add_colspace_sendtonewcol_var4 ))))

 (:action program_pre_home_sendtonewcol_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_sendtonewcol_var1 ))(not (del_home_sendtonewcol_var1 ))(not (add_home_sendtonewcol_var1 )))
   :effect (and (pre_home_sendtonewcol_var1 )))

 (:action program_eff_home_sendtonewcol_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_home_sendtonewcol_var1 ))(not (add_home_sendtonewcol_var1 )))
   :effect (and (when (pre_home_sendtonewcol_var1 )(del_home_sendtonewcol_var1 ))(when (not (pre_home_sendtonewcol_var1 ))(add_home_sendtonewcol_var1 ))))

 (:action program_pre_home_sendtonewcol_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_sendtonewcol_var2 ))(not (del_home_sendtonewcol_var2 ))(not (add_home_sendtonewcol_var2 )))
   :effect (and (pre_home_sendtonewcol_var2 )))

 (:action program_eff_home_sendtonewcol_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_home_sendtonewcol_var2 ))(not (add_home_sendtonewcol_var2 )))
   :effect (and (when (pre_home_sendtonewcol_var2 )(del_home_sendtonewcol_var2 ))(when (not (pre_home_sendtonewcol_var2 ))(add_home_sendtonewcol_var2 ))))

 (:action program_pre_bottomcol_sendtonewcol_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_sendtonewcol_var1 ))(not (del_bottomcol_sendtonewcol_var1 ))(not (add_bottomcol_sendtonewcol_var1 )))
   :effect (and (pre_bottomcol_sendtonewcol_var1 )))

 (:action program_eff_bottomcol_sendtonewcol_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_sendtonewcol_var1 ))(not (add_bottomcol_sendtonewcol_var1 )))
   :effect (and (when (pre_bottomcol_sendtonewcol_var1 )(del_bottomcol_sendtonewcol_var1 ))(when (not (pre_bottomcol_sendtonewcol_var1 ))(add_bottomcol_sendtonewcol_var1 ))))

 (:action program_pre_bottomcol_sendtonewcol_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_sendtonewcol_var2 ))(not (del_bottomcol_sendtonewcol_var2 ))(not (add_bottomcol_sendtonewcol_var2 )))
   :effect (and (pre_bottomcol_sendtonewcol_var2 )))

 (:action program_eff_bottomcol_sendtonewcol_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_sendtonewcol_var2 ))(not (add_bottomcol_sendtonewcol_var2 )))
   :effect (and (when (pre_bottomcol_sendtonewcol_var2 )(del_bottomcol_sendtonewcol_var2 ))(when (not (pre_bottomcol_sendtonewcol_var2 ))(add_bottomcol_sendtonewcol_var2 ))))

 (:action program_pre_canstack_sendtonewcol_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtonewcol_var1_var1 ))(not (del_canstack_sendtonewcol_var1_var1 ))(not (add_canstack_sendtonewcol_var1_var1 )))
   :effect (and (pre_canstack_sendtonewcol_var1_var1 )))

 (:action program_eff_canstack_sendtonewcol_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtonewcol_var1_var1 ))(not (add_canstack_sendtonewcol_var1_var1 )))
   :effect (and (when (pre_canstack_sendtonewcol_var1_var1 )(del_canstack_sendtonewcol_var1_var1 ))(when (not (pre_canstack_sendtonewcol_var1_var1 ))(add_canstack_sendtonewcol_var1_var1 ))))

 (:action program_pre_canstack_sendtonewcol_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtonewcol_var1_var2 ))(not (del_canstack_sendtonewcol_var1_var2 ))(not (add_canstack_sendtonewcol_var1_var2 )))
   :effect (and (pre_canstack_sendtonewcol_var1_var2 )))

 (:action program_eff_canstack_sendtonewcol_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtonewcol_var1_var2 ))(not (add_canstack_sendtonewcol_var1_var2 )))
   :effect (and (when (pre_canstack_sendtonewcol_var1_var2 )(del_canstack_sendtonewcol_var1_var2 ))(when (not (pre_canstack_sendtonewcol_var1_var2 ))(add_canstack_sendtonewcol_var1_var2 ))))

 (:action program_pre_canstack_sendtonewcol_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtonewcol_var2_var1 ))(not (del_canstack_sendtonewcol_var2_var1 ))(not (add_canstack_sendtonewcol_var2_var1 )))
   :effect (and (pre_canstack_sendtonewcol_var2_var1 )))

 (:action program_eff_canstack_sendtonewcol_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtonewcol_var2_var1 ))(not (add_canstack_sendtonewcol_var2_var1 )))
   :effect (and (when (pre_canstack_sendtonewcol_var2_var1 )(del_canstack_sendtonewcol_var2_var1 ))(when (not (pre_canstack_sendtonewcol_var2_var1 ))(add_canstack_sendtonewcol_var2_var1 ))))

 (:action program_pre_canstack_sendtonewcol_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtonewcol_var2_var2 ))(not (del_canstack_sendtonewcol_var2_var2 ))(not (add_canstack_sendtonewcol_var2_var2 )))
   :effect (and (pre_canstack_sendtonewcol_var2_var2 )))

 (:action program_eff_canstack_sendtonewcol_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtonewcol_var2_var2 ))(not (add_canstack_sendtonewcol_var2_var2 )))
   :effect (and (when (pre_canstack_sendtonewcol_var2_var2 )(del_canstack_sendtonewcol_var2_var2 ))(when (not (pre_canstack_sendtonewcol_var2_var2 ))(add_canstack_sendtonewcol_var2_var2 ))))

 (:action program_pre_value_sendtonewcol_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtonewcol_var1_var3 ))(not (del_value_sendtonewcol_var1_var3 ))(not (add_value_sendtonewcol_var1_var3 )))
   :effect (and (pre_value_sendtonewcol_var1_var3 )))

 (:action program_eff_value_sendtonewcol_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtonewcol_var1_var3 ))(not (add_value_sendtonewcol_var1_var3 )))
   :effect (and (when (pre_value_sendtonewcol_var1_var3 )(del_value_sendtonewcol_var1_var3 ))(when (not (pre_value_sendtonewcol_var1_var3 ))(add_value_sendtonewcol_var1_var3 ))))

 (:action program_pre_value_sendtonewcol_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtonewcol_var1_var4 ))(not (del_value_sendtonewcol_var1_var4 ))(not (add_value_sendtonewcol_var1_var4 )))
   :effect (and (pre_value_sendtonewcol_var1_var4 )))

 (:action program_eff_value_sendtonewcol_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtonewcol_var1_var4 ))(not (add_value_sendtonewcol_var1_var4 )))
   :effect (and (when (pre_value_sendtonewcol_var1_var4 )(del_value_sendtonewcol_var1_var4 ))(when (not (pre_value_sendtonewcol_var1_var4 ))(add_value_sendtonewcol_var1_var4 ))))

 (:action program_pre_value_sendtonewcol_var2_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtonewcol_var2_var3 ))(not (del_value_sendtonewcol_var2_var3 ))(not (add_value_sendtonewcol_var2_var3 )))
   :effect (and (pre_value_sendtonewcol_var2_var3 )))

 (:action program_eff_value_sendtonewcol_var2_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtonewcol_var2_var3 ))(not (add_value_sendtonewcol_var2_var3 )))
   :effect (and (when (pre_value_sendtonewcol_var2_var3 )(del_value_sendtonewcol_var2_var3 ))(when (not (pre_value_sendtonewcol_var2_var3 ))(add_value_sendtonewcol_var2_var3 ))))

 (:action program_pre_value_sendtonewcol_var2_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtonewcol_var2_var4 ))(not (del_value_sendtonewcol_var2_var4 ))(not (add_value_sendtonewcol_var2_var4 )))
   :effect (and (pre_value_sendtonewcol_var2_var4 )))

 (:action program_eff_value_sendtonewcol_var2_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtonewcol_var2_var4 ))(not (add_value_sendtonewcol_var2_var4 )))
   :effect (and (when (pre_value_sendtonewcol_var2_var4 )(del_value_sendtonewcol_var2_var4 ))(when (not (pre_value_sendtonewcol_var2_var4 ))(add_value_sendtonewcol_var2_var4 ))))

 (:action program_pre_successor_sendtonewcol_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtonewcol_var3_var3 ))(not (del_successor_sendtonewcol_var3_var3 ))(not (add_successor_sendtonewcol_var3_var3 )))
   :effect (and (pre_successor_sendtonewcol_var3_var3 )))

 (:action program_eff_successor_sendtonewcol_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtonewcol_var3_var3 ))(not (add_successor_sendtonewcol_var3_var3 )))
   :effect (and (when (pre_successor_sendtonewcol_var3_var3 )(del_successor_sendtonewcol_var3_var3 ))(when (not (pre_successor_sendtonewcol_var3_var3 ))(add_successor_sendtonewcol_var3_var3 ))))

 (:action program_pre_successor_sendtonewcol_var3_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtonewcol_var3_var4 ))(not (del_successor_sendtonewcol_var3_var4 ))(not (add_successor_sendtonewcol_var3_var4 )))
   :effect (and (pre_successor_sendtonewcol_var3_var4 )))

 (:action program_eff_successor_sendtonewcol_var3_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtonewcol_var3_var4 ))(not (add_successor_sendtonewcol_var3_var4 )))
   :effect (and (when (pre_successor_sendtonewcol_var3_var4 )(del_successor_sendtonewcol_var3_var4 ))(when (not (pre_successor_sendtonewcol_var3_var4 ))(add_successor_sendtonewcol_var3_var4 ))))

 (:action program_pre_successor_sendtonewcol_var4_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtonewcol_var4_var3 ))(not (del_successor_sendtonewcol_var4_var3 ))(not (add_successor_sendtonewcol_var4_var3 )))
   :effect (and (pre_successor_sendtonewcol_var4_var3 )))

 (:action program_eff_successor_sendtonewcol_var4_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtonewcol_var4_var3 ))(not (add_successor_sendtonewcol_var4_var3 )))
   :effect (and (when (pre_successor_sendtonewcol_var4_var3 )(del_successor_sendtonewcol_var4_var3 ))(when (not (pre_successor_sendtonewcol_var4_var3 ))(add_successor_sendtonewcol_var4_var3 ))))

 (:action program_pre_successor_sendtonewcol_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtonewcol_var4_var4 ))(not (del_successor_sendtonewcol_var4_var4 ))(not (add_successor_sendtonewcol_var4_var4 )))
   :effect (and (pre_successor_sendtonewcol_var4_var4 )))

 (:action program_eff_successor_sendtonewcol_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtonewcol_var4_var4 ))(not (add_successor_sendtonewcol_var4_var4 )))
   :effect (and (when (pre_successor_sendtonewcol_var4_var4 )(del_successor_sendtonewcol_var4_var4 ))(when (not (pre_successor_sendtonewcol_var4_var4 ))(add_successor_sendtonewcol_var4_var4 ))))

 (:action program_pre_on_sendtohome_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtohome_var1_var1 ))(not (del_on_sendtohome_var1_var1 ))(not (add_on_sendtohome_var1_var1 )))
   :effect (and (pre_on_sendtohome_var1_var1 )))

 (:action program_eff_on_sendtohome_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtohome_var1_var1 ))(not (add_on_sendtohome_var1_var1 )))
   :effect (and (when (pre_on_sendtohome_var1_var1 )(del_on_sendtohome_var1_var1 ))(when (not (pre_on_sendtohome_var1_var1 ))(add_on_sendtohome_var1_var1 ))))

 (:action program_pre_on_sendtohome_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtohome_var1_var2 ))(not (del_on_sendtohome_var1_var2 ))(not (add_on_sendtohome_var1_var2 )))
   :effect (and (pre_on_sendtohome_var1_var2 )))

 (:action program_eff_on_sendtohome_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtohome_var1_var2 ))(not (add_on_sendtohome_var1_var2 )))
   :effect (and (when (pre_on_sendtohome_var1_var2 )(del_on_sendtohome_var1_var2 ))(when (not (pre_on_sendtohome_var1_var2 ))(add_on_sendtohome_var1_var2 ))))

 (:action program_pre_on_sendtohome_var1_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtohome_var1_var5 ))(not (del_on_sendtohome_var1_var5 ))(not (add_on_sendtohome_var1_var5 )))
   :effect (and (pre_on_sendtohome_var1_var5 )))

 (:action program_eff_on_sendtohome_var1_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtohome_var1_var5 ))(not (add_on_sendtohome_var1_var5 )))
   :effect (and (when (pre_on_sendtohome_var1_var5 )(del_on_sendtohome_var1_var5 ))(when (not (pre_on_sendtohome_var1_var5 ))(add_on_sendtohome_var1_var5 ))))

 (:action program_pre_on_sendtohome_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtohome_var2_var1 ))(not (del_on_sendtohome_var2_var1 ))(not (add_on_sendtohome_var2_var1 )))
   :effect (and (pre_on_sendtohome_var2_var1 )))

 (:action program_eff_on_sendtohome_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtohome_var2_var1 ))(not (add_on_sendtohome_var2_var1 )))
   :effect (and (when (pre_on_sendtohome_var2_var1 )(del_on_sendtohome_var2_var1 ))(when (not (pre_on_sendtohome_var2_var1 ))(add_on_sendtohome_var2_var1 ))))

 (:action program_pre_on_sendtohome_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtohome_var2_var2 ))(not (del_on_sendtohome_var2_var2 ))(not (add_on_sendtohome_var2_var2 )))
   :effect (and (pre_on_sendtohome_var2_var2 )))

 (:action program_eff_on_sendtohome_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtohome_var2_var2 ))(not (add_on_sendtohome_var2_var2 )))
   :effect (and (when (pre_on_sendtohome_var2_var2 )(del_on_sendtohome_var2_var2 ))(when (not (pre_on_sendtohome_var2_var2 ))(add_on_sendtohome_var2_var2 ))))

 (:action program_pre_on_sendtohome_var2_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtohome_var2_var5 ))(not (del_on_sendtohome_var2_var5 ))(not (add_on_sendtohome_var2_var5 )))
   :effect (and (pre_on_sendtohome_var2_var5 )))

 (:action program_eff_on_sendtohome_var2_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtohome_var2_var5 ))(not (add_on_sendtohome_var2_var5 )))
   :effect (and (when (pre_on_sendtohome_var2_var5 )(del_on_sendtohome_var2_var5 ))(when (not (pre_on_sendtohome_var2_var5 ))(add_on_sendtohome_var2_var5 ))))

 (:action program_pre_on_sendtohome_var5_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtohome_var5_var1 ))(not (del_on_sendtohome_var5_var1 ))(not (add_on_sendtohome_var5_var1 )))
   :effect (and (pre_on_sendtohome_var5_var1 )))

 (:action program_eff_on_sendtohome_var5_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtohome_var5_var1 ))(not (add_on_sendtohome_var5_var1 )))
   :effect (and (when (pre_on_sendtohome_var5_var1 )(del_on_sendtohome_var5_var1 ))(when (not (pre_on_sendtohome_var5_var1 ))(add_on_sendtohome_var5_var1 ))))

 (:action program_pre_on_sendtohome_var5_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtohome_var5_var2 ))(not (del_on_sendtohome_var5_var2 ))(not (add_on_sendtohome_var5_var2 )))
   :effect (and (pre_on_sendtohome_var5_var2 )))

 (:action program_eff_on_sendtohome_var5_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtohome_var5_var2 ))(not (add_on_sendtohome_var5_var2 )))
   :effect (and (when (pre_on_sendtohome_var5_var2 )(del_on_sendtohome_var5_var2 ))(when (not (pre_on_sendtohome_var5_var2 ))(add_on_sendtohome_var5_var2 ))))

 (:action program_pre_on_sendtohome_var5_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtohome_var5_var5 ))(not (del_on_sendtohome_var5_var5 ))(not (add_on_sendtohome_var5_var5 )))
   :effect (and (pre_on_sendtohome_var5_var5 )))

 (:action program_eff_on_sendtohome_var5_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtohome_var5_var5 ))(not (add_on_sendtohome_var5_var5 )))
   :effect (and (when (pre_on_sendtohome_var5_var5 )(del_on_sendtohome_var5_var5 ))(when (not (pre_on_sendtohome_var5_var5 ))(add_on_sendtohome_var5_var5 ))))

 (:action program_pre_incell_sendtohome_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_sendtohome_var1 ))(not (del_incell_sendtohome_var1 ))(not (add_incell_sendtohome_var1 )))
   :effect (and (pre_incell_sendtohome_var1 )))

 (:action program_eff_incell_sendtohome_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_sendtohome_var1 ))(not (add_incell_sendtohome_var1 )))
   :effect (and (when (pre_incell_sendtohome_var1 )(del_incell_sendtohome_var1 ))(when (not (pre_incell_sendtohome_var1 ))(add_incell_sendtohome_var1 ))))

 (:action program_pre_incell_sendtohome_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_sendtohome_var2 ))(not (del_incell_sendtohome_var2 ))(not (add_incell_sendtohome_var2 )))
   :effect (and (pre_incell_sendtohome_var2 )))

 (:action program_eff_incell_sendtohome_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_sendtohome_var2 ))(not (add_incell_sendtohome_var2 )))
   :effect (and (when (pre_incell_sendtohome_var2 )(del_incell_sendtohome_var2 ))(when (not (pre_incell_sendtohome_var2 ))(add_incell_sendtohome_var2 ))))

 (:action program_pre_incell_sendtohome_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_sendtohome_var5 ))(not (del_incell_sendtohome_var5 ))(not (add_incell_sendtohome_var5 )))
   :effect (and (pre_incell_sendtohome_var5 )))

 (:action program_eff_incell_sendtohome_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_sendtohome_var5 ))(not (add_incell_sendtohome_var5 )))
   :effect (and (when (pre_incell_sendtohome_var5 )(del_incell_sendtohome_var5 ))(when (not (pre_incell_sendtohome_var5 ))(add_incell_sendtohome_var5 ))))

 (:action program_pre_clear_sendtohome_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_sendtohome_var1 ))(not (del_clear_sendtohome_var1 ))(not (add_clear_sendtohome_var1 )))
   :effect (and (pre_clear_sendtohome_var1 )))

 (:action program_eff_clear_sendtohome_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_sendtohome_var1 ))(not (add_clear_sendtohome_var1 )))
   :effect (and (when (pre_clear_sendtohome_var1 )(del_clear_sendtohome_var1 ))(when (not (pre_clear_sendtohome_var1 ))(add_clear_sendtohome_var1 ))))

 (:action program_pre_clear_sendtohome_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_sendtohome_var2 ))(not (del_clear_sendtohome_var2 ))(not (add_clear_sendtohome_var2 )))
   :effect (and (pre_clear_sendtohome_var2 )))

 (:action program_eff_clear_sendtohome_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_sendtohome_var2 ))(not (add_clear_sendtohome_var2 )))
   :effect (and (when (pre_clear_sendtohome_var2 )(del_clear_sendtohome_var2 ))(when (not (pre_clear_sendtohome_var2 ))(add_clear_sendtohome_var2 ))))

 (:action program_pre_clear_sendtohome_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_sendtohome_var5 ))(not (del_clear_sendtohome_var5 ))(not (add_clear_sendtohome_var5 )))
   :effect (and (pre_clear_sendtohome_var5 )))

 (:action program_eff_clear_sendtohome_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_sendtohome_var5 ))(not (add_clear_sendtohome_var5 )))
   :effect (and (when (pre_clear_sendtohome_var5 )(del_clear_sendtohome_var5 ))(when (not (pre_clear_sendtohome_var5 ))(add_clear_sendtohome_var5 ))))

 (:action program_pre_cellspace_sendtohome_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_sendtohome_var4 ))(not (del_cellspace_sendtohome_var4 ))(not (add_cellspace_sendtohome_var4 )))
   :effect (and (pre_cellspace_sendtohome_var4 )))

 (:action program_eff_cellspace_sendtohome_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_sendtohome_var4 ))(not (add_cellspace_sendtohome_var4 )))
   :effect (and (when (pre_cellspace_sendtohome_var4 )(del_cellspace_sendtohome_var4 ))(when (not (pre_cellspace_sendtohome_var4 ))(add_cellspace_sendtohome_var4 ))))

 (:action program_pre_cellspace_sendtohome_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_sendtohome_var6 ))(not (del_cellspace_sendtohome_var6 ))(not (add_cellspace_sendtohome_var6 )))
   :effect (and (pre_cellspace_sendtohome_var6 )))

 (:action program_eff_cellspace_sendtohome_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_sendtohome_var6 ))(not (add_cellspace_sendtohome_var6 )))
   :effect (and (when (pre_cellspace_sendtohome_var6 )(del_cellspace_sendtohome_var6 ))(when (not (pre_cellspace_sendtohome_var6 ))(add_cellspace_sendtohome_var6 ))))

 (:action program_pre_colspace_sendtohome_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_sendtohome_var4 ))(not (del_colspace_sendtohome_var4 ))(not (add_colspace_sendtohome_var4 )))
   :effect (and (pre_colspace_sendtohome_var4 )))

 (:action program_eff_colspace_sendtohome_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_sendtohome_var4 ))(not (add_colspace_sendtohome_var4 )))
   :effect (and (when (pre_colspace_sendtohome_var4 )(del_colspace_sendtohome_var4 ))(when (not (pre_colspace_sendtohome_var4 ))(add_colspace_sendtohome_var4 ))))

 (:action program_pre_colspace_sendtohome_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_sendtohome_var6 ))(not (del_colspace_sendtohome_var6 ))(not (add_colspace_sendtohome_var6 )))
   :effect (and (pre_colspace_sendtohome_var6 )))

 (:action program_eff_colspace_sendtohome_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_sendtohome_var6 ))(not (add_colspace_sendtohome_var6 )))
   :effect (and (when (pre_colspace_sendtohome_var6 )(del_colspace_sendtohome_var6 ))(when (not (pre_colspace_sendtohome_var6 ))(add_colspace_sendtohome_var6 ))))

 (:action program_pre_home_sendtohome_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_sendtohome_var1 ))(not (del_home_sendtohome_var1 ))(not (add_home_sendtohome_var1 )))
   :effect (and (pre_home_sendtohome_var1 )))

 (:action program_eff_home_sendtohome_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_home_sendtohome_var1 ))(not (add_home_sendtohome_var1 )))
   :effect (and (when (pre_home_sendtohome_var1 )(del_home_sendtohome_var1 ))(when (not (pre_home_sendtohome_var1 ))(add_home_sendtohome_var1 ))))

 (:action program_pre_home_sendtohome_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_sendtohome_var2 ))(not (del_home_sendtohome_var2 ))(not (add_home_sendtohome_var2 )))
   :effect (and (pre_home_sendtohome_var2 )))

 (:action program_eff_home_sendtohome_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_home_sendtohome_var2 ))(not (add_home_sendtohome_var2 )))
   :effect (and (when (pre_home_sendtohome_var2 )(del_home_sendtohome_var2 ))(when (not (pre_home_sendtohome_var2 ))(add_home_sendtohome_var2 ))))

 (:action program_pre_home_sendtohome_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_sendtohome_var5 ))(not (del_home_sendtohome_var5 ))(not (add_home_sendtohome_var5 )))
   :effect (and (pre_home_sendtohome_var5 )))

 (:action program_eff_home_sendtohome_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_home_sendtohome_var5 ))(not (add_home_sendtohome_var5 )))
   :effect (and (when (pre_home_sendtohome_var5 )(del_home_sendtohome_var5 ))(when (not (pre_home_sendtohome_var5 ))(add_home_sendtohome_var5 ))))

 (:action program_pre_bottomcol_sendtohome_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_sendtohome_var1 ))(not (del_bottomcol_sendtohome_var1 ))(not (add_bottomcol_sendtohome_var1 )))
   :effect (and (pre_bottomcol_sendtohome_var1 )))

 (:action program_eff_bottomcol_sendtohome_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_sendtohome_var1 ))(not (add_bottomcol_sendtohome_var1 )))
   :effect (and (when (pre_bottomcol_sendtohome_var1 )(del_bottomcol_sendtohome_var1 ))(when (not (pre_bottomcol_sendtohome_var1 ))(add_bottomcol_sendtohome_var1 ))))

 (:action program_pre_bottomcol_sendtohome_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_sendtohome_var2 ))(not (del_bottomcol_sendtohome_var2 ))(not (add_bottomcol_sendtohome_var2 )))
   :effect (and (pre_bottomcol_sendtohome_var2 )))

 (:action program_eff_bottomcol_sendtohome_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_sendtohome_var2 ))(not (add_bottomcol_sendtohome_var2 )))
   :effect (and (when (pre_bottomcol_sendtohome_var2 )(del_bottomcol_sendtohome_var2 ))(when (not (pre_bottomcol_sendtohome_var2 ))(add_bottomcol_sendtohome_var2 ))))

 (:action program_pre_bottomcol_sendtohome_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_sendtohome_var5 ))(not (del_bottomcol_sendtohome_var5 ))(not (add_bottomcol_sendtohome_var5 )))
   :effect (and (pre_bottomcol_sendtohome_var5 )))

 (:action program_eff_bottomcol_sendtohome_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_sendtohome_var5 ))(not (add_bottomcol_sendtohome_var5 )))
   :effect (and (when (pre_bottomcol_sendtohome_var5 )(del_bottomcol_sendtohome_var5 ))(when (not (pre_bottomcol_sendtohome_var5 ))(add_bottomcol_sendtohome_var5 ))))

 (:action program_pre_canstack_sendtohome_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtohome_var1_var1 ))(not (del_canstack_sendtohome_var1_var1 ))(not (add_canstack_sendtohome_var1_var1 )))
   :effect (and (pre_canstack_sendtohome_var1_var1 )))

 (:action program_eff_canstack_sendtohome_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtohome_var1_var1 ))(not (add_canstack_sendtohome_var1_var1 )))
   :effect (and (when (pre_canstack_sendtohome_var1_var1 )(del_canstack_sendtohome_var1_var1 ))(when (not (pre_canstack_sendtohome_var1_var1 ))(add_canstack_sendtohome_var1_var1 ))))

 (:action program_pre_canstack_sendtohome_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtohome_var1_var2 ))(not (del_canstack_sendtohome_var1_var2 ))(not (add_canstack_sendtohome_var1_var2 )))
   :effect (and (pre_canstack_sendtohome_var1_var2 )))

 (:action program_eff_canstack_sendtohome_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtohome_var1_var2 ))(not (add_canstack_sendtohome_var1_var2 )))
   :effect (and (when (pre_canstack_sendtohome_var1_var2 )(del_canstack_sendtohome_var1_var2 ))(when (not (pre_canstack_sendtohome_var1_var2 ))(add_canstack_sendtohome_var1_var2 ))))

 (:action program_pre_canstack_sendtohome_var1_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtohome_var1_var5 ))(not (del_canstack_sendtohome_var1_var5 ))(not (add_canstack_sendtohome_var1_var5 )))
   :effect (and (pre_canstack_sendtohome_var1_var5 )))

 (:action program_eff_canstack_sendtohome_var1_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtohome_var1_var5 ))(not (add_canstack_sendtohome_var1_var5 )))
   :effect (and (when (pre_canstack_sendtohome_var1_var5 )(del_canstack_sendtohome_var1_var5 ))(when (not (pre_canstack_sendtohome_var1_var5 ))(add_canstack_sendtohome_var1_var5 ))))

 (:action program_pre_canstack_sendtohome_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtohome_var2_var1 ))(not (del_canstack_sendtohome_var2_var1 ))(not (add_canstack_sendtohome_var2_var1 )))
   :effect (and (pre_canstack_sendtohome_var2_var1 )))

 (:action program_eff_canstack_sendtohome_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtohome_var2_var1 ))(not (add_canstack_sendtohome_var2_var1 )))
   :effect (and (when (pre_canstack_sendtohome_var2_var1 )(del_canstack_sendtohome_var2_var1 ))(when (not (pre_canstack_sendtohome_var2_var1 ))(add_canstack_sendtohome_var2_var1 ))))

 (:action program_pre_canstack_sendtohome_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtohome_var2_var2 ))(not (del_canstack_sendtohome_var2_var2 ))(not (add_canstack_sendtohome_var2_var2 )))
   :effect (and (pre_canstack_sendtohome_var2_var2 )))

 (:action program_eff_canstack_sendtohome_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtohome_var2_var2 ))(not (add_canstack_sendtohome_var2_var2 )))
   :effect (and (when (pre_canstack_sendtohome_var2_var2 )(del_canstack_sendtohome_var2_var2 ))(when (not (pre_canstack_sendtohome_var2_var2 ))(add_canstack_sendtohome_var2_var2 ))))

 (:action program_pre_canstack_sendtohome_var2_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtohome_var2_var5 ))(not (del_canstack_sendtohome_var2_var5 ))(not (add_canstack_sendtohome_var2_var5 )))
   :effect (and (pre_canstack_sendtohome_var2_var5 )))

 (:action program_eff_canstack_sendtohome_var2_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtohome_var2_var5 ))(not (add_canstack_sendtohome_var2_var5 )))
   :effect (and (when (pre_canstack_sendtohome_var2_var5 )(del_canstack_sendtohome_var2_var5 ))(when (not (pre_canstack_sendtohome_var2_var5 ))(add_canstack_sendtohome_var2_var5 ))))

 (:action program_pre_canstack_sendtohome_var5_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtohome_var5_var1 ))(not (del_canstack_sendtohome_var5_var1 ))(not (add_canstack_sendtohome_var5_var1 )))
   :effect (and (pre_canstack_sendtohome_var5_var1 )))

 (:action program_eff_canstack_sendtohome_var5_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtohome_var5_var1 ))(not (add_canstack_sendtohome_var5_var1 )))
   :effect (and (when (pre_canstack_sendtohome_var5_var1 )(del_canstack_sendtohome_var5_var1 ))(when (not (pre_canstack_sendtohome_var5_var1 ))(add_canstack_sendtohome_var5_var1 ))))

 (:action program_pre_canstack_sendtohome_var5_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtohome_var5_var2 ))(not (del_canstack_sendtohome_var5_var2 ))(not (add_canstack_sendtohome_var5_var2 )))
   :effect (and (pre_canstack_sendtohome_var5_var2 )))

 (:action program_eff_canstack_sendtohome_var5_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtohome_var5_var2 ))(not (add_canstack_sendtohome_var5_var2 )))
   :effect (and (when (pre_canstack_sendtohome_var5_var2 )(del_canstack_sendtohome_var5_var2 ))(when (not (pre_canstack_sendtohome_var5_var2 ))(add_canstack_sendtohome_var5_var2 ))))

 (:action program_pre_canstack_sendtohome_var5_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtohome_var5_var5 ))(not (del_canstack_sendtohome_var5_var5 ))(not (add_canstack_sendtohome_var5_var5 )))
   :effect (and (pre_canstack_sendtohome_var5_var5 )))

 (:action program_eff_canstack_sendtohome_var5_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtohome_var5_var5 ))(not (add_canstack_sendtohome_var5_var5 )))
   :effect (and (when (pre_canstack_sendtohome_var5_var5 )(del_canstack_sendtohome_var5_var5 ))(when (not (pre_canstack_sendtohome_var5_var5 ))(add_canstack_sendtohome_var5_var5 ))))

 (:action program_pre_suit_sendtohome_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_suit_sendtohome_var1_var3 ))(not (del_suit_sendtohome_var1_var3 ))(not (add_suit_sendtohome_var1_var3 )))
   :effect (and (pre_suit_sendtohome_var1_var3 )))

 (:action program_eff_suit_sendtohome_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_suit_sendtohome_var1_var3 ))(not (add_suit_sendtohome_var1_var3 )))
   :effect (and (when (pre_suit_sendtohome_var1_var3 )(del_suit_sendtohome_var1_var3 ))(when (not (pre_suit_sendtohome_var1_var3 ))(add_suit_sendtohome_var1_var3 ))))

 (:action program_pre_suit_sendtohome_var2_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_suit_sendtohome_var2_var3 ))(not (del_suit_sendtohome_var2_var3 ))(not (add_suit_sendtohome_var2_var3 )))
   :effect (and (pre_suit_sendtohome_var2_var3 )))

 (:action program_eff_suit_sendtohome_var2_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_suit_sendtohome_var2_var3 ))(not (add_suit_sendtohome_var2_var3 )))
   :effect (and (when (pre_suit_sendtohome_var2_var3 )(del_suit_sendtohome_var2_var3 ))(when (not (pre_suit_sendtohome_var2_var3 ))(add_suit_sendtohome_var2_var3 ))))

 (:action program_pre_suit_sendtohome_var5_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_suit_sendtohome_var5_var3 ))(not (del_suit_sendtohome_var5_var3 ))(not (add_suit_sendtohome_var5_var3 )))
   :effect (and (pre_suit_sendtohome_var5_var3 )))

 (:action program_eff_suit_sendtohome_var5_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_suit_sendtohome_var5_var3 ))(not (add_suit_sendtohome_var5_var3 )))
   :effect (and (when (pre_suit_sendtohome_var5_var3 )(del_suit_sendtohome_var5_var3 ))(when (not (pre_suit_sendtohome_var5_var3 ))(add_suit_sendtohome_var5_var3 ))))

 (:action program_pre_value_sendtohome_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtohome_var1_var4 ))(not (del_value_sendtohome_var1_var4 ))(not (add_value_sendtohome_var1_var4 )))
   :effect (and (pre_value_sendtohome_var1_var4 )))

 (:action program_eff_value_sendtohome_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtohome_var1_var4 ))(not (add_value_sendtohome_var1_var4 )))
   :effect (and (when (pre_value_sendtohome_var1_var4 )(del_value_sendtohome_var1_var4 ))(when (not (pre_value_sendtohome_var1_var4 ))(add_value_sendtohome_var1_var4 ))))

 (:action program_pre_value_sendtohome_var1_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtohome_var1_var6 ))(not (del_value_sendtohome_var1_var6 ))(not (add_value_sendtohome_var1_var6 )))
   :effect (and (pre_value_sendtohome_var1_var6 )))

 (:action program_eff_value_sendtohome_var1_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtohome_var1_var6 ))(not (add_value_sendtohome_var1_var6 )))
   :effect (and (when (pre_value_sendtohome_var1_var6 )(del_value_sendtohome_var1_var6 ))(when (not (pre_value_sendtohome_var1_var6 ))(add_value_sendtohome_var1_var6 ))))

 (:action program_pre_value_sendtohome_var2_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtohome_var2_var4 ))(not (del_value_sendtohome_var2_var4 ))(not (add_value_sendtohome_var2_var4 )))
   :effect (and (pre_value_sendtohome_var2_var4 )))

 (:action program_eff_value_sendtohome_var2_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtohome_var2_var4 ))(not (add_value_sendtohome_var2_var4 )))
   :effect (and (when (pre_value_sendtohome_var2_var4 )(del_value_sendtohome_var2_var4 ))(when (not (pre_value_sendtohome_var2_var4 ))(add_value_sendtohome_var2_var4 ))))

 (:action program_pre_value_sendtohome_var2_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtohome_var2_var6 ))(not (del_value_sendtohome_var2_var6 ))(not (add_value_sendtohome_var2_var6 )))
   :effect (and (pre_value_sendtohome_var2_var6 )))

 (:action program_eff_value_sendtohome_var2_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtohome_var2_var6 ))(not (add_value_sendtohome_var2_var6 )))
   :effect (and (when (pre_value_sendtohome_var2_var6 )(del_value_sendtohome_var2_var6 ))(when (not (pre_value_sendtohome_var2_var6 ))(add_value_sendtohome_var2_var6 ))))

 (:action program_pre_value_sendtohome_var5_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtohome_var5_var4 ))(not (del_value_sendtohome_var5_var4 ))(not (add_value_sendtohome_var5_var4 )))
   :effect (and (pre_value_sendtohome_var5_var4 )))

 (:action program_eff_value_sendtohome_var5_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtohome_var5_var4 ))(not (add_value_sendtohome_var5_var4 )))
   :effect (and (when (pre_value_sendtohome_var5_var4 )(del_value_sendtohome_var5_var4 ))(when (not (pre_value_sendtohome_var5_var4 ))(add_value_sendtohome_var5_var4 ))))

 (:action program_pre_value_sendtohome_var5_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtohome_var5_var6 ))(not (del_value_sendtohome_var5_var6 ))(not (add_value_sendtohome_var5_var6 )))
   :effect (and (pre_value_sendtohome_var5_var6 )))

 (:action program_eff_value_sendtohome_var5_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtohome_var5_var6 ))(not (add_value_sendtohome_var5_var6 )))
   :effect (and (when (pre_value_sendtohome_var5_var6 )(del_value_sendtohome_var5_var6 ))(when (not (pre_value_sendtohome_var5_var6 ))(add_value_sendtohome_var5_var6 ))))

 (:action program_pre_successor_sendtohome_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome_var4_var4 ))(not (del_successor_sendtohome_var4_var4 ))(not (add_successor_sendtohome_var4_var4 )))
   :effect (and (pre_successor_sendtohome_var4_var4 )))

 (:action program_eff_successor_sendtohome_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome_var4_var4 ))(not (add_successor_sendtohome_var4_var4 )))
   :effect (and (when (pre_successor_sendtohome_var4_var4 )(del_successor_sendtohome_var4_var4 ))(when (not (pre_successor_sendtohome_var4_var4 ))(add_successor_sendtohome_var4_var4 ))))

 (:action program_pre_successor_sendtohome_var4_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome_var4_var6 ))(not (del_successor_sendtohome_var4_var6 ))(not (add_successor_sendtohome_var4_var6 )))
   :effect (and (pre_successor_sendtohome_var4_var6 )))

 (:action program_eff_successor_sendtohome_var4_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome_var4_var6 ))(not (add_successor_sendtohome_var4_var6 )))
   :effect (and (when (pre_successor_sendtohome_var4_var6 )(del_successor_sendtohome_var4_var6 ))(when (not (pre_successor_sendtohome_var4_var6 ))(add_successor_sendtohome_var4_var6 ))))

 (:action program_pre_successor_sendtohome_var6_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome_var6_var4 ))(not (del_successor_sendtohome_var6_var4 ))(not (add_successor_sendtohome_var6_var4 )))
   :effect (and (pre_successor_sendtohome_var6_var4 )))

 (:action program_eff_successor_sendtohome_var6_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome_var6_var4 ))(not (add_successor_sendtohome_var6_var4 )))
   :effect (and (when (pre_successor_sendtohome_var6_var4 )(del_successor_sendtohome_var6_var4 ))(when (not (pre_successor_sendtohome_var6_var4 ))(add_successor_sendtohome_var6_var4 ))))

 (:action program_pre_successor_sendtohome_var6_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome_var6_var6 ))(not (del_successor_sendtohome_var6_var6 ))(not (add_successor_sendtohome_var6_var6 )))
   :effect (and (pre_successor_sendtohome_var6_var6 )))

 (:action program_eff_successor_sendtohome_var6_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome_var6_var6 ))(not (add_successor_sendtohome_var6_var6 )))
   :effect (and (when (pre_successor_sendtohome_var6_var6 )(del_successor_sendtohome_var6_var6 ))(when (not (pre_successor_sendtohome_var6_var6 ))(add_successor_sendtohome_var6_var6 ))))

 (:action program_pre_on_sendtohome-b_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtohome-b_var1_var1 ))(not (del_on_sendtohome-b_var1_var1 ))(not (add_on_sendtohome-b_var1_var1 )))
   :effect (and (pre_on_sendtohome-b_var1_var1 )))

 (:action program_eff_on_sendtohome-b_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtohome-b_var1_var1 ))(not (add_on_sendtohome-b_var1_var1 )))
   :effect (and (when (pre_on_sendtohome-b_var1_var1 )(del_on_sendtohome-b_var1_var1 ))(when (not (pre_on_sendtohome-b_var1_var1 ))(add_on_sendtohome-b_var1_var1 ))))

 (:action program_pre_on_sendtohome-b_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtohome-b_var1_var4 ))(not (del_on_sendtohome-b_var1_var4 ))(not (add_on_sendtohome-b_var1_var4 )))
   :effect (and (pre_on_sendtohome-b_var1_var4 )))

 (:action program_eff_on_sendtohome-b_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtohome-b_var1_var4 ))(not (add_on_sendtohome-b_var1_var4 )))
   :effect (and (when (pre_on_sendtohome-b_var1_var4 )(del_on_sendtohome-b_var1_var4 ))(when (not (pre_on_sendtohome-b_var1_var4 ))(add_on_sendtohome-b_var1_var4 ))))

 (:action program_pre_on_sendtohome-b_var4_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtohome-b_var4_var1 ))(not (del_on_sendtohome-b_var4_var1 ))(not (add_on_sendtohome-b_var4_var1 )))
   :effect (and (pre_on_sendtohome-b_var4_var1 )))

 (:action program_eff_on_sendtohome-b_var4_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtohome-b_var4_var1 ))(not (add_on_sendtohome-b_var4_var1 )))
   :effect (and (when (pre_on_sendtohome-b_var4_var1 )(del_on_sendtohome-b_var4_var1 ))(when (not (pre_on_sendtohome-b_var4_var1 ))(add_on_sendtohome-b_var4_var1 ))))

 (:action program_pre_on_sendtohome-b_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_sendtohome-b_var4_var4 ))(not (del_on_sendtohome-b_var4_var4 ))(not (add_on_sendtohome-b_var4_var4 )))
   :effect (and (pre_on_sendtohome-b_var4_var4 )))

 (:action program_eff_on_sendtohome-b_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_on_sendtohome-b_var4_var4 ))(not (add_on_sendtohome-b_var4_var4 )))
   :effect (and (when (pre_on_sendtohome-b_var4_var4 )(del_on_sendtohome-b_var4_var4 ))(when (not (pre_on_sendtohome-b_var4_var4 ))(add_on_sendtohome-b_var4_var4 ))))

 (:action program_pre_incell_sendtohome-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_sendtohome-b_var1 ))(not (del_incell_sendtohome-b_var1 ))(not (add_incell_sendtohome-b_var1 )))
   :effect (and (pre_incell_sendtohome-b_var1 )))

 (:action program_eff_incell_sendtohome-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_sendtohome-b_var1 ))(not (add_incell_sendtohome-b_var1 )))
   :effect (and (when (pre_incell_sendtohome-b_var1 )(del_incell_sendtohome-b_var1 ))(when (not (pre_incell_sendtohome-b_var1 ))(add_incell_sendtohome-b_var1 ))))

 (:action program_pre_incell_sendtohome-b_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_sendtohome-b_var4 ))(not (del_incell_sendtohome-b_var4 ))(not (add_incell_sendtohome-b_var4 )))
   :effect (and (pre_incell_sendtohome-b_var4 )))

 (:action program_eff_incell_sendtohome-b_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_sendtohome-b_var4 ))(not (add_incell_sendtohome-b_var4 )))
   :effect (and (when (pre_incell_sendtohome-b_var4 )(del_incell_sendtohome-b_var4 ))(when (not (pre_incell_sendtohome-b_var4 ))(add_incell_sendtohome-b_var4 ))))

 (:action program_pre_clear_sendtohome-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_sendtohome-b_var1 ))(not (del_clear_sendtohome-b_var1 ))(not (add_clear_sendtohome-b_var1 )))
   :effect (and (pre_clear_sendtohome-b_var1 )))

 (:action program_eff_clear_sendtohome-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_sendtohome-b_var1 ))(not (add_clear_sendtohome-b_var1 )))
   :effect (and (when (pre_clear_sendtohome-b_var1 )(del_clear_sendtohome-b_var1 ))(when (not (pre_clear_sendtohome-b_var1 ))(add_clear_sendtohome-b_var1 ))))

 (:action program_pre_clear_sendtohome-b_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_sendtohome-b_var4 ))(not (del_clear_sendtohome-b_var4 ))(not (add_clear_sendtohome-b_var4 )))
   :effect (and (pre_clear_sendtohome-b_var4 )))

 (:action program_eff_clear_sendtohome-b_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_sendtohome-b_var4 ))(not (add_clear_sendtohome-b_var4 )))
   :effect (and (when (pre_clear_sendtohome-b_var4 )(del_clear_sendtohome-b_var4 ))(when (not (pre_clear_sendtohome-b_var4 ))(add_clear_sendtohome-b_var4 ))))

 (:action program_pre_cellspace_sendtohome-b_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_sendtohome-b_var3 ))(not (del_cellspace_sendtohome-b_var3 ))(not (add_cellspace_sendtohome-b_var3 )))
   :effect (and (pre_cellspace_sendtohome-b_var3 )))

 (:action program_eff_cellspace_sendtohome-b_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_sendtohome-b_var3 ))(not (add_cellspace_sendtohome-b_var3 )))
   :effect (and (when (pre_cellspace_sendtohome-b_var3 )(del_cellspace_sendtohome-b_var3 ))(when (not (pre_cellspace_sendtohome-b_var3 ))(add_cellspace_sendtohome-b_var3 ))))

 (:action program_pre_cellspace_sendtohome-b_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_sendtohome-b_var5 ))(not (del_cellspace_sendtohome-b_var5 ))(not (add_cellspace_sendtohome-b_var5 )))
   :effect (and (pre_cellspace_sendtohome-b_var5 )))

 (:action program_eff_cellspace_sendtohome-b_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_sendtohome-b_var5 ))(not (add_cellspace_sendtohome-b_var5 )))
   :effect (and (when (pre_cellspace_sendtohome-b_var5 )(del_cellspace_sendtohome-b_var5 ))(when (not (pre_cellspace_sendtohome-b_var5 ))(add_cellspace_sendtohome-b_var5 ))))

 (:action program_pre_cellspace_sendtohome-b_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_sendtohome-b_var6 ))(not (del_cellspace_sendtohome-b_var6 ))(not (add_cellspace_sendtohome-b_var6 )))
   :effect (and (pre_cellspace_sendtohome-b_var6 )))

 (:action program_eff_cellspace_sendtohome-b_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_sendtohome-b_var6 ))(not (add_cellspace_sendtohome-b_var6 )))
   :effect (and (when (pre_cellspace_sendtohome-b_var6 )(del_cellspace_sendtohome-b_var6 ))(when (not (pre_cellspace_sendtohome-b_var6 ))(add_cellspace_sendtohome-b_var6 ))))

 (:action program_pre_cellspace_sendtohome-b_var7
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_sendtohome-b_var7 ))(not (del_cellspace_sendtohome-b_var7 ))(not (add_cellspace_sendtohome-b_var7 )))
   :effect (and (pre_cellspace_sendtohome-b_var7 )))

 (:action program_eff_cellspace_sendtohome-b_var7
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_sendtohome-b_var7 ))(not (add_cellspace_sendtohome-b_var7 )))
   :effect (and (when (pre_cellspace_sendtohome-b_var7 )(del_cellspace_sendtohome-b_var7 ))(when (not (pre_cellspace_sendtohome-b_var7 ))(add_cellspace_sendtohome-b_var7 ))))

 (:action program_pre_colspace_sendtohome-b_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_sendtohome-b_var3 ))(not (del_colspace_sendtohome-b_var3 ))(not (add_colspace_sendtohome-b_var3 )))
   :effect (and (pre_colspace_sendtohome-b_var3 )))

 (:action program_eff_colspace_sendtohome-b_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_sendtohome-b_var3 ))(not (add_colspace_sendtohome-b_var3 )))
   :effect (and (when (pre_colspace_sendtohome-b_var3 )(del_colspace_sendtohome-b_var3 ))(when (not (pre_colspace_sendtohome-b_var3 ))(add_colspace_sendtohome-b_var3 ))))

 (:action program_pre_colspace_sendtohome-b_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_sendtohome-b_var5 ))(not (del_colspace_sendtohome-b_var5 ))(not (add_colspace_sendtohome-b_var5 )))
   :effect (and (pre_colspace_sendtohome-b_var5 )))

 (:action program_eff_colspace_sendtohome-b_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_sendtohome-b_var5 ))(not (add_colspace_sendtohome-b_var5 )))
   :effect (and (when (pre_colspace_sendtohome-b_var5 )(del_colspace_sendtohome-b_var5 ))(when (not (pre_colspace_sendtohome-b_var5 ))(add_colspace_sendtohome-b_var5 ))))

 (:action program_pre_colspace_sendtohome-b_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_sendtohome-b_var6 ))(not (del_colspace_sendtohome-b_var6 ))(not (add_colspace_sendtohome-b_var6 )))
   :effect (and (pre_colspace_sendtohome-b_var6 )))

 (:action program_eff_colspace_sendtohome-b_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_sendtohome-b_var6 ))(not (add_colspace_sendtohome-b_var6 )))
   :effect (and (when (pre_colspace_sendtohome-b_var6 )(del_colspace_sendtohome-b_var6 ))(when (not (pre_colspace_sendtohome-b_var6 ))(add_colspace_sendtohome-b_var6 ))))

 (:action program_pre_colspace_sendtohome-b_var7
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_sendtohome-b_var7 ))(not (del_colspace_sendtohome-b_var7 ))(not (add_colspace_sendtohome-b_var7 )))
   :effect (and (pre_colspace_sendtohome-b_var7 )))

 (:action program_eff_colspace_sendtohome-b_var7
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_sendtohome-b_var7 ))(not (add_colspace_sendtohome-b_var7 )))
   :effect (and (when (pre_colspace_sendtohome-b_var7 )(del_colspace_sendtohome-b_var7 ))(when (not (pre_colspace_sendtohome-b_var7 ))(add_colspace_sendtohome-b_var7 ))))

 (:action program_pre_home_sendtohome-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_sendtohome-b_var1 ))(not (del_home_sendtohome-b_var1 ))(not (add_home_sendtohome-b_var1 )))
   :effect (and (pre_home_sendtohome-b_var1 )))

 (:action program_eff_home_sendtohome-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_home_sendtohome-b_var1 ))(not (add_home_sendtohome-b_var1 )))
   :effect (and (when (pre_home_sendtohome-b_var1 )(del_home_sendtohome-b_var1 ))(when (not (pre_home_sendtohome-b_var1 ))(add_home_sendtohome-b_var1 ))))

 (:action program_pre_home_sendtohome-b_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_sendtohome-b_var4 ))(not (del_home_sendtohome-b_var4 ))(not (add_home_sendtohome-b_var4 )))
   :effect (and (pre_home_sendtohome-b_var4 )))

 (:action program_eff_home_sendtohome-b_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_home_sendtohome-b_var4 ))(not (add_home_sendtohome-b_var4 )))
   :effect (and (when (pre_home_sendtohome-b_var4 )(del_home_sendtohome-b_var4 ))(when (not (pre_home_sendtohome-b_var4 ))(add_home_sendtohome-b_var4 ))))

 (:action program_pre_bottomcol_sendtohome-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_sendtohome-b_var1 ))(not (del_bottomcol_sendtohome-b_var1 ))(not (add_bottomcol_sendtohome-b_var1 )))
   :effect (and (pre_bottomcol_sendtohome-b_var1 )))

 (:action program_eff_bottomcol_sendtohome-b_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_sendtohome-b_var1 ))(not (add_bottomcol_sendtohome-b_var1 )))
   :effect (and (when (pre_bottomcol_sendtohome-b_var1 )(del_bottomcol_sendtohome-b_var1 ))(when (not (pre_bottomcol_sendtohome-b_var1 ))(add_bottomcol_sendtohome-b_var1 ))))

 (:action program_pre_bottomcol_sendtohome-b_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_sendtohome-b_var4 ))(not (del_bottomcol_sendtohome-b_var4 ))(not (add_bottomcol_sendtohome-b_var4 )))
   :effect (and (pre_bottomcol_sendtohome-b_var4 )))

 (:action program_eff_bottomcol_sendtohome-b_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_sendtohome-b_var4 ))(not (add_bottomcol_sendtohome-b_var4 )))
   :effect (and (when (pre_bottomcol_sendtohome-b_var4 )(del_bottomcol_sendtohome-b_var4 ))(when (not (pre_bottomcol_sendtohome-b_var4 ))(add_bottomcol_sendtohome-b_var4 ))))

 (:action program_pre_canstack_sendtohome-b_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtohome-b_var1_var1 ))(not (del_canstack_sendtohome-b_var1_var1 ))(not (add_canstack_sendtohome-b_var1_var1 )))
   :effect (and (pre_canstack_sendtohome-b_var1_var1 )))

 (:action program_eff_canstack_sendtohome-b_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtohome-b_var1_var1 ))(not (add_canstack_sendtohome-b_var1_var1 )))
   :effect (and (when (pre_canstack_sendtohome-b_var1_var1 )(del_canstack_sendtohome-b_var1_var1 ))(when (not (pre_canstack_sendtohome-b_var1_var1 ))(add_canstack_sendtohome-b_var1_var1 ))))

 (:action program_pre_canstack_sendtohome-b_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtohome-b_var1_var4 ))(not (del_canstack_sendtohome-b_var1_var4 ))(not (add_canstack_sendtohome-b_var1_var4 )))
   :effect (and (pre_canstack_sendtohome-b_var1_var4 )))

 (:action program_eff_canstack_sendtohome-b_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtohome-b_var1_var4 ))(not (add_canstack_sendtohome-b_var1_var4 )))
   :effect (and (when (pre_canstack_sendtohome-b_var1_var4 )(del_canstack_sendtohome-b_var1_var4 ))(when (not (pre_canstack_sendtohome-b_var1_var4 ))(add_canstack_sendtohome-b_var1_var4 ))))

 (:action program_pre_canstack_sendtohome-b_var4_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtohome-b_var4_var1 ))(not (del_canstack_sendtohome-b_var4_var1 ))(not (add_canstack_sendtohome-b_var4_var1 )))
   :effect (and (pre_canstack_sendtohome-b_var4_var1 )))

 (:action program_eff_canstack_sendtohome-b_var4_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtohome-b_var4_var1 ))(not (add_canstack_sendtohome-b_var4_var1 )))
   :effect (and (when (pre_canstack_sendtohome-b_var4_var1 )(del_canstack_sendtohome-b_var4_var1 ))(when (not (pre_canstack_sendtohome-b_var4_var1 ))(add_canstack_sendtohome-b_var4_var1 ))))

 (:action program_pre_canstack_sendtohome-b_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_sendtohome-b_var4_var4 ))(not (del_canstack_sendtohome-b_var4_var4 ))(not (add_canstack_sendtohome-b_var4_var4 )))
   :effect (and (pre_canstack_sendtohome-b_var4_var4 )))

 (:action program_eff_canstack_sendtohome-b_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_sendtohome-b_var4_var4 ))(not (add_canstack_sendtohome-b_var4_var4 )))
   :effect (and (when (pre_canstack_sendtohome-b_var4_var4 )(del_canstack_sendtohome-b_var4_var4 ))(when (not (pre_canstack_sendtohome-b_var4_var4 ))(add_canstack_sendtohome-b_var4_var4 ))))

 (:action program_pre_suit_sendtohome-b_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_suit_sendtohome-b_var1_var2 ))(not (del_suit_sendtohome-b_var1_var2 ))(not (add_suit_sendtohome-b_var1_var2 )))
   :effect (and (pre_suit_sendtohome-b_var1_var2 )))

 (:action program_eff_suit_sendtohome-b_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_suit_sendtohome-b_var1_var2 ))(not (add_suit_sendtohome-b_var1_var2 )))
   :effect (and (when (pre_suit_sendtohome-b_var1_var2 )(del_suit_sendtohome-b_var1_var2 ))(when (not (pre_suit_sendtohome-b_var1_var2 ))(add_suit_sendtohome-b_var1_var2 ))))

 (:action program_pre_suit_sendtohome-b_var4_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_suit_sendtohome-b_var4_var2 ))(not (del_suit_sendtohome-b_var4_var2 ))(not (add_suit_sendtohome-b_var4_var2 )))
   :effect (and (pre_suit_sendtohome-b_var4_var2 )))

 (:action program_eff_suit_sendtohome-b_var4_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_suit_sendtohome-b_var4_var2 ))(not (add_suit_sendtohome-b_var4_var2 )))
   :effect (and (when (pre_suit_sendtohome-b_var4_var2 )(del_suit_sendtohome-b_var4_var2 ))(when (not (pre_suit_sendtohome-b_var4_var2 ))(add_suit_sendtohome-b_var4_var2 ))))

 (:action program_pre_value_sendtohome-b_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtohome-b_var1_var3 ))(not (del_value_sendtohome-b_var1_var3 ))(not (add_value_sendtohome-b_var1_var3 )))
   :effect (and (pre_value_sendtohome-b_var1_var3 )))

 (:action program_eff_value_sendtohome-b_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtohome-b_var1_var3 ))(not (add_value_sendtohome-b_var1_var3 )))
   :effect (and (when (pre_value_sendtohome-b_var1_var3 )(del_value_sendtohome-b_var1_var3 ))(when (not (pre_value_sendtohome-b_var1_var3 ))(add_value_sendtohome-b_var1_var3 ))))

 (:action program_pre_value_sendtohome-b_var1_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtohome-b_var1_var5 ))(not (del_value_sendtohome-b_var1_var5 ))(not (add_value_sendtohome-b_var1_var5 )))
   :effect (and (pre_value_sendtohome-b_var1_var5 )))

 (:action program_eff_value_sendtohome-b_var1_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtohome-b_var1_var5 ))(not (add_value_sendtohome-b_var1_var5 )))
   :effect (and (when (pre_value_sendtohome-b_var1_var5 )(del_value_sendtohome-b_var1_var5 ))(when (not (pre_value_sendtohome-b_var1_var5 ))(add_value_sendtohome-b_var1_var5 ))))

 (:action program_pre_value_sendtohome-b_var1_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtohome-b_var1_var6 ))(not (del_value_sendtohome-b_var1_var6 ))(not (add_value_sendtohome-b_var1_var6 )))
   :effect (and (pre_value_sendtohome-b_var1_var6 )))

 (:action program_eff_value_sendtohome-b_var1_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtohome-b_var1_var6 ))(not (add_value_sendtohome-b_var1_var6 )))
   :effect (and (when (pre_value_sendtohome-b_var1_var6 )(del_value_sendtohome-b_var1_var6 ))(when (not (pre_value_sendtohome-b_var1_var6 ))(add_value_sendtohome-b_var1_var6 ))))

 (:action program_pre_value_sendtohome-b_var1_var7
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtohome-b_var1_var7 ))(not (del_value_sendtohome-b_var1_var7 ))(not (add_value_sendtohome-b_var1_var7 )))
   :effect (and (pre_value_sendtohome-b_var1_var7 )))

 (:action program_eff_value_sendtohome-b_var1_var7
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtohome-b_var1_var7 ))(not (add_value_sendtohome-b_var1_var7 )))
   :effect (and (when (pre_value_sendtohome-b_var1_var7 )(del_value_sendtohome-b_var1_var7 ))(when (not (pre_value_sendtohome-b_var1_var7 ))(add_value_sendtohome-b_var1_var7 ))))

 (:action program_pre_value_sendtohome-b_var4_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtohome-b_var4_var3 ))(not (del_value_sendtohome-b_var4_var3 ))(not (add_value_sendtohome-b_var4_var3 )))
   :effect (and (pre_value_sendtohome-b_var4_var3 )))

 (:action program_eff_value_sendtohome-b_var4_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtohome-b_var4_var3 ))(not (add_value_sendtohome-b_var4_var3 )))
   :effect (and (when (pre_value_sendtohome-b_var4_var3 )(del_value_sendtohome-b_var4_var3 ))(when (not (pre_value_sendtohome-b_var4_var3 ))(add_value_sendtohome-b_var4_var3 ))))

 (:action program_pre_value_sendtohome-b_var4_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtohome-b_var4_var5 ))(not (del_value_sendtohome-b_var4_var5 ))(not (add_value_sendtohome-b_var4_var5 )))
   :effect (and (pre_value_sendtohome-b_var4_var5 )))

 (:action program_eff_value_sendtohome-b_var4_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtohome-b_var4_var5 ))(not (add_value_sendtohome-b_var4_var5 )))
   :effect (and (when (pre_value_sendtohome-b_var4_var5 )(del_value_sendtohome-b_var4_var5 ))(when (not (pre_value_sendtohome-b_var4_var5 ))(add_value_sendtohome-b_var4_var5 ))))

 (:action program_pre_value_sendtohome-b_var4_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtohome-b_var4_var6 ))(not (del_value_sendtohome-b_var4_var6 ))(not (add_value_sendtohome-b_var4_var6 )))
   :effect (and (pre_value_sendtohome-b_var4_var6 )))

 (:action program_eff_value_sendtohome-b_var4_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtohome-b_var4_var6 ))(not (add_value_sendtohome-b_var4_var6 )))
   :effect (and (when (pre_value_sendtohome-b_var4_var6 )(del_value_sendtohome-b_var4_var6 ))(when (not (pre_value_sendtohome-b_var4_var6 ))(add_value_sendtohome-b_var4_var6 ))))

 (:action program_pre_value_sendtohome-b_var4_var7
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_sendtohome-b_var4_var7 ))(not (del_value_sendtohome-b_var4_var7 ))(not (add_value_sendtohome-b_var4_var7 )))
   :effect (and (pre_value_sendtohome-b_var4_var7 )))

 (:action program_eff_value_sendtohome-b_var4_var7
   :parameters ()
   :precondition (and (modeProg )(not (del_value_sendtohome-b_var4_var7 ))(not (add_value_sendtohome-b_var4_var7 )))
   :effect (and (when (pre_value_sendtohome-b_var4_var7 )(del_value_sendtohome-b_var4_var7 ))(when (not (pre_value_sendtohome-b_var4_var7 ))(add_value_sendtohome-b_var4_var7 ))))

 (:action program_pre_successor_sendtohome-b_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome-b_var3_var3 ))(not (del_successor_sendtohome-b_var3_var3 ))(not (add_successor_sendtohome-b_var3_var3 )))
   :effect (and (pre_successor_sendtohome-b_var3_var3 )))

 (:action program_eff_successor_sendtohome-b_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome-b_var3_var3 ))(not (add_successor_sendtohome-b_var3_var3 )))
   :effect (and (when (pre_successor_sendtohome-b_var3_var3 )(del_successor_sendtohome-b_var3_var3 ))(when (not (pre_successor_sendtohome-b_var3_var3 ))(add_successor_sendtohome-b_var3_var3 ))))

 (:action program_pre_successor_sendtohome-b_var3_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome-b_var3_var5 ))(not (del_successor_sendtohome-b_var3_var5 ))(not (add_successor_sendtohome-b_var3_var5 )))
   :effect (and (pre_successor_sendtohome-b_var3_var5 )))

 (:action program_eff_successor_sendtohome-b_var3_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome-b_var3_var5 ))(not (add_successor_sendtohome-b_var3_var5 )))
   :effect (and (when (pre_successor_sendtohome-b_var3_var5 )(del_successor_sendtohome-b_var3_var5 ))(when (not (pre_successor_sendtohome-b_var3_var5 ))(add_successor_sendtohome-b_var3_var5 ))))

 (:action program_pre_successor_sendtohome-b_var3_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome-b_var3_var6 ))(not (del_successor_sendtohome-b_var3_var6 ))(not (add_successor_sendtohome-b_var3_var6 )))
   :effect (and (pre_successor_sendtohome-b_var3_var6 )))

 (:action program_eff_successor_sendtohome-b_var3_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome-b_var3_var6 ))(not (add_successor_sendtohome-b_var3_var6 )))
   :effect (and (when (pre_successor_sendtohome-b_var3_var6 )(del_successor_sendtohome-b_var3_var6 ))(when (not (pre_successor_sendtohome-b_var3_var6 ))(add_successor_sendtohome-b_var3_var6 ))))

 (:action program_pre_successor_sendtohome-b_var3_var7
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome-b_var3_var7 ))(not (del_successor_sendtohome-b_var3_var7 ))(not (add_successor_sendtohome-b_var3_var7 )))
   :effect (and (pre_successor_sendtohome-b_var3_var7 )))

 (:action program_eff_successor_sendtohome-b_var3_var7
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome-b_var3_var7 ))(not (add_successor_sendtohome-b_var3_var7 )))
   :effect (and (when (pre_successor_sendtohome-b_var3_var7 )(del_successor_sendtohome-b_var3_var7 ))(when (not (pre_successor_sendtohome-b_var3_var7 ))(add_successor_sendtohome-b_var3_var7 ))))

 (:action program_pre_successor_sendtohome-b_var5_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome-b_var5_var3 ))(not (del_successor_sendtohome-b_var5_var3 ))(not (add_successor_sendtohome-b_var5_var3 )))
   :effect (and (pre_successor_sendtohome-b_var5_var3 )))

 (:action program_eff_successor_sendtohome-b_var5_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome-b_var5_var3 ))(not (add_successor_sendtohome-b_var5_var3 )))
   :effect (and (when (pre_successor_sendtohome-b_var5_var3 )(del_successor_sendtohome-b_var5_var3 ))(when (not (pre_successor_sendtohome-b_var5_var3 ))(add_successor_sendtohome-b_var5_var3 ))))

 (:action program_pre_successor_sendtohome-b_var5_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome-b_var5_var5 ))(not (del_successor_sendtohome-b_var5_var5 ))(not (add_successor_sendtohome-b_var5_var5 )))
   :effect (and (pre_successor_sendtohome-b_var5_var5 )))

 (:action program_eff_successor_sendtohome-b_var5_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome-b_var5_var5 ))(not (add_successor_sendtohome-b_var5_var5 )))
   :effect (and (when (pre_successor_sendtohome-b_var5_var5 )(del_successor_sendtohome-b_var5_var5 ))(when (not (pre_successor_sendtohome-b_var5_var5 ))(add_successor_sendtohome-b_var5_var5 ))))

 (:action program_pre_successor_sendtohome-b_var5_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome-b_var5_var6 ))(not (del_successor_sendtohome-b_var5_var6 ))(not (add_successor_sendtohome-b_var5_var6 )))
   :effect (and (pre_successor_sendtohome-b_var5_var6 )))

 (:action program_eff_successor_sendtohome-b_var5_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome-b_var5_var6 ))(not (add_successor_sendtohome-b_var5_var6 )))
   :effect (and (when (pre_successor_sendtohome-b_var5_var6 )(del_successor_sendtohome-b_var5_var6 ))(when (not (pre_successor_sendtohome-b_var5_var6 ))(add_successor_sendtohome-b_var5_var6 ))))

 (:action program_pre_successor_sendtohome-b_var5_var7
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome-b_var5_var7 ))(not (del_successor_sendtohome-b_var5_var7 ))(not (add_successor_sendtohome-b_var5_var7 )))
   :effect (and (pre_successor_sendtohome-b_var5_var7 )))

 (:action program_eff_successor_sendtohome-b_var5_var7
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome-b_var5_var7 ))(not (add_successor_sendtohome-b_var5_var7 )))
   :effect (and (when (pre_successor_sendtohome-b_var5_var7 )(del_successor_sendtohome-b_var5_var7 ))(when (not (pre_successor_sendtohome-b_var5_var7 ))(add_successor_sendtohome-b_var5_var7 ))))

 (:action program_pre_successor_sendtohome-b_var6_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome-b_var6_var3 ))(not (del_successor_sendtohome-b_var6_var3 ))(not (add_successor_sendtohome-b_var6_var3 )))
   :effect (and (pre_successor_sendtohome-b_var6_var3 )))

 (:action program_eff_successor_sendtohome-b_var6_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome-b_var6_var3 ))(not (add_successor_sendtohome-b_var6_var3 )))
   :effect (and (when (pre_successor_sendtohome-b_var6_var3 )(del_successor_sendtohome-b_var6_var3 ))(when (not (pre_successor_sendtohome-b_var6_var3 ))(add_successor_sendtohome-b_var6_var3 ))))

 (:action program_pre_successor_sendtohome-b_var6_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome-b_var6_var5 ))(not (del_successor_sendtohome-b_var6_var5 ))(not (add_successor_sendtohome-b_var6_var5 )))
   :effect (and (pre_successor_sendtohome-b_var6_var5 )))

 (:action program_eff_successor_sendtohome-b_var6_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome-b_var6_var5 ))(not (add_successor_sendtohome-b_var6_var5 )))
   :effect (and (when (pre_successor_sendtohome-b_var6_var5 )(del_successor_sendtohome-b_var6_var5 ))(when (not (pre_successor_sendtohome-b_var6_var5 ))(add_successor_sendtohome-b_var6_var5 ))))

 (:action program_pre_successor_sendtohome-b_var6_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome-b_var6_var6 ))(not (del_successor_sendtohome-b_var6_var6 ))(not (add_successor_sendtohome-b_var6_var6 )))
   :effect (and (pre_successor_sendtohome-b_var6_var6 )))

 (:action program_eff_successor_sendtohome-b_var6_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome-b_var6_var6 ))(not (add_successor_sendtohome-b_var6_var6 )))
   :effect (and (when (pre_successor_sendtohome-b_var6_var6 )(del_successor_sendtohome-b_var6_var6 ))(when (not (pre_successor_sendtohome-b_var6_var6 ))(add_successor_sendtohome-b_var6_var6 ))))

 (:action program_pre_successor_sendtohome-b_var6_var7
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome-b_var6_var7 ))(not (del_successor_sendtohome-b_var6_var7 ))(not (add_successor_sendtohome-b_var6_var7 )))
   :effect (and (pre_successor_sendtohome-b_var6_var7 )))

 (:action program_eff_successor_sendtohome-b_var6_var7
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome-b_var6_var7 ))(not (add_successor_sendtohome-b_var6_var7 )))
   :effect (and (when (pre_successor_sendtohome-b_var6_var7 )(del_successor_sendtohome-b_var6_var7 ))(when (not (pre_successor_sendtohome-b_var6_var7 ))(add_successor_sendtohome-b_var6_var7 ))))

 (:action program_pre_successor_sendtohome-b_var7_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome-b_var7_var3 ))(not (del_successor_sendtohome-b_var7_var3 ))(not (add_successor_sendtohome-b_var7_var3 )))
   :effect (and (pre_successor_sendtohome-b_var7_var3 )))

 (:action program_eff_successor_sendtohome-b_var7_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome-b_var7_var3 ))(not (add_successor_sendtohome-b_var7_var3 )))
   :effect (and (when (pre_successor_sendtohome-b_var7_var3 )(del_successor_sendtohome-b_var7_var3 ))(when (not (pre_successor_sendtohome-b_var7_var3 ))(add_successor_sendtohome-b_var7_var3 ))))

 (:action program_pre_successor_sendtohome-b_var7_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome-b_var7_var5 ))(not (del_successor_sendtohome-b_var7_var5 ))(not (add_successor_sendtohome-b_var7_var5 )))
   :effect (and (pre_successor_sendtohome-b_var7_var5 )))

 (:action program_eff_successor_sendtohome-b_var7_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome-b_var7_var5 ))(not (add_successor_sendtohome-b_var7_var5 )))
   :effect (and (when (pre_successor_sendtohome-b_var7_var5 )(del_successor_sendtohome-b_var7_var5 ))(when (not (pre_successor_sendtohome-b_var7_var5 ))(add_successor_sendtohome-b_var7_var5 ))))

 (:action program_pre_successor_sendtohome-b_var7_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome-b_var7_var6 ))(not (del_successor_sendtohome-b_var7_var6 ))(not (add_successor_sendtohome-b_var7_var6 )))
   :effect (and (pre_successor_sendtohome-b_var7_var6 )))

 (:action program_eff_successor_sendtohome-b_var7_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome-b_var7_var6 ))(not (add_successor_sendtohome-b_var7_var6 )))
   :effect (and (when (pre_successor_sendtohome-b_var7_var6 )(del_successor_sendtohome-b_var7_var6 ))(when (not (pre_successor_sendtohome-b_var7_var6 ))(add_successor_sendtohome-b_var7_var6 ))))

 (:action program_pre_successor_sendtohome-b_var7_var7
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_sendtohome-b_var7_var7 ))(not (del_successor_sendtohome-b_var7_var7 ))(not (add_successor_sendtohome-b_var7_var7 )))
   :effect (and (pre_successor_sendtohome-b_var7_var7 )))

 (:action program_eff_successor_sendtohome-b_var7_var7
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_sendtohome-b_var7_var7 ))(not (add_successor_sendtohome-b_var7_var7 )))
   :effect (and (when (pre_successor_sendtohome-b_var7_var7 )(del_successor_sendtohome-b_var7_var7 ))(when (not (pre_successor_sendtohome-b_var7_var7 ))(add_successor_sendtohome-b_var7_var7 ))))

 (:action program_pre_on_homefromfreecell_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_homefromfreecell_var1_var1 ))(not (del_on_homefromfreecell_var1_var1 ))(not (add_on_homefromfreecell_var1_var1 )))
   :effect (and (pre_on_homefromfreecell_var1_var1 )))

 (:action program_eff_on_homefromfreecell_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_homefromfreecell_var1_var1 ))(not (add_on_homefromfreecell_var1_var1 )))
   :effect (and (when (pre_on_homefromfreecell_var1_var1 )(del_on_homefromfreecell_var1_var1 ))(when (not (pre_on_homefromfreecell_var1_var1 ))(add_on_homefromfreecell_var1_var1 ))))

 (:action program_pre_on_homefromfreecell_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_homefromfreecell_var1_var4 ))(not (del_on_homefromfreecell_var1_var4 ))(not (add_on_homefromfreecell_var1_var4 )))
   :effect (and (pre_on_homefromfreecell_var1_var4 )))

 (:action program_eff_on_homefromfreecell_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_on_homefromfreecell_var1_var4 ))(not (add_on_homefromfreecell_var1_var4 )))
   :effect (and (when (pre_on_homefromfreecell_var1_var4 )(del_on_homefromfreecell_var1_var4 ))(when (not (pre_on_homefromfreecell_var1_var4 ))(add_on_homefromfreecell_var1_var4 ))))

 (:action program_pre_on_homefromfreecell_var4_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_homefromfreecell_var4_var1 ))(not (del_on_homefromfreecell_var4_var1 ))(not (add_on_homefromfreecell_var4_var1 )))
   :effect (and (pre_on_homefromfreecell_var4_var1 )))

 (:action program_eff_on_homefromfreecell_var4_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_homefromfreecell_var4_var1 ))(not (add_on_homefromfreecell_var4_var1 )))
   :effect (and (when (pre_on_homefromfreecell_var4_var1 )(del_on_homefromfreecell_var4_var1 ))(when (not (pre_on_homefromfreecell_var4_var1 ))(add_on_homefromfreecell_var4_var1 ))))

 (:action program_pre_on_homefromfreecell_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_homefromfreecell_var4_var4 ))(not (del_on_homefromfreecell_var4_var4 ))(not (add_on_homefromfreecell_var4_var4 )))
   :effect (and (pre_on_homefromfreecell_var4_var4 )))

 (:action program_eff_on_homefromfreecell_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_on_homefromfreecell_var4_var4 ))(not (add_on_homefromfreecell_var4_var4 )))
   :effect (and (when (pre_on_homefromfreecell_var4_var4 )(del_on_homefromfreecell_var4_var4 ))(when (not (pre_on_homefromfreecell_var4_var4 ))(add_on_homefromfreecell_var4_var4 ))))

 (:action program_pre_incell_homefromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_homefromfreecell_var1 ))(not (del_incell_homefromfreecell_var1 ))(not (add_incell_homefromfreecell_var1 )))
   :effect (and (pre_incell_homefromfreecell_var1 )))

 (:action program_eff_incell_homefromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_homefromfreecell_var1 ))(not (add_incell_homefromfreecell_var1 )))
   :effect (and (when (pre_incell_homefromfreecell_var1 )(del_incell_homefromfreecell_var1 ))(when (not (pre_incell_homefromfreecell_var1 ))(add_incell_homefromfreecell_var1 ))))

 (:action program_pre_incell_homefromfreecell_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_homefromfreecell_var4 ))(not (del_incell_homefromfreecell_var4 ))(not (add_incell_homefromfreecell_var4 )))
   :effect (and (pre_incell_homefromfreecell_var4 )))

 (:action program_eff_incell_homefromfreecell_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_homefromfreecell_var4 ))(not (add_incell_homefromfreecell_var4 )))
   :effect (and (when (pre_incell_homefromfreecell_var4 )(del_incell_homefromfreecell_var4 ))(when (not (pre_incell_homefromfreecell_var4 ))(add_incell_homefromfreecell_var4 ))))

 (:action program_pre_clear_homefromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_homefromfreecell_var1 ))(not (del_clear_homefromfreecell_var1 ))(not (add_clear_homefromfreecell_var1 )))
   :effect (and (pre_clear_homefromfreecell_var1 )))

 (:action program_eff_clear_homefromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_homefromfreecell_var1 ))(not (add_clear_homefromfreecell_var1 )))
   :effect (and (when (pre_clear_homefromfreecell_var1 )(del_clear_homefromfreecell_var1 ))(when (not (pre_clear_homefromfreecell_var1 ))(add_clear_homefromfreecell_var1 ))))

 (:action program_pre_clear_homefromfreecell_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_homefromfreecell_var4 ))(not (del_clear_homefromfreecell_var4 ))(not (add_clear_homefromfreecell_var4 )))
   :effect (and (pre_clear_homefromfreecell_var4 )))

 (:action program_eff_clear_homefromfreecell_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_homefromfreecell_var4 ))(not (add_clear_homefromfreecell_var4 )))
   :effect (and (when (pre_clear_homefromfreecell_var4 )(del_clear_homefromfreecell_var4 ))(when (not (pre_clear_homefromfreecell_var4 ))(add_clear_homefromfreecell_var4 ))))

 (:action program_pre_cellspace_homefromfreecell_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_homefromfreecell_var3 ))(not (del_cellspace_homefromfreecell_var3 ))(not (add_cellspace_homefromfreecell_var3 )))
   :effect (and (pre_cellspace_homefromfreecell_var3 )))

 (:action program_eff_cellspace_homefromfreecell_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_homefromfreecell_var3 ))(not (add_cellspace_homefromfreecell_var3 )))
   :effect (and (when (pre_cellspace_homefromfreecell_var3 )(del_cellspace_homefromfreecell_var3 ))(when (not (pre_cellspace_homefromfreecell_var3 ))(add_cellspace_homefromfreecell_var3 ))))

 (:action program_pre_cellspace_homefromfreecell_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_homefromfreecell_var5 ))(not (del_cellspace_homefromfreecell_var5 ))(not (add_cellspace_homefromfreecell_var5 )))
   :effect (and (pre_cellspace_homefromfreecell_var5 )))

 (:action program_eff_cellspace_homefromfreecell_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_homefromfreecell_var5 ))(not (add_cellspace_homefromfreecell_var5 )))
   :effect (and (when (pre_cellspace_homefromfreecell_var5 )(del_cellspace_homefromfreecell_var5 ))(when (not (pre_cellspace_homefromfreecell_var5 ))(add_cellspace_homefromfreecell_var5 ))))

 (:action program_pre_cellspace_homefromfreecell_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_homefromfreecell_var6 ))(not (del_cellspace_homefromfreecell_var6 ))(not (add_cellspace_homefromfreecell_var6 )))
   :effect (and (pre_cellspace_homefromfreecell_var6 )))

 (:action program_eff_cellspace_homefromfreecell_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_homefromfreecell_var6 ))(not (add_cellspace_homefromfreecell_var6 )))
   :effect (and (when (pre_cellspace_homefromfreecell_var6 )(del_cellspace_homefromfreecell_var6 ))(when (not (pre_cellspace_homefromfreecell_var6 ))(add_cellspace_homefromfreecell_var6 ))))

 (:action program_pre_cellspace_homefromfreecell_var7
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_homefromfreecell_var7 ))(not (del_cellspace_homefromfreecell_var7 ))(not (add_cellspace_homefromfreecell_var7 )))
   :effect (and (pre_cellspace_homefromfreecell_var7 )))

 (:action program_eff_cellspace_homefromfreecell_var7
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_homefromfreecell_var7 ))(not (add_cellspace_homefromfreecell_var7 )))
   :effect (and (when (pre_cellspace_homefromfreecell_var7 )(del_cellspace_homefromfreecell_var7 ))(when (not (pre_cellspace_homefromfreecell_var7 ))(add_cellspace_homefromfreecell_var7 ))))

 (:action program_pre_colspace_homefromfreecell_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_homefromfreecell_var3 ))(not (del_colspace_homefromfreecell_var3 ))(not (add_colspace_homefromfreecell_var3 )))
   :effect (and (pre_colspace_homefromfreecell_var3 )))

 (:action program_eff_colspace_homefromfreecell_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_homefromfreecell_var3 ))(not (add_colspace_homefromfreecell_var3 )))
   :effect (and (when (pre_colspace_homefromfreecell_var3 )(del_colspace_homefromfreecell_var3 ))(when (not (pre_colspace_homefromfreecell_var3 ))(add_colspace_homefromfreecell_var3 ))))

 (:action program_pre_colspace_homefromfreecell_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_homefromfreecell_var5 ))(not (del_colspace_homefromfreecell_var5 ))(not (add_colspace_homefromfreecell_var5 )))
   :effect (and (pre_colspace_homefromfreecell_var5 )))

 (:action program_eff_colspace_homefromfreecell_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_homefromfreecell_var5 ))(not (add_colspace_homefromfreecell_var5 )))
   :effect (and (when (pre_colspace_homefromfreecell_var5 )(del_colspace_homefromfreecell_var5 ))(when (not (pre_colspace_homefromfreecell_var5 ))(add_colspace_homefromfreecell_var5 ))))

 (:action program_pre_colspace_homefromfreecell_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_homefromfreecell_var6 ))(not (del_colspace_homefromfreecell_var6 ))(not (add_colspace_homefromfreecell_var6 )))
   :effect (and (pre_colspace_homefromfreecell_var6 )))

 (:action program_eff_colspace_homefromfreecell_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_homefromfreecell_var6 ))(not (add_colspace_homefromfreecell_var6 )))
   :effect (and (when (pre_colspace_homefromfreecell_var6 )(del_colspace_homefromfreecell_var6 ))(when (not (pre_colspace_homefromfreecell_var6 ))(add_colspace_homefromfreecell_var6 ))))

 (:action program_pre_colspace_homefromfreecell_var7
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_homefromfreecell_var7 ))(not (del_colspace_homefromfreecell_var7 ))(not (add_colspace_homefromfreecell_var7 )))
   :effect (and (pre_colspace_homefromfreecell_var7 )))

 (:action program_eff_colspace_homefromfreecell_var7
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_homefromfreecell_var7 ))(not (add_colspace_homefromfreecell_var7 )))
   :effect (and (when (pre_colspace_homefromfreecell_var7 )(del_colspace_homefromfreecell_var7 ))(when (not (pre_colspace_homefromfreecell_var7 ))(add_colspace_homefromfreecell_var7 ))))

 (:action program_pre_home_homefromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_homefromfreecell_var1 ))(not (del_home_homefromfreecell_var1 ))(not (add_home_homefromfreecell_var1 )))
   :effect (and (pre_home_homefromfreecell_var1 )))

 (:action program_eff_home_homefromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_home_homefromfreecell_var1 ))(not (add_home_homefromfreecell_var1 )))
   :effect (and (when (pre_home_homefromfreecell_var1 )(del_home_homefromfreecell_var1 ))(when (not (pre_home_homefromfreecell_var1 ))(add_home_homefromfreecell_var1 ))))

 (:action program_pre_home_homefromfreecell_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_homefromfreecell_var4 ))(not (del_home_homefromfreecell_var4 ))(not (add_home_homefromfreecell_var4 )))
   :effect (and (pre_home_homefromfreecell_var4 )))

 (:action program_eff_home_homefromfreecell_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_home_homefromfreecell_var4 ))(not (add_home_homefromfreecell_var4 )))
   :effect (and (when (pre_home_homefromfreecell_var4 )(del_home_homefromfreecell_var4 ))(when (not (pre_home_homefromfreecell_var4 ))(add_home_homefromfreecell_var4 ))))

 (:action program_pre_bottomcol_homefromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_homefromfreecell_var1 ))(not (del_bottomcol_homefromfreecell_var1 ))(not (add_bottomcol_homefromfreecell_var1 )))
   :effect (and (pre_bottomcol_homefromfreecell_var1 )))

 (:action program_eff_bottomcol_homefromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_homefromfreecell_var1 ))(not (add_bottomcol_homefromfreecell_var1 )))
   :effect (and (when (pre_bottomcol_homefromfreecell_var1 )(del_bottomcol_homefromfreecell_var1 ))(when (not (pre_bottomcol_homefromfreecell_var1 ))(add_bottomcol_homefromfreecell_var1 ))))

 (:action program_pre_bottomcol_homefromfreecell_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_homefromfreecell_var4 ))(not (del_bottomcol_homefromfreecell_var4 ))(not (add_bottomcol_homefromfreecell_var4 )))
   :effect (and (pre_bottomcol_homefromfreecell_var4 )))

 (:action program_eff_bottomcol_homefromfreecell_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_homefromfreecell_var4 ))(not (add_bottomcol_homefromfreecell_var4 )))
   :effect (and (when (pre_bottomcol_homefromfreecell_var4 )(del_bottomcol_homefromfreecell_var4 ))(when (not (pre_bottomcol_homefromfreecell_var4 ))(add_bottomcol_homefromfreecell_var4 ))))

 (:action program_pre_canstack_homefromfreecell_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_homefromfreecell_var1_var1 ))(not (del_canstack_homefromfreecell_var1_var1 ))(not (add_canstack_homefromfreecell_var1_var1 )))
   :effect (and (pre_canstack_homefromfreecell_var1_var1 )))

 (:action program_eff_canstack_homefromfreecell_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_homefromfreecell_var1_var1 ))(not (add_canstack_homefromfreecell_var1_var1 )))
   :effect (and (when (pre_canstack_homefromfreecell_var1_var1 )(del_canstack_homefromfreecell_var1_var1 ))(when (not (pre_canstack_homefromfreecell_var1_var1 ))(add_canstack_homefromfreecell_var1_var1 ))))

 (:action program_pre_canstack_homefromfreecell_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_homefromfreecell_var1_var4 ))(not (del_canstack_homefromfreecell_var1_var4 ))(not (add_canstack_homefromfreecell_var1_var4 )))
   :effect (and (pre_canstack_homefromfreecell_var1_var4 )))

 (:action program_eff_canstack_homefromfreecell_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_homefromfreecell_var1_var4 ))(not (add_canstack_homefromfreecell_var1_var4 )))
   :effect (and (when (pre_canstack_homefromfreecell_var1_var4 )(del_canstack_homefromfreecell_var1_var4 ))(when (not (pre_canstack_homefromfreecell_var1_var4 ))(add_canstack_homefromfreecell_var1_var4 ))))

 (:action program_pre_canstack_homefromfreecell_var4_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_homefromfreecell_var4_var1 ))(not (del_canstack_homefromfreecell_var4_var1 ))(not (add_canstack_homefromfreecell_var4_var1 )))
   :effect (and (pre_canstack_homefromfreecell_var4_var1 )))

 (:action program_eff_canstack_homefromfreecell_var4_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_homefromfreecell_var4_var1 ))(not (add_canstack_homefromfreecell_var4_var1 )))
   :effect (and (when (pre_canstack_homefromfreecell_var4_var1 )(del_canstack_homefromfreecell_var4_var1 ))(when (not (pre_canstack_homefromfreecell_var4_var1 ))(add_canstack_homefromfreecell_var4_var1 ))))

 (:action program_pre_canstack_homefromfreecell_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_homefromfreecell_var4_var4 ))(not (del_canstack_homefromfreecell_var4_var4 ))(not (add_canstack_homefromfreecell_var4_var4 )))
   :effect (and (pre_canstack_homefromfreecell_var4_var4 )))

 (:action program_eff_canstack_homefromfreecell_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_homefromfreecell_var4_var4 ))(not (add_canstack_homefromfreecell_var4_var4 )))
   :effect (and (when (pre_canstack_homefromfreecell_var4_var4 )(del_canstack_homefromfreecell_var4_var4 ))(when (not (pre_canstack_homefromfreecell_var4_var4 ))(add_canstack_homefromfreecell_var4_var4 ))))

 (:action program_pre_suit_homefromfreecell_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_suit_homefromfreecell_var1_var2 ))(not (del_suit_homefromfreecell_var1_var2 ))(not (add_suit_homefromfreecell_var1_var2 )))
   :effect (and (pre_suit_homefromfreecell_var1_var2 )))

 (:action program_eff_suit_homefromfreecell_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_suit_homefromfreecell_var1_var2 ))(not (add_suit_homefromfreecell_var1_var2 )))
   :effect (and (when (pre_suit_homefromfreecell_var1_var2 )(del_suit_homefromfreecell_var1_var2 ))(when (not (pre_suit_homefromfreecell_var1_var2 ))(add_suit_homefromfreecell_var1_var2 ))))

 (:action program_pre_suit_homefromfreecell_var4_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_suit_homefromfreecell_var4_var2 ))(not (del_suit_homefromfreecell_var4_var2 ))(not (add_suit_homefromfreecell_var4_var2 )))
   :effect (and (pre_suit_homefromfreecell_var4_var2 )))

 (:action program_eff_suit_homefromfreecell_var4_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_suit_homefromfreecell_var4_var2 ))(not (add_suit_homefromfreecell_var4_var2 )))
   :effect (and (when (pre_suit_homefromfreecell_var4_var2 )(del_suit_homefromfreecell_var4_var2 ))(when (not (pre_suit_homefromfreecell_var4_var2 ))(add_suit_homefromfreecell_var4_var2 ))))

 (:action program_pre_value_homefromfreecell_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_homefromfreecell_var1_var3 ))(not (del_value_homefromfreecell_var1_var3 ))(not (add_value_homefromfreecell_var1_var3 )))
   :effect (and (pre_value_homefromfreecell_var1_var3 )))

 (:action program_eff_value_homefromfreecell_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_value_homefromfreecell_var1_var3 ))(not (add_value_homefromfreecell_var1_var3 )))
   :effect (and (when (pre_value_homefromfreecell_var1_var3 )(del_value_homefromfreecell_var1_var3 ))(when (not (pre_value_homefromfreecell_var1_var3 ))(add_value_homefromfreecell_var1_var3 ))))

 (:action program_pre_value_homefromfreecell_var1_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_homefromfreecell_var1_var5 ))(not (del_value_homefromfreecell_var1_var5 ))(not (add_value_homefromfreecell_var1_var5 )))
   :effect (and (pre_value_homefromfreecell_var1_var5 )))

 (:action program_eff_value_homefromfreecell_var1_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_value_homefromfreecell_var1_var5 ))(not (add_value_homefromfreecell_var1_var5 )))
   :effect (and (when (pre_value_homefromfreecell_var1_var5 )(del_value_homefromfreecell_var1_var5 ))(when (not (pre_value_homefromfreecell_var1_var5 ))(add_value_homefromfreecell_var1_var5 ))))

 (:action program_pre_value_homefromfreecell_var1_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_homefromfreecell_var1_var6 ))(not (del_value_homefromfreecell_var1_var6 ))(not (add_value_homefromfreecell_var1_var6 )))
   :effect (and (pre_value_homefromfreecell_var1_var6 )))

 (:action program_eff_value_homefromfreecell_var1_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_value_homefromfreecell_var1_var6 ))(not (add_value_homefromfreecell_var1_var6 )))
   :effect (and (when (pre_value_homefromfreecell_var1_var6 )(del_value_homefromfreecell_var1_var6 ))(when (not (pre_value_homefromfreecell_var1_var6 ))(add_value_homefromfreecell_var1_var6 ))))

 (:action program_pre_value_homefromfreecell_var1_var7
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_homefromfreecell_var1_var7 ))(not (del_value_homefromfreecell_var1_var7 ))(not (add_value_homefromfreecell_var1_var7 )))
   :effect (and (pre_value_homefromfreecell_var1_var7 )))

 (:action program_eff_value_homefromfreecell_var1_var7
   :parameters ()
   :precondition (and (modeProg )(not (del_value_homefromfreecell_var1_var7 ))(not (add_value_homefromfreecell_var1_var7 )))
   :effect (and (when (pre_value_homefromfreecell_var1_var7 )(del_value_homefromfreecell_var1_var7 ))(when (not (pre_value_homefromfreecell_var1_var7 ))(add_value_homefromfreecell_var1_var7 ))))

 (:action program_pre_value_homefromfreecell_var4_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_homefromfreecell_var4_var3 ))(not (del_value_homefromfreecell_var4_var3 ))(not (add_value_homefromfreecell_var4_var3 )))
   :effect (and (pre_value_homefromfreecell_var4_var3 )))

 (:action program_eff_value_homefromfreecell_var4_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_value_homefromfreecell_var4_var3 ))(not (add_value_homefromfreecell_var4_var3 )))
   :effect (and (when (pre_value_homefromfreecell_var4_var3 )(del_value_homefromfreecell_var4_var3 ))(when (not (pre_value_homefromfreecell_var4_var3 ))(add_value_homefromfreecell_var4_var3 ))))

 (:action program_pre_value_homefromfreecell_var4_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_homefromfreecell_var4_var5 ))(not (del_value_homefromfreecell_var4_var5 ))(not (add_value_homefromfreecell_var4_var5 )))
   :effect (and (pre_value_homefromfreecell_var4_var5 )))

 (:action program_eff_value_homefromfreecell_var4_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_value_homefromfreecell_var4_var5 ))(not (add_value_homefromfreecell_var4_var5 )))
   :effect (and (when (pre_value_homefromfreecell_var4_var5 )(del_value_homefromfreecell_var4_var5 ))(when (not (pre_value_homefromfreecell_var4_var5 ))(add_value_homefromfreecell_var4_var5 ))))

 (:action program_pre_value_homefromfreecell_var4_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_homefromfreecell_var4_var6 ))(not (del_value_homefromfreecell_var4_var6 ))(not (add_value_homefromfreecell_var4_var6 )))
   :effect (and (pre_value_homefromfreecell_var4_var6 )))

 (:action program_eff_value_homefromfreecell_var4_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_value_homefromfreecell_var4_var6 ))(not (add_value_homefromfreecell_var4_var6 )))
   :effect (and (when (pre_value_homefromfreecell_var4_var6 )(del_value_homefromfreecell_var4_var6 ))(when (not (pre_value_homefromfreecell_var4_var6 ))(add_value_homefromfreecell_var4_var6 ))))

 (:action program_pre_value_homefromfreecell_var4_var7
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_homefromfreecell_var4_var7 ))(not (del_value_homefromfreecell_var4_var7 ))(not (add_value_homefromfreecell_var4_var7 )))
   :effect (and (pre_value_homefromfreecell_var4_var7 )))

 (:action program_eff_value_homefromfreecell_var4_var7
   :parameters ()
   :precondition (and (modeProg )(not (del_value_homefromfreecell_var4_var7 ))(not (add_value_homefromfreecell_var4_var7 )))
   :effect (and (when (pre_value_homefromfreecell_var4_var7 )(del_value_homefromfreecell_var4_var7 ))(when (not (pre_value_homefromfreecell_var4_var7 ))(add_value_homefromfreecell_var4_var7 ))))

 (:action program_pre_successor_homefromfreecell_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_homefromfreecell_var3_var3 ))(not (del_successor_homefromfreecell_var3_var3 ))(not (add_successor_homefromfreecell_var3_var3 )))
   :effect (and (pre_successor_homefromfreecell_var3_var3 )))

 (:action program_eff_successor_homefromfreecell_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_homefromfreecell_var3_var3 ))(not (add_successor_homefromfreecell_var3_var3 )))
   :effect (and (when (pre_successor_homefromfreecell_var3_var3 )(del_successor_homefromfreecell_var3_var3 ))(when (not (pre_successor_homefromfreecell_var3_var3 ))(add_successor_homefromfreecell_var3_var3 ))))

 (:action program_pre_successor_homefromfreecell_var3_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_homefromfreecell_var3_var5 ))(not (del_successor_homefromfreecell_var3_var5 ))(not (add_successor_homefromfreecell_var3_var5 )))
   :effect (and (pre_successor_homefromfreecell_var3_var5 )))

 (:action program_eff_successor_homefromfreecell_var3_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_homefromfreecell_var3_var5 ))(not (add_successor_homefromfreecell_var3_var5 )))
   :effect (and (when (pre_successor_homefromfreecell_var3_var5 )(del_successor_homefromfreecell_var3_var5 ))(when (not (pre_successor_homefromfreecell_var3_var5 ))(add_successor_homefromfreecell_var3_var5 ))))

 (:action program_pre_successor_homefromfreecell_var3_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_homefromfreecell_var3_var6 ))(not (del_successor_homefromfreecell_var3_var6 ))(not (add_successor_homefromfreecell_var3_var6 )))
   :effect (and (pre_successor_homefromfreecell_var3_var6 )))

 (:action program_eff_successor_homefromfreecell_var3_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_homefromfreecell_var3_var6 ))(not (add_successor_homefromfreecell_var3_var6 )))
   :effect (and (when (pre_successor_homefromfreecell_var3_var6 )(del_successor_homefromfreecell_var3_var6 ))(when (not (pre_successor_homefromfreecell_var3_var6 ))(add_successor_homefromfreecell_var3_var6 ))))

 (:action program_pre_successor_homefromfreecell_var3_var7
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_homefromfreecell_var3_var7 ))(not (del_successor_homefromfreecell_var3_var7 ))(not (add_successor_homefromfreecell_var3_var7 )))
   :effect (and (pre_successor_homefromfreecell_var3_var7 )))

 (:action program_eff_successor_homefromfreecell_var3_var7
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_homefromfreecell_var3_var7 ))(not (add_successor_homefromfreecell_var3_var7 )))
   :effect (and (when (pre_successor_homefromfreecell_var3_var7 )(del_successor_homefromfreecell_var3_var7 ))(when (not (pre_successor_homefromfreecell_var3_var7 ))(add_successor_homefromfreecell_var3_var7 ))))

 (:action program_pre_successor_homefromfreecell_var5_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_homefromfreecell_var5_var3 ))(not (del_successor_homefromfreecell_var5_var3 ))(not (add_successor_homefromfreecell_var5_var3 )))
   :effect (and (pre_successor_homefromfreecell_var5_var3 )))

 (:action program_eff_successor_homefromfreecell_var5_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_homefromfreecell_var5_var3 ))(not (add_successor_homefromfreecell_var5_var3 )))
   :effect (and (when (pre_successor_homefromfreecell_var5_var3 )(del_successor_homefromfreecell_var5_var3 ))(when (not (pre_successor_homefromfreecell_var5_var3 ))(add_successor_homefromfreecell_var5_var3 ))))

 (:action program_pre_successor_homefromfreecell_var5_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_homefromfreecell_var5_var5 ))(not (del_successor_homefromfreecell_var5_var5 ))(not (add_successor_homefromfreecell_var5_var5 )))
   :effect (and (pre_successor_homefromfreecell_var5_var5 )))

 (:action program_eff_successor_homefromfreecell_var5_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_homefromfreecell_var5_var5 ))(not (add_successor_homefromfreecell_var5_var5 )))
   :effect (and (when (pre_successor_homefromfreecell_var5_var5 )(del_successor_homefromfreecell_var5_var5 ))(when (not (pre_successor_homefromfreecell_var5_var5 ))(add_successor_homefromfreecell_var5_var5 ))))

 (:action program_pre_successor_homefromfreecell_var5_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_homefromfreecell_var5_var6 ))(not (del_successor_homefromfreecell_var5_var6 ))(not (add_successor_homefromfreecell_var5_var6 )))
   :effect (and (pre_successor_homefromfreecell_var5_var6 )))

 (:action program_eff_successor_homefromfreecell_var5_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_homefromfreecell_var5_var6 ))(not (add_successor_homefromfreecell_var5_var6 )))
   :effect (and (when (pre_successor_homefromfreecell_var5_var6 )(del_successor_homefromfreecell_var5_var6 ))(when (not (pre_successor_homefromfreecell_var5_var6 ))(add_successor_homefromfreecell_var5_var6 ))))

 (:action program_pre_successor_homefromfreecell_var5_var7
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_homefromfreecell_var5_var7 ))(not (del_successor_homefromfreecell_var5_var7 ))(not (add_successor_homefromfreecell_var5_var7 )))
   :effect (and (pre_successor_homefromfreecell_var5_var7 )))

 (:action program_eff_successor_homefromfreecell_var5_var7
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_homefromfreecell_var5_var7 ))(not (add_successor_homefromfreecell_var5_var7 )))
   :effect (and (when (pre_successor_homefromfreecell_var5_var7 )(del_successor_homefromfreecell_var5_var7 ))(when (not (pre_successor_homefromfreecell_var5_var7 ))(add_successor_homefromfreecell_var5_var7 ))))

 (:action program_pre_successor_homefromfreecell_var6_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_homefromfreecell_var6_var3 ))(not (del_successor_homefromfreecell_var6_var3 ))(not (add_successor_homefromfreecell_var6_var3 )))
   :effect (and (pre_successor_homefromfreecell_var6_var3 )))

 (:action program_eff_successor_homefromfreecell_var6_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_homefromfreecell_var6_var3 ))(not (add_successor_homefromfreecell_var6_var3 )))
   :effect (and (when (pre_successor_homefromfreecell_var6_var3 )(del_successor_homefromfreecell_var6_var3 ))(when (not (pre_successor_homefromfreecell_var6_var3 ))(add_successor_homefromfreecell_var6_var3 ))))

 (:action program_pre_successor_homefromfreecell_var6_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_homefromfreecell_var6_var5 ))(not (del_successor_homefromfreecell_var6_var5 ))(not (add_successor_homefromfreecell_var6_var5 )))
   :effect (and (pre_successor_homefromfreecell_var6_var5 )))

 (:action program_eff_successor_homefromfreecell_var6_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_homefromfreecell_var6_var5 ))(not (add_successor_homefromfreecell_var6_var5 )))
   :effect (and (when (pre_successor_homefromfreecell_var6_var5 )(del_successor_homefromfreecell_var6_var5 ))(when (not (pre_successor_homefromfreecell_var6_var5 ))(add_successor_homefromfreecell_var6_var5 ))))

 (:action program_pre_successor_homefromfreecell_var6_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_homefromfreecell_var6_var6 ))(not (del_successor_homefromfreecell_var6_var6 ))(not (add_successor_homefromfreecell_var6_var6 )))
   :effect (and (pre_successor_homefromfreecell_var6_var6 )))

 (:action program_eff_successor_homefromfreecell_var6_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_homefromfreecell_var6_var6 ))(not (add_successor_homefromfreecell_var6_var6 )))
   :effect (and (when (pre_successor_homefromfreecell_var6_var6 )(del_successor_homefromfreecell_var6_var6 ))(when (not (pre_successor_homefromfreecell_var6_var6 ))(add_successor_homefromfreecell_var6_var6 ))))

 (:action program_pre_successor_homefromfreecell_var6_var7
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_homefromfreecell_var6_var7 ))(not (del_successor_homefromfreecell_var6_var7 ))(not (add_successor_homefromfreecell_var6_var7 )))
   :effect (and (pre_successor_homefromfreecell_var6_var7 )))

 (:action program_eff_successor_homefromfreecell_var6_var7
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_homefromfreecell_var6_var7 ))(not (add_successor_homefromfreecell_var6_var7 )))
   :effect (and (when (pre_successor_homefromfreecell_var6_var7 )(del_successor_homefromfreecell_var6_var7 ))(when (not (pre_successor_homefromfreecell_var6_var7 ))(add_successor_homefromfreecell_var6_var7 ))))

 (:action program_pre_successor_homefromfreecell_var7_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_homefromfreecell_var7_var3 ))(not (del_successor_homefromfreecell_var7_var3 ))(not (add_successor_homefromfreecell_var7_var3 )))
   :effect (and (pre_successor_homefromfreecell_var7_var3 )))

 (:action program_eff_successor_homefromfreecell_var7_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_homefromfreecell_var7_var3 ))(not (add_successor_homefromfreecell_var7_var3 )))
   :effect (and (when (pre_successor_homefromfreecell_var7_var3 )(del_successor_homefromfreecell_var7_var3 ))(when (not (pre_successor_homefromfreecell_var7_var3 ))(add_successor_homefromfreecell_var7_var3 ))))

 (:action program_pre_successor_homefromfreecell_var7_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_homefromfreecell_var7_var5 ))(not (del_successor_homefromfreecell_var7_var5 ))(not (add_successor_homefromfreecell_var7_var5 )))
   :effect (and (pre_successor_homefromfreecell_var7_var5 )))

 (:action program_eff_successor_homefromfreecell_var7_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_homefromfreecell_var7_var5 ))(not (add_successor_homefromfreecell_var7_var5 )))
   :effect (and (when (pre_successor_homefromfreecell_var7_var5 )(del_successor_homefromfreecell_var7_var5 ))(when (not (pre_successor_homefromfreecell_var7_var5 ))(add_successor_homefromfreecell_var7_var5 ))))

 (:action program_pre_successor_homefromfreecell_var7_var6
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_homefromfreecell_var7_var6 ))(not (del_successor_homefromfreecell_var7_var6 ))(not (add_successor_homefromfreecell_var7_var6 )))
   :effect (and (pre_successor_homefromfreecell_var7_var6 )))

 (:action program_eff_successor_homefromfreecell_var7_var6
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_homefromfreecell_var7_var6 ))(not (add_successor_homefromfreecell_var7_var6 )))
   :effect (and (when (pre_successor_homefromfreecell_var7_var6 )(del_successor_homefromfreecell_var7_var6 ))(when (not (pre_successor_homefromfreecell_var7_var6 ))(add_successor_homefromfreecell_var7_var6 ))))

 (:action program_pre_successor_homefromfreecell_var7_var7
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_homefromfreecell_var7_var7 ))(not (del_successor_homefromfreecell_var7_var7 ))(not (add_successor_homefromfreecell_var7_var7 )))
   :effect (and (pre_successor_homefromfreecell_var7_var7 )))

 (:action program_eff_successor_homefromfreecell_var7_var7
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_homefromfreecell_var7_var7 ))(not (add_successor_homefromfreecell_var7_var7 )))
   :effect (and (when (pre_successor_homefromfreecell_var7_var7 )(del_successor_homefromfreecell_var7_var7 ))(when (not (pre_successor_homefromfreecell_var7_var7 ))(add_successor_homefromfreecell_var7_var7 ))))

 (:action program_pre_on_colfromfreecell_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_colfromfreecell_var1_var1 ))(not (del_on_colfromfreecell_var1_var1 ))(not (add_on_colfromfreecell_var1_var1 )))
   :effect (and (pre_on_colfromfreecell_var1_var1 )))

 (:action program_eff_on_colfromfreecell_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_colfromfreecell_var1_var1 ))(not (add_on_colfromfreecell_var1_var1 )))
   :effect (and (when (pre_on_colfromfreecell_var1_var1 )(del_on_colfromfreecell_var1_var1 ))(when (not (pre_on_colfromfreecell_var1_var1 ))(add_on_colfromfreecell_var1_var1 ))))

 (:action program_pre_on_colfromfreecell_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_colfromfreecell_var1_var2 ))(not (del_on_colfromfreecell_var1_var2 ))(not (add_on_colfromfreecell_var1_var2 )))
   :effect (and (pre_on_colfromfreecell_var1_var2 )))

 (:action program_eff_on_colfromfreecell_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_on_colfromfreecell_var1_var2 ))(not (add_on_colfromfreecell_var1_var2 )))
   :effect (and (when (pre_on_colfromfreecell_var1_var2 )(del_on_colfromfreecell_var1_var2 ))(when (not (pre_on_colfromfreecell_var1_var2 ))(add_on_colfromfreecell_var1_var2 ))))

 (:action program_pre_on_colfromfreecell_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_colfromfreecell_var2_var1 ))(not (del_on_colfromfreecell_var2_var1 ))(not (add_on_colfromfreecell_var2_var1 )))
   :effect (and (pre_on_colfromfreecell_var2_var1 )))

 (:action program_eff_on_colfromfreecell_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_colfromfreecell_var2_var1 ))(not (add_on_colfromfreecell_var2_var1 )))
   :effect (and (when (pre_on_colfromfreecell_var2_var1 )(del_on_colfromfreecell_var2_var1 ))(when (not (pre_on_colfromfreecell_var2_var1 ))(add_on_colfromfreecell_var2_var1 ))))

 (:action program_pre_on_colfromfreecell_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_colfromfreecell_var2_var2 ))(not (del_on_colfromfreecell_var2_var2 ))(not (add_on_colfromfreecell_var2_var2 )))
   :effect (and (pre_on_colfromfreecell_var2_var2 )))

 (:action program_eff_on_colfromfreecell_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_on_colfromfreecell_var2_var2 ))(not (add_on_colfromfreecell_var2_var2 )))
   :effect (and (when (pre_on_colfromfreecell_var2_var2 )(del_on_colfromfreecell_var2_var2 ))(when (not (pre_on_colfromfreecell_var2_var2 ))(add_on_colfromfreecell_var2_var2 ))))

 (:action program_pre_incell_colfromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_colfromfreecell_var1 ))(not (del_incell_colfromfreecell_var1 ))(not (add_incell_colfromfreecell_var1 )))
   :effect (and (pre_incell_colfromfreecell_var1 )))

 (:action program_eff_incell_colfromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_colfromfreecell_var1 ))(not (add_incell_colfromfreecell_var1 )))
   :effect (and (when (pre_incell_colfromfreecell_var1 )(del_incell_colfromfreecell_var1 ))(when (not (pre_incell_colfromfreecell_var1 ))(add_incell_colfromfreecell_var1 ))))

 (:action program_pre_incell_colfromfreecell_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_colfromfreecell_var2 ))(not (del_incell_colfromfreecell_var2 ))(not (add_incell_colfromfreecell_var2 )))
   :effect (and (pre_incell_colfromfreecell_var2 )))

 (:action program_eff_incell_colfromfreecell_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_colfromfreecell_var2 ))(not (add_incell_colfromfreecell_var2 )))
   :effect (and (when (pre_incell_colfromfreecell_var2 )(del_incell_colfromfreecell_var2 ))(when (not (pre_incell_colfromfreecell_var2 ))(add_incell_colfromfreecell_var2 ))))

 (:action program_pre_clear_colfromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_colfromfreecell_var1 ))(not (del_clear_colfromfreecell_var1 ))(not (add_clear_colfromfreecell_var1 )))
   :effect (and (pre_clear_colfromfreecell_var1 )))

 (:action program_eff_clear_colfromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_colfromfreecell_var1 ))(not (add_clear_colfromfreecell_var1 )))
   :effect (and (when (pre_clear_colfromfreecell_var1 )(del_clear_colfromfreecell_var1 ))(when (not (pre_clear_colfromfreecell_var1 ))(add_clear_colfromfreecell_var1 ))))

 (:action program_pre_clear_colfromfreecell_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_colfromfreecell_var2 ))(not (del_clear_colfromfreecell_var2 ))(not (add_clear_colfromfreecell_var2 )))
   :effect (and (pre_clear_colfromfreecell_var2 )))

 (:action program_eff_clear_colfromfreecell_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_colfromfreecell_var2 ))(not (add_clear_colfromfreecell_var2 )))
   :effect (and (when (pre_clear_colfromfreecell_var2 )(del_clear_colfromfreecell_var2 ))(when (not (pre_clear_colfromfreecell_var2 ))(add_clear_colfromfreecell_var2 ))))

 (:action program_pre_cellspace_colfromfreecell_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_colfromfreecell_var3 ))(not (del_cellspace_colfromfreecell_var3 ))(not (add_cellspace_colfromfreecell_var3 )))
   :effect (and (pre_cellspace_colfromfreecell_var3 )))

 (:action program_eff_cellspace_colfromfreecell_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_colfromfreecell_var3 ))(not (add_cellspace_colfromfreecell_var3 )))
   :effect (and (when (pre_cellspace_colfromfreecell_var3 )(del_cellspace_colfromfreecell_var3 ))(when (not (pre_cellspace_colfromfreecell_var3 ))(add_cellspace_colfromfreecell_var3 ))))

 (:action program_pre_cellspace_colfromfreecell_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_colfromfreecell_var4 ))(not (del_cellspace_colfromfreecell_var4 ))(not (add_cellspace_colfromfreecell_var4 )))
   :effect (and (pre_cellspace_colfromfreecell_var4 )))

 (:action program_eff_cellspace_colfromfreecell_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_colfromfreecell_var4 ))(not (add_cellspace_colfromfreecell_var4 )))
   :effect (and (when (pre_cellspace_colfromfreecell_var4 )(del_cellspace_colfromfreecell_var4 ))(when (not (pre_cellspace_colfromfreecell_var4 ))(add_cellspace_colfromfreecell_var4 ))))

 (:action program_pre_colspace_colfromfreecell_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_colfromfreecell_var3 ))(not (del_colspace_colfromfreecell_var3 ))(not (add_colspace_colfromfreecell_var3 )))
   :effect (and (pre_colspace_colfromfreecell_var3 )))

 (:action program_eff_colspace_colfromfreecell_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_colfromfreecell_var3 ))(not (add_colspace_colfromfreecell_var3 )))
   :effect (and (when (pre_colspace_colfromfreecell_var3 )(del_colspace_colfromfreecell_var3 ))(when (not (pre_colspace_colfromfreecell_var3 ))(add_colspace_colfromfreecell_var3 ))))

 (:action program_pre_colspace_colfromfreecell_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_colfromfreecell_var4 ))(not (del_colspace_colfromfreecell_var4 ))(not (add_colspace_colfromfreecell_var4 )))
   :effect (and (pre_colspace_colfromfreecell_var4 )))

 (:action program_eff_colspace_colfromfreecell_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_colfromfreecell_var4 ))(not (add_colspace_colfromfreecell_var4 )))
   :effect (and (when (pre_colspace_colfromfreecell_var4 )(del_colspace_colfromfreecell_var4 ))(when (not (pre_colspace_colfromfreecell_var4 ))(add_colspace_colfromfreecell_var4 ))))

 (:action program_pre_home_colfromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_colfromfreecell_var1 ))(not (del_home_colfromfreecell_var1 ))(not (add_home_colfromfreecell_var1 )))
   :effect (and (pre_home_colfromfreecell_var1 )))

 (:action program_eff_home_colfromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_home_colfromfreecell_var1 ))(not (add_home_colfromfreecell_var1 )))
   :effect (and (when (pre_home_colfromfreecell_var1 )(del_home_colfromfreecell_var1 ))(when (not (pre_home_colfromfreecell_var1 ))(add_home_colfromfreecell_var1 ))))

 (:action program_pre_home_colfromfreecell_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_colfromfreecell_var2 ))(not (del_home_colfromfreecell_var2 ))(not (add_home_colfromfreecell_var2 )))
   :effect (and (pre_home_colfromfreecell_var2 )))

 (:action program_eff_home_colfromfreecell_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_home_colfromfreecell_var2 ))(not (add_home_colfromfreecell_var2 )))
   :effect (and (when (pre_home_colfromfreecell_var2 )(del_home_colfromfreecell_var2 ))(when (not (pre_home_colfromfreecell_var2 ))(add_home_colfromfreecell_var2 ))))

 (:action program_pre_bottomcol_colfromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_colfromfreecell_var1 ))(not (del_bottomcol_colfromfreecell_var1 ))(not (add_bottomcol_colfromfreecell_var1 )))
   :effect (and (pre_bottomcol_colfromfreecell_var1 )))

 (:action program_eff_bottomcol_colfromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_colfromfreecell_var1 ))(not (add_bottomcol_colfromfreecell_var1 )))
   :effect (and (when (pre_bottomcol_colfromfreecell_var1 )(del_bottomcol_colfromfreecell_var1 ))(when (not (pre_bottomcol_colfromfreecell_var1 ))(add_bottomcol_colfromfreecell_var1 ))))

 (:action program_pre_bottomcol_colfromfreecell_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_colfromfreecell_var2 ))(not (del_bottomcol_colfromfreecell_var2 ))(not (add_bottomcol_colfromfreecell_var2 )))
   :effect (and (pre_bottomcol_colfromfreecell_var2 )))

 (:action program_eff_bottomcol_colfromfreecell_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_colfromfreecell_var2 ))(not (add_bottomcol_colfromfreecell_var2 )))
   :effect (and (when (pre_bottomcol_colfromfreecell_var2 )(del_bottomcol_colfromfreecell_var2 ))(when (not (pre_bottomcol_colfromfreecell_var2 ))(add_bottomcol_colfromfreecell_var2 ))))

 (:action program_pre_canstack_colfromfreecell_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_colfromfreecell_var1_var1 ))(not (del_canstack_colfromfreecell_var1_var1 ))(not (add_canstack_colfromfreecell_var1_var1 )))
   :effect (and (pre_canstack_colfromfreecell_var1_var1 )))

 (:action program_eff_canstack_colfromfreecell_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_colfromfreecell_var1_var1 ))(not (add_canstack_colfromfreecell_var1_var1 )))
   :effect (and (when (pre_canstack_colfromfreecell_var1_var1 )(del_canstack_colfromfreecell_var1_var1 ))(when (not (pre_canstack_colfromfreecell_var1_var1 ))(add_canstack_colfromfreecell_var1_var1 ))))

 (:action program_pre_canstack_colfromfreecell_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_colfromfreecell_var1_var2 ))(not (del_canstack_colfromfreecell_var1_var2 ))(not (add_canstack_colfromfreecell_var1_var2 )))
   :effect (and (pre_canstack_colfromfreecell_var1_var2 )))

 (:action program_eff_canstack_colfromfreecell_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_colfromfreecell_var1_var2 ))(not (add_canstack_colfromfreecell_var1_var2 )))
   :effect (and (when (pre_canstack_colfromfreecell_var1_var2 )(del_canstack_colfromfreecell_var1_var2 ))(when (not (pre_canstack_colfromfreecell_var1_var2 ))(add_canstack_colfromfreecell_var1_var2 ))))

 (:action program_pre_canstack_colfromfreecell_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_colfromfreecell_var2_var1 ))(not (del_canstack_colfromfreecell_var2_var1 ))(not (add_canstack_colfromfreecell_var2_var1 )))
   :effect (and (pre_canstack_colfromfreecell_var2_var1 )))

 (:action program_eff_canstack_colfromfreecell_var2_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_colfromfreecell_var2_var1 ))(not (add_canstack_colfromfreecell_var2_var1 )))
   :effect (and (when (pre_canstack_colfromfreecell_var2_var1 )(del_canstack_colfromfreecell_var2_var1 ))(when (not (pre_canstack_colfromfreecell_var2_var1 ))(add_canstack_colfromfreecell_var2_var1 ))))

 (:action program_pre_canstack_colfromfreecell_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_colfromfreecell_var2_var2 ))(not (del_canstack_colfromfreecell_var2_var2 ))(not (add_canstack_colfromfreecell_var2_var2 )))
   :effect (and (pre_canstack_colfromfreecell_var2_var2 )))

 (:action program_eff_canstack_colfromfreecell_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_colfromfreecell_var2_var2 ))(not (add_canstack_colfromfreecell_var2_var2 )))
   :effect (and (when (pre_canstack_colfromfreecell_var2_var2 )(del_canstack_colfromfreecell_var2_var2 ))(when (not (pre_canstack_colfromfreecell_var2_var2 ))(add_canstack_colfromfreecell_var2_var2 ))))

 (:action program_pre_value_colfromfreecell_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_colfromfreecell_var1_var3 ))(not (del_value_colfromfreecell_var1_var3 ))(not (add_value_colfromfreecell_var1_var3 )))
   :effect (and (pre_value_colfromfreecell_var1_var3 )))

 (:action program_eff_value_colfromfreecell_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_value_colfromfreecell_var1_var3 ))(not (add_value_colfromfreecell_var1_var3 )))
   :effect (and (when (pre_value_colfromfreecell_var1_var3 )(del_value_colfromfreecell_var1_var3 ))(when (not (pre_value_colfromfreecell_var1_var3 ))(add_value_colfromfreecell_var1_var3 ))))

 (:action program_pre_value_colfromfreecell_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_colfromfreecell_var1_var4 ))(not (del_value_colfromfreecell_var1_var4 ))(not (add_value_colfromfreecell_var1_var4 )))
   :effect (and (pre_value_colfromfreecell_var1_var4 )))

 (:action program_eff_value_colfromfreecell_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_value_colfromfreecell_var1_var4 ))(not (add_value_colfromfreecell_var1_var4 )))
   :effect (and (when (pre_value_colfromfreecell_var1_var4 )(del_value_colfromfreecell_var1_var4 ))(when (not (pre_value_colfromfreecell_var1_var4 ))(add_value_colfromfreecell_var1_var4 ))))

 (:action program_pre_value_colfromfreecell_var2_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_colfromfreecell_var2_var3 ))(not (del_value_colfromfreecell_var2_var3 ))(not (add_value_colfromfreecell_var2_var3 )))
   :effect (and (pre_value_colfromfreecell_var2_var3 )))

 (:action program_eff_value_colfromfreecell_var2_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_value_colfromfreecell_var2_var3 ))(not (add_value_colfromfreecell_var2_var3 )))
   :effect (and (when (pre_value_colfromfreecell_var2_var3 )(del_value_colfromfreecell_var2_var3 ))(when (not (pre_value_colfromfreecell_var2_var3 ))(add_value_colfromfreecell_var2_var3 ))))

 (:action program_pre_value_colfromfreecell_var2_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_colfromfreecell_var2_var4 ))(not (del_value_colfromfreecell_var2_var4 ))(not (add_value_colfromfreecell_var2_var4 )))
   :effect (and (pre_value_colfromfreecell_var2_var4 )))

 (:action program_eff_value_colfromfreecell_var2_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_value_colfromfreecell_var2_var4 ))(not (add_value_colfromfreecell_var2_var4 )))
   :effect (and (when (pre_value_colfromfreecell_var2_var4 )(del_value_colfromfreecell_var2_var4 ))(when (not (pre_value_colfromfreecell_var2_var4 ))(add_value_colfromfreecell_var2_var4 ))))

 (:action program_pre_successor_colfromfreecell_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_colfromfreecell_var3_var3 ))(not (del_successor_colfromfreecell_var3_var3 ))(not (add_successor_colfromfreecell_var3_var3 )))
   :effect (and (pre_successor_colfromfreecell_var3_var3 )))

 (:action program_eff_successor_colfromfreecell_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_colfromfreecell_var3_var3 ))(not (add_successor_colfromfreecell_var3_var3 )))
   :effect (and (when (pre_successor_colfromfreecell_var3_var3 )(del_successor_colfromfreecell_var3_var3 ))(when (not (pre_successor_colfromfreecell_var3_var3 ))(add_successor_colfromfreecell_var3_var3 ))))

 (:action program_pre_successor_colfromfreecell_var3_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_colfromfreecell_var3_var4 ))(not (del_successor_colfromfreecell_var3_var4 ))(not (add_successor_colfromfreecell_var3_var4 )))
   :effect (and (pre_successor_colfromfreecell_var3_var4 )))

 (:action program_eff_successor_colfromfreecell_var3_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_colfromfreecell_var3_var4 ))(not (add_successor_colfromfreecell_var3_var4 )))
   :effect (and (when (pre_successor_colfromfreecell_var3_var4 )(del_successor_colfromfreecell_var3_var4 ))(when (not (pre_successor_colfromfreecell_var3_var4 ))(add_successor_colfromfreecell_var3_var4 ))))

 (:action program_pre_successor_colfromfreecell_var4_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_colfromfreecell_var4_var3 ))(not (del_successor_colfromfreecell_var4_var3 ))(not (add_successor_colfromfreecell_var4_var3 )))
   :effect (and (pre_successor_colfromfreecell_var4_var3 )))

 (:action program_eff_successor_colfromfreecell_var4_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_colfromfreecell_var4_var3 ))(not (add_successor_colfromfreecell_var4_var3 )))
   :effect (and (when (pre_successor_colfromfreecell_var4_var3 )(del_successor_colfromfreecell_var4_var3 ))(when (not (pre_successor_colfromfreecell_var4_var3 ))(add_successor_colfromfreecell_var4_var3 ))))

 (:action program_pre_successor_colfromfreecell_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_colfromfreecell_var4_var4 ))(not (del_successor_colfromfreecell_var4_var4 ))(not (add_successor_colfromfreecell_var4_var4 )))
   :effect (and (pre_successor_colfromfreecell_var4_var4 )))

 (:action program_eff_successor_colfromfreecell_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_colfromfreecell_var4_var4 ))(not (add_successor_colfromfreecell_var4_var4 )))
   :effect (and (when (pre_successor_colfromfreecell_var4_var4 )(del_successor_colfromfreecell_var4_var4 ))(when (not (pre_successor_colfromfreecell_var4_var4 ))(add_successor_colfromfreecell_var4_var4 ))))

 (:action program_pre_on_newcolfromfreecell_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_on_newcolfromfreecell_var1_var1 ))(not (del_on_newcolfromfreecell_var1_var1 ))(not (add_on_newcolfromfreecell_var1_var1 )))
   :effect (and (pre_on_newcolfromfreecell_var1_var1 )))

 (:action program_eff_on_newcolfromfreecell_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_on_newcolfromfreecell_var1_var1 ))(not (add_on_newcolfromfreecell_var1_var1 )))
   :effect (and (when (pre_on_newcolfromfreecell_var1_var1 )(del_on_newcolfromfreecell_var1_var1 ))(when (not (pre_on_newcolfromfreecell_var1_var1 ))(add_on_newcolfromfreecell_var1_var1 ))))

 (:action program_pre_incell_newcolfromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_incell_newcolfromfreecell_var1 ))(not (del_incell_newcolfromfreecell_var1 ))(not (add_incell_newcolfromfreecell_var1 )))
   :effect (and (pre_incell_newcolfromfreecell_var1 )))

 (:action program_eff_incell_newcolfromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_incell_newcolfromfreecell_var1 ))(not (add_incell_newcolfromfreecell_var1 )))
   :effect (and (when (pre_incell_newcolfromfreecell_var1 )(del_incell_newcolfromfreecell_var1 ))(when (not (pre_incell_newcolfromfreecell_var1 ))(add_incell_newcolfromfreecell_var1 ))))

 (:action program_pre_clear_newcolfromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_clear_newcolfromfreecell_var1 ))(not (del_clear_newcolfromfreecell_var1 ))(not (add_clear_newcolfromfreecell_var1 )))
   :effect (and (pre_clear_newcolfromfreecell_var1 )))

 (:action program_eff_clear_newcolfromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_clear_newcolfromfreecell_var1 ))(not (add_clear_newcolfromfreecell_var1 )))
   :effect (and (when (pre_clear_newcolfromfreecell_var1 )(del_clear_newcolfromfreecell_var1 ))(when (not (pre_clear_newcolfromfreecell_var1 ))(add_clear_newcolfromfreecell_var1 ))))

 (:action program_pre_cellspace_newcolfromfreecell_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_newcolfromfreecell_var2 ))(not (del_cellspace_newcolfromfreecell_var2 ))(not (add_cellspace_newcolfromfreecell_var2 )))
   :effect (and (pre_cellspace_newcolfromfreecell_var2 )))

 (:action program_eff_cellspace_newcolfromfreecell_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_newcolfromfreecell_var2 ))(not (add_cellspace_newcolfromfreecell_var2 )))
   :effect (and (when (pre_cellspace_newcolfromfreecell_var2 )(del_cellspace_newcolfromfreecell_var2 ))(when (not (pre_cellspace_newcolfromfreecell_var2 ))(add_cellspace_newcolfromfreecell_var2 ))))

 (:action program_pre_cellspace_newcolfromfreecell_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_newcolfromfreecell_var3 ))(not (del_cellspace_newcolfromfreecell_var3 ))(not (add_cellspace_newcolfromfreecell_var3 )))
   :effect (and (pre_cellspace_newcolfromfreecell_var3 )))

 (:action program_eff_cellspace_newcolfromfreecell_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_newcolfromfreecell_var3 ))(not (add_cellspace_newcolfromfreecell_var3 )))
   :effect (and (when (pre_cellspace_newcolfromfreecell_var3 )(del_cellspace_newcolfromfreecell_var3 ))(when (not (pre_cellspace_newcolfromfreecell_var3 ))(add_cellspace_newcolfromfreecell_var3 ))))

 (:action program_pre_cellspace_newcolfromfreecell_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_newcolfromfreecell_var4 ))(not (del_cellspace_newcolfromfreecell_var4 ))(not (add_cellspace_newcolfromfreecell_var4 )))
   :effect (and (pre_cellspace_newcolfromfreecell_var4 )))

 (:action program_eff_cellspace_newcolfromfreecell_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_newcolfromfreecell_var4 ))(not (add_cellspace_newcolfromfreecell_var4 )))
   :effect (and (when (pre_cellspace_newcolfromfreecell_var4 )(del_cellspace_newcolfromfreecell_var4 ))(when (not (pre_cellspace_newcolfromfreecell_var4 ))(add_cellspace_newcolfromfreecell_var4 ))))

 (:action program_pre_cellspace_newcolfromfreecell_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_cellspace_newcolfromfreecell_var5 ))(not (del_cellspace_newcolfromfreecell_var5 ))(not (add_cellspace_newcolfromfreecell_var5 )))
   :effect (and (pre_cellspace_newcolfromfreecell_var5 )))

 (:action program_eff_cellspace_newcolfromfreecell_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_cellspace_newcolfromfreecell_var5 ))(not (add_cellspace_newcolfromfreecell_var5 )))
   :effect (and (when (pre_cellspace_newcolfromfreecell_var5 )(del_cellspace_newcolfromfreecell_var5 ))(when (not (pre_cellspace_newcolfromfreecell_var5 ))(add_cellspace_newcolfromfreecell_var5 ))))

 (:action program_pre_colspace_newcolfromfreecell_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_newcolfromfreecell_var2 ))(not (del_colspace_newcolfromfreecell_var2 ))(not (add_colspace_newcolfromfreecell_var2 )))
   :effect (and (pre_colspace_newcolfromfreecell_var2 )))

 (:action program_eff_colspace_newcolfromfreecell_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_newcolfromfreecell_var2 ))(not (add_colspace_newcolfromfreecell_var2 )))
   :effect (and (when (pre_colspace_newcolfromfreecell_var2 )(del_colspace_newcolfromfreecell_var2 ))(when (not (pre_colspace_newcolfromfreecell_var2 ))(add_colspace_newcolfromfreecell_var2 ))))

 (:action program_pre_colspace_newcolfromfreecell_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_newcolfromfreecell_var3 ))(not (del_colspace_newcolfromfreecell_var3 ))(not (add_colspace_newcolfromfreecell_var3 )))
   :effect (and (pre_colspace_newcolfromfreecell_var3 )))

 (:action program_eff_colspace_newcolfromfreecell_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_newcolfromfreecell_var3 ))(not (add_colspace_newcolfromfreecell_var3 )))
   :effect (and (when (pre_colspace_newcolfromfreecell_var3 )(del_colspace_newcolfromfreecell_var3 ))(when (not (pre_colspace_newcolfromfreecell_var3 ))(add_colspace_newcolfromfreecell_var3 ))))

 (:action program_pre_colspace_newcolfromfreecell_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_newcolfromfreecell_var4 ))(not (del_colspace_newcolfromfreecell_var4 ))(not (add_colspace_newcolfromfreecell_var4 )))
   :effect (and (pre_colspace_newcolfromfreecell_var4 )))

 (:action program_eff_colspace_newcolfromfreecell_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_newcolfromfreecell_var4 ))(not (add_colspace_newcolfromfreecell_var4 )))
   :effect (and (when (pre_colspace_newcolfromfreecell_var4 )(del_colspace_newcolfromfreecell_var4 ))(when (not (pre_colspace_newcolfromfreecell_var4 ))(add_colspace_newcolfromfreecell_var4 ))))

 (:action program_pre_colspace_newcolfromfreecell_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_colspace_newcolfromfreecell_var5 ))(not (del_colspace_newcolfromfreecell_var5 ))(not (add_colspace_newcolfromfreecell_var5 )))
   :effect (and (pre_colspace_newcolfromfreecell_var5 )))

 (:action program_eff_colspace_newcolfromfreecell_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_colspace_newcolfromfreecell_var5 ))(not (add_colspace_newcolfromfreecell_var5 )))
   :effect (and (when (pre_colspace_newcolfromfreecell_var5 )(del_colspace_newcolfromfreecell_var5 ))(when (not (pre_colspace_newcolfromfreecell_var5 ))(add_colspace_newcolfromfreecell_var5 ))))

 (:action program_pre_home_newcolfromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_home_newcolfromfreecell_var1 ))(not (del_home_newcolfromfreecell_var1 ))(not (add_home_newcolfromfreecell_var1 )))
   :effect (and (pre_home_newcolfromfreecell_var1 )))

 (:action program_eff_home_newcolfromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_home_newcolfromfreecell_var1 ))(not (add_home_newcolfromfreecell_var1 )))
   :effect (and (when (pre_home_newcolfromfreecell_var1 )(del_home_newcolfromfreecell_var1 ))(when (not (pre_home_newcolfromfreecell_var1 ))(add_home_newcolfromfreecell_var1 ))))

 (:action program_pre_bottomcol_newcolfromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_bottomcol_newcolfromfreecell_var1 ))(not (del_bottomcol_newcolfromfreecell_var1 ))(not (add_bottomcol_newcolfromfreecell_var1 )))
   :effect (and (pre_bottomcol_newcolfromfreecell_var1 )))

 (:action program_eff_bottomcol_newcolfromfreecell_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_bottomcol_newcolfromfreecell_var1 ))(not (add_bottomcol_newcolfromfreecell_var1 )))
   :effect (and (when (pre_bottomcol_newcolfromfreecell_var1 )(del_bottomcol_newcolfromfreecell_var1 ))(when (not (pre_bottomcol_newcolfromfreecell_var1 ))(add_bottomcol_newcolfromfreecell_var1 ))))

 (:action program_pre_canstack_newcolfromfreecell_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (pre_canstack_newcolfromfreecell_var1_var1 ))(not (del_canstack_newcolfromfreecell_var1_var1 ))(not (add_canstack_newcolfromfreecell_var1_var1 )))
   :effect (and (pre_canstack_newcolfromfreecell_var1_var1 )))

 (:action program_eff_canstack_newcolfromfreecell_var1_var1
   :parameters ()
   :precondition (and (modeProg )(not (del_canstack_newcolfromfreecell_var1_var1 ))(not (add_canstack_newcolfromfreecell_var1_var1 )))
   :effect (and (when (pre_canstack_newcolfromfreecell_var1_var1 )(del_canstack_newcolfromfreecell_var1_var1 ))(when (not (pre_canstack_newcolfromfreecell_var1_var1 ))(add_canstack_newcolfromfreecell_var1_var1 ))))

 (:action program_pre_value_newcolfromfreecell_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_newcolfromfreecell_var1_var2 ))(not (del_value_newcolfromfreecell_var1_var2 ))(not (add_value_newcolfromfreecell_var1_var2 )))
   :effect (and (pre_value_newcolfromfreecell_var1_var2 )))

 (:action program_eff_value_newcolfromfreecell_var1_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_value_newcolfromfreecell_var1_var2 ))(not (add_value_newcolfromfreecell_var1_var2 )))
   :effect (and (when (pre_value_newcolfromfreecell_var1_var2 )(del_value_newcolfromfreecell_var1_var2 ))(when (not (pre_value_newcolfromfreecell_var1_var2 ))(add_value_newcolfromfreecell_var1_var2 ))))

 (:action program_pre_value_newcolfromfreecell_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_newcolfromfreecell_var1_var3 ))(not (del_value_newcolfromfreecell_var1_var3 ))(not (add_value_newcolfromfreecell_var1_var3 )))
   :effect (and (pre_value_newcolfromfreecell_var1_var3 )))

 (:action program_eff_value_newcolfromfreecell_var1_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_value_newcolfromfreecell_var1_var3 ))(not (add_value_newcolfromfreecell_var1_var3 )))
   :effect (and (when (pre_value_newcolfromfreecell_var1_var3 )(del_value_newcolfromfreecell_var1_var3 ))(when (not (pre_value_newcolfromfreecell_var1_var3 ))(add_value_newcolfromfreecell_var1_var3 ))))

 (:action program_pre_value_newcolfromfreecell_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_newcolfromfreecell_var1_var4 ))(not (del_value_newcolfromfreecell_var1_var4 ))(not (add_value_newcolfromfreecell_var1_var4 )))
   :effect (and (pre_value_newcolfromfreecell_var1_var4 )))

 (:action program_eff_value_newcolfromfreecell_var1_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_value_newcolfromfreecell_var1_var4 ))(not (add_value_newcolfromfreecell_var1_var4 )))
   :effect (and (when (pre_value_newcolfromfreecell_var1_var4 )(del_value_newcolfromfreecell_var1_var4 ))(when (not (pre_value_newcolfromfreecell_var1_var4 ))(add_value_newcolfromfreecell_var1_var4 ))))

 (:action program_pre_value_newcolfromfreecell_var1_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_value_newcolfromfreecell_var1_var5 ))(not (del_value_newcolfromfreecell_var1_var5 ))(not (add_value_newcolfromfreecell_var1_var5 )))
   :effect (and (pre_value_newcolfromfreecell_var1_var5 )))

 (:action program_eff_value_newcolfromfreecell_var1_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_value_newcolfromfreecell_var1_var5 ))(not (add_value_newcolfromfreecell_var1_var5 )))
   :effect (and (when (pre_value_newcolfromfreecell_var1_var5 )(del_value_newcolfromfreecell_var1_var5 ))(when (not (pre_value_newcolfromfreecell_var1_var5 ))(add_value_newcolfromfreecell_var1_var5 ))))

 (:action program_pre_successor_newcolfromfreecell_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_newcolfromfreecell_var2_var2 ))(not (del_successor_newcolfromfreecell_var2_var2 ))(not (add_successor_newcolfromfreecell_var2_var2 )))
   :effect (and (pre_successor_newcolfromfreecell_var2_var2 )))

 (:action program_eff_successor_newcolfromfreecell_var2_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_newcolfromfreecell_var2_var2 ))(not (add_successor_newcolfromfreecell_var2_var2 )))
   :effect (and (when (pre_successor_newcolfromfreecell_var2_var2 )(del_successor_newcolfromfreecell_var2_var2 ))(when (not (pre_successor_newcolfromfreecell_var2_var2 ))(add_successor_newcolfromfreecell_var2_var2 ))))

 (:action program_pre_successor_newcolfromfreecell_var2_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_newcolfromfreecell_var2_var3 ))(not (del_successor_newcolfromfreecell_var2_var3 ))(not (add_successor_newcolfromfreecell_var2_var3 )))
   :effect (and (pre_successor_newcolfromfreecell_var2_var3 )))

 (:action program_eff_successor_newcolfromfreecell_var2_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_newcolfromfreecell_var2_var3 ))(not (add_successor_newcolfromfreecell_var2_var3 )))
   :effect (and (when (pre_successor_newcolfromfreecell_var2_var3 )(del_successor_newcolfromfreecell_var2_var3 ))(when (not (pre_successor_newcolfromfreecell_var2_var3 ))(add_successor_newcolfromfreecell_var2_var3 ))))

 (:action program_pre_successor_newcolfromfreecell_var2_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_newcolfromfreecell_var2_var4 ))(not (del_successor_newcolfromfreecell_var2_var4 ))(not (add_successor_newcolfromfreecell_var2_var4 )))
   :effect (and (pre_successor_newcolfromfreecell_var2_var4 )))

 (:action program_eff_successor_newcolfromfreecell_var2_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_newcolfromfreecell_var2_var4 ))(not (add_successor_newcolfromfreecell_var2_var4 )))
   :effect (and (when (pre_successor_newcolfromfreecell_var2_var4 )(del_successor_newcolfromfreecell_var2_var4 ))(when (not (pre_successor_newcolfromfreecell_var2_var4 ))(add_successor_newcolfromfreecell_var2_var4 ))))

 (:action program_pre_successor_newcolfromfreecell_var2_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_newcolfromfreecell_var2_var5 ))(not (del_successor_newcolfromfreecell_var2_var5 ))(not (add_successor_newcolfromfreecell_var2_var5 )))
   :effect (and (pre_successor_newcolfromfreecell_var2_var5 )))

 (:action program_eff_successor_newcolfromfreecell_var2_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_newcolfromfreecell_var2_var5 ))(not (add_successor_newcolfromfreecell_var2_var5 )))
   :effect (and (when (pre_successor_newcolfromfreecell_var2_var5 )(del_successor_newcolfromfreecell_var2_var5 ))(when (not (pre_successor_newcolfromfreecell_var2_var5 ))(add_successor_newcolfromfreecell_var2_var5 ))))

 (:action program_pre_successor_newcolfromfreecell_var3_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_newcolfromfreecell_var3_var2 ))(not (del_successor_newcolfromfreecell_var3_var2 ))(not (add_successor_newcolfromfreecell_var3_var2 )))
   :effect (and (pre_successor_newcolfromfreecell_var3_var2 )))

 (:action program_eff_successor_newcolfromfreecell_var3_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_newcolfromfreecell_var3_var2 ))(not (add_successor_newcolfromfreecell_var3_var2 )))
   :effect (and (when (pre_successor_newcolfromfreecell_var3_var2 )(del_successor_newcolfromfreecell_var3_var2 ))(when (not (pre_successor_newcolfromfreecell_var3_var2 ))(add_successor_newcolfromfreecell_var3_var2 ))))

 (:action program_pre_successor_newcolfromfreecell_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_newcolfromfreecell_var3_var3 ))(not (del_successor_newcolfromfreecell_var3_var3 ))(not (add_successor_newcolfromfreecell_var3_var3 )))
   :effect (and (pre_successor_newcolfromfreecell_var3_var3 )))

 (:action program_eff_successor_newcolfromfreecell_var3_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_newcolfromfreecell_var3_var3 ))(not (add_successor_newcolfromfreecell_var3_var3 )))
   :effect (and (when (pre_successor_newcolfromfreecell_var3_var3 )(del_successor_newcolfromfreecell_var3_var3 ))(when (not (pre_successor_newcolfromfreecell_var3_var3 ))(add_successor_newcolfromfreecell_var3_var3 ))))

 (:action program_pre_successor_newcolfromfreecell_var3_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_newcolfromfreecell_var3_var4 ))(not (del_successor_newcolfromfreecell_var3_var4 ))(not (add_successor_newcolfromfreecell_var3_var4 )))
   :effect (and (pre_successor_newcolfromfreecell_var3_var4 )))

 (:action program_eff_successor_newcolfromfreecell_var3_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_newcolfromfreecell_var3_var4 ))(not (add_successor_newcolfromfreecell_var3_var4 )))
   :effect (and (when (pre_successor_newcolfromfreecell_var3_var4 )(del_successor_newcolfromfreecell_var3_var4 ))(when (not (pre_successor_newcolfromfreecell_var3_var4 ))(add_successor_newcolfromfreecell_var3_var4 ))))

 (:action program_pre_successor_newcolfromfreecell_var3_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_newcolfromfreecell_var3_var5 ))(not (del_successor_newcolfromfreecell_var3_var5 ))(not (add_successor_newcolfromfreecell_var3_var5 )))
   :effect (and (pre_successor_newcolfromfreecell_var3_var5 )))

 (:action program_eff_successor_newcolfromfreecell_var3_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_newcolfromfreecell_var3_var5 ))(not (add_successor_newcolfromfreecell_var3_var5 )))
   :effect (and (when (pre_successor_newcolfromfreecell_var3_var5 )(del_successor_newcolfromfreecell_var3_var5 ))(when (not (pre_successor_newcolfromfreecell_var3_var5 ))(add_successor_newcolfromfreecell_var3_var5 ))))

 (:action program_pre_successor_newcolfromfreecell_var4_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_newcolfromfreecell_var4_var2 ))(not (del_successor_newcolfromfreecell_var4_var2 ))(not (add_successor_newcolfromfreecell_var4_var2 )))
   :effect (and (pre_successor_newcolfromfreecell_var4_var2 )))

 (:action program_eff_successor_newcolfromfreecell_var4_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_newcolfromfreecell_var4_var2 ))(not (add_successor_newcolfromfreecell_var4_var2 )))
   :effect (and (when (pre_successor_newcolfromfreecell_var4_var2 )(del_successor_newcolfromfreecell_var4_var2 ))(when (not (pre_successor_newcolfromfreecell_var4_var2 ))(add_successor_newcolfromfreecell_var4_var2 ))))

 (:action program_pre_successor_newcolfromfreecell_var4_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_newcolfromfreecell_var4_var3 ))(not (del_successor_newcolfromfreecell_var4_var3 ))(not (add_successor_newcolfromfreecell_var4_var3 )))
   :effect (and (pre_successor_newcolfromfreecell_var4_var3 )))

 (:action program_eff_successor_newcolfromfreecell_var4_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_newcolfromfreecell_var4_var3 ))(not (add_successor_newcolfromfreecell_var4_var3 )))
   :effect (and (when (pre_successor_newcolfromfreecell_var4_var3 )(del_successor_newcolfromfreecell_var4_var3 ))(when (not (pre_successor_newcolfromfreecell_var4_var3 ))(add_successor_newcolfromfreecell_var4_var3 ))))

 (:action program_pre_successor_newcolfromfreecell_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_newcolfromfreecell_var4_var4 ))(not (del_successor_newcolfromfreecell_var4_var4 ))(not (add_successor_newcolfromfreecell_var4_var4 )))
   :effect (and (pre_successor_newcolfromfreecell_var4_var4 )))

 (:action program_eff_successor_newcolfromfreecell_var4_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_newcolfromfreecell_var4_var4 ))(not (add_successor_newcolfromfreecell_var4_var4 )))
   :effect (and (when (pre_successor_newcolfromfreecell_var4_var4 )(del_successor_newcolfromfreecell_var4_var4 ))(when (not (pre_successor_newcolfromfreecell_var4_var4 ))(add_successor_newcolfromfreecell_var4_var4 ))))

 (:action program_pre_successor_newcolfromfreecell_var4_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_newcolfromfreecell_var4_var5 ))(not (del_successor_newcolfromfreecell_var4_var5 ))(not (add_successor_newcolfromfreecell_var4_var5 )))
   :effect (and (pre_successor_newcolfromfreecell_var4_var5 )))

 (:action program_eff_successor_newcolfromfreecell_var4_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_newcolfromfreecell_var4_var5 ))(not (add_successor_newcolfromfreecell_var4_var5 )))
   :effect (and (when (pre_successor_newcolfromfreecell_var4_var5 )(del_successor_newcolfromfreecell_var4_var5 ))(when (not (pre_successor_newcolfromfreecell_var4_var5 ))(add_successor_newcolfromfreecell_var4_var5 ))))

 (:action program_pre_successor_newcolfromfreecell_var5_var2
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_newcolfromfreecell_var5_var2 ))(not (del_successor_newcolfromfreecell_var5_var2 ))(not (add_successor_newcolfromfreecell_var5_var2 )))
   :effect (and (pre_successor_newcolfromfreecell_var5_var2 )))

 (:action program_eff_successor_newcolfromfreecell_var5_var2
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_newcolfromfreecell_var5_var2 ))(not (add_successor_newcolfromfreecell_var5_var2 )))
   :effect (and (when (pre_successor_newcolfromfreecell_var5_var2 )(del_successor_newcolfromfreecell_var5_var2 ))(when (not (pre_successor_newcolfromfreecell_var5_var2 ))(add_successor_newcolfromfreecell_var5_var2 ))))

 (:action program_pre_successor_newcolfromfreecell_var5_var3
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_newcolfromfreecell_var5_var3 ))(not (del_successor_newcolfromfreecell_var5_var3 ))(not (add_successor_newcolfromfreecell_var5_var3 )))
   :effect (and (pre_successor_newcolfromfreecell_var5_var3 )))

 (:action program_eff_successor_newcolfromfreecell_var5_var3
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_newcolfromfreecell_var5_var3 ))(not (add_successor_newcolfromfreecell_var5_var3 )))
   :effect (and (when (pre_successor_newcolfromfreecell_var5_var3 )(del_successor_newcolfromfreecell_var5_var3 ))(when (not (pre_successor_newcolfromfreecell_var5_var3 ))(add_successor_newcolfromfreecell_var5_var3 ))))

 (:action program_pre_successor_newcolfromfreecell_var5_var4
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_newcolfromfreecell_var5_var4 ))(not (del_successor_newcolfromfreecell_var5_var4 ))(not (add_successor_newcolfromfreecell_var5_var4 )))
   :effect (and (pre_successor_newcolfromfreecell_var5_var4 )))

 (:action program_eff_successor_newcolfromfreecell_var5_var4
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_newcolfromfreecell_var5_var4 ))(not (add_successor_newcolfromfreecell_var5_var4 )))
   :effect (and (when (pre_successor_newcolfromfreecell_var5_var4 )(del_successor_newcolfromfreecell_var5_var4 ))(when (not (pre_successor_newcolfromfreecell_var5_var4 ))(add_successor_newcolfromfreecell_var5_var4 ))))

 (:action program_pre_successor_newcolfromfreecell_var5_var5
   :parameters ()
   :precondition (and (modeProg )(not (pre_successor_newcolfromfreecell_var5_var5 ))(not (del_successor_newcolfromfreecell_var5_var5 ))(not (add_successor_newcolfromfreecell_var5_var5 )))
   :effect (and (pre_successor_newcolfromfreecell_var5_var5 )))

 (:action program_eff_successor_newcolfromfreecell_var5_var5
   :parameters ()
   :precondition (and (modeProg )(not (del_successor_newcolfromfreecell_var5_var5 ))(not (add_successor_newcolfromfreecell_var5_var5 )))
   :effect (and (when (pre_successor_newcolfromfreecell_var5_var5 )(del_successor_newcolfromfreecell_var5_var5 ))(when (not (pre_successor_newcolfromfreecell_var5_var5 ))(add_successor_newcolfromfreecell_var5_var5 ))))

 (:action validate_1
   :parameters ()
   :precondition (and (modeProg ))
   :effect (and (not (modeProg ))(current i1)(not (bottomcol c0))(bottomcol c2)(not (bottomcol ca))(not (bottomcol d0))(bottomcol d2)(bottomcol da)(not (bottomcol h0))(bottomcol h2)(bottomcol ha)(not (bottomcol s0))(bottomcol s2)(not (bottomcol sa))(not (canstack c0 c0))(not (canstack c0 c2))(not (canstack c0 ca))(not (canstack c0 d0))(not (canstack c0 d2))(not (canstack c0 da))(not (canstack c0 h0))(not (canstack c0 h2))(not (canstack c0 ha))(not (canstack c0 s0))(not (canstack c0 s2))(not (canstack c0 sa))(not (canstack c2 c0))(not (canstack c2 c2))(not (canstack c2 ca))(not (canstack c2 d0))(not (canstack c2 d2))(not (canstack c2 da))(not (canstack c2 h0))(not (canstack c2 h2))(not (canstack c2 ha))(not (canstack c2 s0))(not (canstack c2 s2))(not (canstack c2 sa))(not (canstack ca c0))(not (canstack ca c2))(not (canstack ca ca))(not (canstack ca d0))(canstack ca d2)(not (canstack ca da))(not (canstack ca h0))(canstack ca h2)(not (canstack ca ha))(not (canstack ca s0))(not (canstack ca s2))(not (canstack ca sa))(not (canstack d0 c0))(not (canstack d0 c2))(not (canstack d0 ca))(not (canstack d0 d0))(not (canstack d0 d2))(not (canstack d0 da))(not (canstack d0 h0))(not (canstack d0 h2))(not (canstack d0 ha))(not (canstack d0 s0))(not (canstack d0 s2))(not (canstack d0 sa))(not (canstack d2 c0))(not (canstack d2 c2))(not (canstack d2 ca))(not (canstack d2 d0))(not (canstack d2 d2))(not (canstack d2 da))(not (canstack d2 h0))(not (canstack d2 h2))(not (canstack d2 ha))(not (canstack d2 s0))(not (canstack d2 s2))(not (canstack d2 sa))(not (canstack da c0))(canstack da c2)(not (canstack da ca))(not (canstack da d0))(not (canstack da d2))(not (canstack da da))(not (canstack da h0))(not (canstack da h2))(not (canstack da ha))(not (canstack da s0))(canstack da s2)(not (canstack da sa))(not (canstack h0 c0))(not (canstack h0 c2))(not (canstack h0 ca))(not (canstack h0 d0))(not (canstack h0 d2))(not (canstack h0 da))(not (canstack h0 h0))(not (canstack h0 h2))(not (canstack h0 ha))(not (canstack h0 s0))(not (canstack h0 s2))(not (canstack h0 sa))(not (canstack h2 c0))(not (canstack h2 c2))(not (canstack h2 ca))(not (canstack h2 d0))(not (canstack h2 d2))(not (canstack h2 da))(not (canstack h2 h0))(not (canstack h2 h2))(not (canstack h2 ha))(not (canstack h2 s0))(not (canstack h2 s2))(not (canstack h2 sa))(not (canstack ha c0))(canstack ha c2)(not (canstack ha ca))(not (canstack ha d0))(not (canstack ha d2))(not (canstack ha da))(not (canstack ha h0))(not (canstack ha h2))(not (canstack ha ha))(not (canstack ha s0))(canstack ha s2)(not (canstack ha sa))(not (canstack s0 c0))(not (canstack s0 c2))(not (canstack s0 ca))(not (canstack s0 d0))(not (canstack s0 d2))(not (canstack s0 da))(not (canstack s0 h0))(not (canstack s0 h2))(not (canstack s0 ha))(not (canstack s0 s0))(not (canstack s0 s2))(not (canstack s0 sa))(not (canstack s2 c0))(not (canstack s2 c2))(not (canstack s2 ca))(not (canstack s2 d0))(not (canstack s2 d2))(not (canstack s2 da))(not (canstack s2 h0))(not (canstack s2 h2))(not (canstack s2 ha))(not (canstack s2 s0))(not (canstack s2 s2))(not (canstack s2 sa))(not (canstack sa c0))(not (canstack sa c2))(not (canstack sa ca))(not (canstack sa d0))(canstack sa d2)(not (canstack sa da))(not (canstack sa h0))(canstack sa h2)(not (canstack sa ha))(not (canstack sa s0))(not (canstack sa s2))(not (canstack sa sa))(not (cellspace n0))(not (cellspace n1))(not (cellspace n10))(not (cellspace n11))(not (cellspace n12))(not (cellspace n13))(not (cellspace n2))(not (cellspace n3))(cellspace n4)(not (cellspace n5))(not (cellspace n6))(not (cellspace n7))(not (cellspace n8))(not (cellspace n9))(not (clear c0))(clear c2)(clear ca)(not (clear d0))(not (clear d2))(clear da)(not (clear h0))(clear h2)(not (clear ha))(not (clear s0))(clear s2)(clear sa)(not (colspace n0))(not (colspace n1))(not (colspace n10))(not (colspace n11))(not (colspace n12))(not (colspace n13))(colspace n2)(not (colspace n3))(not (colspace n4))(not (colspace n5))(not (colspace n6))(not (colspace n7))(not (colspace n8))(not (colspace n9))(home c0)(not (home c2))(not (home ca))(home d0)(not (home d2))(not (home da))(home h0)(not (home h2))(not (home ha))(home s0)(not (home s2))(not (home sa))(not (incell c0))(not (incell c2))(not (incell ca))(not (incell d0))(not (incell d2))(not (incell da))(not (incell h0))(not (incell h2))(not (incell ha))(not (incell s0))(not (incell s2))(not (incell sa))(not (on c0 c0))(not (on c0 c2))(not (on c0 ca))(not (on c0 d0))(not (on c0 d2))(not (on c0 da))(not (on c0 h0))(not (on c0 h2))(not (on c0 ha))(not (on c0 s0))(not (on c0 s2))(not (on c0 sa))(not (on c2 c0))(not (on c2 c2))(not (on c2 ca))(not (on c2 d0))(not (on c2 d2))(not (on c2 da))(not (on c2 h0))(not (on c2 h2))(not (on c2 ha))(not (on c2 s0))(not (on c2 s2))(not (on c2 sa))(not (on ca c0))(not (on ca c2))(not (on ca ca))(not (on ca d0))(on ca d2)(not (on ca da))(not (on ca h0))(not (on ca h2))(not (on ca ha))(not (on ca s0))(not (on ca s2))(not (on ca sa))(not (on d0 c0))(not (on d0 c2))(not (on d0 ca))(not (on d0 d0))(not (on d0 d2))(not (on d0 da))(not (on d0 h0))(not (on d0 h2))(not (on d0 ha))(not (on d0 s0))(not (on d0 s2))(not (on d0 sa))(not (on d2 c0))(not (on d2 c2))(not (on d2 ca))(not (on d2 d0))(not (on d2 d2))(not (on d2 da))(not (on d2 h0))(not (on d2 h2))(not (on d2 ha))(not (on d2 s0))(not (on d2 s2))(not (on d2 sa))(not (on da c0))(not (on da c2))(not (on da ca))(not (on da d0))(not (on da d2))(not (on da da))(not (on da h0))(not (on da h2))(not (on da ha))(not (on da s0))(not (on da s2))(not (on da sa))(not (on h0 c0))(not (on h0 c2))(not (on h0 ca))(not (on h0 d0))(not (on h0 d2))(not (on h0 da))(not (on h0 h0))(not (on h0 h2))(not (on h0 ha))(not (on h0 s0))(not (on h0 s2))(not (on h0 sa))(not (on h2 c0))(not (on h2 c2))(not (on h2 ca))(not (on h2 d0))(not (on h2 d2))(not (on h2 da))(not (on h2 h0))(not (on h2 h2))(not (on h2 ha))(not (on h2 s0))(not (on h2 s2))(not (on h2 sa))(not (on ha c0))(not (on ha c2))(not (on ha ca))(not (on ha d0))(not (on ha d2))(not (on ha da))(not (on ha h0))(not (on ha h2))(not (on ha ha))(not (on ha s0))(not (on ha s2))(not (on ha sa))(not (on s0 c0))(not (on s0 c2))(not (on s0 ca))(not (on s0 d0))(not (on s0 d2))(not (on s0 da))(not (on s0 h0))(not (on s0 h2))(not (on s0 ha))(not (on s0 s0))(not (on s0 s2))(not (on s0 sa))(not (on s2 c0))(not (on s2 c2))(not (on s2 ca))(not (on s2 d0))(not (on s2 d2))(not (on s2 da))(not (on s2 h0))(not (on s2 h2))(not (on s2 ha))(not (on s2 s0))(not (on s2 s2))(not (on s2 sa))(not (on sa c0))(not (on sa c2))(not (on sa ca))(not (on sa d0))(not (on sa d2))(not (on sa da))(not (on sa h0))(not (on sa h2))(on sa ha)(not (on sa s0))(not (on sa s2))(not (on sa sa))(not (successor n0 n0))(not (successor n0 n1))(not (successor n0 n10))(not (successor n0 n11))(not (successor n0 n12))(not (successor n0 n13))(not (successor n0 n2))(not (successor n0 n3))(not (successor n0 n4))(not (successor n0 n5))(not (successor n0 n6))(not (successor n0 n7))(not (successor n0 n8))(not (successor n0 n9))(successor n1 n0)(not (successor n1 n1))(not (successor n1 n10))(not (successor n1 n11))(not (successor n1 n12))(not (successor n1 n13))(not (successor n1 n2))(not (successor n1 n3))(not (successor n1 n4))(not (successor n1 n5))(not (successor n1 n6))(not (successor n1 n7))(not (successor n1 n8))(not (successor n1 n9))(not (successor n10 n0))(not (successor n10 n1))(not (successor n10 n10))(not (successor n10 n11))(not (successor n10 n12))(not (successor n10 n13))(not (successor n10 n2))(not (successor n10 n3))(not (successor n10 n4))(not (successor n10 n5))(not (successor n10 n6))(not (successor n10 n7))(not (successor n10 n8))(successor n10 n9)(not (successor n11 n0))(not (successor n11 n1))(successor n11 n10)(not (successor n11 n11))(not (successor n11 n12))(not (successor n11 n13))(not (successor n11 n2))(not (successor n11 n3))(not (successor n11 n4))(not (successor n11 n5))(not (successor n11 n6))(not (successor n11 n7))(not (successor n11 n8))(not (successor n11 n9))(not (successor n12 n0))(not (successor n12 n1))(not (successor n12 n10))(successor n12 n11)(not (successor n12 n12))(not (successor n12 n13))(not (successor n12 n2))(not (successor n12 n3))(not (successor n12 n4))(not (successor n12 n5))(not (successor n12 n6))(not (successor n12 n7))(not (successor n12 n8))(not (successor n12 n9))(not (successor n13 n0))(not (successor n13 n1))(not (successor n13 n10))(not (successor n13 n11))(successor n13 n12)(not (successor n13 n13))(not (successor n13 n2))(not (successor n13 n3))(not (successor n13 n4))(not (successor n13 n5))(not (successor n13 n6))(not (successor n13 n7))(not (successor n13 n8))(not (successor n13 n9))(not (successor n2 n0))(successor n2 n1)(not (successor n2 n10))(not (successor n2 n11))(not (successor n2 n12))(not (successor n2 n13))(not (successor n2 n2))(not (successor n2 n3))(not (successor n2 n4))(not (successor n2 n5))(not (successor n2 n6))(not (successor n2 n7))(not (successor n2 n8))(not (successor n2 n9))(not (successor n3 n0))(not (successor n3 n1))(not (successor n3 n10))(not (successor n3 n11))(not (successor n3 n12))(not (successor n3 n13))(successor n3 n2)(not (successor n3 n3))(not (successor n3 n4))(not (successor n3 n5))(not (successor n3 n6))(not (successor n3 n7))(not (successor n3 n8))(not (successor n3 n9))(not (successor n4 n0))(not (successor n4 n1))(not (successor n4 n10))(not (successor n4 n11))(not (successor n4 n12))(not (successor n4 n13))(not (successor n4 n2))(successor n4 n3)(not (successor n4 n4))(not (successor n4 n5))(not (successor n4 n6))(not (successor n4 n7))(not (successor n4 n8))(not (successor n4 n9))(not (successor n5 n0))(not (successor n5 n1))(not (successor n5 n10))(not (successor n5 n11))(not (successor n5 n12))(not (successor n5 n13))(not (successor n5 n2))(not (successor n5 n3))(successor n5 n4)(not (successor n5 n5))(not (successor n5 n6))(not (successor n5 n7))(not (successor n5 n8))(not (successor n5 n9))(not (successor n6 n0))(not (successor n6 n1))(not (successor n6 n10))(not (successor n6 n11))(not (successor n6 n12))(not (successor n6 n13))(not (successor n6 n2))(not (successor n6 n3))(not (successor n6 n4))(successor n6 n5)(not (successor n6 n6))(not (successor n6 n7))(not (successor n6 n8))(not (successor n6 n9))(not (successor n7 n0))(not (successor n7 n1))(not (successor n7 n10))(not (successor n7 n11))(not (successor n7 n12))(not (successor n7 n13))(not (successor n7 n2))(not (successor n7 n3))(not (successor n7 n4))(not (successor n7 n5))(successor n7 n6)(not (successor n7 n7))(not (successor n7 n8))(not (successor n7 n9))(not (successor n8 n0))(not (successor n8 n1))(not (successor n8 n10))(not (successor n8 n11))(not (successor n8 n12))(not (successor n8 n13))(not (successor n8 n2))(not (successor n8 n3))(not (successor n8 n4))(not (successor n8 n5))(not (successor n8 n6))(successor n8 n7)(not (successor n8 n8))(not (successor n8 n9))(not (successor n9 n0))(not (successor n9 n1))(not (successor n9 n10))(not (successor n9 n11))(not (successor n9 n12))(not (successor n9 n13))(not (successor n9 n2))(not (successor n9 n3))(not (successor n9 n4))(not (successor n9 n5))(not (successor n9 n6))(not (successor n9 n7))(successor n9 n8)(not (successor n9 n9))(suit c0 c)(not (suit c0 d))(not (suit c0 h))(not (suit c0 s))(suit c2 c)(not (suit c2 d))(not (suit c2 h))(not (suit c2 s))(suit ca c)(not (suit ca d))(not (suit ca h))(not (suit ca s))(not (suit d0 c))(suit d0 d)(not (suit d0 h))(not (suit d0 s))(not (suit d2 c))(suit d2 d)(not (suit d2 h))(not (suit d2 s))(not (suit da c))(suit da d)(not (suit da h))(not (suit da s))(not (suit h0 c))(not (suit h0 d))(suit h0 h)(not (suit h0 s))(not (suit h2 c))(not (suit h2 d))(suit h2 h)(not (suit h2 s))(not (suit ha c))(not (suit ha d))(suit ha h)(not (suit ha s))(not (suit s0 c))(not (suit s0 d))(not (suit s0 h))(suit s0 s)(not (suit s2 c))(not (suit s2 d))(not (suit s2 h))(suit s2 s)(not (suit sa c))(not (suit sa d))(not (suit sa h))(suit sa s)(value c0 n0)(not (value c0 n1))(not (value c0 n10))(not (value c0 n11))(not (value c0 n12))(not (value c0 n13))(not (value c0 n2))(not (value c0 n3))(not (value c0 n4))(not (value c0 n5))(not (value c0 n6))(not (value c0 n7))(not (value c0 n8))(not (value c0 n9))(not (value c2 n0))(not (value c2 n1))(not (value c2 n10))(not (value c2 n11))(not (value c2 n12))(not (value c2 n13))(value c2 n2)(not (value c2 n3))(not (value c2 n4))(not (value c2 n5))(not (value c2 n6))(not (value c2 n7))(not (value c2 n8))(not (value c2 n9))(not (value ca n0))(value ca n1)(not (value ca n10))(not (value ca n11))(not (value ca n12))(not (value ca n13))(not (value ca n2))(not (value ca n3))(not (value ca n4))(not (value ca n5))(not (value ca n6))(not (value ca n7))(not (value ca n8))(not (value ca n9))(value d0 n0)(not (value d0 n1))(not (value d0 n10))(not (value d0 n11))(not (value d0 n12))(not (value d0 n13))(not (value d0 n2))(not (value d0 n3))(not (value d0 n4))(not (value d0 n5))(not (value d0 n6))(not (value d0 n7))(not (value d0 n8))(not (value d0 n9))(not (value d2 n0))(not (value d2 n1))(not (value d2 n10))(not (value d2 n11))(not (value d2 n12))(not (value d2 n13))(value d2 n2)(not (value d2 n3))(not (value d2 n4))(not (value d2 n5))(not (value d2 n6))(not (value d2 n7))(not (value d2 n8))(not (value d2 n9))(not (value da n0))(value da n1)(not (value da n10))(not (value da n11))(not (value da n12))(not (value da n13))(not (value da n2))(not (value da n3))(not (value da n4))(not (value da n5))(not (value da n6))(not (value da n7))(not (value da n8))(not (value da n9))(value h0 n0)(not (value h0 n1))(not (value h0 n10))(not (value h0 n11))(not (value h0 n12))(not (value h0 n13))(not (value h0 n2))(not (value h0 n3))(not (value h0 n4))(not (value h0 n5))(not (value h0 n6))(not (value h0 n7))(not (value h0 n8))(not (value h0 n9))(not (value h2 n0))(not (value h2 n1))(not (value h2 n10))(not (value h2 n11))(not (value h2 n12))(not (value h2 n13))(value h2 n2)(not (value h2 n3))(not (value h2 n4))(not (value h2 n5))(not (value h2 n6))(not (value h2 n7))(not (value h2 n8))(not (value h2 n9))(not (value ha n0))(value ha n1)(not (value ha n10))(not (value ha n11))(not (value ha n12))(not (value ha n13))(not (value ha n2))(not (value ha n3))(not (value ha n4))(not (value ha n5))(not (value ha n6))(not (value ha n7))(not (value ha n8))(not (value ha n9))(value s0 n0)(not (value s0 n1))(not (value s0 n10))(not (value s0 n11))(not (value s0 n12))(not (value s0 n13))(not (value s0 n2))(not (value s0 n3))(not (value s0 n4))(not (value s0 n5))(not (value s0 n6))(not (value s0 n7))(not (value s0 n8))(not (value s0 n9))(not (value s2 n0))(not (value s2 n1))(not (value s2 n10))(not (value s2 n11))(not (value s2 n12))(not (value s2 n13))(value s2 n2)(not (value s2 n3))(not (value s2 n4))(not (value s2 n5))(not (value s2 n6))(not (value s2 n7))(not (value s2 n8))(not (value s2 n9))(not (value sa n0))(value sa n1)(not (value sa n10))(not (value sa n11))(not (value sa n12))(not (value sa n13))(not (value sa n2))(not (value sa n3))(not (value sa n4))(not (value sa n5))(not (value sa n6))(not (value sa n7))(not (value sa n8))(not (value sa n9))(plan-sendtohome i1 ca d2 c n1 c0 n0)(plan-sendtohome i2 sa ha s n1 s0 n0)(plan-sendtohome-b i3 da d n1 d0 n0 n2 n3)(test1 )(not (action_applied ))))

 (:action validate_2
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(not (bottomcol c0))(bottomcol c2)(not (bottomcol ca))(not (bottomcol d0))(bottomcol d2)(not (bottomcol da))(not (bottomcol h0))(bottomcol h2)(bottomcol ha)(not (bottomcol s0))(bottomcol s2)(not (bottomcol sa))(not (canstack c0 c0))(not (canstack c0 c2))(not (canstack c0 ca))(not (canstack c0 d0))(not (canstack c0 d2))(not (canstack c0 da))(not (canstack c0 h0))(not (canstack c0 h2))(not (canstack c0 ha))(not (canstack c0 s0))(not (canstack c0 s2))(not (canstack c0 sa))(not (canstack c2 c0))(not (canstack c2 c2))(not (canstack c2 ca))(not (canstack c2 d0))(not (canstack c2 d2))(not (canstack c2 da))(not (canstack c2 h0))(not (canstack c2 h2))(not (canstack c2 ha))(not (canstack c2 s0))(not (canstack c2 s2))(not (canstack c2 sa))(not (canstack ca c0))(not (canstack ca c2))(not (canstack ca ca))(not (canstack ca d0))(canstack ca d2)(not (canstack ca da))(not (canstack ca h0))(canstack ca h2)(not (canstack ca ha))(not (canstack ca s0))(not (canstack ca s2))(not (canstack ca sa))(not (canstack d0 c0))(not (canstack d0 c2))(not (canstack d0 ca))(not (canstack d0 d0))(not (canstack d0 d2))(not (canstack d0 da))(not (canstack d0 h0))(not (canstack d0 h2))(not (canstack d0 ha))(not (canstack d0 s0))(not (canstack d0 s2))(not (canstack d0 sa))(not (canstack d2 c0))(not (canstack d2 c2))(not (canstack d2 ca))(not (canstack d2 d0))(not (canstack d2 d2))(not (canstack d2 da))(not (canstack d2 h0))(not (canstack d2 h2))(not (canstack d2 ha))(not (canstack d2 s0))(not (canstack d2 s2))(not (canstack d2 sa))(not (canstack da c0))(canstack da c2)(not (canstack da ca))(not (canstack da d0))(not (canstack da d2))(not (canstack da da))(not (canstack da h0))(not (canstack da h2))(not (canstack da ha))(not (canstack da s0))(canstack da s2)(not (canstack da sa))(not (canstack h0 c0))(not (canstack h0 c2))(not (canstack h0 ca))(not (canstack h0 d0))(not (canstack h0 d2))(not (canstack h0 da))(not (canstack h0 h0))(not (canstack h0 h2))(not (canstack h0 ha))(not (canstack h0 s0))(not (canstack h0 s2))(not (canstack h0 sa))(not (canstack h2 c0))(not (canstack h2 c2))(not (canstack h2 ca))(not (canstack h2 d0))(not (canstack h2 d2))(not (canstack h2 da))(not (canstack h2 h0))(not (canstack h2 h2))(not (canstack h2 ha))(not (canstack h2 s0))(not (canstack h2 s2))(not (canstack h2 sa))(not (canstack ha c0))(canstack ha c2)(not (canstack ha ca))(not (canstack ha d0))(not (canstack ha d2))(not (canstack ha da))(not (canstack ha h0))(not (canstack ha h2))(not (canstack ha ha))(not (canstack ha s0))(canstack ha s2)(not (canstack ha sa))(not (canstack s0 c0))(not (canstack s0 c2))(not (canstack s0 ca))(not (canstack s0 d0))(not (canstack s0 d2))(not (canstack s0 da))(not (canstack s0 h0))(not (canstack s0 h2))(not (canstack s0 ha))(not (canstack s0 s0))(not (canstack s0 s2))(not (canstack s0 sa))(not (canstack s2 c0))(not (canstack s2 c2))(not (canstack s2 ca))(not (canstack s2 d0))(not (canstack s2 d2))(not (canstack s2 da))(not (canstack s2 h0))(not (canstack s2 h2))(not (canstack s2 ha))(not (canstack s2 s0))(not (canstack s2 s2))(not (canstack s2 sa))(not (canstack sa c0))(not (canstack sa c2))(not (canstack sa ca))(not (canstack sa d0))(canstack sa d2)(not (canstack sa da))(not (canstack sa h0))(canstack sa h2)(not (canstack sa ha))(not (canstack sa s0))(not (canstack sa s2))(not (canstack sa sa))(not (cellspace n0))(not (cellspace n1))(not (cellspace n10))(not (cellspace n11))(not (cellspace n12))(not (cellspace n13))(not (cellspace n2))(not (cellspace n3))(cellspace n4)(not (cellspace n5))(not (cellspace n6))(not (cellspace n7))(not (cellspace n8))(not (cellspace n9))(not (clear c0))(clear c2)(not (clear ca))(not (clear d0))(clear d2)(not (clear da))(not (clear h0))(clear h2)(clear ha)(not (clear s0))(clear s2)(not (clear sa))(not (colspace n0))(not (colspace n1))(not (colspace n10))(not (colspace n11))(not (colspace n12))(not (colspace n13))(not (colspace n2))(colspace n3)(not (colspace n4))(not (colspace n5))(not (colspace n6))(not (colspace n7))(not (colspace n8))(not (colspace n9))(not (home c0))(not (home c2))(home ca)(not (home d0))(not (home d2))(home da)(home h0)(not (home h2))(not (home ha))(not (home s0))(not (home s2))(home sa)(not (incell c0))(not (incell c2))(not (incell ca))(not (incell d0))(not (incell d2))(not (incell da))(not (incell h0))(not (incell h2))(not (incell ha))(not (incell s0))(not (incell s2))(not (incell sa))(not (on c0 c0))(not (on c0 c2))(not (on c0 ca))(not (on c0 d0))(not (on c0 d2))(not (on c0 da))(not (on c0 h0))(not (on c0 h2))(not (on c0 ha))(not (on c0 s0))(not (on c0 s2))(not (on c0 sa))(not (on c2 c0))(not (on c2 c2))(not (on c2 ca))(not (on c2 d0))(not (on c2 d2))(not (on c2 da))(not (on c2 h0))(not (on c2 h2))(not (on c2 ha))(not (on c2 s0))(not (on c2 s2))(not (on c2 sa))(not (on ca c0))(not (on ca c2))(not (on ca ca))(not (on ca d0))(not (on ca d2))(not (on ca da))(not (on ca h0))(not (on ca h2))(not (on ca ha))(not (on ca s0))(not (on ca s2))(not (on ca sa))(not (on d0 c0))(not (on d0 c2))(not (on d0 ca))(not (on d0 d0))(not (on d0 d2))(not (on d0 da))(not (on d0 h0))(not (on d0 h2))(not (on d0 ha))(not (on d0 s0))(not (on d0 s2))(not (on d0 sa))(not (on d2 c0))(not (on d2 c2))(not (on d2 ca))(not (on d2 d0))(not (on d2 d2))(not (on d2 da))(not (on d2 h0))(not (on d2 h2))(not (on d2 ha))(not (on d2 s0))(not (on d2 s2))(not (on d2 sa))(not (on da c0))(not (on da c2))(not (on da ca))(not (on da d0))(not (on da d2))(not (on da da))(not (on da h0))(not (on da h2))(not (on da ha))(not (on da s0))(not (on da s2))(not (on da sa))(not (on h0 c0))(not (on h0 c2))(not (on h0 ca))(not (on h0 d0))(not (on h0 d2))(not (on h0 da))(not (on h0 h0))(not (on h0 h2))(not (on h0 ha))(not (on h0 s0))(not (on h0 s2))(not (on h0 sa))(not (on h2 c0))(not (on h2 c2))(not (on h2 ca))(not (on h2 d0))(not (on h2 d2))(not (on h2 da))(not (on h2 h0))(not (on h2 h2))(not (on h2 ha))(not (on h2 s0))(not (on h2 s2))(not (on h2 sa))(not (on ha c0))(not (on ha c2))(not (on ha ca))(not (on ha d0))(not (on ha d2))(not (on ha da))(not (on ha h0))(not (on ha h2))(not (on ha ha))(not (on ha s0))(not (on ha s2))(not (on ha sa))(not (on s0 c0))(not (on s0 c2))(not (on s0 ca))(not (on s0 d0))(not (on s0 d2))(not (on s0 da))(not (on s0 h0))(not (on s0 h2))(not (on s0 ha))(not (on s0 s0))(not (on s0 s2))(not (on s0 sa))(not (on s2 c0))(not (on s2 c2))(not (on s2 ca))(not (on s2 d0))(not (on s2 d2))(not (on s2 da))(not (on s2 h0))(not (on s2 h2))(not (on s2 ha))(not (on s2 s0))(not (on s2 s2))(not (on s2 sa))(not (on sa c0))(not (on sa c2))(not (on sa ca))(not (on sa d0))(not (on sa d2))(not (on sa da))(not (on sa h0))(not (on sa h2))(not (on sa ha))(not (on sa s0))(not (on sa s2))(not (on sa sa))(not (successor n0 n0))(not (successor n0 n1))(not (successor n0 n10))(not (successor n0 n11))(not (successor n0 n12))(not (successor n0 n13))(not (successor n0 n2))(not (successor n0 n3))(not (successor n0 n4))(not (successor n0 n5))(not (successor n0 n6))(not (successor n0 n7))(not (successor n0 n8))(not (successor n0 n9))(successor n1 n0)(not (successor n1 n1))(not (successor n1 n10))(not (successor n1 n11))(not (successor n1 n12))(not (successor n1 n13))(not (successor n1 n2))(not (successor n1 n3))(not (successor n1 n4))(not (successor n1 n5))(not (successor n1 n6))(not (successor n1 n7))(not (successor n1 n8))(not (successor n1 n9))(not (successor n10 n0))(not (successor n10 n1))(not (successor n10 n10))(not (successor n10 n11))(not (successor n10 n12))(not (successor n10 n13))(not (successor n10 n2))(not (successor n10 n3))(not (successor n10 n4))(not (successor n10 n5))(not (successor n10 n6))(not (successor n10 n7))(not (successor n10 n8))(successor n10 n9)(not (successor n11 n0))(not (successor n11 n1))(successor n11 n10)(not (successor n11 n11))(not (successor n11 n12))(not (successor n11 n13))(not (successor n11 n2))(not (successor n11 n3))(not (successor n11 n4))(not (successor n11 n5))(not (successor n11 n6))(not (successor n11 n7))(not (successor n11 n8))(not (successor n11 n9))(not (successor n12 n0))(not (successor n12 n1))(not (successor n12 n10))(successor n12 n11)(not (successor n12 n12))(not (successor n12 n13))(not (successor n12 n2))(not (successor n12 n3))(not (successor n12 n4))(not (successor n12 n5))(not (successor n12 n6))(not (successor n12 n7))(not (successor n12 n8))(not (successor n12 n9))(not (successor n13 n0))(not (successor n13 n1))(not (successor n13 n10))(not (successor n13 n11))(successor n13 n12)(not (successor n13 n13))(not (successor n13 n2))(not (successor n13 n3))(not (successor n13 n4))(not (successor n13 n5))(not (successor n13 n6))(not (successor n13 n7))(not (successor n13 n8))(not (successor n13 n9))(not (successor n2 n0))(successor n2 n1)(not (successor n2 n10))(not (successor n2 n11))(not (successor n2 n12))(not (successor n2 n13))(not (successor n2 n2))(not (successor n2 n3))(not (successor n2 n4))(not (successor n2 n5))(not (successor n2 n6))(not (successor n2 n7))(not (successor n2 n8))(not (successor n2 n9))(not (successor n3 n0))(not (successor n3 n1))(not (successor n3 n10))(not (successor n3 n11))(not (successor n3 n12))(not (successor n3 n13))(successor n3 n2)(not (successor n3 n3))(not (successor n3 n4))(not (successor n3 n5))(not (successor n3 n6))(not (successor n3 n7))(not (successor n3 n8))(not (successor n3 n9))(not (successor n4 n0))(not (successor n4 n1))(not (successor n4 n10))(not (successor n4 n11))(not (successor n4 n12))(not (successor n4 n13))(not (successor n4 n2))(successor n4 n3)(not (successor n4 n4))(not (successor n4 n5))(not (successor n4 n6))(not (successor n4 n7))(not (successor n4 n8))(not (successor n4 n9))(not (successor n5 n0))(not (successor n5 n1))(not (successor n5 n10))(not (successor n5 n11))(not (successor n5 n12))(not (successor n5 n13))(not (successor n5 n2))(not (successor n5 n3))(successor n5 n4)(not (successor n5 n5))(not (successor n5 n6))(not (successor n5 n7))(not (successor n5 n8))(not (successor n5 n9))(not (successor n6 n0))(not (successor n6 n1))(not (successor n6 n10))(not (successor n6 n11))(not (successor n6 n12))(not (successor n6 n13))(not (successor n6 n2))(not (successor n6 n3))(not (successor n6 n4))(successor n6 n5)(not (successor n6 n6))(not (successor n6 n7))(not (successor n6 n8))(not (successor n6 n9))(not (successor n7 n0))(not (successor n7 n1))(not (successor n7 n10))(not (successor n7 n11))(not (successor n7 n12))(not (successor n7 n13))(not (successor n7 n2))(not (successor n7 n3))(not (successor n7 n4))(not (successor n7 n5))(successor n7 n6)(not (successor n7 n7))(not (successor n7 n8))(not (successor n7 n9))(not (successor n8 n0))(not (successor n8 n1))(not (successor n8 n10))(not (successor n8 n11))(not (successor n8 n12))(not (successor n8 n13))(not (successor n8 n2))(not (successor n8 n3))(not (successor n8 n4))(not (successor n8 n5))(not (successor n8 n6))(successor n8 n7)(not (successor n8 n8))(not (successor n8 n9))(not (successor n9 n0))(not (successor n9 n1))(not (successor n9 n10))(not (successor n9 n11))(not (successor n9 n12))(not (successor n9 n13))(not (successor n9 n2))(not (successor n9 n3))(not (successor n9 n4))(not (successor n9 n5))(not (successor n9 n6))(not (successor n9 n7))(successor n9 n8)(not (successor n9 n9))(suit c0 c)(not (suit c0 d))(not (suit c0 h))(not (suit c0 s))(suit c2 c)(not (suit c2 d))(not (suit c2 h))(not (suit c2 s))(suit ca c)(not (suit ca d))(not (suit ca h))(not (suit ca s))(not (suit d0 c))(suit d0 d)(not (suit d0 h))(not (suit d0 s))(not (suit d2 c))(suit d2 d)(not (suit d2 h))(not (suit d2 s))(not (suit da c))(suit da d)(not (suit da h))(not (suit da s))(not (suit h0 c))(not (suit h0 d))(suit h0 h)(not (suit h0 s))(not (suit h2 c))(not (suit h2 d))(suit h2 h)(not (suit h2 s))(not (suit ha c))(not (suit ha d))(suit ha h)(not (suit ha s))(not (suit s0 c))(not (suit s0 d))(not (suit s0 h))(suit s0 s)(not (suit s2 c))(not (suit s2 d))(not (suit s2 h))(suit s2 s)(not (suit sa c))(not (suit sa d))(not (suit sa h))(suit sa s)(value c0 n0)(not (value c0 n1))(not (value c0 n10))(not (value c0 n11))(not (value c0 n12))(not (value c0 n13))(not (value c0 n2))(not (value c0 n3))(not (value c0 n4))(not (value c0 n5))(not (value c0 n6))(not (value c0 n7))(not (value c0 n8))(not (value c0 n9))(not (value c2 n0))(not (value c2 n1))(not (value c2 n10))(not (value c2 n11))(not (value c2 n12))(not (value c2 n13))(value c2 n2)(not (value c2 n3))(not (value c2 n4))(not (value c2 n5))(not (value c2 n6))(not (value c2 n7))(not (value c2 n8))(not (value c2 n9))(not (value ca n0))(value ca n1)(not (value ca n10))(not (value ca n11))(not (value ca n12))(not (value ca n13))(not (value ca n2))(not (value ca n3))(not (value ca n4))(not (value ca n5))(not (value ca n6))(not (value ca n7))(not (value ca n8))(not (value ca n9))(value d0 n0)(not (value d0 n1))(not (value d0 n10))(not (value d0 n11))(not (value d0 n12))(not (value d0 n13))(not (value d0 n2))(not (value d0 n3))(not (value d0 n4))(not (value d0 n5))(not (value d0 n6))(not (value d0 n7))(not (value d0 n8))(not (value d0 n9))(not (value d2 n0))(not (value d2 n1))(not (value d2 n10))(not (value d2 n11))(not (value d2 n12))(not (value d2 n13))(value d2 n2)(not (value d2 n3))(not (value d2 n4))(not (value d2 n5))(not (value d2 n6))(not (value d2 n7))(not (value d2 n8))(not (value d2 n9))(not (value da n0))(value da n1)(not (value da n10))(not (value da n11))(not (value da n12))(not (value da n13))(not (value da n2))(not (value da n3))(not (value da n4))(not (value da n5))(not (value da n6))(not (value da n7))(not (value da n8))(not (value da n9))(value h0 n0)(not (value h0 n1))(not (value h0 n10))(not (value h0 n11))(not (value h0 n12))(not (value h0 n13))(not (value h0 n2))(not (value h0 n3))(not (value h0 n4))(not (value h0 n5))(not (value h0 n6))(not (value h0 n7))(not (value h0 n8))(not (value h0 n9))(not (value h2 n0))(not (value h2 n1))(not (value h2 n10))(not (value h2 n11))(not (value h2 n12))(not (value h2 n13))(value h2 n2)(not (value h2 n3))(not (value h2 n4))(not (value h2 n5))(not (value h2 n6))(not (value h2 n7))(not (value h2 n8))(not (value h2 n9))(not (value ha n0))(value ha n1)(not (value ha n10))(not (value ha n11))(not (value ha n12))(not (value ha n13))(not (value ha n2))(not (value ha n3))(not (value ha n4))(not (value ha n5))(not (value ha n6))(not (value ha n7))(not (value ha n8))(not (value ha n9))(value s0 n0)(not (value s0 n1))(not (value s0 n10))(not (value s0 n11))(not (value s0 n12))(not (value s0 n13))(not (value s0 n2))(not (value s0 n3))(not (value s0 n4))(not (value s0 n5))(not (value s0 n6))(not (value s0 n7))(not (value s0 n8))(not (value s0 n9))(not (value s2 n0))(not (value s2 n1))(not (value s2 n10))(not (value s2 n11))(not (value s2 n12))(not (value s2 n13))(value s2 n2)(not (value s2 n3))(not (value s2 n4))(not (value s2 n5))(not (value s2 n6))(not (value s2 n7))(not (value s2 n8))(not (value s2 n9))(not (value sa n0))(value sa n1)(not (value sa n10))(not (value sa n11))(not (value sa n12))(not (value sa n13))(not (value sa n2))(not (value sa n3))(not (value sa n4))(not (value sa n5))(not (value sa n6))(not (value sa n7))(not (value sa n8))(not (value sa n9))(test1 ))
   :effect (and (not (plan-sendtohome i1 ca d2 c n1 c0 n0))(not (plan-sendtohome i2 sa ha s n1 s0 n0))(not (plan-sendtohome-b i3 da d n1 d0 n0 n2 n3))(current i1)(not (current i4))(plan-sendtohome-b i1 ha h n1 h0 n0 n3 n4)(plan-sendtohome-b i2 c2 c n2 ca n1 n4 n5)(plan-sendtohome-b i3 d2 d n2 da n1 n5 n6)(test2 )(not (test1 ))(not (action_applied ))))

 (:action validate_3
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(not (bottomcol c0))(not (bottomcol c2))(not (bottomcol ca))(not (bottomcol d0))(not (bottomcol d2))(not (bottomcol da))(not (bottomcol h0))(bottomcol h2)(not (bottomcol ha))(not (bottomcol s0))(bottomcol s2)(not (bottomcol sa))(not (canstack c0 c0))(not (canstack c0 c2))(not (canstack c0 ca))(not (canstack c0 d0))(not (canstack c0 d2))(not (canstack c0 da))(not (canstack c0 h0))(not (canstack c0 h2))(not (canstack c0 ha))(not (canstack c0 s0))(not (canstack c0 s2))(not (canstack c0 sa))(not (canstack c2 c0))(not (canstack c2 c2))(not (canstack c2 ca))(not (canstack c2 d0))(not (canstack c2 d2))(not (canstack c2 da))(not (canstack c2 h0))(not (canstack c2 h2))(not (canstack c2 ha))(not (canstack c2 s0))(not (canstack c2 s2))(not (canstack c2 sa))(not (canstack ca c0))(not (canstack ca c2))(not (canstack ca ca))(not (canstack ca d0))(canstack ca d2)(not (canstack ca da))(not (canstack ca h0))(canstack ca h2)(not (canstack ca ha))(not (canstack ca s0))(not (canstack ca s2))(not (canstack ca sa))(not (canstack d0 c0))(not (canstack d0 c2))(not (canstack d0 ca))(not (canstack d0 d0))(not (canstack d0 d2))(not (canstack d0 da))(not (canstack d0 h0))(not (canstack d0 h2))(not (canstack d0 ha))(not (canstack d0 s0))(not (canstack d0 s2))(not (canstack d0 sa))(not (canstack d2 c0))(not (canstack d2 c2))(not (canstack d2 ca))(not (canstack d2 d0))(not (canstack d2 d2))(not (canstack d2 da))(not (canstack d2 h0))(not (canstack d2 h2))(not (canstack d2 ha))(not (canstack d2 s0))(not (canstack d2 s2))(not (canstack d2 sa))(not (canstack da c0))(canstack da c2)(not (canstack da ca))(not (canstack da d0))(not (canstack da d2))(not (canstack da da))(not (canstack da h0))(not (canstack da h2))(not (canstack da ha))(not (canstack da s0))(canstack da s2)(not (canstack da sa))(not (canstack h0 c0))(not (canstack h0 c2))(not (canstack h0 ca))(not (canstack h0 d0))(not (canstack h0 d2))(not (canstack h0 da))(not (canstack h0 h0))(not (canstack h0 h2))(not (canstack h0 ha))(not (canstack h0 s0))(not (canstack h0 s2))(not (canstack h0 sa))(not (canstack h2 c0))(not (canstack h2 c2))(not (canstack h2 ca))(not (canstack h2 d0))(not (canstack h2 d2))(not (canstack h2 da))(not (canstack h2 h0))(not (canstack h2 h2))(not (canstack h2 ha))(not (canstack h2 s0))(not (canstack h2 s2))(not (canstack h2 sa))(not (canstack ha c0))(canstack ha c2)(not (canstack ha ca))(not (canstack ha d0))(not (canstack ha d2))(not (canstack ha da))(not (canstack ha h0))(not (canstack ha h2))(not (canstack ha ha))(not (canstack ha s0))(canstack ha s2)(not (canstack ha sa))(not (canstack s0 c0))(not (canstack s0 c2))(not (canstack s0 ca))(not (canstack s0 d0))(not (canstack s0 d2))(not (canstack s0 da))(not (canstack s0 h0))(not (canstack s0 h2))(not (canstack s0 ha))(not (canstack s0 s0))(not (canstack s0 s2))(not (canstack s0 sa))(not (canstack s2 c0))(not (canstack s2 c2))(not (canstack s2 ca))(not (canstack s2 d0))(not (canstack s2 d2))(not (canstack s2 da))(not (canstack s2 h0))(not (canstack s2 h2))(not (canstack s2 ha))(not (canstack s2 s0))(not (canstack s2 s2))(not (canstack s2 sa))(not (canstack sa c0))(not (canstack sa c2))(not (canstack sa ca))(not (canstack sa d0))(canstack sa d2)(not (canstack sa da))(not (canstack sa h0))(canstack sa h2)(not (canstack sa ha))(not (canstack sa s0))(not (canstack sa s2))(not (canstack sa sa))(not (cellspace n0))(not (cellspace n1))(not (cellspace n10))(not (cellspace n11))(not (cellspace n12))(not (cellspace n13))(not (cellspace n2))(not (cellspace n3))(cellspace n4)(not (cellspace n5))(not (cellspace n6))(not (cellspace n7))(not (cellspace n8))(not (cellspace n9))(not (clear c0))(not (clear c2))(not (clear ca))(not (clear d0))(not (clear d2))(not (clear da))(not (clear h0))(clear h2)(not (clear ha))(not (clear s0))(clear s2)(not (clear sa))(not (colspace n0))(not (colspace n1))(not (colspace n10))(not (colspace n11))(not (colspace n12))(not (colspace n13))(not (colspace n2))(not (colspace n3))(not (colspace n4))(not (colspace n5))(colspace n6)(not (colspace n7))(not (colspace n8))(not (colspace n9))(not (home c0))(home c2)(not (home ca))(not (home d0))(home d2)(not (home da))(not (home h0))(not (home h2))(home ha)(not (home s0))(not (home s2))(home sa)(not (incell c0))(not (incell c2))(not (incell ca))(not (incell d0))(not (incell d2))(not (incell da))(not (incell h0))(not (incell h2))(not (incell ha))(not (incell s0))(not (incell s2))(not (incell sa))(not (on c0 c0))(not (on c0 c2))(not (on c0 ca))(not (on c0 d0))(not (on c0 d2))(not (on c0 da))(not (on c0 h0))(not (on c0 h2))(not (on c0 ha))(not (on c0 s0))(not (on c0 s2))(not (on c0 sa))(not (on c2 c0))(not (on c2 c2))(not (on c2 ca))(not (on c2 d0))(not (on c2 d2))(not (on c2 da))(not (on c2 h0))(not (on c2 h2))(not (on c2 ha))(not (on c2 s0))(not (on c2 s2))(not (on c2 sa))(not (on ca c0))(not (on ca c2))(not (on ca ca))(not (on ca d0))(not (on ca d2))(not (on ca da))(not (on ca h0))(not (on ca h2))(not (on ca ha))(not (on ca s0))(not (on ca s2))(not (on ca sa))(not (on d0 c0))(not (on d0 c2))(not (on d0 ca))(not (on d0 d0))(not (on d0 d2))(not (on d0 da))(not (on d0 h0))(not (on d0 h2))(not (on d0 ha))(not (on d0 s0))(not (on d0 s2))(not (on d0 sa))(not (on d2 c0))(not (on d2 c2))(not (on d2 ca))(not (on d2 d0))(not (on d2 d2))(not (on d2 da))(not (on d2 h0))(not (on d2 h2))(not (on d2 ha))(not (on d2 s0))(not (on d2 s2))(not (on d2 sa))(not (on da c0))(not (on da c2))(not (on da ca))(not (on da d0))(not (on da d2))(not (on da da))(not (on da h0))(not (on da h2))(not (on da ha))(not (on da s0))(not (on da s2))(not (on da sa))(not (on h0 c0))(not (on h0 c2))(not (on h0 ca))(not (on h0 d0))(not (on h0 d2))(not (on h0 da))(not (on h0 h0))(not (on h0 h2))(not (on h0 ha))(not (on h0 s0))(not (on h0 s2))(not (on h0 sa))(not (on h2 c0))(not (on h2 c2))(not (on h2 ca))(not (on h2 d0))(not (on h2 d2))(not (on h2 da))(not (on h2 h0))(not (on h2 h2))(not (on h2 ha))(not (on h2 s0))(not (on h2 s2))(not (on h2 sa))(not (on ha c0))(not (on ha c2))(not (on ha ca))(not (on ha d0))(not (on ha d2))(not (on ha da))(not (on ha h0))(not (on ha h2))(not (on ha ha))(not (on ha s0))(not (on ha s2))(not (on ha sa))(not (on s0 c0))(not (on s0 c2))(not (on s0 ca))(not (on s0 d0))(not (on s0 d2))(not (on s0 da))(not (on s0 h0))(not (on s0 h2))(not (on s0 ha))(not (on s0 s0))(not (on s0 s2))(not (on s0 sa))(not (on s2 c0))(not (on s2 c2))(not (on s2 ca))(not (on s2 d0))(not (on s2 d2))(not (on s2 da))(not (on s2 h0))(not (on s2 h2))(not (on s2 ha))(not (on s2 s0))(not (on s2 s2))(not (on s2 sa))(not (on sa c0))(not (on sa c2))(not (on sa ca))(not (on sa d0))(not (on sa d2))(not (on sa da))(not (on sa h0))(not (on sa h2))(not (on sa ha))(not (on sa s0))(not (on sa s2))(not (on sa sa))(not (successor n0 n0))(not (successor n0 n1))(not (successor n0 n10))(not (successor n0 n11))(not (successor n0 n12))(not (successor n0 n13))(not (successor n0 n2))(not (successor n0 n3))(not (successor n0 n4))(not (successor n0 n5))(not (successor n0 n6))(not (successor n0 n7))(not (successor n0 n8))(not (successor n0 n9))(successor n1 n0)(not (successor n1 n1))(not (successor n1 n10))(not (successor n1 n11))(not (successor n1 n12))(not (successor n1 n13))(not (successor n1 n2))(not (successor n1 n3))(not (successor n1 n4))(not (successor n1 n5))(not (successor n1 n6))(not (successor n1 n7))(not (successor n1 n8))(not (successor n1 n9))(not (successor n10 n0))(not (successor n10 n1))(not (successor n10 n10))(not (successor n10 n11))(not (successor n10 n12))(not (successor n10 n13))(not (successor n10 n2))(not (successor n10 n3))(not (successor n10 n4))(not (successor n10 n5))(not (successor n10 n6))(not (successor n10 n7))(not (successor n10 n8))(successor n10 n9)(not (successor n11 n0))(not (successor n11 n1))(successor n11 n10)(not (successor n11 n11))(not (successor n11 n12))(not (successor n11 n13))(not (successor n11 n2))(not (successor n11 n3))(not (successor n11 n4))(not (successor n11 n5))(not (successor n11 n6))(not (successor n11 n7))(not (successor n11 n8))(not (successor n11 n9))(not (successor n12 n0))(not (successor n12 n1))(not (successor n12 n10))(successor n12 n11)(not (successor n12 n12))(not (successor n12 n13))(not (successor n12 n2))(not (successor n12 n3))(not (successor n12 n4))(not (successor n12 n5))(not (successor n12 n6))(not (successor n12 n7))(not (successor n12 n8))(not (successor n12 n9))(not (successor n13 n0))(not (successor n13 n1))(not (successor n13 n10))(not (successor n13 n11))(successor n13 n12)(not (successor n13 n13))(not (successor n13 n2))(not (successor n13 n3))(not (successor n13 n4))(not (successor n13 n5))(not (successor n13 n6))(not (successor n13 n7))(not (successor n13 n8))(not (successor n13 n9))(not (successor n2 n0))(successor n2 n1)(not (successor n2 n10))(not (successor n2 n11))(not (successor n2 n12))(not (successor n2 n13))(not (successor n2 n2))(not (successor n2 n3))(not (successor n2 n4))(not (successor n2 n5))(not (successor n2 n6))(not (successor n2 n7))(not (successor n2 n8))(not (successor n2 n9))(not (successor n3 n0))(not (successor n3 n1))(not (successor n3 n10))(not (successor n3 n11))(not (successor n3 n12))(not (successor n3 n13))(successor n3 n2)(not (successor n3 n3))(not (successor n3 n4))(not (successor n3 n5))(not (successor n3 n6))(not (successor n3 n7))(not (successor n3 n8))(not (successor n3 n9))(not (successor n4 n0))(not (successor n4 n1))(not (successor n4 n10))(not (successor n4 n11))(not (successor n4 n12))(not (successor n4 n13))(not (successor n4 n2))(successor n4 n3)(not (successor n4 n4))(not (successor n4 n5))(not (successor n4 n6))(not (successor n4 n7))(not (successor n4 n8))(not (successor n4 n9))(not (successor n5 n0))(not (successor n5 n1))(not (successor n5 n10))(not (successor n5 n11))(not (successor n5 n12))(not (successor n5 n13))(not (successor n5 n2))(not (successor n5 n3))(successor n5 n4)(not (successor n5 n5))(not (successor n5 n6))(not (successor n5 n7))(not (successor n5 n8))(not (successor n5 n9))(not (successor n6 n0))(not (successor n6 n1))(not (successor n6 n10))(not (successor n6 n11))(not (successor n6 n12))(not (successor n6 n13))(not (successor n6 n2))(not (successor n6 n3))(not (successor n6 n4))(successor n6 n5)(not (successor n6 n6))(not (successor n6 n7))(not (successor n6 n8))(not (successor n6 n9))(not (successor n7 n0))(not (successor n7 n1))(not (successor n7 n10))(not (successor n7 n11))(not (successor n7 n12))(not (successor n7 n13))(not (successor n7 n2))(not (successor n7 n3))(not (successor n7 n4))(not (successor n7 n5))(successor n7 n6)(not (successor n7 n7))(not (successor n7 n8))(not (successor n7 n9))(not (successor n8 n0))(not (successor n8 n1))(not (successor n8 n10))(not (successor n8 n11))(not (successor n8 n12))(not (successor n8 n13))(not (successor n8 n2))(not (successor n8 n3))(not (successor n8 n4))(not (successor n8 n5))(not (successor n8 n6))(successor n8 n7)(not (successor n8 n8))(not (successor n8 n9))(not (successor n9 n0))(not (successor n9 n1))(not (successor n9 n10))(not (successor n9 n11))(not (successor n9 n12))(not (successor n9 n13))(not (successor n9 n2))(not (successor n9 n3))(not (successor n9 n4))(not (successor n9 n5))(not (successor n9 n6))(not (successor n9 n7))(successor n9 n8)(not (successor n9 n9))(suit c0 c)(not (suit c0 d))(not (suit c0 h))(not (suit c0 s))(suit c2 c)(not (suit c2 d))(not (suit c2 h))(not (suit c2 s))(suit ca c)(not (suit ca d))(not (suit ca h))(not (suit ca s))(not (suit d0 c))(suit d0 d)(not (suit d0 h))(not (suit d0 s))(not (suit d2 c))(suit d2 d)(not (suit d2 h))(not (suit d2 s))(not (suit da c))(suit da d)(not (suit da h))(not (suit da s))(not (suit h0 c))(not (suit h0 d))(suit h0 h)(not (suit h0 s))(not (suit h2 c))(not (suit h2 d))(suit h2 h)(not (suit h2 s))(not (suit ha c))(not (suit ha d))(suit ha h)(not (suit ha s))(not (suit s0 c))(not (suit s0 d))(not (suit s0 h))(suit s0 s)(not (suit s2 c))(not (suit s2 d))(not (suit s2 h))(suit s2 s)(not (suit sa c))(not (suit sa d))(not (suit sa h))(suit sa s)(value c0 n0)(not (value c0 n1))(not (value c0 n10))(not (value c0 n11))(not (value c0 n12))(not (value c0 n13))(not (value c0 n2))(not (value c0 n3))(not (value c0 n4))(not (value c0 n5))(not (value c0 n6))(not (value c0 n7))(not (value c0 n8))(not (value c0 n9))(not (value c2 n0))(not (value c2 n1))(not (value c2 n10))(not (value c2 n11))(not (value c2 n12))(not (value c2 n13))(value c2 n2)(not (value c2 n3))(not (value c2 n4))(not (value c2 n5))(not (value c2 n6))(not (value c2 n7))(not (value c2 n8))(not (value c2 n9))(not (value ca n0))(value ca n1)(not (value ca n10))(not (value ca n11))(not (value ca n12))(not (value ca n13))(not (value ca n2))(not (value ca n3))(not (value ca n4))(not (value ca n5))(not (value ca n6))(not (value ca n7))(not (value ca n8))(not (value ca n9))(value d0 n0)(not (value d0 n1))(not (value d0 n10))(not (value d0 n11))(not (value d0 n12))(not (value d0 n13))(not (value d0 n2))(not (value d0 n3))(not (value d0 n4))(not (value d0 n5))(not (value d0 n6))(not (value d0 n7))(not (value d0 n8))(not (value d0 n9))(not (value d2 n0))(not (value d2 n1))(not (value d2 n10))(not (value d2 n11))(not (value d2 n12))(not (value d2 n13))(value d2 n2)(not (value d2 n3))(not (value d2 n4))(not (value d2 n5))(not (value d2 n6))(not (value d2 n7))(not (value d2 n8))(not (value d2 n9))(not (value da n0))(value da n1)(not (value da n10))(not (value da n11))(not (value da n12))(not (value da n13))(not (value da n2))(not (value da n3))(not (value da n4))(not (value da n5))(not (value da n6))(not (value da n7))(not (value da n8))(not (value da n9))(value h0 n0)(not (value h0 n1))(not (value h0 n10))(not (value h0 n11))(not (value h0 n12))(not (value h0 n13))(not (value h0 n2))(not (value h0 n3))(not (value h0 n4))(not (value h0 n5))(not (value h0 n6))(not (value h0 n7))(not (value h0 n8))(not (value h0 n9))(not (value h2 n0))(not (value h2 n1))(not (value h2 n10))(not (value h2 n11))(not (value h2 n12))(not (value h2 n13))(value h2 n2)(not (value h2 n3))(not (value h2 n4))(not (value h2 n5))(not (value h2 n6))(not (value h2 n7))(not (value h2 n8))(not (value h2 n9))(not (value ha n0))(value ha n1)(not (value ha n10))(not (value ha n11))(not (value ha n12))(not (value ha n13))(not (value ha n2))(not (value ha n3))(not (value ha n4))(not (value ha n5))(not (value ha n6))(not (value ha n7))(not (value ha n8))(not (value ha n9))(value s0 n0)(not (value s0 n1))(not (value s0 n10))(not (value s0 n11))(not (value s0 n12))(not (value s0 n13))(not (value s0 n2))(not (value s0 n3))(not (value s0 n4))(not (value s0 n5))(not (value s0 n6))(not (value s0 n7))(not (value s0 n8))(not (value s0 n9))(not (value s2 n0))(not (value s2 n1))(not (value s2 n10))(not (value s2 n11))(not (value s2 n12))(not (value s2 n13))(value s2 n2)(not (value s2 n3))(not (value s2 n4))(not (value s2 n5))(not (value s2 n6))(not (value s2 n7))(not (value s2 n8))(not (value s2 n9))(not (value sa n0))(value sa n1)(not (value sa n10))(not (value sa n11))(not (value sa n12))(not (value sa n13))(not (value sa n2))(not (value sa n3))(not (value sa n4))(not (value sa n5))(not (value sa n6))(not (value sa n7))(not (value sa n8))(not (value sa n9))(test2 ))
   :effect (and (not (plan-sendtohome-b i1 ha h n1 h0 n0 n3 n4))(not (plan-sendtohome-b i2 c2 c n2 ca n1 n4 n5))(not (plan-sendtohome-b i3 d2 d n2 da n1 n5 n6))(current i1)(not (current i4))(not (home d2))(not (home ha))(not (colspace n6))(not (home sa))(not (home c2))(home c0)(home d0)(on ha ca)(on c2 sa)(home h0)(home s0)(clear ha)(bottomcol ca)(clear c2)(bottomcol d2)(clear da)(bottomcol da)(colspace n3)(on sa d2)(plan-move i1 ha ca s2)(plan-sendtohome i2 ha s2 h n1 h0 n0)(plan-sendtohome-b i3 ca c n1 c0 n0 n3 n4)(test3 )(not (test2 ))(not (action_applied ))))

 (:action validate_4
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(not (bottomcol c0))(not (bottomcol c2))(not (bottomcol ca))(not (bottomcol d0))(bottomcol d2)(bottomcol da)(not (bottomcol h0))(bottomcol h2)(not (bottomcol ha))(not (bottomcol s0))(bottomcol s2)(not (bottomcol sa))(not (canstack c0 c0))(not (canstack c0 c2))(not (canstack c0 ca))(not (canstack c0 d0))(not (canstack c0 d2))(not (canstack c0 da))(not (canstack c0 h0))(not (canstack c0 h2))(not (canstack c0 ha))(not (canstack c0 s0))(not (canstack c0 s2))(not (canstack c0 sa))(not (canstack c2 c0))(not (canstack c2 c2))(not (canstack c2 ca))(not (canstack c2 d0))(not (canstack c2 d2))(not (canstack c2 da))(not (canstack c2 h0))(not (canstack c2 h2))(not (canstack c2 ha))(not (canstack c2 s0))(not (canstack c2 s2))(not (canstack c2 sa))(not (canstack ca c0))(not (canstack ca c2))(not (canstack ca ca))(not (canstack ca d0))(canstack ca d2)(not (canstack ca da))(not (canstack ca h0))(canstack ca h2)(not (canstack ca ha))(not (canstack ca s0))(not (canstack ca s2))(not (canstack ca sa))(not (canstack d0 c0))(not (canstack d0 c2))(not (canstack d0 ca))(not (canstack d0 d0))(not (canstack d0 d2))(not (canstack d0 da))(not (canstack d0 h0))(not (canstack d0 h2))(not (canstack d0 ha))(not (canstack d0 s0))(not (canstack d0 s2))(not (canstack d0 sa))(not (canstack d2 c0))(not (canstack d2 c2))(not (canstack d2 ca))(not (canstack d2 d0))(not (canstack d2 d2))(not (canstack d2 da))(not (canstack d2 h0))(not (canstack d2 h2))(not (canstack d2 ha))(not (canstack d2 s0))(not (canstack d2 s2))(not (canstack d2 sa))(not (canstack da c0))(canstack da c2)(not (canstack da ca))(not (canstack da d0))(not (canstack da d2))(not (canstack da da))(not (canstack da h0))(not (canstack da h2))(not (canstack da ha))(not (canstack da s0))(canstack da s2)(not (canstack da sa))(not (canstack h0 c0))(not (canstack h0 c2))(not (canstack h0 ca))(not (canstack h0 d0))(not (canstack h0 d2))(not (canstack h0 da))(not (canstack h0 h0))(not (canstack h0 h2))(not (canstack h0 ha))(not (canstack h0 s0))(not (canstack h0 s2))(not (canstack h0 sa))(not (canstack h2 c0))(not (canstack h2 c2))(not (canstack h2 ca))(not (canstack h2 d0))(not (canstack h2 d2))(not (canstack h2 da))(not (canstack h2 h0))(not (canstack h2 h2))(not (canstack h2 ha))(not (canstack h2 s0))(not (canstack h2 s2))(not (canstack h2 sa))(not (canstack ha c0))(canstack ha c2)(not (canstack ha ca))(not (canstack ha d0))(not (canstack ha d2))(not (canstack ha da))(not (canstack ha h0))(not (canstack ha h2))(not (canstack ha ha))(not (canstack ha s0))(canstack ha s2)(not (canstack ha sa))(not (canstack s0 c0))(not (canstack s0 c2))(not (canstack s0 ca))(not (canstack s0 d0))(not (canstack s0 d2))(not (canstack s0 da))(not (canstack s0 h0))(not (canstack s0 h2))(not (canstack s0 ha))(not (canstack s0 s0))(not (canstack s0 s2))(not (canstack s0 sa))(not (canstack s2 c0))(not (canstack s2 c2))(not (canstack s2 ca))(not (canstack s2 d0))(not (canstack s2 d2))(not (canstack s2 da))(not (canstack s2 h0))(not (canstack s2 h2))(not (canstack s2 ha))(not (canstack s2 s0))(not (canstack s2 s2))(not (canstack s2 sa))(not (canstack sa c0))(not (canstack sa c2))(not (canstack sa ca))(not (canstack sa d0))(canstack sa d2)(not (canstack sa da))(not (canstack sa h0))(canstack sa h2)(not (canstack sa ha))(not (canstack sa s0))(not (canstack sa s2))(not (canstack sa sa))(not (cellspace n0))(not (cellspace n1))(not (cellspace n10))(not (cellspace n11))(not (cellspace n12))(not (cellspace n13))(not (cellspace n2))(not (cellspace n3))(cellspace n4)(not (cellspace n5))(not (cellspace n6))(not (cellspace n7))(not (cellspace n8))(not (cellspace n9))(not (clear c0))(clear c2)(not (clear ca))(not (clear d0))(not (clear d2))(clear da)(not (clear h0))(clear h2)(not (clear ha))(not (clear s0))(clear s2)(not (clear sa))(not (colspace n0))(not (colspace n1))(not (colspace n10))(not (colspace n11))(not (colspace n12))(not (colspace n13))(not (colspace n2))(not (colspace n3))(colspace n4)(not (colspace n5))(not (colspace n6))(not (colspace n7))(not (colspace n8))(not (colspace n9))(not (home c0))(not (home c2))(home ca)(home d0)(not (home d2))(not (home da))(not (home h0))(not (home h2))(home ha)(home s0)(not (home s2))(not (home sa))(not (incell c0))(not (incell c2))(not (incell ca))(not (incell d0))(not (incell d2))(not (incell da))(not (incell h0))(not (incell h2))(not (incell ha))(not (incell s0))(not (incell s2))(not (incell sa))(not (on c0 c0))(not (on c0 c2))(not (on c0 ca))(not (on c0 d0))(not (on c0 d2))(not (on c0 da))(not (on c0 h0))(not (on c0 h2))(not (on c0 ha))(not (on c0 s0))(not (on c0 s2))(not (on c0 sa))(not (on c2 c0))(not (on c2 c2))(not (on c2 ca))(not (on c2 d0))(not (on c2 d2))(not (on c2 da))(not (on c2 h0))(not (on c2 h2))(not (on c2 ha))(not (on c2 s0))(not (on c2 s2))(on c2 sa)(not (on ca c0))(not (on ca c2))(not (on ca ca))(not (on ca d0))(not (on ca d2))(not (on ca da))(not (on ca h0))(not (on ca h2))(not (on ca ha))(not (on ca s0))(not (on ca s2))(not (on ca sa))(not (on d0 c0))(not (on d0 c2))(not (on d0 ca))(not (on d0 d0))(not (on d0 d2))(not (on d0 da))(not (on d0 h0))(not (on d0 h2))(not (on d0 ha))(not (on d0 s0))(not (on d0 s2))(not (on d0 sa))(not (on d2 c0))(not (on d2 c2))(not (on d2 ca))(not (on d2 d0))(not (on d2 d2))(not (on d2 da))(not (on d2 h0))(not (on d2 h2))(not (on d2 ha))(not (on d2 s0))(not (on d2 s2))(not (on d2 sa))(not (on da c0))(not (on da c2))(not (on da ca))(not (on da d0))(not (on da d2))(not (on da da))(not (on da h0))(not (on da h2))(not (on da ha))(not (on da s0))(not (on da s2))(not (on da sa))(not (on h0 c0))(not (on h0 c2))(not (on h0 ca))(not (on h0 d0))(not (on h0 d2))(not (on h0 da))(not (on h0 h0))(not (on h0 h2))(not (on h0 ha))(not (on h0 s0))(not (on h0 s2))(not (on h0 sa))(not (on h2 c0))(not (on h2 c2))(not (on h2 ca))(not (on h2 d0))(not (on h2 d2))(not (on h2 da))(not (on h2 h0))(not (on h2 h2))(not (on h2 ha))(not (on h2 s0))(not (on h2 s2))(not (on h2 sa))(not (on ha c0))(not (on ha c2))(not (on ha ca))(not (on ha d0))(not (on ha d2))(not (on ha da))(not (on ha h0))(not (on ha h2))(not (on ha ha))(not (on ha s0))(not (on ha s2))(not (on ha sa))(not (on s0 c0))(not (on s0 c2))(not (on s0 ca))(not (on s0 d0))(not (on s0 d2))(not (on s0 da))(not (on s0 h0))(not (on s0 h2))(not (on s0 ha))(not (on s0 s0))(not (on s0 s2))(not (on s0 sa))(not (on s2 c0))(not (on s2 c2))(not (on s2 ca))(not (on s2 d0))(not (on s2 d2))(not (on s2 da))(not (on s2 h0))(not (on s2 h2))(not (on s2 ha))(not (on s2 s0))(not (on s2 s2))(not (on s2 sa))(not (on sa c0))(not (on sa c2))(not (on sa ca))(not (on sa d0))(on sa d2)(not (on sa da))(not (on sa h0))(not (on sa h2))(not (on sa ha))(not (on sa s0))(not (on sa s2))(not (on sa sa))(not (successor n0 n0))(not (successor n0 n1))(not (successor n0 n10))(not (successor n0 n11))(not (successor n0 n12))(not (successor n0 n13))(not (successor n0 n2))(not (successor n0 n3))(not (successor n0 n4))(not (successor n0 n5))(not (successor n0 n6))(not (successor n0 n7))(not (successor n0 n8))(not (successor n0 n9))(successor n1 n0)(not (successor n1 n1))(not (successor n1 n10))(not (successor n1 n11))(not (successor n1 n12))(not (successor n1 n13))(not (successor n1 n2))(not (successor n1 n3))(not (successor n1 n4))(not (successor n1 n5))(not (successor n1 n6))(not (successor n1 n7))(not (successor n1 n8))(not (successor n1 n9))(not (successor n10 n0))(not (successor n10 n1))(not (successor n10 n10))(not (successor n10 n11))(not (successor n10 n12))(not (successor n10 n13))(not (successor n10 n2))(not (successor n10 n3))(not (successor n10 n4))(not (successor n10 n5))(not (successor n10 n6))(not (successor n10 n7))(not (successor n10 n8))(successor n10 n9)(not (successor n11 n0))(not (successor n11 n1))(successor n11 n10)(not (successor n11 n11))(not (successor n11 n12))(not (successor n11 n13))(not (successor n11 n2))(not (successor n11 n3))(not (successor n11 n4))(not (successor n11 n5))(not (successor n11 n6))(not (successor n11 n7))(not (successor n11 n8))(not (successor n11 n9))(not (successor n12 n0))(not (successor n12 n1))(not (successor n12 n10))(successor n12 n11)(not (successor n12 n12))(not (successor n12 n13))(not (successor n12 n2))(not (successor n12 n3))(not (successor n12 n4))(not (successor n12 n5))(not (successor n12 n6))(not (successor n12 n7))(not (successor n12 n8))(not (successor n12 n9))(not (successor n13 n0))(not (successor n13 n1))(not (successor n13 n10))(not (successor n13 n11))(successor n13 n12)(not (successor n13 n13))(not (successor n13 n2))(not (successor n13 n3))(not (successor n13 n4))(not (successor n13 n5))(not (successor n13 n6))(not (successor n13 n7))(not (successor n13 n8))(not (successor n13 n9))(not (successor n2 n0))(successor n2 n1)(not (successor n2 n10))(not (successor n2 n11))(not (successor n2 n12))(not (successor n2 n13))(not (successor n2 n2))(not (successor n2 n3))(not (successor n2 n4))(not (successor n2 n5))(not (successor n2 n6))(not (successor n2 n7))(not (successor n2 n8))(not (successor n2 n9))(not (successor n3 n0))(not (successor n3 n1))(not (successor n3 n10))(not (successor n3 n11))(not (successor n3 n12))(not (successor n3 n13))(successor n3 n2)(not (successor n3 n3))(not (successor n3 n4))(not (successor n3 n5))(not (successor n3 n6))(not (successor n3 n7))(not (successor n3 n8))(not (successor n3 n9))(not (successor n4 n0))(not (successor n4 n1))(not (successor n4 n10))(not (successor n4 n11))(not (successor n4 n12))(not (successor n4 n13))(not (successor n4 n2))(successor n4 n3)(not (successor n4 n4))(not (successor n4 n5))(not (successor n4 n6))(not (successor n4 n7))(not (successor n4 n8))(not (successor n4 n9))(not (successor n5 n0))(not (successor n5 n1))(not (successor n5 n10))(not (successor n5 n11))(not (successor n5 n12))(not (successor n5 n13))(not (successor n5 n2))(not (successor n5 n3))(successor n5 n4)(not (successor n5 n5))(not (successor n5 n6))(not (successor n5 n7))(not (successor n5 n8))(not (successor n5 n9))(not (successor n6 n0))(not (successor n6 n1))(not (successor n6 n10))(not (successor n6 n11))(not (successor n6 n12))(not (successor n6 n13))(not (successor n6 n2))(not (successor n6 n3))(not (successor n6 n4))(successor n6 n5)(not (successor n6 n6))(not (successor n6 n7))(not (successor n6 n8))(not (successor n6 n9))(not (successor n7 n0))(not (successor n7 n1))(not (successor n7 n10))(not (successor n7 n11))(not (successor n7 n12))(not (successor n7 n13))(not (successor n7 n2))(not (successor n7 n3))(not (successor n7 n4))(not (successor n7 n5))(successor n7 n6)(not (successor n7 n7))(not (successor n7 n8))(not (successor n7 n9))(not (successor n8 n0))(not (successor n8 n1))(not (successor n8 n10))(not (successor n8 n11))(not (successor n8 n12))(not (successor n8 n13))(not (successor n8 n2))(not (successor n8 n3))(not (successor n8 n4))(not (successor n8 n5))(not (successor n8 n6))(successor n8 n7)(not (successor n8 n8))(not (successor n8 n9))(not (successor n9 n0))(not (successor n9 n1))(not (successor n9 n10))(not (successor n9 n11))(not (successor n9 n12))(not (successor n9 n13))(not (successor n9 n2))(not (successor n9 n3))(not (successor n9 n4))(not (successor n9 n5))(not (successor n9 n6))(not (successor n9 n7))(successor n9 n8)(not (successor n9 n9))(suit c0 c)(not (suit c0 d))(not (suit c0 h))(not (suit c0 s))(suit c2 c)(not (suit c2 d))(not (suit c2 h))(not (suit c2 s))(suit ca c)(not (suit ca d))(not (suit ca h))(not (suit ca s))(not (suit d0 c))(suit d0 d)(not (suit d0 h))(not (suit d0 s))(not (suit d2 c))(suit d2 d)(not (suit d2 h))(not (suit d2 s))(not (suit da c))(suit da d)(not (suit da h))(not (suit da s))(not (suit h0 c))(not (suit h0 d))(suit h0 h)(not (suit h0 s))(not (suit h2 c))(not (suit h2 d))(suit h2 h)(not (suit h2 s))(not (suit ha c))(not (suit ha d))(suit ha h)(not (suit ha s))(not (suit s0 c))(not (suit s0 d))(not (suit s0 h))(suit s0 s)(not (suit s2 c))(not (suit s2 d))(not (suit s2 h))(suit s2 s)(not (suit sa c))(not (suit sa d))(not (suit sa h))(suit sa s)(value c0 n0)(not (value c0 n1))(not (value c0 n10))(not (value c0 n11))(not (value c0 n12))(not (value c0 n13))(not (value c0 n2))(not (value c0 n3))(not (value c0 n4))(not (value c0 n5))(not (value c0 n6))(not (value c0 n7))(not (value c0 n8))(not (value c0 n9))(not (value c2 n0))(not (value c2 n1))(not (value c2 n10))(not (value c2 n11))(not (value c2 n12))(not (value c2 n13))(value c2 n2)(not (value c2 n3))(not (value c2 n4))(not (value c2 n5))(not (value c2 n6))(not (value c2 n7))(not (value c2 n8))(not (value c2 n9))(not (value ca n0))(value ca n1)(not (value ca n10))(not (value ca n11))(not (value ca n12))(not (value ca n13))(not (value ca n2))(not (value ca n3))(not (value ca n4))(not (value ca n5))(not (value ca n6))(not (value ca n7))(not (value ca n8))(not (value ca n9))(value d0 n0)(not (value d0 n1))(not (value d0 n10))(not (value d0 n11))(not (value d0 n12))(not (value d0 n13))(not (value d0 n2))(not (value d0 n3))(not (value d0 n4))(not (value d0 n5))(not (value d0 n6))(not (value d0 n7))(not (value d0 n8))(not (value d0 n9))(not (value d2 n0))(not (value d2 n1))(not (value d2 n10))(not (value d2 n11))(not (value d2 n12))(not (value d2 n13))(value d2 n2)(not (value d2 n3))(not (value d2 n4))(not (value d2 n5))(not (value d2 n6))(not (value d2 n7))(not (value d2 n8))(not (value d2 n9))(not (value da n0))(value da n1)(not (value da n10))(not (value da n11))(not (value da n12))(not (value da n13))(not (value da n2))(not (value da n3))(not (value da n4))(not (value da n5))(not (value da n6))(not (value da n7))(not (value da n8))(not (value da n9))(value h0 n0)(not (value h0 n1))(not (value h0 n10))(not (value h0 n11))(not (value h0 n12))(not (value h0 n13))(not (value h0 n2))(not (value h0 n3))(not (value h0 n4))(not (value h0 n5))(not (value h0 n6))(not (value h0 n7))(not (value h0 n8))(not (value h0 n9))(not (value h2 n0))(not (value h2 n1))(not (value h2 n10))(not (value h2 n11))(not (value h2 n12))(not (value h2 n13))(value h2 n2)(not (value h2 n3))(not (value h2 n4))(not (value h2 n5))(not (value h2 n6))(not (value h2 n7))(not (value h2 n8))(not (value h2 n9))(not (value ha n0))(value ha n1)(not (value ha n10))(not (value ha n11))(not (value ha n12))(not (value ha n13))(not (value ha n2))(not (value ha n3))(not (value ha n4))(not (value ha n5))(not (value ha n6))(not (value ha n7))(not (value ha n8))(not (value ha n9))(value s0 n0)(not (value s0 n1))(not (value s0 n10))(not (value s0 n11))(not (value s0 n12))(not (value s0 n13))(not (value s0 n2))(not (value s0 n3))(not (value s0 n4))(not (value s0 n5))(not (value s0 n6))(not (value s0 n7))(not (value s0 n8))(not (value s0 n9))(not (value s2 n0))(not (value s2 n1))(not (value s2 n10))(not (value s2 n11))(not (value s2 n12))(not (value s2 n13))(value s2 n2)(not (value s2 n3))(not (value s2 n4))(not (value s2 n5))(not (value s2 n6))(not (value s2 n7))(not (value s2 n8))(not (value s2 n9))(not (value sa n0))(value sa n1)(not (value sa n10))(not (value sa n11))(not (value sa n12))(not (value sa n13))(not (value sa n2))(not (value sa n3))(not (value sa n4))(not (value sa n5))(not (value sa n6))(not (value sa n7))(not (value sa n8))(not (value sa n9))(test3 ))
   :effect (and (not (plan-move i1 ha ca s2))(not (plan-sendtohome i2 ha s2 h n1 h0 n0))(not (plan-sendtohome-b i3 ca c n1 c0 n0 n3 n4))(current i1)(not (current i4))(plan-sendtohome i1 c2 sa c n2 ca n1)(plan-sendtohome i2 sa d2 s n1 s0 n0)(plan-sendtohome-b i3 da d n1 d0 n0 n4 n5)(test4 )(not (test3 ))(not (action_applied ))))

 (:action validate_5
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(not (bottomcol c0))(not (bottomcol c2))(not (bottomcol ca))(not (bottomcol d0))(bottomcol d2)(not (bottomcol da))(not (bottomcol h0))(bottomcol h2)(not (bottomcol ha))(not (bottomcol s0))(bottomcol s2)(not (bottomcol sa))(not (canstack c0 c0))(not (canstack c0 c2))(not (canstack c0 ca))(not (canstack c0 d0))(not (canstack c0 d2))(not (canstack c0 da))(not (canstack c0 h0))(not (canstack c0 h2))(not (canstack c0 ha))(not (canstack c0 s0))(not (canstack c0 s2))(not (canstack c0 sa))(not (canstack c2 c0))(not (canstack c2 c2))(not (canstack c2 ca))(not (canstack c2 d0))(not (canstack c2 d2))(not (canstack c2 da))(not (canstack c2 h0))(not (canstack c2 h2))(not (canstack c2 ha))(not (canstack c2 s0))(not (canstack c2 s2))(not (canstack c2 sa))(not (canstack ca c0))(not (canstack ca c2))(not (canstack ca ca))(not (canstack ca d0))(canstack ca d2)(not (canstack ca da))(not (canstack ca h0))(canstack ca h2)(not (canstack ca ha))(not (canstack ca s0))(not (canstack ca s2))(not (canstack ca sa))(not (canstack d0 c0))(not (canstack d0 c2))(not (canstack d0 ca))(not (canstack d0 d0))(not (canstack d0 d2))(not (canstack d0 da))(not (canstack d0 h0))(not (canstack d0 h2))(not (canstack d0 ha))(not (canstack d0 s0))(not (canstack d0 s2))(not (canstack d0 sa))(not (canstack d2 c0))(not (canstack d2 c2))(not (canstack d2 ca))(not (canstack d2 d0))(not (canstack d2 d2))(not (canstack d2 da))(not (canstack d2 h0))(not (canstack d2 h2))(not (canstack d2 ha))(not (canstack d2 s0))(not (canstack d2 s2))(not (canstack d2 sa))(not (canstack da c0))(canstack da c2)(not (canstack da ca))(not (canstack da d0))(not (canstack da d2))(not (canstack da da))(not (canstack da h0))(not (canstack da h2))(not (canstack da ha))(not (canstack da s0))(canstack da s2)(not (canstack da sa))(not (canstack h0 c0))(not (canstack h0 c2))(not (canstack h0 ca))(not (canstack h0 d0))(not (canstack h0 d2))(not (canstack h0 da))(not (canstack h0 h0))(not (canstack h0 h2))(not (canstack h0 ha))(not (canstack h0 s0))(not (canstack h0 s2))(not (canstack h0 sa))(not (canstack h2 c0))(not (canstack h2 c2))(not (canstack h2 ca))(not (canstack h2 d0))(not (canstack h2 d2))(not (canstack h2 da))(not (canstack h2 h0))(not (canstack h2 h2))(not (canstack h2 ha))(not (canstack h2 s0))(not (canstack h2 s2))(not (canstack h2 sa))(not (canstack ha c0))(canstack ha c2)(not (canstack ha ca))(not (canstack ha d0))(not (canstack ha d2))(not (canstack ha da))(not (canstack ha h0))(not (canstack ha h2))(not (canstack ha ha))(not (canstack ha s0))(canstack ha s2)(not (canstack ha sa))(not (canstack s0 c0))(not (canstack s0 c2))(not (canstack s0 ca))(not (canstack s0 d0))(not (canstack s0 d2))(not (canstack s0 da))(not (canstack s0 h0))(not (canstack s0 h2))(not (canstack s0 ha))(not (canstack s0 s0))(not (canstack s0 s2))(not (canstack s0 sa))(not (canstack s2 c0))(not (canstack s2 c2))(not (canstack s2 ca))(not (canstack s2 d0))(not (canstack s2 d2))(not (canstack s2 da))(not (canstack s2 h0))(not (canstack s2 h2))(not (canstack s2 ha))(not (canstack s2 s0))(not (canstack s2 s2))(not (canstack s2 sa))(not (canstack sa c0))(not (canstack sa c2))(not (canstack sa ca))(not (canstack sa d0))(canstack sa d2)(not (canstack sa da))(not (canstack sa h0))(canstack sa h2)(not (canstack sa ha))(not (canstack sa s0))(not (canstack sa s2))(not (canstack sa sa))(not (cellspace n0))(not (cellspace n1))(not (cellspace n10))(not (cellspace n11))(not (cellspace n12))(not (cellspace n13))(not (cellspace n2))(not (cellspace n3))(cellspace n4)(not (cellspace n5))(not (cellspace n6))(not (cellspace n7))(not (cellspace n8))(not (cellspace n9))(not (clear c0))(not (clear c2))(not (clear ca))(not (clear d0))(clear d2)(not (clear da))(not (clear h0))(clear h2)(not (clear ha))(not (clear s0))(clear s2)(not (clear sa))(not (colspace n0))(not (colspace n1))(not (colspace n10))(not (colspace n11))(not (colspace n12))(not (colspace n13))(not (colspace n2))(not (colspace n3))(not (colspace n4))(colspace n5)(not (colspace n6))(not (colspace n7))(not (colspace n8))(not (colspace n9))(not (home c0))(home c2)(not (home ca))(not (home d0))(not (home d2))(home da)(not (home h0))(not (home h2))(home ha)(not (home s0))(not (home s2))(home sa)(not (incell c0))(not (incell c2))(not (incell ca))(not (incell d0))(not (incell d2))(not (incell da))(not (incell h0))(not (incell h2))(not (incell ha))(not (incell s0))(not (incell s2))(not (incell sa))(not (on c0 c0))(not (on c0 c2))(not (on c0 ca))(not (on c0 d0))(not (on c0 d2))(not (on c0 da))(not (on c0 h0))(not (on c0 h2))(not (on c0 ha))(not (on c0 s0))(not (on c0 s2))(not (on c0 sa))(not (on c2 c0))(not (on c2 c2))(not (on c2 ca))(not (on c2 d0))(not (on c2 d2))(not (on c2 da))(not (on c2 h0))(not (on c2 h2))(not (on c2 ha))(not (on c2 s0))(not (on c2 s2))(not (on c2 sa))(not (on ca c0))(not (on ca c2))(not (on ca ca))(not (on ca d0))(not (on ca d2))(not (on ca da))(not (on ca h0))(not (on ca h2))(not (on ca ha))(not (on ca s0))(not (on ca s2))(not (on ca sa))(not (on d0 c0))(not (on d0 c2))(not (on d0 ca))(not (on d0 d0))(not (on d0 d2))(not (on d0 da))(not (on d0 h0))(not (on d0 h2))(not (on d0 ha))(not (on d0 s0))(not (on d0 s2))(not (on d0 sa))(not (on d2 c0))(not (on d2 c2))(not (on d2 ca))(not (on d2 d0))(not (on d2 d2))(not (on d2 da))(not (on d2 h0))(not (on d2 h2))(not (on d2 ha))(not (on d2 s0))(not (on d2 s2))(not (on d2 sa))(not (on da c0))(not (on da c2))(not (on da ca))(not (on da d0))(not (on da d2))(not (on da da))(not (on da h0))(not (on da h2))(not (on da ha))(not (on da s0))(not (on da s2))(not (on da sa))(not (on h0 c0))(not (on h0 c2))(not (on h0 ca))(not (on h0 d0))(not (on h0 d2))(not (on h0 da))(not (on h0 h0))(not (on h0 h2))(not (on h0 ha))(not (on h0 s0))(not (on h0 s2))(not (on h0 sa))(not (on h2 c0))(not (on h2 c2))(not (on h2 ca))(not (on h2 d0))(not (on h2 d2))(not (on h2 da))(not (on h2 h0))(not (on h2 h2))(not (on h2 ha))(not (on h2 s0))(not (on h2 s2))(not (on h2 sa))(not (on ha c0))(not (on ha c2))(not (on ha ca))(not (on ha d0))(not (on ha d2))(not (on ha da))(not (on ha h0))(not (on ha h2))(not (on ha ha))(not (on ha s0))(not (on ha s2))(not (on ha sa))(not (on s0 c0))(not (on s0 c2))(not (on s0 ca))(not (on s0 d0))(not (on s0 d2))(not (on s0 da))(not (on s0 h0))(not (on s0 h2))(not (on s0 ha))(not (on s0 s0))(not (on s0 s2))(not (on s0 sa))(not (on s2 c0))(not (on s2 c2))(not (on s2 ca))(not (on s2 d0))(not (on s2 d2))(not (on s2 da))(not (on s2 h0))(not (on s2 h2))(not (on s2 ha))(not (on s2 s0))(not (on s2 s2))(not (on s2 sa))(not (on sa c0))(not (on sa c2))(not (on sa ca))(not (on sa d0))(not (on sa d2))(not (on sa da))(not (on sa h0))(not (on sa h2))(not (on sa ha))(not (on sa s0))(not (on sa s2))(not (on sa sa))(not (successor n0 n0))(not (successor n0 n1))(not (successor n0 n10))(not (successor n0 n11))(not (successor n0 n12))(not (successor n0 n13))(not (successor n0 n2))(not (successor n0 n3))(not (successor n0 n4))(not (successor n0 n5))(not (successor n0 n6))(not (successor n0 n7))(not (successor n0 n8))(not (successor n0 n9))(successor n1 n0)(not (successor n1 n1))(not (successor n1 n10))(not (successor n1 n11))(not (successor n1 n12))(not (successor n1 n13))(not (successor n1 n2))(not (successor n1 n3))(not (successor n1 n4))(not (successor n1 n5))(not (successor n1 n6))(not (successor n1 n7))(not (successor n1 n8))(not (successor n1 n9))(not (successor n10 n0))(not (successor n10 n1))(not (successor n10 n10))(not (successor n10 n11))(not (successor n10 n12))(not (successor n10 n13))(not (successor n10 n2))(not (successor n10 n3))(not (successor n10 n4))(not (successor n10 n5))(not (successor n10 n6))(not (successor n10 n7))(not (successor n10 n8))(successor n10 n9)(not (successor n11 n0))(not (successor n11 n1))(successor n11 n10)(not (successor n11 n11))(not (successor n11 n12))(not (successor n11 n13))(not (successor n11 n2))(not (successor n11 n3))(not (successor n11 n4))(not (successor n11 n5))(not (successor n11 n6))(not (successor n11 n7))(not (successor n11 n8))(not (successor n11 n9))(not (successor n12 n0))(not (successor n12 n1))(not (successor n12 n10))(successor n12 n11)(not (successor n12 n12))(not (successor n12 n13))(not (successor n12 n2))(not (successor n12 n3))(not (successor n12 n4))(not (successor n12 n5))(not (successor n12 n6))(not (successor n12 n7))(not (successor n12 n8))(not (successor n12 n9))(not (successor n13 n0))(not (successor n13 n1))(not (successor n13 n10))(not (successor n13 n11))(successor n13 n12)(not (successor n13 n13))(not (successor n13 n2))(not (successor n13 n3))(not (successor n13 n4))(not (successor n13 n5))(not (successor n13 n6))(not (successor n13 n7))(not (successor n13 n8))(not (successor n13 n9))(not (successor n2 n0))(successor n2 n1)(not (successor n2 n10))(not (successor n2 n11))(not (successor n2 n12))(not (successor n2 n13))(not (successor n2 n2))(not (successor n2 n3))(not (successor n2 n4))(not (successor n2 n5))(not (successor n2 n6))(not (successor n2 n7))(not (successor n2 n8))(not (successor n2 n9))(not (successor n3 n0))(not (successor n3 n1))(not (successor n3 n10))(not (successor n3 n11))(not (successor n3 n12))(not (successor n3 n13))(successor n3 n2)(not (successor n3 n3))(not (successor n3 n4))(not (successor n3 n5))(not (successor n3 n6))(not (successor n3 n7))(not (successor n3 n8))(not (successor n3 n9))(not (successor n4 n0))(not (successor n4 n1))(not (successor n4 n10))(not (successor n4 n11))(not (successor n4 n12))(not (successor n4 n13))(not (successor n4 n2))(successor n4 n3)(not (successor n4 n4))(not (successor n4 n5))(not (successor n4 n6))(not (successor n4 n7))(not (successor n4 n8))(not (successor n4 n9))(not (successor n5 n0))(not (successor n5 n1))(not (successor n5 n10))(not (successor n5 n11))(not (successor n5 n12))(not (successor n5 n13))(not (successor n5 n2))(not (successor n5 n3))(successor n5 n4)(not (successor n5 n5))(not (successor n5 n6))(not (successor n5 n7))(not (successor n5 n8))(not (successor n5 n9))(not (successor n6 n0))(not (successor n6 n1))(not (successor n6 n10))(not (successor n6 n11))(not (successor n6 n12))(not (successor n6 n13))(not (successor n6 n2))(not (successor n6 n3))(not (successor n6 n4))(successor n6 n5)(not (successor n6 n6))(not (successor n6 n7))(not (successor n6 n8))(not (successor n6 n9))(not (successor n7 n0))(not (successor n7 n1))(not (successor n7 n10))(not (successor n7 n11))(not (successor n7 n12))(not (successor n7 n13))(not (successor n7 n2))(not (successor n7 n3))(not (successor n7 n4))(not (successor n7 n5))(successor n7 n6)(not (successor n7 n7))(not (successor n7 n8))(not (successor n7 n9))(not (successor n8 n0))(not (successor n8 n1))(not (successor n8 n10))(not (successor n8 n11))(not (successor n8 n12))(not (successor n8 n13))(not (successor n8 n2))(not (successor n8 n3))(not (successor n8 n4))(not (successor n8 n5))(not (successor n8 n6))(successor n8 n7)(not (successor n8 n8))(not (successor n8 n9))(not (successor n9 n0))(not (successor n9 n1))(not (successor n9 n10))(not (successor n9 n11))(not (successor n9 n12))(not (successor n9 n13))(not (successor n9 n2))(not (successor n9 n3))(not (successor n9 n4))(not (successor n9 n5))(not (successor n9 n6))(not (successor n9 n7))(successor n9 n8)(not (successor n9 n9))(suit c0 c)(not (suit c0 d))(not (suit c0 h))(not (suit c0 s))(suit c2 c)(not (suit c2 d))(not (suit c2 h))(not (suit c2 s))(suit ca c)(not (suit ca d))(not (suit ca h))(not (suit ca s))(not (suit d0 c))(suit d0 d)(not (suit d0 h))(not (suit d0 s))(not (suit d2 c))(suit d2 d)(not (suit d2 h))(not (suit d2 s))(not (suit da c))(suit da d)(not (suit da h))(not (suit da s))(not (suit h0 c))(not (suit h0 d))(suit h0 h)(not (suit h0 s))(not (suit h2 c))(not (suit h2 d))(suit h2 h)(not (suit h2 s))(not (suit ha c))(not (suit ha d))(suit ha h)(not (suit ha s))(not (suit s0 c))(not (suit s0 d))(not (suit s0 h))(suit s0 s)(not (suit s2 c))(not (suit s2 d))(not (suit s2 h))(suit s2 s)(not (suit sa c))(not (suit sa d))(not (suit sa h))(suit sa s)(value c0 n0)(not (value c0 n1))(not (value c0 n10))(not (value c0 n11))(not (value c0 n12))(not (value c0 n13))(not (value c0 n2))(not (value c0 n3))(not (value c0 n4))(not (value c0 n5))(not (value c0 n6))(not (value c0 n7))(not (value c0 n8))(not (value c0 n9))(not (value c2 n0))(not (value c2 n1))(not (value c2 n10))(not (value c2 n11))(not (value c2 n12))(not (value c2 n13))(value c2 n2)(not (value c2 n3))(not (value c2 n4))(not (value c2 n5))(not (value c2 n6))(not (value c2 n7))(not (value c2 n8))(not (value c2 n9))(not (value ca n0))(value ca n1)(not (value ca n10))(not (value ca n11))(not (value ca n12))(not (value ca n13))(not (value ca n2))(not (value ca n3))(not (value ca n4))(not (value ca n5))(not (value ca n6))(not (value ca n7))(not (value ca n8))(not (value ca n9))(value d0 n0)(not (value d0 n1))(not (value d0 n10))(not (value d0 n11))(not (value d0 n12))(not (value d0 n13))(not (value d0 n2))(not (value d0 n3))(not (value d0 n4))(not (value d0 n5))(not (value d0 n6))(not (value d0 n7))(not (value d0 n8))(not (value d0 n9))(not (value d2 n0))(not (value d2 n1))(not (value d2 n10))(not (value d2 n11))(not (value d2 n12))(not (value d2 n13))(value d2 n2)(not (value d2 n3))(not (value d2 n4))(not (value d2 n5))(not (value d2 n6))(not (value d2 n7))(not (value d2 n8))(not (value d2 n9))(not (value da n0))(value da n1)(not (value da n10))(not (value da n11))(not (value da n12))(not (value da n13))(not (value da n2))(not (value da n3))(not (value da n4))(not (value da n5))(not (value da n6))(not (value da n7))(not (value da n8))(not (value da n9))(value h0 n0)(not (value h0 n1))(not (value h0 n10))(not (value h0 n11))(not (value h0 n12))(not (value h0 n13))(not (value h0 n2))(not (value h0 n3))(not (value h0 n4))(not (value h0 n5))(not (value h0 n6))(not (value h0 n7))(not (value h0 n8))(not (value h0 n9))(not (value h2 n0))(not (value h2 n1))(not (value h2 n10))(not (value h2 n11))(not (value h2 n12))(not (value h2 n13))(value h2 n2)(not (value h2 n3))(not (value h2 n4))(not (value h2 n5))(not (value h2 n6))(not (value h2 n7))(not (value h2 n8))(not (value h2 n9))(not (value ha n0))(value ha n1)(not (value ha n10))(not (value ha n11))(not (value ha n12))(not (value ha n13))(not (value ha n2))(not (value ha n3))(not (value ha n4))(not (value ha n5))(not (value ha n6))(not (value ha n7))(not (value ha n8))(not (value ha n9))(value s0 n0)(not (value s0 n1))(not (value s0 n10))(not (value s0 n11))(not (value s0 n12))(not (value s0 n13))(not (value s0 n2))(not (value s0 n3))(not (value s0 n4))(not (value s0 n5))(not (value s0 n6))(not (value s0 n7))(not (value s0 n8))(not (value s0 n9))(not (value s2 n0))(not (value s2 n1))(not (value s2 n10))(not (value s2 n11))(not (value s2 n12))(not (value s2 n13))(value s2 n2)(not (value s2 n3))(not (value s2 n4))(not (value s2 n5))(not (value s2 n6))(not (value s2 n7))(not (value s2 n8))(not (value s2 n9))(not (value sa n0))(value sa n1)(not (value sa n10))(not (value sa n11))(not (value sa n12))(not (value sa n13))(not (value sa n2))(not (value sa n3))(not (value sa n4))(not (value sa n5))(not (value sa n6))(not (value sa n7))(not (value sa n8))(not (value sa n9))(test4 ))
   :effect (and (not (plan-sendtohome i1 c2 sa c n2 ca n1))(not (plan-sendtohome i2 sa d2 s n1 s0 n0))(not (plan-sendtohome-b i3 da d n1 d0 n0 n4 n5))(current i1)(not (current i4))(plan-sendtohome-b i1 d2 d n2 da n1 n5 n6)(plan-sendtohome-b i2 h2 h n2 ha n1 n6 n7)(plan-sendtohome-b i3 s2 s n2 sa n1 n7 n8)(test5 )(not (test4 ))(not (action_applied ))))

 (:action validate_6
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(not (bottomcol c0))(not (bottomcol c2))(not (bottomcol ca))(not (bottomcol d0))(not (bottomcol d2))(not (bottomcol da))(not (bottomcol h0))(not (bottomcol h2))(not (bottomcol ha))(not (bottomcol s0))(not (bottomcol s2))(not (bottomcol sa))(not (canstack c0 c0))(not (canstack c0 c2))(not (canstack c0 ca))(not (canstack c0 d0))(not (canstack c0 d2))(not (canstack c0 da))(not (canstack c0 h0))(not (canstack c0 h2))(not (canstack c0 ha))(not (canstack c0 s0))(not (canstack c0 s2))(not (canstack c0 sa))(not (canstack c2 c0))(not (canstack c2 c2))(not (canstack c2 ca))(not (canstack c2 d0))(not (canstack c2 d2))(not (canstack c2 da))(not (canstack c2 h0))(not (canstack c2 h2))(not (canstack c2 ha))(not (canstack c2 s0))(not (canstack c2 s2))(not (canstack c2 sa))(not (canstack ca c0))(not (canstack ca c2))(not (canstack ca ca))(not (canstack ca d0))(canstack ca d2)(not (canstack ca da))(not (canstack ca h0))(canstack ca h2)(not (canstack ca ha))(not (canstack ca s0))(not (canstack ca s2))(not (canstack ca sa))(not (canstack d0 c0))(not (canstack d0 c2))(not (canstack d0 ca))(not (canstack d0 d0))(not (canstack d0 d2))(not (canstack d0 da))(not (canstack d0 h0))(not (canstack d0 h2))(not (canstack d0 ha))(not (canstack d0 s0))(not (canstack d0 s2))(not (canstack d0 sa))(not (canstack d2 c0))(not (canstack d2 c2))(not (canstack d2 ca))(not (canstack d2 d0))(not (canstack d2 d2))(not (canstack d2 da))(not (canstack d2 h0))(not (canstack d2 h2))(not (canstack d2 ha))(not (canstack d2 s0))(not (canstack d2 s2))(not (canstack d2 sa))(not (canstack da c0))(canstack da c2)(not (canstack da ca))(not (canstack da d0))(not (canstack da d2))(not (canstack da da))(not (canstack da h0))(not (canstack da h2))(not (canstack da ha))(not (canstack da s0))(canstack da s2)(not (canstack da sa))(not (canstack h0 c0))(not (canstack h0 c2))(not (canstack h0 ca))(not (canstack h0 d0))(not (canstack h0 d2))(not (canstack h0 da))(not (canstack h0 h0))(not (canstack h0 h2))(not (canstack h0 ha))(not (canstack h0 s0))(not (canstack h0 s2))(not (canstack h0 sa))(not (canstack h2 c0))(not (canstack h2 c2))(not (canstack h2 ca))(not (canstack h2 d0))(not (canstack h2 d2))(not (canstack h2 da))(not (canstack h2 h0))(not (canstack h2 h2))(not (canstack h2 ha))(not (canstack h2 s0))(not (canstack h2 s2))(not (canstack h2 sa))(not (canstack ha c0))(canstack ha c2)(not (canstack ha ca))(not (canstack ha d0))(not (canstack ha d2))(not (canstack ha da))(not (canstack ha h0))(not (canstack ha h2))(not (canstack ha ha))(not (canstack ha s0))(canstack ha s2)(not (canstack ha sa))(not (canstack s0 c0))(not (canstack s0 c2))(not (canstack s0 ca))(not (canstack s0 d0))(not (canstack s0 d2))(not (canstack s0 da))(not (canstack s0 h0))(not (canstack s0 h2))(not (canstack s0 ha))(not (canstack s0 s0))(not (canstack s0 s2))(not (canstack s0 sa))(not (canstack s2 c0))(not (canstack s2 c2))(not (canstack s2 ca))(not (canstack s2 d0))(not (canstack s2 d2))(not (canstack s2 da))(not (canstack s2 h0))(not (canstack s2 h2))(not (canstack s2 ha))(not (canstack s2 s0))(not (canstack s2 s2))(not (canstack s2 sa))(not (canstack sa c0))(not (canstack sa c2))(not (canstack sa ca))(not (canstack sa d0))(canstack sa d2)(not (canstack sa da))(not (canstack sa h0))(canstack sa h2)(not (canstack sa ha))(not (canstack sa s0))(not (canstack sa s2))(not (canstack sa sa))(not (cellspace n0))(not (cellspace n1))(not (cellspace n10))(not (cellspace n11))(not (cellspace n12))(not (cellspace n13))(not (cellspace n2))(not (cellspace n3))(cellspace n4)(not (cellspace n5))(not (cellspace n6))(not (cellspace n7))(not (cellspace n8))(not (cellspace n9))(not (clear c0))(not (clear c2))(not (clear ca))(not (clear d0))(not (clear d2))(not (clear da))(not (clear h0))(not (clear h2))(not (clear ha))(not (clear s0))(not (clear s2))(not (clear sa))(not (colspace n0))(not (colspace n1))(not (colspace n10))(not (colspace n11))(not (colspace n12))(not (colspace n13))(not (colspace n2))(not (colspace n3))(not (colspace n4))(not (colspace n5))(not (colspace n6))(not (colspace n7))(colspace n8)(not (colspace n9))(not (home c0))(home c2)(not (home ca))(not (home d0))(home d2)(not (home da))(not (home h0))(home h2)(not (home ha))(not (home s0))(home s2)(not (home sa))(not (incell c0))(not (incell c2))(not (incell ca))(not (incell d0))(not (incell d2))(not (incell da))(not (incell h0))(not (incell h2))(not (incell ha))(not (incell s0))(not (incell s2))(not (incell sa))(not (on c0 c0))(not (on c0 c2))(not (on c0 ca))(not (on c0 d0))(not (on c0 d2))(not (on c0 da))(not (on c0 h0))(not (on c0 h2))(not (on c0 ha))(not (on c0 s0))(not (on c0 s2))(not (on c0 sa))(not (on c2 c0))(not (on c2 c2))(not (on c2 ca))(not (on c2 d0))(not (on c2 d2))(not (on c2 da))(not (on c2 h0))(not (on c2 h2))(not (on c2 ha))(not (on c2 s0))(not (on c2 s2))(not (on c2 sa))(not (on ca c0))(not (on ca c2))(not (on ca ca))(not (on ca d0))(not (on ca d2))(not (on ca da))(not (on ca h0))(not (on ca h2))(not (on ca ha))(not (on ca s0))(not (on ca s2))(not (on ca sa))(not (on d0 c0))(not (on d0 c2))(not (on d0 ca))(not (on d0 d0))(not (on d0 d2))(not (on d0 da))(not (on d0 h0))(not (on d0 h2))(not (on d0 ha))(not (on d0 s0))(not (on d0 s2))(not (on d0 sa))(not (on d2 c0))(not (on d2 c2))(not (on d2 ca))(not (on d2 d0))(not (on d2 d2))(not (on d2 da))(not (on d2 h0))(not (on d2 h2))(not (on d2 ha))(not (on d2 s0))(not (on d2 s2))(not (on d2 sa))(not (on da c0))(not (on da c2))(not (on da ca))(not (on da d0))(not (on da d2))(not (on da da))(not (on da h0))(not (on da h2))(not (on da ha))(not (on da s0))(not (on da s2))(not (on da sa))(not (on h0 c0))(not (on h0 c2))(not (on h0 ca))(not (on h0 d0))(not (on h0 d2))(not (on h0 da))(not (on h0 h0))(not (on h0 h2))(not (on h0 ha))(not (on h0 s0))(not (on h0 s2))(not (on h0 sa))(not (on h2 c0))(not (on h2 c2))(not (on h2 ca))(not (on h2 d0))(not (on h2 d2))(not (on h2 da))(not (on h2 h0))(not (on h2 h2))(not (on h2 ha))(not (on h2 s0))(not (on h2 s2))(not (on h2 sa))(not (on ha c0))(not (on ha c2))(not (on ha ca))(not (on ha d0))(not (on ha d2))(not (on ha da))(not (on ha h0))(not (on ha h2))(not (on ha ha))(not (on ha s0))(not (on ha s2))(not (on ha sa))(not (on s0 c0))(not (on s0 c2))(not (on s0 ca))(not (on s0 d0))(not (on s0 d2))(not (on s0 da))(not (on s0 h0))(not (on s0 h2))(not (on s0 ha))(not (on s0 s0))(not (on s0 s2))(not (on s0 sa))(not (on s2 c0))(not (on s2 c2))(not (on s2 ca))(not (on s2 d0))(not (on s2 d2))(not (on s2 da))(not (on s2 h0))(not (on s2 h2))(not (on s2 ha))(not (on s2 s0))(not (on s2 s2))(not (on s2 sa))(not (on sa c0))(not (on sa c2))(not (on sa ca))(not (on sa d0))(not (on sa d2))(not (on sa da))(not (on sa h0))(not (on sa h2))(not (on sa ha))(not (on sa s0))(not (on sa s2))(not (on sa sa))(not (successor n0 n0))(not (successor n0 n1))(not (successor n0 n10))(not (successor n0 n11))(not (successor n0 n12))(not (successor n0 n13))(not (successor n0 n2))(not (successor n0 n3))(not (successor n0 n4))(not (successor n0 n5))(not (successor n0 n6))(not (successor n0 n7))(not (successor n0 n8))(not (successor n0 n9))(successor n1 n0)(not (successor n1 n1))(not (successor n1 n10))(not (successor n1 n11))(not (successor n1 n12))(not (successor n1 n13))(not (successor n1 n2))(not (successor n1 n3))(not (successor n1 n4))(not (successor n1 n5))(not (successor n1 n6))(not (successor n1 n7))(not (successor n1 n8))(not (successor n1 n9))(not (successor n10 n0))(not (successor n10 n1))(not (successor n10 n10))(not (successor n10 n11))(not (successor n10 n12))(not (successor n10 n13))(not (successor n10 n2))(not (successor n10 n3))(not (successor n10 n4))(not (successor n10 n5))(not (successor n10 n6))(not (successor n10 n7))(not (successor n10 n8))(successor n10 n9)(not (successor n11 n0))(not (successor n11 n1))(successor n11 n10)(not (successor n11 n11))(not (successor n11 n12))(not (successor n11 n13))(not (successor n11 n2))(not (successor n11 n3))(not (successor n11 n4))(not (successor n11 n5))(not (successor n11 n6))(not (successor n11 n7))(not (successor n11 n8))(not (successor n11 n9))(not (successor n12 n0))(not (successor n12 n1))(not (successor n12 n10))(successor n12 n11)(not (successor n12 n12))(not (successor n12 n13))(not (successor n12 n2))(not (successor n12 n3))(not (successor n12 n4))(not (successor n12 n5))(not (successor n12 n6))(not (successor n12 n7))(not (successor n12 n8))(not (successor n12 n9))(not (successor n13 n0))(not (successor n13 n1))(not (successor n13 n10))(not (successor n13 n11))(successor n13 n12)(not (successor n13 n13))(not (successor n13 n2))(not (successor n13 n3))(not (successor n13 n4))(not (successor n13 n5))(not (successor n13 n6))(not (successor n13 n7))(not (successor n13 n8))(not (successor n13 n9))(not (successor n2 n0))(successor n2 n1)(not (successor n2 n10))(not (successor n2 n11))(not (successor n2 n12))(not (successor n2 n13))(not (successor n2 n2))(not (successor n2 n3))(not (successor n2 n4))(not (successor n2 n5))(not (successor n2 n6))(not (successor n2 n7))(not (successor n2 n8))(not (successor n2 n9))(not (successor n3 n0))(not (successor n3 n1))(not (successor n3 n10))(not (successor n3 n11))(not (successor n3 n12))(not (successor n3 n13))(successor n3 n2)(not (successor n3 n3))(not (successor n3 n4))(not (successor n3 n5))(not (successor n3 n6))(not (successor n3 n7))(not (successor n3 n8))(not (successor n3 n9))(not (successor n4 n0))(not (successor n4 n1))(not (successor n4 n10))(not (successor n4 n11))(not (successor n4 n12))(not (successor n4 n13))(not (successor n4 n2))(successor n4 n3)(not (successor n4 n4))(not (successor n4 n5))(not (successor n4 n6))(not (successor n4 n7))(not (successor n4 n8))(not (successor n4 n9))(not (successor n5 n0))(not (successor n5 n1))(not (successor n5 n10))(not (successor n5 n11))(not (successor n5 n12))(not (successor n5 n13))(not (successor n5 n2))(not (successor n5 n3))(successor n5 n4)(not (successor n5 n5))(not (successor n5 n6))(not (successor n5 n7))(not (successor n5 n8))(not (successor n5 n9))(not (successor n6 n0))(not (successor n6 n1))(not (successor n6 n10))(not (successor n6 n11))(not (successor n6 n12))(not (successor n6 n13))(not (successor n6 n2))(not (successor n6 n3))(not (successor n6 n4))(successor n6 n5)(not (successor n6 n6))(not (successor n6 n7))(not (successor n6 n8))(not (successor n6 n9))(not (successor n7 n0))(not (successor n7 n1))(not (successor n7 n10))(not (successor n7 n11))(not (successor n7 n12))(not (successor n7 n13))(not (successor n7 n2))(not (successor n7 n3))(not (successor n7 n4))(not (successor n7 n5))(successor n7 n6)(not (successor n7 n7))(not (successor n7 n8))(not (successor n7 n9))(not (successor n8 n0))(not (successor n8 n1))(not (successor n8 n10))(not (successor n8 n11))(not (successor n8 n12))(not (successor n8 n13))(not (successor n8 n2))(not (successor n8 n3))(not (successor n8 n4))(not (successor n8 n5))(not (successor n8 n6))(successor n8 n7)(not (successor n8 n8))(not (successor n8 n9))(not (successor n9 n0))(not (successor n9 n1))(not (successor n9 n10))(not (successor n9 n11))(not (successor n9 n12))(not (successor n9 n13))(not (successor n9 n2))(not (successor n9 n3))(not (successor n9 n4))(not (successor n9 n5))(not (successor n9 n6))(not (successor n9 n7))(successor n9 n8)(not (successor n9 n9))(suit c0 c)(not (suit c0 d))(not (suit c0 h))(not (suit c0 s))(suit c2 c)(not (suit c2 d))(not (suit c2 h))(not (suit c2 s))(suit ca c)(not (suit ca d))(not (suit ca h))(not (suit ca s))(not (suit d0 c))(suit d0 d)(not (suit d0 h))(not (suit d0 s))(not (suit d2 c))(suit d2 d)(not (suit d2 h))(not (suit d2 s))(not (suit da c))(suit da d)(not (suit da h))(not (suit da s))(not (suit h0 c))(not (suit h0 d))(suit h0 h)(not (suit h0 s))(not (suit h2 c))(not (suit h2 d))(suit h2 h)(not (suit h2 s))(not (suit ha c))(not (suit ha d))(suit ha h)(not (suit ha s))(not (suit s0 c))(not (suit s0 d))(not (suit s0 h))(suit s0 s)(not (suit s2 c))(not (suit s2 d))(not (suit s2 h))(suit s2 s)(not (suit sa c))(not (suit sa d))(not (suit sa h))(suit sa s)(value c0 n0)(not (value c0 n1))(not (value c0 n10))(not (value c0 n11))(not (value c0 n12))(not (value c0 n13))(not (value c0 n2))(not (value c0 n3))(not (value c0 n4))(not (value c0 n5))(not (value c0 n6))(not (value c0 n7))(not (value c0 n8))(not (value c0 n9))(not (value c2 n0))(not (value c2 n1))(not (value c2 n10))(not (value c2 n11))(not (value c2 n12))(not (value c2 n13))(value c2 n2)(not (value c2 n3))(not (value c2 n4))(not (value c2 n5))(not (value c2 n6))(not (value c2 n7))(not (value c2 n8))(not (value c2 n9))(not (value ca n0))(value ca n1)(not (value ca n10))(not (value ca n11))(not (value ca n12))(not (value ca n13))(not (value ca n2))(not (value ca n3))(not (value ca n4))(not (value ca n5))(not (value ca n6))(not (value ca n7))(not (value ca n8))(not (value ca n9))(value d0 n0)(not (value d0 n1))(not (value d0 n10))(not (value d0 n11))(not (value d0 n12))(not (value d0 n13))(not (value d0 n2))(not (value d0 n3))(not (value d0 n4))(not (value d0 n5))(not (value d0 n6))(not (value d0 n7))(not (value d0 n8))(not (value d0 n9))(not (value d2 n0))(not (value d2 n1))(not (value d2 n10))(not (value d2 n11))(not (value d2 n12))(not (value d2 n13))(value d2 n2)(not (value d2 n3))(not (value d2 n4))(not (value d2 n5))(not (value d2 n6))(not (value d2 n7))(not (value d2 n8))(not (value d2 n9))(not (value da n0))(value da n1)(not (value da n10))(not (value da n11))(not (value da n12))(not (value da n13))(not (value da n2))(not (value da n3))(not (value da n4))(not (value da n5))(not (value da n6))(not (value da n7))(not (value da n8))(not (value da n9))(value h0 n0)(not (value h0 n1))(not (value h0 n10))(not (value h0 n11))(not (value h0 n12))(not (value h0 n13))(not (value h0 n2))(not (value h0 n3))(not (value h0 n4))(not (value h0 n5))(not (value h0 n6))(not (value h0 n7))(not (value h0 n8))(not (value h0 n9))(not (value h2 n0))(not (value h2 n1))(not (value h2 n10))(not (value h2 n11))(not (value h2 n12))(not (value h2 n13))(value h2 n2)(not (value h2 n3))(not (value h2 n4))(not (value h2 n5))(not (value h2 n6))(not (value h2 n7))(not (value h2 n8))(not (value h2 n9))(not (value ha n0))(value ha n1)(not (value ha n10))(not (value ha n11))(not (value ha n12))(not (value ha n13))(not (value ha n2))(not (value ha n3))(not (value ha n4))(not (value ha n5))(not (value ha n6))(not (value ha n7))(not (value ha n8))(not (value ha n9))(value s0 n0)(not (value s0 n1))(not (value s0 n10))(not (value s0 n11))(not (value s0 n12))(not (value s0 n13))(not (value s0 n2))(not (value s0 n3))(not (value s0 n4))(not (value s0 n5))(not (value s0 n6))(not (value s0 n7))(not (value s0 n8))(not (value s0 n9))(not (value s2 n0))(not (value s2 n1))(not (value s2 n10))(not (value s2 n11))(not (value s2 n12))(not (value s2 n13))(value s2 n2)(not (value s2 n3))(not (value s2 n4))(not (value s2 n5))(not (value s2 n6))(not (value s2 n7))(not (value s2 n8))(not (value s2 n9))(not (value sa n0))(value sa n1)(not (value sa n10))(not (value sa n11))(not (value sa n12))(not (value sa n13))(not (value sa n2))(not (value sa n3))(not (value sa n4))(not (value sa n5))(not (value sa n6))(not (value sa n7))(not (value sa n8))(not (value sa n9))(test5 ))
   :effect (and (not (plan-sendtohome-b i1 d2 d n2 da n1 n5 n6))(not (plan-sendtohome-b i2 h2 h n2 ha n1 n6 n7))(not (plan-sendtohome-b i3 s2 s n2 sa n1 n7 n8))(current i1)(not (current i4))(not (home d2))(not (colspace n8))(not (home s2))(not (home h2))(not (home c2))(home h0)(home c0)(home d0)(clear h2)(on da d2)(clear da)(colspace n2)(clear ha)(bottomcol ca)(clear sa)(home s0)(clear c2)(bottomcol d2)(bottomcol s2)(bottomcol ha)(bottomcol sa)(bottomcol c2)(clear ca)(on h2 s2)(plan-sendtofree i1 h2 s2 n4 n3)(plan-sendtohome i2 da d2 d n1 d0 n0)(plan-sendtohome-b i3 ca c n1 c0 n0 n2 n3)(test6 )(not (test5 ))(not (action_applied ))))

 (:action validate_7
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(not (bottomcol c0))(bottomcol c2)(not (bottomcol ca))(not (bottomcol d0))(bottomcol d2)(not (bottomcol da))(not (bottomcol h0))(not (bottomcol h2))(bottomcol ha)(not (bottomcol s0))(bottomcol s2)(bottomcol sa)(not (canstack c0 c0))(not (canstack c0 c2))(not (canstack c0 ca))(not (canstack c0 d0))(not (canstack c0 d2))(not (canstack c0 da))(not (canstack c0 h0))(not (canstack c0 h2))(not (canstack c0 ha))(not (canstack c0 s0))(not (canstack c0 s2))(not (canstack c0 sa))(not (canstack c2 c0))(not (canstack c2 c2))(not (canstack c2 ca))(not (canstack c2 d0))(not (canstack c2 d2))(not (canstack c2 da))(not (canstack c2 h0))(not (canstack c2 h2))(not (canstack c2 ha))(not (canstack c2 s0))(not (canstack c2 s2))(not (canstack c2 sa))(not (canstack ca c0))(not (canstack ca c2))(not (canstack ca ca))(not (canstack ca d0))(canstack ca d2)(not (canstack ca da))(not (canstack ca h0))(canstack ca h2)(not (canstack ca ha))(not (canstack ca s0))(not (canstack ca s2))(not (canstack ca sa))(not (canstack d0 c0))(not (canstack d0 c2))(not (canstack d0 ca))(not (canstack d0 d0))(not (canstack d0 d2))(not (canstack d0 da))(not (canstack d0 h0))(not (canstack d0 h2))(not (canstack d0 ha))(not (canstack d0 s0))(not (canstack d0 s2))(not (canstack d0 sa))(not (canstack d2 c0))(not (canstack d2 c2))(not (canstack d2 ca))(not (canstack d2 d0))(not (canstack d2 d2))(not (canstack d2 da))(not (canstack d2 h0))(not (canstack d2 h2))(not (canstack d2 ha))(not (canstack d2 s0))(not (canstack d2 s2))(not (canstack d2 sa))(not (canstack da c0))(canstack da c2)(not (canstack da ca))(not (canstack da d0))(not (canstack da d2))(not (canstack da da))(not (canstack da h0))(not (canstack da h2))(not (canstack da ha))(not (canstack da s0))(canstack da s2)(not (canstack da sa))(not (canstack h0 c0))(not (canstack h0 c2))(not (canstack h0 ca))(not (canstack h0 d0))(not (canstack h0 d2))(not (canstack h0 da))(not (canstack h0 h0))(not (canstack h0 h2))(not (canstack h0 ha))(not (canstack h0 s0))(not (canstack h0 s2))(not (canstack h0 sa))(not (canstack h2 c0))(not (canstack h2 c2))(not (canstack h2 ca))(not (canstack h2 d0))(not (canstack h2 d2))(not (canstack h2 da))(not (canstack h2 h0))(not (canstack h2 h2))(not (canstack h2 ha))(not (canstack h2 s0))(not (canstack h2 s2))(not (canstack h2 sa))(not (canstack ha c0))(canstack ha c2)(not (canstack ha ca))(not (canstack ha d0))(not (canstack ha d2))(not (canstack ha da))(not (canstack ha h0))(not (canstack ha h2))(not (canstack ha ha))(not (canstack ha s0))(canstack ha s2)(not (canstack ha sa))(not (canstack s0 c0))(not (canstack s0 c2))(not (canstack s0 ca))(not (canstack s0 d0))(not (canstack s0 d2))(not (canstack s0 da))(not (canstack s0 h0))(not (canstack s0 h2))(not (canstack s0 ha))(not (canstack s0 s0))(not (canstack s0 s2))(not (canstack s0 sa))(not (canstack s2 c0))(not (canstack s2 c2))(not (canstack s2 ca))(not (canstack s2 d0))(not (canstack s2 d2))(not (canstack s2 da))(not (canstack s2 h0))(not (canstack s2 h2))(not (canstack s2 ha))(not (canstack s2 s0))(not (canstack s2 s2))(not (canstack s2 sa))(not (canstack sa c0))(not (canstack sa c2))(not (canstack sa ca))(not (canstack sa d0))(canstack sa d2)(not (canstack sa da))(not (canstack sa h0))(canstack sa h2)(not (canstack sa ha))(not (canstack sa s0))(not (canstack sa s2))(not (canstack sa sa))(not (cellspace n0))(not (cellspace n1))(not (cellspace n10))(not (cellspace n11))(not (cellspace n12))(not (cellspace n13))(not (cellspace n2))(cellspace n3)(not (cellspace n4))(not (cellspace n5))(not (cellspace n6))(not (cellspace n7))(not (cellspace n8))(not (cellspace n9))(not (clear c0))(clear c2)(not (clear ca))(not (clear d0))(clear d2)(not (clear da))(not (clear h0))(not (clear h2))(clear ha)(not (clear s0))(clear s2)(clear sa)(not (colspace n0))(not (colspace n1))(not (colspace n10))(not (colspace n11))(not (colspace n12))(not (colspace n13))(not (colspace n2))(colspace n3)(not (colspace n4))(not (colspace n5))(not (colspace n6))(not (colspace n7))(not (colspace n8))(not (colspace n9))(not (home c0))(not (home c2))(home ca)(not (home d0))(not (home d2))(home da)(home h0)(not (home h2))(not (home ha))(home s0)(not (home s2))(not (home sa))(not (incell c0))(not (incell c2))(not (incell ca))(not (incell d0))(not (incell d2))(not (incell da))(not (incell h0))(incell h2)(not (incell ha))(not (incell s0))(not (incell s2))(not (incell sa))(not (on c0 c0))(not (on c0 c2))(not (on c0 ca))(not (on c0 d0))(not (on c0 d2))(not (on c0 da))(not (on c0 h0))(not (on c0 h2))(not (on c0 ha))(not (on c0 s0))(not (on c0 s2))(not (on c0 sa))(not (on c2 c0))(not (on c2 c2))(not (on c2 ca))(not (on c2 d0))(not (on c2 d2))(not (on c2 da))(not (on c2 h0))(not (on c2 h2))(not (on c2 ha))(not (on c2 s0))(not (on c2 s2))(not (on c2 sa))(not (on ca c0))(not (on ca c2))(not (on ca ca))(not (on ca d0))(not (on ca d2))(not (on ca da))(not (on ca h0))(not (on ca h2))(not (on ca ha))(not (on ca s0))(not (on ca s2))(not (on ca sa))(not (on d0 c0))(not (on d0 c2))(not (on d0 ca))(not (on d0 d0))(not (on d0 d2))(not (on d0 da))(not (on d0 h0))(not (on d0 h2))(not (on d0 ha))(not (on d0 s0))(not (on d0 s2))(not (on d0 sa))(not (on d2 c0))(not (on d2 c2))(not (on d2 ca))(not (on d2 d0))(not (on d2 d2))(not (on d2 da))(not (on d2 h0))(not (on d2 h2))(not (on d2 ha))(not (on d2 s0))(not (on d2 s2))(not (on d2 sa))(not (on da c0))(not (on da c2))(not (on da ca))(not (on da d0))(not (on da d2))(not (on da da))(not (on da h0))(not (on da h2))(not (on da ha))(not (on da s0))(not (on da s2))(not (on da sa))(not (on h0 c0))(not (on h0 c2))(not (on h0 ca))(not (on h0 d0))(not (on h0 d2))(not (on h0 da))(not (on h0 h0))(not (on h0 h2))(not (on h0 ha))(not (on h0 s0))(not (on h0 s2))(not (on h0 sa))(not (on h2 c0))(not (on h2 c2))(not (on h2 ca))(not (on h2 d0))(not (on h2 d2))(not (on h2 da))(not (on h2 h0))(not (on h2 h2))(not (on h2 ha))(not (on h2 s0))(not (on h2 s2))(not (on h2 sa))(not (on ha c0))(not (on ha c2))(not (on ha ca))(not (on ha d0))(not (on ha d2))(not (on ha da))(not (on ha h0))(not (on ha h2))(not (on ha ha))(not (on ha s0))(not (on ha s2))(not (on ha sa))(not (on s0 c0))(not (on s0 c2))(not (on s0 ca))(not (on s0 d0))(not (on s0 d2))(not (on s0 da))(not (on s0 h0))(not (on s0 h2))(not (on s0 ha))(not (on s0 s0))(not (on s0 s2))(not (on s0 sa))(not (on s2 c0))(not (on s2 c2))(not (on s2 ca))(not (on s2 d0))(not (on s2 d2))(not (on s2 da))(not (on s2 h0))(not (on s2 h2))(not (on s2 ha))(not (on s2 s0))(not (on s2 s2))(not (on s2 sa))(not (on sa c0))(not (on sa c2))(not (on sa ca))(not (on sa d0))(not (on sa d2))(not (on sa da))(not (on sa h0))(not (on sa h2))(not (on sa ha))(not (on sa s0))(not (on sa s2))(not (on sa sa))(not (successor n0 n0))(not (successor n0 n1))(not (successor n0 n10))(not (successor n0 n11))(not (successor n0 n12))(not (successor n0 n13))(not (successor n0 n2))(not (successor n0 n3))(not (successor n0 n4))(not (successor n0 n5))(not (successor n0 n6))(not (successor n0 n7))(not (successor n0 n8))(not (successor n0 n9))(successor n1 n0)(not (successor n1 n1))(not (successor n1 n10))(not (successor n1 n11))(not (successor n1 n12))(not (successor n1 n13))(not (successor n1 n2))(not (successor n1 n3))(not (successor n1 n4))(not (successor n1 n5))(not (successor n1 n6))(not (successor n1 n7))(not (successor n1 n8))(not (successor n1 n9))(not (successor n10 n0))(not (successor n10 n1))(not (successor n10 n10))(not (successor n10 n11))(not (successor n10 n12))(not (successor n10 n13))(not (successor n10 n2))(not (successor n10 n3))(not (successor n10 n4))(not (successor n10 n5))(not (successor n10 n6))(not (successor n10 n7))(not (successor n10 n8))(successor n10 n9)(not (successor n11 n0))(not (successor n11 n1))(successor n11 n10)(not (successor n11 n11))(not (successor n11 n12))(not (successor n11 n13))(not (successor n11 n2))(not (successor n11 n3))(not (successor n11 n4))(not (successor n11 n5))(not (successor n11 n6))(not (successor n11 n7))(not (successor n11 n8))(not (successor n11 n9))(not (successor n12 n0))(not (successor n12 n1))(not (successor n12 n10))(successor n12 n11)(not (successor n12 n12))(not (successor n12 n13))(not (successor n12 n2))(not (successor n12 n3))(not (successor n12 n4))(not (successor n12 n5))(not (successor n12 n6))(not (successor n12 n7))(not (successor n12 n8))(not (successor n12 n9))(not (successor n13 n0))(not (successor n13 n1))(not (successor n13 n10))(not (successor n13 n11))(successor n13 n12)(not (successor n13 n13))(not (successor n13 n2))(not (successor n13 n3))(not (successor n13 n4))(not (successor n13 n5))(not (successor n13 n6))(not (successor n13 n7))(not (successor n13 n8))(not (successor n13 n9))(not (successor n2 n0))(successor n2 n1)(not (successor n2 n10))(not (successor n2 n11))(not (successor n2 n12))(not (successor n2 n13))(not (successor n2 n2))(not (successor n2 n3))(not (successor n2 n4))(not (successor n2 n5))(not (successor n2 n6))(not (successor n2 n7))(not (successor n2 n8))(not (successor n2 n9))(not (successor n3 n0))(not (successor n3 n1))(not (successor n3 n10))(not (successor n3 n11))(not (successor n3 n12))(not (successor n3 n13))(successor n3 n2)(not (successor n3 n3))(not (successor n3 n4))(not (successor n3 n5))(not (successor n3 n6))(not (successor n3 n7))(not (successor n3 n8))(not (successor n3 n9))(not (successor n4 n0))(not (successor n4 n1))(not (successor n4 n10))(not (successor n4 n11))(not (successor n4 n12))(not (successor n4 n13))(not (successor n4 n2))(successor n4 n3)(not (successor n4 n4))(not (successor n4 n5))(not (successor n4 n6))(not (successor n4 n7))(not (successor n4 n8))(not (successor n4 n9))(not (successor n5 n0))(not (successor n5 n1))(not (successor n5 n10))(not (successor n5 n11))(not (successor n5 n12))(not (successor n5 n13))(not (successor n5 n2))(not (successor n5 n3))(successor n5 n4)(not (successor n5 n5))(not (successor n5 n6))(not (successor n5 n7))(not (successor n5 n8))(not (successor n5 n9))(not (successor n6 n0))(not (successor n6 n1))(not (successor n6 n10))(not (successor n6 n11))(not (successor n6 n12))(not (successor n6 n13))(not (successor n6 n2))(not (successor n6 n3))(not (successor n6 n4))(successor n6 n5)(not (successor n6 n6))(not (successor n6 n7))(not (successor n6 n8))(not (successor n6 n9))(not (successor n7 n0))(not (successor n7 n1))(not (successor n7 n10))(not (successor n7 n11))(not (successor n7 n12))(not (successor n7 n13))(not (successor n7 n2))(not (successor n7 n3))(not (successor n7 n4))(not (successor n7 n5))(successor n7 n6)(not (successor n7 n7))(not (successor n7 n8))(not (successor n7 n9))(not (successor n8 n0))(not (successor n8 n1))(not (successor n8 n10))(not (successor n8 n11))(not (successor n8 n12))(not (successor n8 n13))(not (successor n8 n2))(not (successor n8 n3))(not (successor n8 n4))(not (successor n8 n5))(not (successor n8 n6))(successor n8 n7)(not (successor n8 n8))(not (successor n8 n9))(not (successor n9 n0))(not (successor n9 n1))(not (successor n9 n10))(not (successor n9 n11))(not (successor n9 n12))(not (successor n9 n13))(not (successor n9 n2))(not (successor n9 n3))(not (successor n9 n4))(not (successor n9 n5))(not (successor n9 n6))(not (successor n9 n7))(successor n9 n8)(not (successor n9 n9))(suit c0 c)(not (suit c0 d))(not (suit c0 h))(not (suit c0 s))(suit c2 c)(not (suit c2 d))(not (suit c2 h))(not (suit c2 s))(suit ca c)(not (suit ca d))(not (suit ca h))(not (suit ca s))(not (suit d0 c))(suit d0 d)(not (suit d0 h))(not (suit d0 s))(not (suit d2 c))(suit d2 d)(not (suit d2 h))(not (suit d2 s))(not (suit da c))(suit da d)(not (suit da h))(not (suit da s))(not (suit h0 c))(not (suit h0 d))(suit h0 h)(not (suit h0 s))(not (suit h2 c))(not (suit h2 d))(suit h2 h)(not (suit h2 s))(not (suit ha c))(not (suit ha d))(suit ha h)(not (suit ha s))(not (suit s0 c))(not (suit s0 d))(not (suit s0 h))(suit s0 s)(not (suit s2 c))(not (suit s2 d))(not (suit s2 h))(suit s2 s)(not (suit sa c))(not (suit sa d))(not (suit sa h))(suit sa s)(value c0 n0)(not (value c0 n1))(not (value c0 n10))(not (value c0 n11))(not (value c0 n12))(not (value c0 n13))(not (value c0 n2))(not (value c0 n3))(not (value c0 n4))(not (value c0 n5))(not (value c0 n6))(not (value c0 n7))(not (value c0 n8))(not (value c0 n9))(not (value c2 n0))(not (value c2 n1))(not (value c2 n10))(not (value c2 n11))(not (value c2 n12))(not (value c2 n13))(value c2 n2)(not (value c2 n3))(not (value c2 n4))(not (value c2 n5))(not (value c2 n6))(not (value c2 n7))(not (value c2 n8))(not (value c2 n9))(not (value ca n0))(value ca n1)(not (value ca n10))(not (value ca n11))(not (value ca n12))(not (value ca n13))(not (value ca n2))(not (value ca n3))(not (value ca n4))(not (value ca n5))(not (value ca n6))(not (value ca n7))(not (value ca n8))(not (value ca n9))(value d0 n0)(not (value d0 n1))(not (value d0 n10))(not (value d0 n11))(not (value d0 n12))(not (value d0 n13))(not (value d0 n2))(not (value d0 n3))(not (value d0 n4))(not (value d0 n5))(not (value d0 n6))(not (value d0 n7))(not (value d0 n8))(not (value d0 n9))(not (value d2 n0))(not (value d2 n1))(not (value d2 n10))(not (value d2 n11))(not (value d2 n12))(not (value d2 n13))(value d2 n2)(not (value d2 n3))(not (value d2 n4))(not (value d2 n5))(not (value d2 n6))(not (value d2 n7))(not (value d2 n8))(not (value d2 n9))(not (value da n0))(value da n1)(not (value da n10))(not (value da n11))(not (value da n12))(not (value da n13))(not (value da n2))(not (value da n3))(not (value da n4))(not (value da n5))(not (value da n6))(not (value da n7))(not (value da n8))(not (value da n9))(value h0 n0)(not (value h0 n1))(not (value h0 n10))(not (value h0 n11))(not (value h0 n12))(not (value h0 n13))(not (value h0 n2))(not (value h0 n3))(not (value h0 n4))(not (value h0 n5))(not (value h0 n6))(not (value h0 n7))(not (value h0 n8))(not (value h0 n9))(not (value h2 n0))(not (value h2 n1))(not (value h2 n10))(not (value h2 n11))(not (value h2 n12))(not (value h2 n13))(value h2 n2)(not (value h2 n3))(not (value h2 n4))(not (value h2 n5))(not (value h2 n6))(not (value h2 n7))(not (value h2 n8))(not (value h2 n9))(not (value ha n0))(value ha n1)(not (value ha n10))(not (value ha n11))(not (value ha n12))(not (value ha n13))(not (value ha n2))(not (value ha n3))(not (value ha n4))(not (value ha n5))(not (value ha n6))(not (value ha n7))(not (value ha n8))(not (value ha n9))(value s0 n0)(not (value s0 n1))(not (value s0 n10))(not (value s0 n11))(not (value s0 n12))(not (value s0 n13))(not (value s0 n2))(not (value s0 n3))(not (value s0 n4))(not (value s0 n5))(not (value s0 n6))(not (value s0 n7))(not (value s0 n8))(not (value s0 n9))(not (value s2 n0))(not (value s2 n1))(not (value s2 n10))(not (value s2 n11))(not (value s2 n12))(not (value s2 n13))(value s2 n2)(not (value s2 n3))(not (value s2 n4))(not (value s2 n5))(not (value s2 n6))(not (value s2 n7))(not (value s2 n8))(not (value s2 n9))(not (value sa n0))(value sa n1)(not (value sa n10))(not (value sa n11))(not (value sa n12))(not (value sa n13))(not (value sa n2))(not (value sa n3))(not (value sa n4))(not (value sa n5))(not (value sa n6))(not (value sa n7))(not (value sa n8))(not (value sa n9))(test6 ))
   :effect (and (not (plan-sendtofree i1 h2 s2 n4 n3))(not (plan-sendtohome i2 da d2 d n1 d0 n0))(not (plan-sendtohome-b i3 ca c n1 c0 n0 n2 n3))(current i1)(not (current i4))(plan-sendtohome-b i1 ha h n1 h0 n0 n3 n4)(plan-homefromfreecell i2 h2 h n2 ha n1 n3 n4)(plan-sendtohome-b i3 sa s n1 s0 n0 n4 n5)(test7 )(not (test6 ))(not (action_applied ))))

 (:action validate_8
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(not (bottomcol c0))(bottomcol c2)(not (bottomcol ca))(not (bottomcol d0))(bottomcol d2)(not (bottomcol da))(not (bottomcol h0))(not (bottomcol h2))(not (bottomcol ha))(not (bottomcol s0))(bottomcol s2)(not (bottomcol sa))(not (canstack c0 c0))(not (canstack c0 c2))(not (canstack c0 ca))(not (canstack c0 d0))(not (canstack c0 d2))(not (canstack c0 da))(not (canstack c0 h0))(not (canstack c0 h2))(not (canstack c0 ha))(not (canstack c0 s0))(not (canstack c0 s2))(not (canstack c0 sa))(not (canstack c2 c0))(not (canstack c2 c2))(not (canstack c2 ca))(not (canstack c2 d0))(not (canstack c2 d2))(not (canstack c2 da))(not (canstack c2 h0))(not (canstack c2 h2))(not (canstack c2 ha))(not (canstack c2 s0))(not (canstack c2 s2))(not (canstack c2 sa))(not (canstack ca c0))(not (canstack ca c2))(not (canstack ca ca))(not (canstack ca d0))(canstack ca d2)(not (canstack ca da))(not (canstack ca h0))(canstack ca h2)(not (canstack ca ha))(not (canstack ca s0))(not (canstack ca s2))(not (canstack ca sa))(not (canstack d0 c0))(not (canstack d0 c2))(not (canstack d0 ca))(not (canstack d0 d0))(not (canstack d0 d2))(not (canstack d0 da))(not (canstack d0 h0))(not (canstack d0 h2))(not (canstack d0 ha))(not (canstack d0 s0))(not (canstack d0 s2))(not (canstack d0 sa))(not (canstack d2 c0))(not (canstack d2 c2))(not (canstack d2 ca))(not (canstack d2 d0))(not (canstack d2 d2))(not (canstack d2 da))(not (canstack d2 h0))(not (canstack d2 h2))(not (canstack d2 ha))(not (canstack d2 s0))(not (canstack d2 s2))(not (canstack d2 sa))(not (canstack da c0))(canstack da c2)(not (canstack da ca))(not (canstack da d0))(not (canstack da d2))(not (canstack da da))(not (canstack da h0))(not (canstack da h2))(not (canstack da ha))(not (canstack da s0))(canstack da s2)(not (canstack da sa))(not (canstack h0 c0))(not (canstack h0 c2))(not (canstack h0 ca))(not (canstack h0 d0))(not (canstack h0 d2))(not (canstack h0 da))(not (canstack h0 h0))(not (canstack h0 h2))(not (canstack h0 ha))(not (canstack h0 s0))(not (canstack h0 s2))(not (canstack h0 sa))(not (canstack h2 c0))(not (canstack h2 c2))(not (canstack h2 ca))(not (canstack h2 d0))(not (canstack h2 d2))(not (canstack h2 da))(not (canstack h2 h0))(not (canstack h2 h2))(not (canstack h2 ha))(not (canstack h2 s0))(not (canstack h2 s2))(not (canstack h2 sa))(not (canstack ha c0))(canstack ha c2)(not (canstack ha ca))(not (canstack ha d0))(not (canstack ha d2))(not (canstack ha da))(not (canstack ha h0))(not (canstack ha h2))(not (canstack ha ha))(not (canstack ha s0))(canstack ha s2)(not (canstack ha sa))(not (canstack s0 c0))(not (canstack s0 c2))(not (canstack s0 ca))(not (canstack s0 d0))(not (canstack s0 d2))(not (canstack s0 da))(not (canstack s0 h0))(not (canstack s0 h2))(not (canstack s0 ha))(not (canstack s0 s0))(not (canstack s0 s2))(not (canstack s0 sa))(not (canstack s2 c0))(not (canstack s2 c2))(not (canstack s2 ca))(not (canstack s2 d0))(not (canstack s2 d2))(not (canstack s2 da))(not (canstack s2 h0))(not (canstack s2 h2))(not (canstack s2 ha))(not (canstack s2 s0))(not (canstack s2 s2))(not (canstack s2 sa))(not (canstack sa c0))(not (canstack sa c2))(not (canstack sa ca))(not (canstack sa d0))(canstack sa d2)(not (canstack sa da))(not (canstack sa h0))(canstack sa h2)(not (canstack sa ha))(not (canstack sa s0))(not (canstack sa s2))(not (canstack sa sa))(not (cellspace n0))(not (cellspace n1))(not (cellspace n10))(not (cellspace n11))(not (cellspace n12))(not (cellspace n13))(not (cellspace n2))(not (cellspace n3))(cellspace n4)(not (cellspace n5))(not (cellspace n6))(not (cellspace n7))(not (cellspace n8))(not (cellspace n9))(not (clear c0))(clear c2)(not (clear ca))(not (clear d0))(clear d2)(not (clear da))(not (clear h0))(not (clear h2))(not (clear ha))(not (clear s0))(clear s2)(not (clear sa))(not (colspace n0))(not (colspace n1))(not (colspace n10))(not (colspace n11))(not (colspace n12))(not (colspace n13))(not (colspace n2))(not (colspace n3))(not (colspace n4))(colspace n5)(not (colspace n6))(not (colspace n7))(not (colspace n8))(not (colspace n9))(not (home c0))(not (home c2))(home ca)(not (home d0))(not (home d2))(home da)(not (home h0))(home h2)(not (home ha))(not (home s0))(not (home s2))(home sa)(not (incell c0))(not (incell c2))(not (incell ca))(not (incell d0))(not (incell d2))(not (incell da))(not (incell h0))(not (incell h2))(not (incell ha))(not (incell s0))(not (incell s2))(not (incell sa))(not (on c0 c0))(not (on c0 c2))(not (on c0 ca))(not (on c0 d0))(not (on c0 d2))(not (on c0 da))(not (on c0 h0))(not (on c0 h2))(not (on c0 ha))(not (on c0 s0))(not (on c0 s2))(not (on c0 sa))(not (on c2 c0))(not (on c2 c2))(not (on c2 ca))(not (on c2 d0))(not (on c2 d2))(not (on c2 da))(not (on c2 h0))(not (on c2 h2))(not (on c2 ha))(not (on c2 s0))(not (on c2 s2))(not (on c2 sa))(not (on ca c0))(not (on ca c2))(not (on ca ca))(not (on ca d0))(not (on ca d2))(not (on ca da))(not (on ca h0))(not (on ca h2))(not (on ca ha))(not (on ca s0))(not (on ca s2))(not (on ca sa))(not (on d0 c0))(not (on d0 c2))(not (on d0 ca))(not (on d0 d0))(not (on d0 d2))(not (on d0 da))(not (on d0 h0))(not (on d0 h2))(not (on d0 ha))(not (on d0 s0))(not (on d0 s2))(not (on d0 sa))(not (on d2 c0))(not (on d2 c2))(not (on d2 ca))(not (on d2 d0))(not (on d2 d2))(not (on d2 da))(not (on d2 h0))(not (on d2 h2))(not (on d2 ha))(not (on d2 s0))(not (on d2 s2))(not (on d2 sa))(not (on da c0))(not (on da c2))(not (on da ca))(not (on da d0))(not (on da d2))(not (on da da))(not (on da h0))(not (on da h2))(not (on da ha))(not (on da s0))(not (on da s2))(not (on da sa))(not (on h0 c0))(not (on h0 c2))(not (on h0 ca))(not (on h0 d0))(not (on h0 d2))(not (on h0 da))(not (on h0 h0))(not (on h0 h2))(not (on h0 ha))(not (on h0 s0))(not (on h0 s2))(not (on h0 sa))(not (on h2 c0))(not (on h2 c2))(not (on h2 ca))(not (on h2 d0))(not (on h2 d2))(not (on h2 da))(not (on h2 h0))(not (on h2 h2))(not (on h2 ha))(not (on h2 s0))(not (on h2 s2))(not (on h2 sa))(not (on ha c0))(not (on ha c2))(not (on ha ca))(not (on ha d0))(not (on ha d2))(not (on ha da))(not (on ha h0))(not (on ha h2))(not (on ha ha))(not (on ha s0))(not (on ha s2))(not (on ha sa))(not (on s0 c0))(not (on s0 c2))(not (on s0 ca))(not (on s0 d0))(not (on s0 d2))(not (on s0 da))(not (on s0 h0))(not (on s0 h2))(not (on s0 ha))(not (on s0 s0))(not (on s0 s2))(not (on s0 sa))(not (on s2 c0))(not (on s2 c2))(not (on s2 ca))(not (on s2 d0))(not (on s2 d2))(not (on s2 da))(not (on s2 h0))(not (on s2 h2))(not (on s2 ha))(not (on s2 s0))(not (on s2 s2))(not (on s2 sa))(not (on sa c0))(not (on sa c2))(not (on sa ca))(not (on sa d0))(not (on sa d2))(not (on sa da))(not (on sa h0))(not (on sa h2))(not (on sa ha))(not (on sa s0))(not (on sa s2))(not (on sa sa))(not (successor n0 n0))(not (successor n0 n1))(not (successor n0 n10))(not (successor n0 n11))(not (successor n0 n12))(not (successor n0 n13))(not (successor n0 n2))(not (successor n0 n3))(not (successor n0 n4))(not (successor n0 n5))(not (successor n0 n6))(not (successor n0 n7))(not (successor n0 n8))(not (successor n0 n9))(successor n1 n0)(not (successor n1 n1))(not (successor n1 n10))(not (successor n1 n11))(not (successor n1 n12))(not (successor n1 n13))(not (successor n1 n2))(not (successor n1 n3))(not (successor n1 n4))(not (successor n1 n5))(not (successor n1 n6))(not (successor n1 n7))(not (successor n1 n8))(not (successor n1 n9))(not (successor n10 n0))(not (successor n10 n1))(not (successor n10 n10))(not (successor n10 n11))(not (successor n10 n12))(not (successor n10 n13))(not (successor n10 n2))(not (successor n10 n3))(not (successor n10 n4))(not (successor n10 n5))(not (successor n10 n6))(not (successor n10 n7))(not (successor n10 n8))(successor n10 n9)(not (successor n11 n0))(not (successor n11 n1))(successor n11 n10)(not (successor n11 n11))(not (successor n11 n12))(not (successor n11 n13))(not (successor n11 n2))(not (successor n11 n3))(not (successor n11 n4))(not (successor n11 n5))(not (successor n11 n6))(not (successor n11 n7))(not (successor n11 n8))(not (successor n11 n9))(not (successor n12 n0))(not (successor n12 n1))(not (successor n12 n10))(successor n12 n11)(not (successor n12 n12))(not (successor n12 n13))(not (successor n12 n2))(not (successor n12 n3))(not (successor n12 n4))(not (successor n12 n5))(not (successor n12 n6))(not (successor n12 n7))(not (successor n12 n8))(not (successor n12 n9))(not (successor n13 n0))(not (successor n13 n1))(not (successor n13 n10))(not (successor n13 n11))(successor n13 n12)(not (successor n13 n13))(not (successor n13 n2))(not (successor n13 n3))(not (successor n13 n4))(not (successor n13 n5))(not (successor n13 n6))(not (successor n13 n7))(not (successor n13 n8))(not (successor n13 n9))(not (successor n2 n0))(successor n2 n1)(not (successor n2 n10))(not (successor n2 n11))(not (successor n2 n12))(not (successor n2 n13))(not (successor n2 n2))(not (successor n2 n3))(not (successor n2 n4))(not (successor n2 n5))(not (successor n2 n6))(not (successor n2 n7))(not (successor n2 n8))(not (successor n2 n9))(not (successor n3 n0))(not (successor n3 n1))(not (successor n3 n10))(not (successor n3 n11))(not (successor n3 n12))(not (successor n3 n13))(successor n3 n2)(not (successor n3 n3))(not (successor n3 n4))(not (successor n3 n5))(not (successor n3 n6))(not (successor n3 n7))(not (successor n3 n8))(not (successor n3 n9))(not (successor n4 n0))(not (successor n4 n1))(not (successor n4 n10))(not (successor n4 n11))(not (successor n4 n12))(not (successor n4 n13))(not (successor n4 n2))(successor n4 n3)(not (successor n4 n4))(not (successor n4 n5))(not (successor n4 n6))(not (successor n4 n7))(not (successor n4 n8))(not (successor n4 n9))(not (successor n5 n0))(not (successor n5 n1))(not (successor n5 n10))(not (successor n5 n11))(not (successor n5 n12))(not (successor n5 n13))(not (successor n5 n2))(not (successor n5 n3))(successor n5 n4)(not (successor n5 n5))(not (successor n5 n6))(not (successor n5 n7))(not (successor n5 n8))(not (successor n5 n9))(not (successor n6 n0))(not (successor n6 n1))(not (successor n6 n10))(not (successor n6 n11))(not (successor n6 n12))(not (successor n6 n13))(not (successor n6 n2))(not (successor n6 n3))(not (successor n6 n4))(successor n6 n5)(not (successor n6 n6))(not (successor n6 n7))(not (successor n6 n8))(not (successor n6 n9))(not (successor n7 n0))(not (successor n7 n1))(not (successor n7 n10))(not (successor n7 n11))(not (successor n7 n12))(not (successor n7 n13))(not (successor n7 n2))(not (successor n7 n3))(not (successor n7 n4))(not (successor n7 n5))(successor n7 n6)(not (successor n7 n7))(not (successor n7 n8))(not (successor n7 n9))(not (successor n8 n0))(not (successor n8 n1))(not (successor n8 n10))(not (successor n8 n11))(not (successor n8 n12))(not (successor n8 n13))(not (successor n8 n2))(not (successor n8 n3))(not (successor n8 n4))(not (successor n8 n5))(not (successor n8 n6))(successor n8 n7)(not (successor n8 n8))(not (successor n8 n9))(not (successor n9 n0))(not (successor n9 n1))(not (successor n9 n10))(not (successor n9 n11))(not (successor n9 n12))(not (successor n9 n13))(not (successor n9 n2))(not (successor n9 n3))(not (successor n9 n4))(not (successor n9 n5))(not (successor n9 n6))(not (successor n9 n7))(successor n9 n8)(not (successor n9 n9))(suit c0 c)(not (suit c0 d))(not (suit c0 h))(not (suit c0 s))(suit c2 c)(not (suit c2 d))(not (suit c2 h))(not (suit c2 s))(suit ca c)(not (suit ca d))(not (suit ca h))(not (suit ca s))(not (suit d0 c))(suit d0 d)(not (suit d0 h))(not (suit d0 s))(not (suit d2 c))(suit d2 d)(not (suit d2 h))(not (suit d2 s))(not (suit da c))(suit da d)(not (suit da h))(not (suit da s))(not (suit h0 c))(not (suit h0 d))(suit h0 h)(not (suit h0 s))(not (suit h2 c))(not (suit h2 d))(suit h2 h)(not (suit h2 s))(not (suit ha c))(not (suit ha d))(suit ha h)(not (suit ha s))(not (suit s0 c))(not (suit s0 d))(not (suit s0 h))(suit s0 s)(not (suit s2 c))(not (suit s2 d))(not (suit s2 h))(suit s2 s)(not (suit sa c))(not (suit sa d))(not (suit sa h))(suit sa s)(value c0 n0)(not (value c0 n1))(not (value c0 n10))(not (value c0 n11))(not (value c0 n12))(not (value c0 n13))(not (value c0 n2))(not (value c0 n3))(not (value c0 n4))(not (value c0 n5))(not (value c0 n6))(not (value c0 n7))(not (value c0 n8))(not (value c0 n9))(not (value c2 n0))(not (value c2 n1))(not (value c2 n10))(not (value c2 n11))(not (value c2 n12))(not (value c2 n13))(value c2 n2)(not (value c2 n3))(not (value c2 n4))(not (value c2 n5))(not (value c2 n6))(not (value c2 n7))(not (value c2 n8))(not (value c2 n9))(not (value ca n0))(value ca n1)(not (value ca n10))(not (value ca n11))(not (value ca n12))(not (value ca n13))(not (value ca n2))(not (value ca n3))(not (value ca n4))(not (value ca n5))(not (value ca n6))(not (value ca n7))(not (value ca n8))(not (value ca n9))(value d0 n0)(not (value d0 n1))(not (value d0 n10))(not (value d0 n11))(not (value d0 n12))(not (value d0 n13))(not (value d0 n2))(not (value d0 n3))(not (value d0 n4))(not (value d0 n5))(not (value d0 n6))(not (value d0 n7))(not (value d0 n8))(not (value d0 n9))(not (value d2 n0))(not (value d2 n1))(not (value d2 n10))(not (value d2 n11))(not (value d2 n12))(not (value d2 n13))(value d2 n2)(not (value d2 n3))(not (value d2 n4))(not (value d2 n5))(not (value d2 n6))(not (value d2 n7))(not (value d2 n8))(not (value d2 n9))(not (value da n0))(value da n1)(not (value da n10))(not (value da n11))(not (value da n12))(not (value da n13))(not (value da n2))(not (value da n3))(not (value da n4))(not (value da n5))(not (value da n6))(not (value da n7))(not (value da n8))(not (value da n9))(value h0 n0)(not (value h0 n1))(not (value h0 n10))(not (value h0 n11))(not (value h0 n12))(not (value h0 n13))(not (value h0 n2))(not (value h0 n3))(not (value h0 n4))(not (value h0 n5))(not (value h0 n6))(not (value h0 n7))(not (value h0 n8))(not (value h0 n9))(not (value h2 n0))(not (value h2 n1))(not (value h2 n10))(not (value h2 n11))(not (value h2 n12))(not (value h2 n13))(value h2 n2)(not (value h2 n3))(not (value h2 n4))(not (value h2 n5))(not (value h2 n6))(not (value h2 n7))(not (value h2 n8))(not (value h2 n9))(not (value ha n0))(value ha n1)(not (value ha n10))(not (value ha n11))(not (value ha n12))(not (value ha n13))(not (value ha n2))(not (value ha n3))(not (value ha n4))(not (value ha n5))(not (value ha n6))(not (value ha n7))(not (value ha n8))(not (value ha n9))(value s0 n0)(not (value s0 n1))(not (value s0 n10))(not (value s0 n11))(not (value s0 n12))(not (value s0 n13))(not (value s0 n2))(not (value s0 n3))(not (value s0 n4))(not (value s0 n5))(not (value s0 n6))(not (value s0 n7))(not (value s0 n8))(not (value s0 n9))(not (value s2 n0))(not (value s2 n1))(not (value s2 n10))(not (value s2 n11))(not (value s2 n12))(not (value s2 n13))(value s2 n2)(not (value s2 n3))(not (value s2 n4))(not (value s2 n5))(not (value s2 n6))(not (value s2 n7))(not (value s2 n8))(not (value s2 n9))(not (value sa n0))(value sa n1)(not (value sa n10))(not (value sa n11))(not (value sa n12))(not (value sa n13))(not (value sa n2))(not (value sa n3))(not (value sa n4))(not (value sa n5))(not (value sa n6))(not (value sa n7))(not (value sa n8))(not (value sa n9))(test7 ))
   :effect (and (not (plan-sendtohome-b i1 ha h n1 h0 n0 n3 n4))(not (plan-homefromfreecell i2 h2 h n2 ha n1 n3 n4))(not (plan-sendtohome-b i3 sa s n1 s0 n0 n4 n5))(current i1)(not (current i4))(plan-sendtohome-b i1 c2 c n2 ca n1 n5 n6)(plan-sendtohome-b i2 d2 d n2 da n1 n6 n7)(plan-sendtohome-b i3 s2 s n2 sa n1 n7 n8)(test8 )(not (test7 ))(not (action_applied ))))

 (:action validate_9
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(not (bottomcol c0))(not (bottomcol c2))(not (bottomcol ca))(not (bottomcol d0))(not (bottomcol d2))(not (bottomcol da))(not (bottomcol h0))(not (bottomcol h2))(not (bottomcol ha))(not (bottomcol s0))(not (bottomcol s2))(not (bottomcol sa))(not (canstack c0 c0))(not (canstack c0 c2))(not (canstack c0 ca))(not (canstack c0 d0))(not (canstack c0 d2))(not (canstack c0 da))(not (canstack c0 h0))(not (canstack c0 h2))(not (canstack c0 ha))(not (canstack c0 s0))(not (canstack c0 s2))(not (canstack c0 sa))(not (canstack c2 c0))(not (canstack c2 c2))(not (canstack c2 ca))(not (canstack c2 d0))(not (canstack c2 d2))(not (canstack c2 da))(not (canstack c2 h0))(not (canstack c2 h2))(not (canstack c2 ha))(not (canstack c2 s0))(not (canstack c2 s2))(not (canstack c2 sa))(not (canstack ca c0))(not (canstack ca c2))(not (canstack ca ca))(not (canstack ca d0))(canstack ca d2)(not (canstack ca da))(not (canstack ca h0))(canstack ca h2)(not (canstack ca ha))(not (canstack ca s0))(not (canstack ca s2))(not (canstack ca sa))(not (canstack d0 c0))(not (canstack d0 c2))(not (canstack d0 ca))(not (canstack d0 d0))(not (canstack d0 d2))(not (canstack d0 da))(not (canstack d0 h0))(not (canstack d0 h2))(not (canstack d0 ha))(not (canstack d0 s0))(not (canstack d0 s2))(not (canstack d0 sa))(not (canstack d2 c0))(not (canstack d2 c2))(not (canstack d2 ca))(not (canstack d2 d0))(not (canstack d2 d2))(not (canstack d2 da))(not (canstack d2 h0))(not (canstack d2 h2))(not (canstack d2 ha))(not (canstack d2 s0))(not (canstack d2 s2))(not (canstack d2 sa))(not (canstack da c0))(canstack da c2)(not (canstack da ca))(not (canstack da d0))(not (canstack da d2))(not (canstack da da))(not (canstack da h0))(not (canstack da h2))(not (canstack da ha))(not (canstack da s0))(canstack da s2)(not (canstack da sa))(not (canstack h0 c0))(not (canstack h0 c2))(not (canstack h0 ca))(not (canstack h0 d0))(not (canstack h0 d2))(not (canstack h0 da))(not (canstack h0 h0))(not (canstack h0 h2))(not (canstack h0 ha))(not (canstack h0 s0))(not (canstack h0 s2))(not (canstack h0 sa))(not (canstack h2 c0))(not (canstack h2 c2))(not (canstack h2 ca))(not (canstack h2 d0))(not (canstack h2 d2))(not (canstack h2 da))(not (canstack h2 h0))(not (canstack h2 h2))(not (canstack h2 ha))(not (canstack h2 s0))(not (canstack h2 s2))(not (canstack h2 sa))(not (canstack ha c0))(canstack ha c2)(not (canstack ha ca))(not (canstack ha d0))(not (canstack ha d2))(not (canstack ha da))(not (canstack ha h0))(not (canstack ha h2))(not (canstack ha ha))(not (canstack ha s0))(canstack ha s2)(not (canstack ha sa))(not (canstack s0 c0))(not (canstack s0 c2))(not (canstack s0 ca))(not (canstack s0 d0))(not (canstack s0 d2))(not (canstack s0 da))(not (canstack s0 h0))(not (canstack s0 h2))(not (canstack s0 ha))(not (canstack s0 s0))(not (canstack s0 s2))(not (canstack s0 sa))(not (canstack s2 c0))(not (canstack s2 c2))(not (canstack s2 ca))(not (canstack s2 d0))(not (canstack s2 d2))(not (canstack s2 da))(not (canstack s2 h0))(not (canstack s2 h2))(not (canstack s2 ha))(not (canstack s2 s0))(not (canstack s2 s2))(not (canstack s2 sa))(not (canstack sa c0))(not (canstack sa c2))(not (canstack sa ca))(not (canstack sa d0))(canstack sa d2)(not (canstack sa da))(not (canstack sa h0))(canstack sa h2)(not (canstack sa ha))(not (canstack sa s0))(not (canstack sa s2))(not (canstack sa sa))(not (cellspace n0))(not (cellspace n1))(not (cellspace n10))(not (cellspace n11))(not (cellspace n12))(not (cellspace n13))(not (cellspace n2))(not (cellspace n3))(cellspace n4)(not (cellspace n5))(not (cellspace n6))(not (cellspace n7))(not (cellspace n8))(not (cellspace n9))(not (clear c0))(not (clear c2))(not (clear ca))(not (clear d0))(not (clear d2))(not (clear da))(not (clear h0))(not (clear h2))(not (clear ha))(not (clear s0))(not (clear s2))(not (clear sa))(not (colspace n0))(not (colspace n1))(not (colspace n10))(not (colspace n11))(not (colspace n12))(not (colspace n13))(not (colspace n2))(not (colspace n3))(not (colspace n4))(not (colspace n5))(not (colspace n6))(not (colspace n7))(colspace n8)(not (colspace n9))(not (home c0))(home c2)(not (home ca))(not (home d0))(home d2)(not (home da))(not (home h0))(home h2)(not (home ha))(not (home s0))(home s2)(not (home sa))(not (incell c0))(not (incell c2))(not (incell ca))(not (incell d0))(not (incell d2))(not (incell da))(not (incell h0))(not (incell h2))(not (incell ha))(not (incell s0))(not (incell s2))(not (incell sa))(not (on c0 c0))(not (on c0 c2))(not (on c0 ca))(not (on c0 d0))(not (on c0 d2))(not (on c0 da))(not (on c0 h0))(not (on c0 h2))(not (on c0 ha))(not (on c0 s0))(not (on c0 s2))(not (on c0 sa))(not (on c2 c0))(not (on c2 c2))(not (on c2 ca))(not (on c2 d0))(not (on c2 d2))(not (on c2 da))(not (on c2 h0))(not (on c2 h2))(not (on c2 ha))(not (on c2 s0))(not (on c2 s2))(not (on c2 sa))(not (on ca c0))(not (on ca c2))(not (on ca ca))(not (on ca d0))(not (on ca d2))(not (on ca da))(not (on ca h0))(not (on ca h2))(not (on ca ha))(not (on ca s0))(not (on ca s2))(not (on ca sa))(not (on d0 c0))(not (on d0 c2))(not (on d0 ca))(not (on d0 d0))(not (on d0 d2))(not (on d0 da))(not (on d0 h0))(not (on d0 h2))(not (on d0 ha))(not (on d0 s0))(not (on d0 s2))(not (on d0 sa))(not (on d2 c0))(not (on d2 c2))(not (on d2 ca))(not (on d2 d0))(not (on d2 d2))(not (on d2 da))(not (on d2 h0))(not (on d2 h2))(not (on d2 ha))(not (on d2 s0))(not (on d2 s2))(not (on d2 sa))(not (on da c0))(not (on da c2))(not (on da ca))(not (on da d0))(not (on da d2))(not (on da da))(not (on da h0))(not (on da h2))(not (on da ha))(not (on da s0))(not (on da s2))(not (on da sa))(not (on h0 c0))(not (on h0 c2))(not (on h0 ca))(not (on h0 d0))(not (on h0 d2))(not (on h0 da))(not (on h0 h0))(not (on h0 h2))(not (on h0 ha))(not (on h0 s0))(not (on h0 s2))(not (on h0 sa))(not (on h2 c0))(not (on h2 c2))(not (on h2 ca))(not (on h2 d0))(not (on h2 d2))(not (on h2 da))(not (on h2 h0))(not (on h2 h2))(not (on h2 ha))(not (on h2 s0))(not (on h2 s2))(not (on h2 sa))(not (on ha c0))(not (on ha c2))(not (on ha ca))(not (on ha d0))(not (on ha d2))(not (on ha da))(not (on ha h0))(not (on ha h2))(not (on ha ha))(not (on ha s0))(not (on ha s2))(not (on ha sa))(not (on s0 c0))(not (on s0 c2))(not (on s0 ca))(not (on s0 d0))(not (on s0 d2))(not (on s0 da))(not (on s0 h0))(not (on s0 h2))(not (on s0 ha))(not (on s0 s0))(not (on s0 s2))(not (on s0 sa))(not (on s2 c0))(not (on s2 c2))(not (on s2 ca))(not (on s2 d0))(not (on s2 d2))(not (on s2 da))(not (on s2 h0))(not (on s2 h2))(not (on s2 ha))(not (on s2 s0))(not (on s2 s2))(not (on s2 sa))(not (on sa c0))(not (on sa c2))(not (on sa ca))(not (on sa d0))(not (on sa d2))(not (on sa da))(not (on sa h0))(not (on sa h2))(not (on sa ha))(not (on sa s0))(not (on sa s2))(not (on sa sa))(not (successor n0 n0))(not (successor n0 n1))(not (successor n0 n10))(not (successor n0 n11))(not (successor n0 n12))(not (successor n0 n13))(not (successor n0 n2))(not (successor n0 n3))(not (successor n0 n4))(not (successor n0 n5))(not (successor n0 n6))(not (successor n0 n7))(not (successor n0 n8))(not (successor n0 n9))(successor n1 n0)(not (successor n1 n1))(not (successor n1 n10))(not (successor n1 n11))(not (successor n1 n12))(not (successor n1 n13))(not (successor n1 n2))(not (successor n1 n3))(not (successor n1 n4))(not (successor n1 n5))(not (successor n1 n6))(not (successor n1 n7))(not (successor n1 n8))(not (successor n1 n9))(not (successor n10 n0))(not (successor n10 n1))(not (successor n10 n10))(not (successor n10 n11))(not (successor n10 n12))(not (successor n10 n13))(not (successor n10 n2))(not (successor n10 n3))(not (successor n10 n4))(not (successor n10 n5))(not (successor n10 n6))(not (successor n10 n7))(not (successor n10 n8))(successor n10 n9)(not (successor n11 n0))(not (successor n11 n1))(successor n11 n10)(not (successor n11 n11))(not (successor n11 n12))(not (successor n11 n13))(not (successor n11 n2))(not (successor n11 n3))(not (successor n11 n4))(not (successor n11 n5))(not (successor n11 n6))(not (successor n11 n7))(not (successor n11 n8))(not (successor n11 n9))(not (successor n12 n0))(not (successor n12 n1))(not (successor n12 n10))(successor n12 n11)(not (successor n12 n12))(not (successor n12 n13))(not (successor n12 n2))(not (successor n12 n3))(not (successor n12 n4))(not (successor n12 n5))(not (successor n12 n6))(not (successor n12 n7))(not (successor n12 n8))(not (successor n12 n9))(not (successor n13 n0))(not (successor n13 n1))(not (successor n13 n10))(not (successor n13 n11))(successor n13 n12)(not (successor n13 n13))(not (successor n13 n2))(not (successor n13 n3))(not (successor n13 n4))(not (successor n13 n5))(not (successor n13 n6))(not (successor n13 n7))(not (successor n13 n8))(not (successor n13 n9))(not (successor n2 n0))(successor n2 n1)(not (successor n2 n10))(not (successor n2 n11))(not (successor n2 n12))(not (successor n2 n13))(not (successor n2 n2))(not (successor n2 n3))(not (successor n2 n4))(not (successor n2 n5))(not (successor n2 n6))(not (successor n2 n7))(not (successor n2 n8))(not (successor n2 n9))(not (successor n3 n0))(not (successor n3 n1))(not (successor n3 n10))(not (successor n3 n11))(not (successor n3 n12))(not (successor n3 n13))(successor n3 n2)(not (successor n3 n3))(not (successor n3 n4))(not (successor n3 n5))(not (successor n3 n6))(not (successor n3 n7))(not (successor n3 n8))(not (successor n3 n9))(not (successor n4 n0))(not (successor n4 n1))(not (successor n4 n10))(not (successor n4 n11))(not (successor n4 n12))(not (successor n4 n13))(not (successor n4 n2))(successor n4 n3)(not (successor n4 n4))(not (successor n4 n5))(not (successor n4 n6))(not (successor n4 n7))(not (successor n4 n8))(not (successor n4 n9))(not (successor n5 n0))(not (successor n5 n1))(not (successor n5 n10))(not (successor n5 n11))(not (successor n5 n12))(not (successor n5 n13))(not (successor n5 n2))(not (successor n5 n3))(successor n5 n4)(not (successor n5 n5))(not (successor n5 n6))(not (successor n5 n7))(not (successor n5 n8))(not (successor n5 n9))(not (successor n6 n0))(not (successor n6 n1))(not (successor n6 n10))(not (successor n6 n11))(not (successor n6 n12))(not (successor n6 n13))(not (successor n6 n2))(not (successor n6 n3))(not (successor n6 n4))(successor n6 n5)(not (successor n6 n6))(not (successor n6 n7))(not (successor n6 n8))(not (successor n6 n9))(not (successor n7 n0))(not (successor n7 n1))(not (successor n7 n10))(not (successor n7 n11))(not (successor n7 n12))(not (successor n7 n13))(not (successor n7 n2))(not (successor n7 n3))(not (successor n7 n4))(not (successor n7 n5))(successor n7 n6)(not (successor n7 n7))(not (successor n7 n8))(not (successor n7 n9))(not (successor n8 n0))(not (successor n8 n1))(not (successor n8 n10))(not (successor n8 n11))(not (successor n8 n12))(not (successor n8 n13))(not (successor n8 n2))(not (successor n8 n3))(not (successor n8 n4))(not (successor n8 n5))(not (successor n8 n6))(successor n8 n7)(not (successor n8 n8))(not (successor n8 n9))(not (successor n9 n0))(not (successor n9 n1))(not (successor n9 n10))(not (successor n9 n11))(not (successor n9 n12))(not (successor n9 n13))(not (successor n9 n2))(not (successor n9 n3))(not (successor n9 n4))(not (successor n9 n5))(not (successor n9 n6))(not (successor n9 n7))(successor n9 n8)(not (successor n9 n9))(suit c0 c)(not (suit c0 d))(not (suit c0 h))(not (suit c0 s))(suit c2 c)(not (suit c2 d))(not (suit c2 h))(not (suit c2 s))(suit ca c)(not (suit ca d))(not (suit ca h))(not (suit ca s))(not (suit d0 c))(suit d0 d)(not (suit d0 h))(not (suit d0 s))(not (suit d2 c))(suit d2 d)(not (suit d2 h))(not (suit d2 s))(not (suit da c))(suit da d)(not (suit da h))(not (suit da s))(not (suit h0 c))(not (suit h0 d))(suit h0 h)(not (suit h0 s))(not (suit h2 c))(not (suit h2 d))(suit h2 h)(not (suit h2 s))(not (suit ha c))(not (suit ha d))(suit ha h)(not (suit ha s))(not (suit s0 c))(not (suit s0 d))(not (suit s0 h))(suit s0 s)(not (suit s2 c))(not (suit s2 d))(not (suit s2 h))(suit s2 s)(not (suit sa c))(not (suit sa d))(not (suit sa h))(suit sa s)(value c0 n0)(not (value c0 n1))(not (value c0 n10))(not (value c0 n11))(not (value c0 n12))(not (value c0 n13))(not (value c0 n2))(not (value c0 n3))(not (value c0 n4))(not (value c0 n5))(not (value c0 n6))(not (value c0 n7))(not (value c0 n8))(not (value c0 n9))(not (value c2 n0))(not (value c2 n1))(not (value c2 n10))(not (value c2 n11))(not (value c2 n12))(not (value c2 n13))(value c2 n2)(not (value c2 n3))(not (value c2 n4))(not (value c2 n5))(not (value c2 n6))(not (value c2 n7))(not (value c2 n8))(not (value c2 n9))(not (value ca n0))(value ca n1)(not (value ca n10))(not (value ca n11))(not (value ca n12))(not (value ca n13))(not (value ca n2))(not (value ca n3))(not (value ca n4))(not (value ca n5))(not (value ca n6))(not (value ca n7))(not (value ca n8))(not (value ca n9))(value d0 n0)(not (value d0 n1))(not (value d0 n10))(not (value d0 n11))(not (value d0 n12))(not (value d0 n13))(not (value d0 n2))(not (value d0 n3))(not (value d0 n4))(not (value d0 n5))(not (value d0 n6))(not (value d0 n7))(not (value d0 n8))(not (value d0 n9))(not (value d2 n0))(not (value d2 n1))(not (value d2 n10))(not (value d2 n11))(not (value d2 n12))(not (value d2 n13))(value d2 n2)(not (value d2 n3))(not (value d2 n4))(not (value d2 n5))(not (value d2 n6))(not (value d2 n7))(not (value d2 n8))(not (value d2 n9))(not (value da n0))(value da n1)(not (value da n10))(not (value da n11))(not (value da n12))(not (value da n13))(not (value da n2))(not (value da n3))(not (value da n4))(not (value da n5))(not (value da n6))(not (value da n7))(not (value da n8))(not (value da n9))(value h0 n0)(not (value h0 n1))(not (value h0 n10))(not (value h0 n11))(not (value h0 n12))(not (value h0 n13))(not (value h0 n2))(not (value h0 n3))(not (value h0 n4))(not (value h0 n5))(not (value h0 n6))(not (value h0 n7))(not (value h0 n8))(not (value h0 n9))(not (value h2 n0))(not (value h2 n1))(not (value h2 n10))(not (value h2 n11))(not (value h2 n12))(not (value h2 n13))(value h2 n2)(not (value h2 n3))(not (value h2 n4))(not (value h2 n5))(not (value h2 n6))(not (value h2 n7))(not (value h2 n8))(not (value h2 n9))(not (value ha n0))(value ha n1)(not (value ha n10))(not (value ha n11))(not (value ha n12))(not (value ha n13))(not (value ha n2))(not (value ha n3))(not (value ha n4))(not (value ha n5))(not (value ha n6))(not (value ha n7))(not (value ha n8))(not (value ha n9))(value s0 n0)(not (value s0 n1))(not (value s0 n10))(not (value s0 n11))(not (value s0 n12))(not (value s0 n13))(not (value s0 n2))(not (value s0 n3))(not (value s0 n4))(not (value s0 n5))(not (value s0 n6))(not (value s0 n7))(not (value s0 n8))(not (value s0 n9))(not (value s2 n0))(not (value s2 n1))(not (value s2 n10))(not (value s2 n11))(not (value s2 n12))(not (value s2 n13))(value s2 n2)(not (value s2 n3))(not (value s2 n4))(not (value s2 n5))(not (value s2 n6))(not (value s2 n7))(not (value s2 n8))(not (value s2 n9))(not (value sa n0))(value sa n1)(not (value sa n10))(not (value sa n11))(not (value sa n12))(not (value sa n13))(not (value sa n2))(not (value sa n3))(not (value sa n4))(not (value sa n5))(not (value sa n6))(not (value sa n7))(not (value sa n8))(not (value sa n9))(test8 ))
   :effect (and (not (plan-sendtohome-b i1 c2 c n2 ca n1 n5 n6))(not (plan-sendtohome-b i2 d2 d n2 da n1 n6 n7))(not (plan-sendtohome-b i3 s2 s n2 sa n1 n7 n8))(current i1)(not (current i4))(not (home d2))(not (colspace n8))(not (home s2))(not (home h2))(not (home c2))(clear s2)(home c0)(home d0)(clear h2)(home h0)(clear da)(colspace n2)(bottomcol ca)(home s0)(on h2 ha)(bottomcol c2)(on da sa)(clear c2)(bottomcol d2)(bottomcol s2)(bottomcol ha)(bottomcol sa)(clear ca)(clear d2)(plan-sendtofree i1 h2 ha n4 n3)(plan-sendtohome i2 da sa d n1 d0 n0)(plan-sendtohome-b i3 ca c n1 c0 n0 n2 n3)(test9 )(not (test8 ))(not (action_applied ))))

 (:action validate_10
   :parameters ()
   :precondition (and (not (modeProg ))(action_applied )(current i4)(not (bottomcol c0))(bottomcol c2)(not (bottomcol ca))(not (bottomcol d0))(bottomcol d2)(not (bottomcol da))(not (bottomcol h0))(not (bottomcol h2))(bottomcol ha)(not (bottomcol s0))(bottomcol s2)(bottomcol sa)(not (canstack c0 c0))(not (canstack c0 c2))(not (canstack c0 ca))(not (canstack c0 d0))(not (canstack c0 d2))(not (canstack c0 da))(not (canstack c0 h0))(not (canstack c0 h2))(not (canstack c0 ha))(not (canstack c0 s0))(not (canstack c0 s2))(not (canstack c0 sa))(not (canstack c2 c0))(not (canstack c2 c2))(not (canstack c2 ca))(not (canstack c2 d0))(not (canstack c2 d2))(not (canstack c2 da))(not (canstack c2 h0))(not (canstack c2 h2))(not (canstack c2 ha))(not (canstack c2 s0))(not (canstack c2 s2))(not (canstack c2 sa))(not (canstack ca c0))(not (canstack ca c2))(not (canstack ca ca))(not (canstack ca d0))(canstack ca d2)(not (canstack ca da))(not (canstack ca h0))(canstack ca h2)(not (canstack ca ha))(not (canstack ca s0))(not (canstack ca s2))(not (canstack ca sa))(not (canstack d0 c0))(not (canstack d0 c2))(not (canstack d0 ca))(not (canstack d0 d0))(not (canstack d0 d2))(not (canstack d0 da))(not (canstack d0 h0))(not (canstack d0 h2))(not (canstack d0 ha))(not (canstack d0 s0))(not (canstack d0 s2))(not (canstack d0 sa))(not (canstack d2 c0))(not (canstack d2 c2))(not (canstack d2 ca))(not (canstack d2 d0))(not (canstack d2 d2))(not (canstack d2 da))(not (canstack d2 h0))(not (canstack d2 h2))(not (canstack d2 ha))(not (canstack d2 s0))(not (canstack d2 s2))(not (canstack d2 sa))(not (canstack da c0))(canstack da c2)(not (canstack da ca))(not (canstack da d0))(not (canstack da d2))(not (canstack da da))(not (canstack da h0))(not (canstack da h2))(not (canstack da ha))(not (canstack da s0))(canstack da s2)(not (canstack da sa))(not (canstack h0 c0))(not (canstack h0 c2))(not (canstack h0 ca))(not (canstack h0 d0))(not (canstack h0 d2))(not (canstack h0 da))(not (canstack h0 h0))(not (canstack h0 h2))(not (canstack h0 ha))(not (canstack h0 s0))(not (canstack h0 s2))(not (canstack h0 sa))(not (canstack h2 c0))(not (canstack h2 c2))(not (canstack h2 ca))(not (canstack h2 d0))(not (canstack h2 d2))(not (canstack h2 da))(not (canstack h2 h0))(not (canstack h2 h2))(not (canstack h2 ha))(not (canstack h2 s0))(not (canstack h2 s2))(not (canstack h2 sa))(not (canstack ha c0))(canstack ha c2)(not (canstack ha ca))(not (canstack ha d0))(not (canstack ha d2))(not (canstack ha da))(not (canstack ha h0))(not (canstack ha h2))(not (canstack ha ha))(not (canstack ha s0))(canstack ha s2)(not (canstack ha sa))(not (canstack s0 c0))(not (canstack s0 c2))(not (canstack s0 ca))(not (canstack s0 d0))(not (canstack s0 d2))(not (canstack s0 da))(not (canstack s0 h0))(not (canstack s0 h2))(not (canstack s0 ha))(not (canstack s0 s0))(not (canstack s0 s2))(not (canstack s0 sa))(not (canstack s2 c0))(not (canstack s2 c2))(not (canstack s2 ca))(not (canstack s2 d0))(not (canstack s2 d2))(not (canstack s2 da))(not (canstack s2 h0))(not (canstack s2 h2))(not (canstack s2 ha))(not (canstack s2 s0))(not (canstack s2 s2))(not (canstack s2 sa))(not (canstack sa c0))(not (canstack sa c2))(not (canstack sa ca))(not (canstack sa d0))(canstack sa d2)(not (canstack sa da))(not (canstack sa h0))(canstack sa h2)(not (canstack sa ha))(not (canstack sa s0))(not (canstack sa s2))(not (canstack sa sa))(not (cellspace n0))(not (cellspace n1))(not (cellspace n10))(not (cellspace n11))(not (cellspace n12))(not (cellspace n13))(not (cellspace n2))(cellspace n3)(not (cellspace n4))(not (cellspace n5))(not (cellspace n6))(not (cellspace n7))(not (cellspace n8))(not (cellspace n9))(not (clear c0))(clear c2)(not (clear ca))(not (clear d0))(clear d2)(not (clear da))(not (clear h0))(not (clear h2))(clear ha)(not (clear s0))(clear s2)(clear sa)(not (colspace n0))(not (colspace n1))(not (colspace n10))(not (colspace n11))(not (colspace n12))(not (colspace n13))(not (colspace n2))(colspace n3)(not (colspace n4))(not (colspace n5))(not (colspace n6))(not (colspace n7))(not (colspace n8))(not (colspace n9))(not (home c0))(not (home c2))(home ca)(not (home d0))(not (home d2))(home da)(home h0)(not (home h2))(not (home ha))(home s0)(not (home s2))(not (home sa))(not (incell c0))(not (incell c2))(not (incell ca))(not (incell d0))(not (incell d2))(not (incell da))(not (incell h0))(incell h2)(not (incell ha))(not (incell s0))(not (incell s2))(not (incell sa))(not (on c0 c0))(not (on c0 c2))(not (on c0 ca))(not (on c0 d0))(not (on c0 d2))(not (on c0 da))(not (on c0 h0))(not (on c0 h2))(not (on c0 ha))(not (on c0 s0))(not (on c0 s2))(not (on c0 sa))(not (on c2 c0))(not (on c2 c2))(not (on c2 ca))(not (on c2 d0))(not (on c2 d2))(not (on c2 da))(not (on c2 h0))(not (on c2 h2))(not (on c2 ha))(not (on c2 s0))(not (on c2 s2))(not (on c2 sa))(not (on ca c0))(not (on ca c2))(not (on ca ca))(not (on ca d0))(not (on ca d2))(not (on ca da))(not (on ca h0))(not (on ca h2))(not (on ca ha))(not (on ca s0))(not (on ca s2))(not (on ca sa))(not (on d0 c0))(not (on d0 c2))(not (on d0 ca))(not (on d0 d0))(not (on d0 d2))(not (on d0 da))(not (on d0 h0))(not (on d0 h2))(not (on d0 ha))(not (on d0 s0))(not (on d0 s2))(not (on d0 sa))(not (on d2 c0))(not (on d2 c2))(not (on d2 ca))(not (on d2 d0))(not (on d2 d2))(not (on d2 da))(not (on d2 h0))(not (on d2 h2))(not (on d2 ha))(not (on d2 s0))(not (on d2 s2))(not (on d2 sa))(not (on da c0))(not (on da c2))(not (on da ca))(not (on da d0))(not (on da d2))(not (on da da))(not (on da h0))(not (on da h2))(not (on da ha))(not (on da s0))(not (on da s2))(not (on da sa))(not (on h0 c0))(not (on h0 c2))(not (on h0 ca))(not (on h0 d0))(not (on h0 d2))(not (on h0 da))(not (on h0 h0))(not (on h0 h2))(not (on h0 ha))(not (on h0 s0))(not (on h0 s2))(not (on h0 sa))(not (on h2 c0))(not (on h2 c2))(not (on h2 ca))(not (on h2 d0))(not (on h2 d2))(not (on h2 da))(not (on h2 h0))(not (on h2 h2))(not (on h2 ha))(not (on h2 s0))(not (on h2 s2))(not (on h2 sa))(not (on ha c0))(not (on ha c2))(not (on ha ca))(not (on ha d0))(not (on ha d2))(not (on ha da))(not (on ha h0))(not (on ha h2))(not (on ha ha))(not (on ha s0))(not (on ha s2))(not (on ha sa))(not (on s0 c0))(not (on s0 c2))(not (on s0 ca))(not (on s0 d0))(not (on s0 d2))(not (on s0 da))(not (on s0 h0))(not (on s0 h2))(not (on s0 ha))(not (on s0 s0))(not (on s0 s2))(not (on s0 sa))(not (on s2 c0))(not (on s2 c2))(not (on s2 ca))(not (on s2 d0))(not (on s2 d2))(not (on s2 da))(not (on s2 h0))(not (on s2 h2))(not (on s2 ha))(not (on s2 s0))(not (on s2 s2))(not (on s2 sa))(not (on sa c0))(not (on sa c2))(not (on sa ca))(not (on sa d0))(not (on sa d2))(not (on sa da))(not (on sa h0))(not (on sa h2))(not (on sa ha))(not (on sa s0))(not (on sa s2))(not (on sa sa))(not (successor n0 n0))(not (successor n0 n1))(not (successor n0 n10))(not (successor n0 n11))(not (successor n0 n12))(not (successor n0 n13))(not (successor n0 n2))(not (successor n0 n3))(not (successor n0 n4))(not (successor n0 n5))(not (successor n0 n6))(not (successor n0 n7))(not (successor n0 n8))(not (successor n0 n9))(successor n1 n0)(not (successor n1 n1))(not (successor n1 n10))(not (successor n1 n11))(not (successor n1 n12))(not (successor n1 n13))(not (successor n1 n2))(not (successor n1 n3))(not (successor n1 n4))(not (successor n1 n5))(not (successor n1 n6))(not (successor n1 n7))(not (successor n1 n8))(not (successor n1 n9))(not (successor n10 n0))(not (successor n10 n1))(not (successor n10 n10))(not (successor n10 n11))(not (successor n10 n12))(not (successor n10 n13))(not (successor n10 n2))(not (successor n10 n3))(not (successor n10 n4))(not (successor n10 n5))(not (successor n10 n6))(not (successor n10 n7))(not (successor n10 n8))(successor n10 n9)(not (successor n11 n0))(not (successor n11 n1))(successor n11 n10)(not (successor n11 n11))(not (successor n11 n12))(not (successor n11 n13))(not (successor n11 n2))(not (successor n11 n3))(not (successor n11 n4))(not (successor n11 n5))(not (successor n11 n6))(not (successor n11 n7))(not (successor n11 n8))(not (successor n11 n9))(not (successor n12 n0))(not (successor n12 n1))(not (successor n12 n10))(successor n12 n11)(not (successor n12 n12))(not (successor n12 n13))(not (successor n12 n2))(not (successor n12 n3))(not (successor n12 n4))(not (successor n12 n5))(not (successor n12 n6))(not (successor n12 n7))(not (successor n12 n8))(not (successor n12 n9))(not (successor n13 n0))(not (successor n13 n1))(not (successor n13 n10))(not (successor n13 n11))(successor n13 n12)(not (successor n13 n13))(not (successor n13 n2))(not (successor n13 n3))(not (successor n13 n4))(not (successor n13 n5))(not (successor n13 n6))(not (successor n13 n7))(not (successor n13 n8))(not (successor n13 n9))(not (successor n2 n0))(successor n2 n1)(not (successor n2 n10))(not (successor n2 n11))(not (successor n2 n12))(not (successor n2 n13))(not (successor n2 n2))(not (successor n2 n3))(not (successor n2 n4))(not (successor n2 n5))(not (successor n2 n6))(not (successor n2 n7))(not (successor n2 n8))(not (successor n2 n9))(not (successor n3 n0))(not (successor n3 n1))(not (successor n3 n10))(not (successor n3 n11))(not (successor n3 n12))(not (successor n3 n13))(successor n3 n2)(not (successor n3 n3))(not (successor n3 n4))(not (successor n3 n5))(not (successor n3 n6))(not (successor n3 n7))(not (successor n3 n8))(not (successor n3 n9))(not (successor n4 n0))(not (successor n4 n1))(not (successor n4 n10))(not (successor n4 n11))(not (successor n4 n12))(not (successor n4 n13))(not (successor n4 n2))(successor n4 n3)(not (successor n4 n4))(not (successor n4 n5))(not (successor n4 n6))(not (successor n4 n7))(not (successor n4 n8))(not (successor n4 n9))(not (successor n5 n0))(not (successor n5 n1))(not (successor n5 n10))(not (successor n5 n11))(not (successor n5 n12))(not (successor n5 n13))(not (successor n5 n2))(not (successor n5 n3))(successor n5 n4)(not (successor n5 n5))(not (successor n5 n6))(not (successor n5 n7))(not (successor n5 n8))(not (successor n5 n9))(not (successor n6 n0))(not (successor n6 n1))(not (successor n6 n10))(not (successor n6 n11))(not (successor n6 n12))(not (successor n6 n13))(not (successor n6 n2))(not (successor n6 n3))(not (successor n6 n4))(successor n6 n5)(not (successor n6 n6))(not (successor n6 n7))(not (successor n6 n8))(not (successor n6 n9))(not (successor n7 n0))(not (successor n7 n1))(not (successor n7 n10))(not (successor n7 n11))(not (successor n7 n12))(not (successor n7 n13))(not (successor n7 n2))(not (successor n7 n3))(not (successor n7 n4))(not (successor n7 n5))(successor n7 n6)(not (successor n7 n7))(not (successor n7 n8))(not (successor n7 n9))(not (successor n8 n0))(not (successor n8 n1))(not (successor n8 n10))(not (successor n8 n11))(not (successor n8 n12))(not (successor n8 n13))(not (successor n8 n2))(not (successor n8 n3))(not (successor n8 n4))(not (successor n8 n5))(not (successor n8 n6))(successor n8 n7)(not (successor n8 n8))(not (successor n8 n9))(not (successor n9 n0))(not (successor n9 n1))(not (successor n9 n10))(not (successor n9 n11))(not (successor n9 n12))(not (successor n9 n13))(not (successor n9 n2))(not (successor n9 n3))(not (successor n9 n4))(not (successor n9 n5))(not (successor n9 n6))(not (successor n9 n7))(successor n9 n8)(not (successor n9 n9))(suit c0 c)(not (suit c0 d))(not (suit c0 h))(not (suit c0 s))(suit c2 c)(not (suit c2 d))(not (suit c2 h))(not (suit c2 s))(suit ca c)(not (suit ca d))(not (suit ca h))(not (suit ca s))(not (suit d0 c))(suit d0 d)(not (suit d0 h))(not (suit d0 s))(not (suit d2 c))(suit d2 d)(not (suit d2 h))(not (suit d2 s))(not (suit da c))(suit da d)(not (suit da h))(not (suit da s))(not (suit h0 c))(not (suit h0 d))(suit h0 h)(not (suit h0 s))(not (suit h2 c))(not (suit h2 d))(suit h2 h)(not (suit h2 s))(not (suit ha c))(not (suit ha d))(suit ha h)(not (suit ha s))(not (suit s0 c))(not (suit s0 d))(not (suit s0 h))(suit s0 s)(not (suit s2 c))(not (suit s2 d))(not (suit s2 h))(suit s2 s)(not (suit sa c))(not (suit sa d))(not (suit sa h))(suit sa s)(value c0 n0)(not (value c0 n1))(not (value c0 n10))(not (value c0 n11))(not (value c0 n12))(not (value c0 n13))(not (value c0 n2))(not (value c0 n3))(not (value c0 n4))(not (value c0 n5))(not (value c0 n6))(not (value c0 n7))(not (value c0 n8))(not (value c0 n9))(not (value c2 n0))(not (value c2 n1))(not (value c2 n10))(not (value c2 n11))(not (value c2 n12))(not (value c2 n13))(value c2 n2)(not (value c2 n3))(not (value c2 n4))(not (value c2 n5))(not (value c2 n6))(not (value c2 n7))(not (value c2 n8))(not (value c2 n9))(not (value ca n0))(value ca n1)(not (value ca n10))(not (value ca n11))(not (value ca n12))(not (value ca n13))(not (value ca n2))(not (value ca n3))(not (value ca n4))(not (value ca n5))(not (value ca n6))(not (value ca n7))(not (value ca n8))(not (value ca n9))(value d0 n0)(not (value d0 n1))(not (value d0 n10))(not (value d0 n11))(not (value d0 n12))(not (value d0 n13))(not (value d0 n2))(not (value d0 n3))(not (value d0 n4))(not (value d0 n5))(not (value d0 n6))(not (value d0 n7))(not (value d0 n8))(not (value d0 n9))(not (value d2 n0))(not (value d2 n1))(not (value d2 n10))(not (value d2 n11))(not (value d2 n12))(not (value d2 n13))(value d2 n2)(not (value d2 n3))(not (value d2 n4))(not (value d2 n5))(not (value d2 n6))(not (value d2 n7))(not (value d2 n8))(not (value d2 n9))(not (value da n0))(value da n1)(not (value da n10))(not (value da n11))(not (value da n12))(not (value da n13))(not (value da n2))(not (value da n3))(not (value da n4))(not (value da n5))(not (value da n6))(not (value da n7))(not (value da n8))(not (value da n9))(value h0 n0)(not (value h0 n1))(not (value h0 n10))(not (value h0 n11))(not (value h0 n12))(not (value h0 n13))(not (value h0 n2))(not (value h0 n3))(not (value h0 n4))(not (value h0 n5))(not (value h0 n6))(not (value h0 n7))(not (value h0 n8))(not (value h0 n9))(not (value h2 n0))(not (value h2 n1))(not (value h2 n10))(not (value h2 n11))(not (value h2 n12))(not (value h2 n13))(value h2 n2)(not (value h2 n3))(not (value h2 n4))(not (value h2 n5))(not (value h2 n6))(not (value h2 n7))(not (value h2 n8))(not (value h2 n9))(not (value ha n0))(value ha n1)(not (value ha n10))(not (value ha n11))(not (value ha n12))(not (value ha n13))(not (value ha n2))(not (value ha n3))(not (value ha n4))(not (value ha n5))(not (value ha n6))(not (value ha n7))(not (value ha n8))(not (value ha n9))(value s0 n0)(not (value s0 n1))(not (value s0 n10))(not (value s0 n11))(not (value s0 n12))(not (value s0 n13))(not (value s0 n2))(not (value s0 n3))(not (value s0 n4))(not (value s0 n5))(not (value s0 n6))(not (value s0 n7))(not (value s0 n8))(not (value s0 n9))(not (value s2 n0))(not (value s2 n1))(not (value s2 n10))(not (value s2 n11))(not (value s2 n12))(not (value s2 n13))(value s2 n2)(not (value s2 n3))(not (value s2 n4))(not (value s2 n5))(not (value s2 n6))(not (value s2 n7))(not (value s2 n8))(not (value s2 n9))(not (value sa n0))(value sa n1)(not (value sa n10))(not (value sa n11))(not (value sa n12))(not (value sa n13))(not (value sa n2))(not (value sa n3))(not (value sa n4))(not (value sa n5))(not (value sa n6))(not (value sa n7))(not (value sa n8))(not (value sa n9))(test9 ))
   :effect (and (not (plan-sendtofree i1 h2 ha n4 n3))(not (plan-sendtohome i2 da sa d n1 d0 n0))(not (plan-sendtohome-b i3 ca c n1 c0 n0 n2 n3))(current i1)(not (current i4))(not (test9 ))(test10 )))

)