(*Generated by Lem from multimap.lem.*)
open HolKernel Parse boolLib bossLib;
open lem_numTheory lem_listTheory lem_setTheory lem_functionTheory lem_basic_classesTheory lem_boolTheory lem_maybeTheory lem_stringTheory lem_assert_extraTheory showTheory lem_set_extraTheory missing_pervasivesTheory;

val _ = numLib.prefer_num();



val _ = new_theory "multimap"

(*open import Bool*) 
(*open import Basic_classes*) 
(*open import Maybe*) 
(*open import Function*) 
(*open import Num*) 
(*open import List*)
(*open import Set*)
(*open import Set_extra*)
(*open import Assert_extra*)
(*open import Missing_pervasives*)
(*open import String*)
(*open import Show*)

(* HMM. Is the right thing instead to implement multiset first? Probably. *)

(* This is a set of pairs
 * augmented with operations implementing a particular kind of 
 * map.
 * 
 * This map differs from the Lem map in the following ways.
 * 
 * 0. The basic idea: it's a multimap, so a single key, supplied as a "query",
 *    can map to many (key, value) results.
 *    But PROBLEM: how do we store them in a tree? We're using OCaml's
 *    Set implementation underneath, and that doesn't allow duplicates.
 * 
 * 1. ANSWER: require keys still be unique, but that the user supplies an 
 *    equivalence relation on them, which
 *    is coarser-grained than the ordering relation
 *    used to order the set. It must be consistent with it, though: 
 *    equivalent keys should appear as a contiguous range in the 
 *    ordering.
 * 
 * 2. This allows many "non-equal" keys, hence present independently
 *    in the set of pairs, to be "equivalent" for the purposes of a 
 *    query.
 * 
 * 3. The coarse-grained equivalence relation can be supplied on a 
 *    per-query basis, meaning that different queries on the same
 *    set can query by finer or coarser criteria (while respecting 
 *    the requirement to be consistent with the ordering).
 * 
 * Although this seems more complicated than writing a map from 
 * k to list (k, v), which would allow us to ditch the finer ordering, 
 * it scales better (no lists) and allows certain range queries which 
 * would be harder to implement under that approach. It also has the 
 * nice property that the inverse multimap is represented as the same
 * set but with the pairs reversed.
 *)

val _ = type_abbrev((* ( 'k, 'v) *) "multimap" , ``: ('k # 'v) set``);

(* In order for bisection search within a set to work, 
 * we need the equivalence class to tell us whether we're less than or
 * greater than the members of the key's class. 
 * It effectively identifies a set of ranges. *)
val _ = type_abbrev((*  'k *) "key_equiv" , ``: 'k -> 'k -> bool``);

(*
val hasMapping : forall 'k 'v. key_equiv 'k -> multimap 'k 'v -> bool
let inline hasMapping equiv m =
*)

(*
val mappingCount : forall 'k 'v. key_equiv 'k -> multimap 'k 'v -> natural
val any : forall 'k 'v. ('k -> 'v -> bool) -> multimap 'k 'v -> bool 
val all : forall 'k 'v. ('k -> 'v -> bool) -> multimap 'k 'v -> bool 
*)
(*val findLowestKVWithKEquivTo : forall 'k 'v. 
    Ord 'k, Ord 'v, SetType 'k, SetType 'v =>
        'k 
        -> key_equiv 'k 
        -> multimap 'k 'v 
        -> maybe ('k * 'v) 
        -> maybe ('k * 'v)*)
 val findLowestKVWithKEquivTo_defn = Hol_defn "findLowestKVWithKEquivTo" `
 (findLowestKVWithKEquivTo dict_Basic_classes_Ord_k dict_Basic_classes_Ord_v k equiv subSet maybeBest=    
  ((case lem_set_extra$chooseAndSplit 
  (instance_Basic_classes_Ord_tup2_dict dict_Basic_classes_Ord_k
     dict_Basic_classes_Ord_v) subSet of
        NONE => (* empty subset *) maybeBest
      | SOME(lower, ((chosenK: 'k), (chosenV : 'v)), higher) =>
            (* is k equiv to chosen? *)
            if equiv k chosenK
            then
                (* is chosen less than our current best? *)
                let (bestK, bestV) = ((case maybeBest of
                    NONE => (chosenK, chosenV)
                    | SOME(currentBestK, currentBestV) => 
                        if pairLess 
  dict_Basic_classes_Ord_v dict_Basic_classes_Ord_k (chosenK, chosenV) (currentBestK, currentBestV)
                            then (chosenK, chosenV)
                            else (currentBestK, currentBestV)
                ))
                in
                (* recurse down lower subSet; best is whichever is lower *)
                findLowestKVWithKEquivTo 
  dict_Basic_classes_Ord_k dict_Basic_classes_Ord_v k equiv lower (SOME(bestK, bestV))
            else
                (* k is not equiv to chosen; do we need to look lower or higher? *)
                if  dict_Basic_classes_Ord_k.isLess_method k chosenK
                then
                    (* k is lower, so look lower for equivs-to-k *)
                    findLowestKVWithKEquivTo 
  dict_Basic_classes_Ord_k dict_Basic_classes_Ord_v k equiv lower maybeBest
                else
                    (* k is higher *)
                    findLowestKVWithKEquivTo 
  dict_Basic_classes_Ord_k dict_Basic_classes_Ord_v k equiv higher maybeBest
    )))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn findLowestKVWithKEquivTo_defn;

(*val testEquiv : natural -> natural -> bool*)
val _ = Define `
 (testEquiv x y=  (if ((x >=( 3:num)) /\ (x <( 5:num)) /\ (y >=( 3:num)) /\ (y <=( 5:num))) then T
     else if ((x <( 3:num)) /\ (y <( 3:num))) then T
     else if ((x >( 5:num)) /\ (y >( 5:num))) then T
     else F))`;


(* Note we can't just use findLowestEquiv with inverted relations, because 
 * chooseAndSplit returns us (lower, chosen, higher) and we need to swap
 * around how we consume that. *)
(*val findHighestKVWithKEquivTo : forall 'k 'v. 
    Ord 'k, Ord 'v, SetType 'k, SetType 'v =>
        'k 
        -> key_equiv 'k 
        -> multimap 'k 'v 
        -> maybe ('k * 'v) 
        -> maybe ('k * 'v)*)
 val findHighestKVWithKEquivTo_defn = Hol_defn "findHighestKVWithKEquivTo" `
 (findHighestKVWithKEquivTo dict_Basic_classes_Ord_k dict_Basic_classes_Ord_v k equiv subSet maybeBest=    
  ((case lem_set_extra$chooseAndSplit 
  (instance_Basic_classes_Ord_tup2_dict dict_Basic_classes_Ord_k
     dict_Basic_classes_Ord_v) subSet of
        NONE => (* empty subset *) maybeBest
      | SOME(lower, ((chosenK: 'k), (chosenV : 'v)), higher) =>
            (* is k equiv to chosen? *)
            if equiv k chosenK
            then
                (* is chosen greater than our current best? *)
                let (bestK, bestV) = ((case maybeBest of
                    NONE => (chosenK, chosenV)
                    | SOME(currentBestK, currentBestV) => 
                        if pairGreater 
  dict_Basic_classes_Ord_k dict_Basic_classes_Ord_v (chosenK, chosenV) (currentBestK, currentBestV)
                            then (chosenK, chosenV)
                            else (currentBestK, currentBestV)
                ))
                in
                (* recurse down higher-than-chosen subSet; best is whichever is higher *)
                findHighestKVWithKEquivTo 
  dict_Basic_classes_Ord_k dict_Basic_classes_Ord_v k equiv higher (SOME(bestK, bestV))
            else
                (* k is not equiv to chosen; do we need to look lower or higher? 
                 * NOTE: the pairs in the set must be lexicographically ordered! *)
                if  dict_Basic_classes_Ord_k.isGreater_method k chosenK
                then
                    (* k is higher than chosen, so look higher for equivs-to-k *)
                    findHighestKVWithKEquivTo 
  dict_Basic_classes_Ord_k dict_Basic_classes_Ord_v k equiv higher maybeBest
                else
                    (* k is lower than chosen, so look lower *)
                    findHighestKVWithKEquivTo 
  dict_Basic_classes_Ord_k dict_Basic_classes_Ord_v k equiv lower maybeBest
    )))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn findHighestKVWithKEquivTo_defn;

(* get the list of all pairs with key equiv to k. *)
(*val lookupBy : forall 'k 'v. 
    Ord 'k, Ord 'v, SetType 'k, SetType 'v =>
        key_equiv 'k -> 'k -> multimap 'k 'v -> list ('k * 'v)*)
val _ = Define `
 (lookupBy0 dict_Basic_classes_Ord_k dict_Basic_classes_Ord_v equiv k m=    
(  
    (* Find the lowest and highest elements equiv to k. 
     * We do this using chooseAndSplit recursively. *)(case findLowestKVWithKEquivTo 
  dict_Basic_classes_Ord_k dict_Basic_classes_Ord_v k equiv m NONE of
        NONE => []
        | SOME lowestEquiv => 
            let (highestEquiv : ('k # 'v)) =                
( 
                (* We can't just invert the relation on the set, because
                 * the whole set is ordered *)(case findHighestKVWithKEquivTo 
  dict_Basic_classes_Ord_k dict_Basic_classes_Ord_v k equiv m NONE of
                    NONE => failwith "impossible: lowest equiv but no highest equiv"
                    | SOME highestEquiv => highestEquiv
                ))
        in
        (* FIXME: split is currently needlessly inefficient on OCaml! *)
        let (lowerThanLow, highEnough) = (lem_set$SET_SPLIT 
  (instance_Basic_classes_Ord_tup2_dict dict_Basic_classes_Ord_k
     dict_Basic_classes_Ord_v) lowestEquiv m)
        in 
        let (wanted, tooHigh) = (lem_set$SET_SPLIT 
  (instance_Basic_classes_Ord_tup2_dict dict_Basic_classes_Ord_k
     dict_Basic_classes_Ord_v) highestEquiv highEnough)
        in        
(
        (* NOTE that lowestEquiv is a single element; we want to include 
         * *all those equiv to it*, which may be non-equal. FIXME: use splitMember,
         * although that needs fixing in Lem (plus an optimised OCaml version). *)(SET_TO_LIST  
  { s | s | (s IN m) /\
              (EQ =
                 (pairCompare dict_Basic_classes_Ord_k.compare_method
                    dict_Basic_classes_Ord_v.compare_method s lowestEquiv))}) ++ (SET_TO_LIST wanted)) ++ (
            (* don't include the lowest and highest twice, if they're the same *)
            if pairLess 
  dict_Basic_classes_Ord_v dict_Basic_classes_Ord_k lowestEquiv highestEquiv then (SET_TO_LIST  
  { s | s | (s IN m) /\
              (EQ =
                 (pairCompare dict_Basic_classes_Ord_k.compare_method
                    dict_Basic_classes_Ord_v.compare_method s highestEquiv))}) else []
        )
    )))`;



(* To delete all pairs with key equiv to k, can use deleteBy *)

val _ = export_theory()
