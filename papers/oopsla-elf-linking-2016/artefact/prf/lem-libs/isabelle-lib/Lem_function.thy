chapter {* Generated by Lem from function.lem. *}

theory "Lem_function" 

imports 
 	 Main
	 "Lem_bool" 
	 "Lem_basic_classes" 

begin 

(******************************************************************************)
(* A library for common operations on functions                               *)
(******************************************************************************)

(*open import Bool Basic_classes*)

(*open import {coq} `Program.Basics`*)

(* ----------------------- *)
(* identity function       *)
(* ----------------------- *)

(*val id : forall 'a. 'a -> 'a*)
(*let id x=  x*)


(* ----------------------- *)
(* constant function       *)
(* ----------------------- *)

(*val const : forall 'a 'b. 'a -> 'b -> 'a*)


(* ----------------------- *)
(* function composition    *)
(* ----------------------- *)

(*val comb : forall 'a 'b 'c. ('b -> 'c) -> ('a -> 'b) -> ('a -> 'c)*)
(*let comb f g=  (fun x -> f (g x))*)


(* ----------------------- *)
(* function application    *)
(* ----------------------- *)

(*val $ [apply] : forall 'a 'b. ('a -> 'b) -> ('a -> 'b)*)
(*let $ f=  (fun x -> f x)*)

(* ----------------------- *)
(* flipping argument order *)
(* ----------------------- *)

(*val flip : forall 'a 'b 'c. ('a -> 'b -> 'c) -> ('b -> 'a -> 'c)*)
(*let flip f=  (fun x y -> f y x)*)


(* currying / uncurrying *)

(*val curry : forall 'a 'b 'c. (('a * 'b) -> 'c) -> 'a -> 'b -> 'c*)
definition curry  :: "('a*'b \<Rightarrow> 'c)\<Rightarrow> 'a \<Rightarrow> 'b \<Rightarrow> 'c "  where 
     " curry f = ( (\<lambda> a b .  f (a, b)))"


(*val uncurry : forall 'a 'b 'c. ('a -> 'b -> 'c) -> ('a * 'b -> 'c)*)
fun uncurry  :: "('a \<Rightarrow> 'b \<Rightarrow> 'c)\<Rightarrow> 'a*'b \<Rightarrow> 'c "  where 
     " uncurry f (a,b) = ( f a b )" 
declare uncurry.simps [simp del]

end
