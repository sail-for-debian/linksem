chapter {* Generated by Lem from relation.lem. *}

theory "Lem_relation" 

imports 
 	 Main
	 "Lem_bool" 
	 "Lem_basic_classes" 
	 "Lem_tuple" 
	 "Lem_set" 
	 "Lem_num" 

begin 



(*open import Bool Basic_classes Tuple Set Num*)
(*open import {hol} `set_relationTheory`*)

(* ========================================================================== *)
(* The type of relations                                                      *)
(* ========================================================================== *)

type_synonym( 'a, 'b) rel_pred =" 'a \<Rightarrow> 'b \<Rightarrow> bool "
type_synonym( 'a, 'b) rel_set =" ('a * 'b) set "

(* Binary relations are usually represented as either
   sets of pairs (rel_set) or as curried functions (rel_pred). 
   
   The choice depends on taste and the backend. Lem should not take a 
   decision, but supports both representations. There is an abstract type
   pred, which can be converted to both representations. The representation
   of pred itself then depends on the backend. However, for the time beeing,
   let's implement relations as sets to get them working more quickly. *)

type_synonym( 'a, 'b) rel =" ('a, 'b) rel_set "

(*val relToSet : forall 'a 'b. SetType 'a, SetType 'b => rel 'a 'b -> rel_set 'a 'b*)
(*val relFromSet : forall 'a 'b. SetType 'a, SetType 'b => rel_set 'a 'b -> rel 'a 'b*)

(*val relEq : forall 'a 'b. SetType 'a, SetType 'b => rel 'a 'b -> rel 'a 'b -> bool*)
definition relEq  :: "('a*'b)set \<Rightarrow>('a*'b)set \<Rightarrow> bool "  where 
     " relEq r1 r2 = ( (r1 = r2))"


(*val relToPred : forall 'a 'b. SetType 'a, SetType 'b, Eq 'a, Eq 'b => rel 'a 'b -> rel_pred 'a 'b*)
(*val relFromPred : forall 'a 'b. SetType 'a, SetType 'b, Eq 'a, Eq 'b => set 'a -> set 'b -> rel_pred 'a 'b -> rel 'a 'b*)

definition relToPred  :: "('a*'b)set \<Rightarrow> 'a \<Rightarrow> 'b \<Rightarrow> bool "  where 
     " relToPred r = ( (\<lambda> x y .  (x, y) \<in> r))"

definition relFromPred  :: " 'a set \<Rightarrow> 'b set \<Rightarrow>('a \<Rightarrow> 'b \<Rightarrow> bool)\<Rightarrow>('a*'b)set "  where 
     " relFromPred xs ys p = ( set_filter (\<lambda> (x,y) .  p x y) (xs \<times> ys))"


 
(* ========================================================================== *)
(* Basic Operations                                                           *)
(* ========================================================================== *)

(* ----------------------- *)
(* membership test         *)
(* ----------------------- *)

(*val inRel : forall 'a 'b. SetType 'a, SetType 'b, Eq 'a, Eq 'b => 'a -> 'b -> rel 'a 'b -> bool*)


(* ----------------------- *)
(* empty relation          *)
(* ----------------------- *)

(*val relEmpty : forall 'a 'b. SetType 'a, SetType 'b => rel 'a 'b*)

(* ----------------------- *)
(* Insertion               *)
(* ----------------------- *)

(*val relAdd : forall 'a 'b. SetType 'a, SetType 'b => 'a -> 'b -> rel 'a 'b -> rel 'a 'b*)


(* ----------------------- *)
(* Identity relation       *)
(* ----------------------- *)

(*val relIdOn : forall 'a. SetType 'a, Eq 'a => set 'a -> rel 'a 'a*)
definition relIdOn  :: " 'a set \<Rightarrow>('a*'a)set "  where 
     " relIdOn s = ( relFromPred s s (op=))"


(*val relId : forall 'a. SetType 'a, Eq 'a => rel 'a 'a*)
(*let ~{coq;ocaml} relId=  {(x, x) | forall x | true}*)

(* ----------------------- *)
(* relation union          *)
(* ----------------------- *)

(*val relUnion : forall 'a 'b. SetType 'a, SetType 'b => rel 'a 'b -> rel 'a 'b -> rel 'a 'b*) 

(* ----------------------- *)
(* relation intersection   *)
(* ----------------------- *)

(*val relIntersection : forall 'a 'b. SetType 'a, SetType 'b, Eq 'a, Eq 'b => rel 'a 'b -> rel 'a 'b -> rel 'a 'b*) 

(* ----------------------- *)
(* Relation Composition    *)
(* ----------------------- *)

(*val relComp : forall 'a 'b 'c. SetType 'a, SetType 'b, SetType 'c, Eq 'a, Eq 'b => rel 'a 'b -> rel 'b 'c -> rel 'a 'c*)
(*let relComp r1 r2=  relFromSet {(e1, e3) | forall ((e1,e2) IN (relToSet r1)) ((e2',e3) IN (relToSet r2)) | e2 = e2'}*)

(* ----------------------- *)
(* restrict                *)
(* ----------------------- *)

(*val relRestrict : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> set 'a -> rel 'a 'a*)
definition relRestrict  :: "('a*'a)set \<Rightarrow> 'a set \<Rightarrow>('a*'a)set "  where 
     " relRestrict r s = ( (
  set_filter (\<lambda> (a,b) .  ((a, b) \<in> r)) (s \<times> s)))"



(* ----------------------- *)
(* Converse                *)
(* ----------------------- *)

(*val relConverse : forall 'a 'b. SetType 'a, SetType 'b => rel 'a 'b -> rel 'b 'a*)
(*let relConverse r=  relFromSet (Set.map swap (relToSet r))*)


(* ----------------------- *)
(* domain                  *)
(* ----------------------- *)

(*val relDomain : forall 'a 'b. SetType 'a, SetType 'b => rel 'a 'b -> set 'a*)
(*let relDomain r=  Set.map (fun x -> fst x) (relToSet r)*)

(* ----------------------- *)
(* range                   *)
(* ----------------------- *)

(*val relRange : forall 'a 'b. SetType 'a, SetType 'b => rel 'a 'b -> set 'b*)
(*let relRange r=  Set.map (fun x -> snd x) (relToSet r)*)


(* ----------------------- *)
(* field / definedOn       *)
(*                         *)
(* avoid the keyword field *)
(* ----------------------- *)

(*val relDefinedOn : forall 'a. SetType 'a => rel 'a 'a -> set 'a*)

(* ----------------------- *)
(* relOver                 *)
(*                         *)
(* avoid the keyword field *)
(* ----------------------- *)

(*val relOver : forall 'a. SetType 'a => rel 'a 'a -> set 'a -> bool*)
definition relOver  :: "('a*'a)set \<Rightarrow> 'a set \<Rightarrow> bool "  where 
     " relOver r s = ( ((((Domain r) \<union> (Range r))) \<subseteq> s))"



(* ----------------------- *)
(* apply a relation        *)
(* ----------------------- *)

(* Given a relation r and a set s, relApply r s applies s to r, i.e.
   it returns the set of all value reachable via r from a value in s.
   This operation can be seen as a generalisation of function application. *)
   
(*val relApply : forall 'a 'b. SetType 'a, SetType 'b, Eq 'a => rel 'a 'b -> set 'a -> set 'b*)
(*let relApply r s=  { y | forall ((x, y) IN (relToSet r)) | x IN s }*)


(* ========================================================================== *)
(* Properties                                                                 *)
(* ========================================================================== *)

(* ----------------------- *)
(* subrel                  *)
(* ----------------------- *)

(*val isSubrel : forall 'a 'b. SetType 'a, SetType 'b, Eq 'a, Eq 'b => rel 'a 'b -> rel 'a 'b -> bool*)

(* ----------------------- *)
(* reflexivity             *)
(* ----------------------- *)

(*val isReflexiveOn : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> set 'a -> bool*)
definition isReflexiveOn  :: "('a*'a)set \<Rightarrow> 'a set \<Rightarrow> bool "  where 
     " isReflexiveOn r s = ( ((\<forall> e \<in> s.  (e, e) \<in> r)))"


(*val isReflexive : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> bool*)
(*let ~{ocaml;coq} isReflexive r=  (forall e. inRel e e r)*)


(* ----------------------- *)
(* irreflexivity           *)
(* ----------------------- *)

(*val isIrreflexiveOn : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> set 'a -> bool*)
definition isIrreflexiveOn  :: "('a*'a)set \<Rightarrow> 'a set \<Rightarrow> bool "  where 
     " isIrreflexiveOn r s = ( ((\<forall> e \<in> s.  \<not> ((e, e) \<in> r))))"


(*val isIrreflexive : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> bool*)
(*let isIrreflexive r=  (forall ((e1, e2) IN (relToSet r)). not (e1 = e2))*)


(* ----------------------- *)
(* symmetry                *)
(* ----------------------- *)

(*val isSymmetricOn : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> set 'a -> bool*)
definition isSymmetricOn  :: "('a*'a)set \<Rightarrow> 'a set \<Rightarrow> bool "  where 
     " isSymmetricOn r s = ( ((\<forall> e1 \<in> s. \<forall> e2 \<in> s.  ((e1, e2) \<in> r) \<longrightarrow> ((e2, e1) \<in> r))))"


(*val isSymmetric : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> bool*)
(*let isSymmetric r=  (forall ((e1, e2) IN relToSet r). inRel e2 e1 r)*)


(* ----------------------- *)
(* antisymmetry            *)
(* ----------------------- *)

(*val isAntisymmetricOn : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> set 'a -> bool*)
definition isAntisymmetricOn  :: "('a*'a)set \<Rightarrow> 'a set \<Rightarrow> bool "  where 
     " isAntisymmetricOn r s = ( ((\<forall> e1 \<in> s. \<forall> e2 \<in> s.  ((e1, e2) \<in> r) \<longrightarrow> (((e2, e1) \<in> r) \<longrightarrow> (e1 = e2)))))"


(*val isAntisymmetric : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> bool*)
(*let isAntisymmetric r=  (forall ((e1, e2) IN relToSet r). (inRel e2 e1 r) --> (e1 = e2))*)


(* ----------------------- *)
(* transitivity            *)
(* ----------------------- *)

(*val isTransitiveOn : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> set 'a -> bool*)
definition isTransitiveOn  :: "('a*'a)set \<Rightarrow> 'a set \<Rightarrow> bool "  where 
     " isTransitiveOn r s = ( ((\<forall> e1 \<in> s. \<forall> e2 \<in> s. \<forall> e3 \<in> s.  ((e1, e2) \<in> r) \<longrightarrow> (((e2, e3) \<in> r) \<longrightarrow> ((e1, e3) \<in> r)))))"


(*val isTransitive : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> bool*)
(*let isTransitive r=  (forall ((e1, e2) IN relToSet r) (e3 IN relApply r {e2}). inRel e1 e3 r)*)

(* ----------------------- *)
(* total                   *)
(* ----------------------- *)

(*val isTotalOn : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> set 'a -> bool*)
definition isTotalOn  :: "('a*'a)set \<Rightarrow> 'a set \<Rightarrow> bool "  where 
     " isTotalOn r s = ( ((\<forall> e1 \<in> s. \<forall> e2 \<in> s.  ((e1, e2) \<in> r) \<or> ((e2, e1) \<in> r))))"



(*val isTotal : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> bool*)
(*let ~{ocaml;coq} isTotal r=  (forall e1 e2. (inRel e1 e2 r) || (inRel e2 e1 r))*)

(*val isTrichotomousOn : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> set 'a -> bool*)
definition isTrichotomousOn  :: "('a*'a)set \<Rightarrow> 'a set \<Rightarrow> bool "  where 
     " isTrichotomousOn r s = ( ((\<forall> e1 \<in> s. \<forall> e2 \<in> s.  ((e1, e2) \<in> r) \<or> ((e1 = e2) \<or> ((e2, e1) \<in> r)))))"


(*val isTrichotomous : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> bool*)
definition isTrichotomous  :: "('a*'a)set \<Rightarrow> bool "  where 
     " isTrichotomous r = ( ((\<forall> e1. \<forall> e2.  ((e1, e2) \<in> r) \<or> ((e1 = e2) \<or> ((e2, e1) \<in> r)))))"



(* ----------------------- *)
(* is_single_valued        *)
(* ----------------------- *)

(*val isSingleValued : forall 'a 'b. SetType 'a, SetType 'b, Eq 'a, Eq 'b => rel 'a 'b -> bool*)
definition isSingleValued  :: "('a*'b)set \<Rightarrow> bool "  where 
     " isSingleValued r = ( ((\<forall> (e1, e2a) \<in> r. \<forall> e2b \<in> Image r {e1}.  e2a = e2b)))"



(* ----------------------- *)
(* equivalence relation    *)
(* ----------------------- *)

(*val isEquivalenceOn : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> set 'a -> bool*)
definition isEquivalenceOn  :: "('a*'a)set \<Rightarrow> 'a set \<Rightarrow> bool "  where 
     " isEquivalenceOn r s = ( isReflexiveOn r s \<and> (isSymmetricOn r s \<and> isTransitiveOn r s))"



(*val isEquivalence : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> bool*)
definition isEquivalence  :: "('a*'a)set \<Rightarrow> bool "  where 
     " isEquivalence r = ( refl r \<and> (sym r \<and> trans r))"



(* ----------------------- *)
(* well founded            *)
(* ----------------------- *)

(*val isWellFounded : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> bool*)
definition isWellFounded  :: "('a*'a)set \<Rightarrow> bool "  where 
     " isWellFounded r = ( ((\<forall> P.  ((\<forall> x.  ((\<forall> y.  ((y, x) \<in> r) \<longrightarrow> P x)) \<longrightarrow> P x)) \<longrightarrow> ((\<forall> x.  P x)))))"



(* ========================================================================== *)
(* Orders                                                                     *)
(* ========================================================================== *)


(* ----------------------- *)
(* pre- or quasiorders     *)
(* ----------------------- *)

(*val isPreorderOn : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> set 'a -> bool*)
definition isPreorderOn  :: "('a*'a)set \<Rightarrow> 'a set \<Rightarrow> bool "  where 
     " isPreorderOn r s = ( isReflexiveOn r s \<and> isTransitiveOn r s )"


(*val isPreorder : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> bool*)
definition isPreorder  :: "('a*'a)set \<Rightarrow> bool "  where 
     " isPreorder r = ( refl r \<and> trans r )"



(* ----------------------- *)
(* partial orders          *)
(* ----------------------- *)

(*val isPartialOrderOn : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> set 'a -> bool*)
definition isPartialOrderOn  :: "('a*'a)set \<Rightarrow> 'a set \<Rightarrow> bool "  where 
     " isPartialOrderOn r s = ( isReflexiveOn r s \<and> (isTransitiveOn r s \<and> isAntisymmetricOn r s))"



(*val isStrictPartialOrderOn : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> set 'a -> bool*)
definition isStrictPartialOrderOn  :: "('a*'a)set \<Rightarrow> 'a set \<Rightarrow> bool "  where 
     " isStrictPartialOrderOn r s = ( isIrreflexiveOn r s \<and> isTransitiveOn r s )"



(*val isStrictPartialOrder : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> bool*)
definition isStrictPartialOrder  :: "('a*'a)set \<Rightarrow> bool "  where 
     " isStrictPartialOrder r = ( irrefl r \<and> trans r )"


(*val isPartialOrder : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> bool*)
definition isPartialOrder  :: "('a*'a)set \<Rightarrow> bool "  where 
     " isPartialOrder r = ( refl r \<and> (trans r \<and> antisym r))"


(* ----------------------- *)
(* total / linear orders   *)
(* ----------------------- *)

(*val isTotalOrderOn : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> set 'a -> bool*)
definition isTotalOrderOn  :: "('a*'a)set \<Rightarrow> 'a set \<Rightarrow> bool "  where 
     " isTotalOrderOn r s = ( isPartialOrderOn r s \<and> isTotalOn r s )"


(*val isStrictTotalOrderOn : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> set 'a -> bool*)
definition isStrictTotalOrderOn  :: "('a*'a)set \<Rightarrow> 'a set \<Rightarrow> bool "  where 
     " isStrictTotalOrderOn r s = ( isStrictPartialOrderOn r s \<and> isTrichotomousOn r s )"


(*val isTotalOrder : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> bool*)
definition isTotalOrder  :: "('a*'a)set \<Rightarrow> bool "  where 
     " isTotalOrder r = ( isPartialOrder r \<and> total r )"


(*val isStrictTotalOrder : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> bool*)
definition isStrictTotalOrder  :: "('a*'a)set \<Rightarrow> bool "  where 
     " isStrictTotalOrder r = ( isStrictPartialOrder r \<and> isTrichotomous r )"




(* ========================================================================== *)
(* closures                                                                   *)
(* ========================================================================== *)

(* ----------------------- *)
(* transitive closure      *)
(* ----------------------- *)

(*val transitiveClosure : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> rel 'a 'a*)
(*val transitiveClosureByEq  : forall 'a. ('a -> 'a -> bool) -> rel 'a 'a -> rel 'a 'a*)
(*val transitiveClosureByCmp : forall 'a. ('a * 'a -> 'a * 'a -> ordering) -> rel 'a 'a -> rel 'a 'a*)


(* ----------------------- *)
(* transitive closure step *)
(* ----------------------- *)

(*val transitiveClosureAdd : forall 'a. SetType 'a, Eq 'a => 'a -> 'a -> rel 'a 'a -> rel 'a 'a*)

definition transitiveClosureAdd  :: " 'a \<Rightarrow> 'a \<Rightarrow>('a*'a)set \<Rightarrow>('a*'a)set "  where 
     " transitiveClosureAdd x y r = ( 
  (((((Set.insert (x,y) (r)))) \<union> (((((
  Set.image (\<lambda> z . (x, z))
    (set_filter (\<lambda> z .  ((y, z) \<in> r)) (Range r)))) \<union> ((Set.image (\<lambda> z . (z, y))
  (set_filter (\<lambda> z .  ((z, x) \<in> r)) (Domain r))))))))))"



(* ========================================================================== *)
(* reflexive closure                                                          *)
(* ========================================================================== *)

(*val reflexiveTransitiveClosureOn : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> set 'a -> rel 'a 'a*)
definition reflexiveTransitiveClosureOn  :: "('a*'a)set \<Rightarrow> 'a set \<Rightarrow>('a*'a)set "  where 
     " reflexiveTransitiveClosureOn r s = ( trancl (((r) \<union> ((relIdOn s)))))"



(*val reflexiveTransitiveClosure : forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> rel 'a 'a*)
definition reflexiveTransitiveClosure  :: "('a*'a)set \<Rightarrow>('a*'a)set "  where 
     " reflexiveTransitiveClosure r = ( trancl (((r) \<union> (Id))))"





(* ========================================================================== *)
(* inverse of closures                                                        *)
(* ========================================================================== *)

(* ----------------------- *)
(* without transitve edges *)
(* ----------------------- *)

(*val withoutTransitiveEdges: forall 'a. SetType 'a, Eq 'a => rel 'a 'a -> rel 'a 'a*)
definition withoutTransitiveEdges  :: "('a*'a)set \<Rightarrow>('a*'a)set "  where 
     " withoutTransitiveEdges r = (
  (let tc = (trancl r) in 
  set_filter
    (\<lambda> (a, c) .  ((\<forall> b \<in> Range r.
                            ((a \<noteq> b) \<and> (b \<noteq> c))
                              \<longrightarrow>
                              \<not>
                                (((a, b) \<in> tc) \<and> ((b, c) \<in> tc)))))
    r))"

end
