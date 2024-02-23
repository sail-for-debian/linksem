chapter {* Generated by Lem from string_extra.lem. *}

theory "Lem_string_extra" 

imports 
 	 Main
	 "Lem_num" 
	 "Lem_list" 
	 "Lem_basic_classes" 
	 "Lem_string" 
	 "Lem_list_extra" 

begin 

(******************************************************************************)
(* String functions                                                           *)
(******************************************************************************)

(*open import Basic_classes*)
(*open import Num*)
(*open import List*)
(*open import String*)
(*open import List_extra*)
(*open import {hol} `stringLib`*)
(*open import {hol} `ASCIInumbersTheory`*)


(******************************************************************************)
(* Character's to numbers                                                     *)
(******************************************************************************)

(*val ord : char -> nat*)

(*val chr : nat -> char*)

(******************************************************************************)
(* Converting to strings                                                      *)
(******************************************************************************)

(*val stringFromNatHelper : nat -> list char -> list char*)
function (sequential,domintros)  stringFromNatHelper  :: " nat \<Rightarrow>(char)list \<Rightarrow>(char)list "  where 
     " stringFromNatHelper n acc1 = (
  if n =( 0 :: nat) then
    acc1
  else
    stringFromNatHelper (n div( 10 :: nat)) (char_of_nat ((n mod( 10 :: nat)) +( 48 :: nat)) # acc1))" 
by pat_completeness auto


(*val stringFromNat : nat -> string*)
definition stringFromNat  :: " nat \<Rightarrow> string "  where 
     " stringFromNat n = ( 
  if n =( 0 :: nat) then (''0'') else  (stringFromNatHelper n []))"


(*val stringFromNaturalHelper : natural -> list char -> list char*)
function (sequential,domintros)  stringFromNaturalHelper  :: " nat \<Rightarrow>(char)list \<Rightarrow>(char)list "  where 
     " stringFromNaturalHelper n acc1 = (
  if n =( 0 :: nat) then
    acc1
  else
    stringFromNaturalHelper (n div( 10 :: nat)) (char_of_nat ( ((n mod( 10 :: nat)) +( 48 :: nat))) # acc1))" 
by pat_completeness auto


(*val stringFromNatural : natural -> string*)
definition stringFromNatural  :: " nat \<Rightarrow> string "  where 
     " stringFromNatural n = ( 
  if n =( 0 :: nat) then (''0'') else  (stringFromNaturalHelper n []))"


(*val stringFromInt : int -> string*)
definition stringFromInt  :: " int \<Rightarrow> string "  where 
     " stringFromInt i = ( 
  if i <( 0 :: int) then 
    (''-'') @ stringFromNat (nat (abs i))
  else
    stringFromNat (nat (abs i)))"


(*val stringFromInteger : integer -> string*)
definition stringFromInteger  :: " int \<Rightarrow> string "  where 
     " stringFromInteger i = ( 
  if i <( 0 :: int) then 
    (''-'') @ stringFromNatural (nat (abs i))
  else
    stringFromNatural (nat (abs i)))"



(******************************************************************************)
(* List-like operations                                                       *)
(******************************************************************************)

(*val nth : string -> nat -> char*)
definition nth  :: " string \<Rightarrow> nat \<Rightarrow> char "  where 
     " nth s n = ( List.nth ( s) n )"


(*val stringConcat : list string -> string*)
definition stringConcat  :: "(string)list \<Rightarrow> string "  where 
     " stringConcat s = (
  List.foldr (op@) s (''''))"


(******************************************************************************)
(* String comparison                                                          *)
(******************************************************************************)

(*val stringCompare : string -> string -> ordering*)

definition stringCompare_method :: "string \<Rightarrow> string \<Rightarrow> ordering" where
  "stringCompare_method s1 s2 \<equiv>
     let lt = List.ord.lexordp_eq (\<lambda>x y. String.nat_of_char x < String.nat_of_char y) s1 s2;
         gt = List.ord.lexordp_eq (\<lambda>x y. String.nat_of_char x < String.nat_of_char y) s2 s1
     in if lt \<and> gt then EQ else if lt then LT else GT"

definition stringLess  :: " string \<Rightarrow> string \<Rightarrow> bool "  where 
     " stringLess x y \<equiv> stringCompare_method x y = LT"

definition stringLessEq  :: " string \<Rightarrow> string \<Rightarrow> bool "  where 
     " stringLessEq x y \<equiv> stringCompare_method x y = EQ \<or> stringCompare_method x y = LT"

definition stringGreater  :: " string \<Rightarrow> string \<Rightarrow> bool "  where 
     " stringGreater x y = ( stringLess y x )"

definition stringGreaterEq  :: " string \<Rightarrow> string \<Rightarrow> bool "  where 
     " stringGreaterEq x y = ( stringLessEq y x )"

definition instance_Basic_classes_Ord_string_dict  :: "(string)Ord_class "  where 
     " instance_Basic_classes_Ord_string_dict = ((|

  compare_method = stringCompare_method,

  isLess_method = stringLess,

  isLessEqual_method = stringLessEq,

  isGreater_method = stringGreater,

  isGreaterEqual_method = stringGreaterEq |) )"

 
end
