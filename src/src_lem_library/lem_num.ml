(*Generated by Lem from num.lem.*)


open Lem_bool
open Lem_basic_classes 

(*class inline ( Numeral 'a ) 
  val fromNumeral : numeral -> 'a 
end*)

(* ========================================================================== *)
(* Syntactic type-classes for common operations                               *)
(* ========================================================================== *)

(* Typeclasses can be used as a mean to overload constants like "+", "-", etc *)

type 'a numNegate_class= { 
  numNegate_method : 'a -> 'a 
}

type 'a numAbs_class= { 
  abs_method : 'a -> 'a 
}

type 'a numAdd_class= { 
  numAdd_method : 'a -> 'a -> 'a
}

type 'a numMinus_class= { 
  numMinus_method : 'a -> 'a -> 'a
}

type 'a numMult_class= { 
  numMult_method : 'a -> 'a -> 'a
}

type 'a numPow_class= { 
  numPow_method : 'a -> int -> 'a
}

type 'a numDivision_class= { 
  numDivision_method : 'a -> 'a -> 'a
}

type 'a numIntegerDivision_class= { 
  div_method : 'a -> 'a -> 'a
}


type 'a numRemainder_class= { 
  mod_method : 'a -> 'a -> 'a
}

type 'a numSucc_class= { 
  succ_method : 'a -> 'a
}

type 'a numPred_class= { 
  pred_method : 'a -> 'a
} 


(* ----------------------- *)
(* natural                 *)
(* ----------------------- *)

(* unbounded size natural numbers *)
(*type natural*)


(* ----------------------- *)
(* int                     *)
(* ----------------------- *)

(* bounded size integers with uncertain length *)

(*type int*)


(* ----------------------- *)
(* integer                 *)
(* ----------------------- *)

(* unbounded size integers *)

(*type integer*)

(* ----------------------- *)
(* bint                    *)
(* ----------------------- *)

(* TODO the bounded ints are only partially implemented, use with care. *)

(* 32 bit integers *)
(*type int32*) 

(* 64 bit integers *)
(*type int64*) 


(* ----------------------- *)
(* rational                *)
(* ----------------------- *)

(* unbounded size and precision rational numbers *)

(*type rational*) (* ???: better type for this in HOL? *)


(* ----------------------- *)
(* double                  *)
(* ----------------------- *)

(* double precision floating point (64 bits) *)

(*type float64*) (* ???: better type for this in HOL? *)

(*type float32*) (* ???: better type for this in HOL? *)


(* ========================================================================== *)
(* Binding the standard operations for the number types                       *)
(* ========================================================================== *)


(* ----------------------- *)
(* nat                     *)
(* ----------------------- *)

(*val natFromNumeral : numeral -> nat*)

(*val natEq : nat -> nat -> bool*)
let instance_Basic_classes_Eq_nat_dict =({

  isEqual_method = (=);

  isInequal_method = (fun n1 n2->not (n1 = n2))})

(*val natLess : nat -> nat -> bool*)
(*val natLessEqual : nat -> nat -> bool*)
(*val natGreater : nat -> nat -> bool*)
(*val natGreaterEqual : nat -> nat -> bool*)

(*val natCompare : nat -> nat -> ordering*)

let instance_Basic_classes_Ord_nat_dict =({

  compare_method = compare;

  isLess_method = (<);

  isLessEqual_method = (<=);

  isGreater_method = (>);

  isGreaterEqual_method = (>=)})

let instance_Basic_classes_SetType_nat_dict =({

  setElemCompare_method = compare})

(*val natAdd : nat -> nat -> nat*)

let instance_Num_NumAdd_nat_dict =({

  numAdd_method = (+)})

(*val natMinus : nat -> nat -> nat*)

let instance_Num_NumMinus_nat_dict =({

  numMinus_method = Nat_num.nat_monus})

(*val natSucc : nat -> nat*)
(*let natSucc n = (Instance_Num_NumAdd_nat.+) n 1*)
let instance_Num_NumSucc_nat_dict =({

  succ_method = succ})

(*val natPred : nat -> nat*)
let instance_Num_NumPred_nat_dict =({

  pred_method = Nat_num.nat_pred})

(*val natMult : nat -> nat -> nat*)

let instance_Num_NumMult_nat_dict =({

  numMult_method = ( * )})

(*val natDiv : nat -> nat -> nat*)

let instance_Num_NumIntegerDivision_nat_dict =({

  div_method = (/)})

let instance_Num_NumDivision_nat_dict =({

  numDivision_method = (/)})

(*val natMod : nat -> nat -> nat*)

let instance_Num_NumRemainder_nat_dict =({

  mod_method = (mod)})


(*val gen_pow_aux : forall 'a. ('a -> 'a -> 'a) -> 'a -> 'a -> nat -> 'a*)
let rec gen_pow_aux (mul : 'a -> 'a -> 'a) (a : 'a) (b : 'a) (e : int) = 
  ( (* cannot happen, call discipline guarentees e >= 1 *) if(e =  0) then 
    a else
      (
      if(e =  1) then (mul a b) else
        (let e'' = (e /  2) in
         let a' = (if (e mod  2) =  0 then a else mul a b) in
         gen_pow_aux mul a' (mul b b) e'')))
       
let gen_pow (one : 'a) (mul : 'a -> 'a -> 'a) (b : 'a) (e : int) : 'a =  
 (if e < 0 then one else 
  if (e = 0) then one else gen_pow_aux mul one b e)

(*val natPow : nat -> nat -> nat*)
let natPow = (gen_pow( 1) ( * ))

let instance_Num_NumPow_nat_dict =({

  numPow_method = natPow})

(*val natMin : nat -> nat -> nat*)

(*val natMax : nat -> nat -> nat*)

let instance_Basic_classes_OrdMaxMin_nat_dict =({

  max_method = max;

  min_method = min})


(* ----------------------- *)
(* natural                 *)
(* ----------------------- *)

(*val naturalFromNumeral : numeral -> natural*)

(*val naturalEq : natural -> natural -> bool*)
let instance_Basic_classes_Eq_Num_natural_dict =({

  isEqual_method = Big_int.eq_big_int;

  isInequal_method = (fun n1 n2->not (Big_int.eq_big_int n1 n2))})

(*val naturalLess : natural -> natural -> bool*)
(*val naturalLessEqual : natural -> natural -> bool*)
(*val naturalGreater : natural -> natural -> bool*)
(*val naturalGreaterEqual : natural -> natural -> bool*)

(*val naturalCompare : natural -> natural -> ordering*)

let instance_Basic_classes_Ord_Num_natural_dict =({

  compare_method = Big_int.compare_big_int;

  isLess_method = Big_int.lt_big_int;

  isLessEqual_method = Big_int.le_big_int;

  isGreater_method = Big_int.gt_big_int;

  isGreaterEqual_method = Big_int.ge_big_int})

let instance_Basic_classes_SetType_Num_natural_dict =({

  setElemCompare_method = Big_int.compare_big_int})

(*val naturalAdd : natural -> natural -> natural*)

let instance_Num_NumAdd_Num_natural_dict =({

  numAdd_method = Big_int.add_big_int})

(*val naturalMinus : natural -> natural -> natural*)

let instance_Num_NumMinus_Num_natural_dict =({

  numMinus_method = Nat_num.natural_monus})

(*val naturalSucc : natural -> natural*)
(*let naturalSucc n = (Instance_Num_NumAdd_Num_natural.+) n 1*)
let instance_Num_NumSucc_Num_natural_dict =({

  succ_method = Big_int.succ_big_int})

(*val naturalPred : natural -> natural*)
let instance_Num_NumPred_Num_natural_dict =({

  pred_method = Nat_num.natural_pred})

(*val naturalMult : natural -> natural -> natural*)

let instance_Num_NumMult_Num_natural_dict =({

  numMult_method = Big_int.mult_big_int})


(*val naturalPow : natural -> nat -> natural*)

let instance_Num_NumPow_Num_natural_dict =({

  numPow_method = Big_int.power_big_int_positive_int})

(*val naturalDiv : natural -> natural -> natural*)

let instance_Num_NumIntegerDivision_Num_natural_dict =({

  div_method = Big_int.div_big_int})

let instance_Num_NumDivision_Num_natural_dict =({

  numDivision_method = Big_int.div_big_int})

(*val naturalMod : natural -> natural -> natural*)

let instance_Num_NumRemainder_Num_natural_dict =({

  mod_method = Big_int.mod_big_int})

(*val naturalMin : natural -> natural -> natural*)

(*val naturalMax : natural -> natural -> natural*)

let instance_Basic_classes_OrdMaxMin_Num_natural_dict =({

  max_method = Big_int.max_big_int;

  min_method = Big_int.min_big_int})


(* ----------------------- *)
(* int                     *)
(* ----------------------- *)

(*val intFromNumeral : numeral -> int*)

(*val intEq : int -> int -> bool*)
let instance_Basic_classes_Eq_Num_int_dict =({

  isEqual_method = (=);

  isInequal_method = (fun n1 n2->not (n1 = n2))})

(*val intLess : int -> int -> bool*)
(*val intLessEqual : int -> int -> bool*)
(*val intGreater : int -> int -> bool*)
(*val intGreaterEqual : int -> int -> bool*)

(*val intCompare : int -> int -> ordering*)

let instance_Basic_classes_Ord_Num_int_dict =({

  compare_method = compare;

  isLess_method = (<);

  isLessEqual_method = (<=);

  isGreater_method = (>);

  isGreaterEqual_method = (>=)})

let instance_Basic_classes_SetType_Num_int_dict =({

  setElemCompare_method = compare})

(*val intNegate : int -> int*)

let instance_Num_NumNegate_Num_int_dict =({

  numNegate_method = (fun i->(~- i))})

(*val intAbs : int -> int*) (* TODO: check *)

let instance_Num_NumAbs_Num_int_dict =({

  abs_method = abs})

(*val intAdd : int -> int -> int*)

let instance_Num_NumAdd_Num_int_dict =({

  numAdd_method = (+)})

(*val intMinus : int -> int -> int*)

let instance_Num_NumMinus_Num_int_dict =({

  numMinus_method = (-)})

(*val intSucc : int -> int*)
let instance_Num_NumSucc_Num_int_dict =({

  succ_method = succ})

(*val intPred : int -> int*)
let instance_Num_NumPred_Num_int_dict =({

  pred_method = pred})

(*val intMult : int -> int -> int*)

let instance_Num_NumMult_Num_int_dict =({

  numMult_method = ( * )})


(*val intPow : int -> nat -> int*)
let intPow = (gen_pow( 1) ( * ))

let instance_Num_NumPow_Num_int_dict =({

  numPow_method = intPow})

(*val intDiv : int -> int -> int*)

let instance_Num_NumIntegerDivision_Num_int_dict =({

  div_method = Nat_num.int_div})

let instance_Num_NumDivision_Num_int_dict =({

  numDivision_method = Nat_num.int_div})

(*val intMod : int -> int -> int*)

let instance_Num_NumRemainder_Num_int_dict =({

  mod_method = Nat_num.int_mod})

(*val intMin : int -> int -> int*)

(*val intMax : int -> int -> int*)

let instance_Basic_classes_OrdMaxMin_Num_int_dict =({

  max_method = max;

  min_method = min})

(* ----------------------- *)
(* int32                   *)
(* ----------------------- *)
(*val int32FromNumeral : numeral -> int32*)

(*val int32Eq : int32 -> int32 -> bool*)

let instance_Basic_classes_Eq_Num_int32_dict =({

  isEqual_method = (=);

  isInequal_method = (fun n1 n2->not (n1 = n2))})

(*val int32Less : int32 -> int32 -> bool*)
(*val int32LessEqual : int32 -> int32 -> bool*)
(*val int32Greater : int32 -> int32 -> bool*)
(*val int32GreaterEqual : int32 -> int32 -> bool*)

(*val int32Compare : int32 -> int32 -> ordering*)

let instance_Basic_classes_Ord_Num_int32_dict =({

  compare_method = Int32.compare;

  isLess_method = (<);

  isLessEqual_method = (<=);

  isGreater_method = (>);

  isGreaterEqual_method = (>=)})

let instance_Basic_classes_SetType_Num_int32_dict =({

  setElemCompare_method = Int32.compare})

(*val int32Negate : int32 -> int32*)

let instance_Num_NumNegate_Num_int32_dict =({

  numNegate_method = Int32.neg})

(*val int32Abs : int32 -> int32*)
(*let int32Abs i = (if (Instance_Basic_classes_Ord_Num_int32.<=) 0 i then i else Instance_Num_NumNegate_Num_int32.~ i)*)

let instance_Num_NumAbs_Num_int32_dict =({

  abs_method = Int32.abs})


(*val int32Add : int32 -> int32 -> int32*)

let instance_Num_NumAdd_Num_int32_dict =({

  numAdd_method = Int32.add})

(*val int32Minus : int32 -> int32 -> int32*)

let instance_Num_NumMinus_Num_int32_dict =({

  numMinus_method = Int32.sub})

(*val int32Succ : int32 -> int32*)

let instance_Num_NumSucc_Num_int32_dict =({

  succ_method = Int32.succ})

(*val int32Pred : int32 -> int32*)
let instance_Num_NumPred_Num_int32_dict =({

  pred_method = Int32.pred})

(*val int32Mult : int32 -> int32 -> int32*)

let instance_Num_NumMult_Num_int32_dict =({

  numMult_method = Int32.mul})


(*val int32Pow : int32 -> nat -> int32*)
let int32Pow = (gen_pow(Int32.of_int 1) Int32.mul)

let instance_Num_NumPow_Num_int32_dict =({

  numPow_method = int32Pow})

(*val int32Div : int32 -> int32 -> int32*)

let instance_Num_NumIntegerDivision_Num_int32_dict =({

  div_method = Nat_num.int32_div})

let instance_Num_NumDivision_Num_int32_dict =({

  numDivision_method = Nat_num.int32_div})

(*val int32Mod : int32 -> int32 -> int32*)

let instance_Num_NumRemainder_Num_int32_dict =({

  mod_method = Nat_num.int32_mod})

(*val int32Min : int32 -> int32 -> int32*)

(*val int32Max : int32 -> int32 -> int32*)

let instance_Basic_classes_OrdMaxMin_Num_int32_dict =({

  max_method = max;

  min_method = min})



(* ----------------------- *)
(* int64                   *)
(* ----------------------- *)
(*val int64FromNumeral : numeral -> int64*)

(*val int64Eq : int64 -> int64 -> bool*)

let instance_Basic_classes_Eq_Num_int64_dict =({

  isEqual_method = (=);

  isInequal_method = (fun n1 n2->not (n1 = n2))})

(*val int64Less : int64 -> int64 -> bool*)
(*val int64LessEqual : int64 -> int64 -> bool*)
(*val int64Greater : int64 -> int64 -> bool*)
(*val int64GreaterEqual : int64 -> int64 -> bool*)

(*val int64Compare : int64 -> int64 -> ordering*)

let instance_Basic_classes_Ord_Num_int64_dict =({

  compare_method = Int64.compare;

  isLess_method = (<);

  isLessEqual_method = (<=);

  isGreater_method = (>);

  isGreaterEqual_method = (>=)})

let instance_Basic_classes_SetType_Num_int64_dict =({

  setElemCompare_method = Int64.compare})

(*val int64Negate : int64 -> int64*)

let instance_Num_NumNegate_Num_int64_dict =({

  numNegate_method = Int64.neg})

(*val int64Abs : int64 -> int64*)
(*let int64Abs i = (if (Instance_Basic_classes_Ord_Num_int64.<=) 0 i then i else Instance_Num_NumNegate_Num_int64.~ i)*)

let instance_Num_NumAbs_Num_int64_dict =({

  abs_method = Int64.abs})


(*val int64Add : int64 -> int64 -> int64*)

let instance_Num_NumAdd_Num_int64_dict =({

  numAdd_method = Int64.add})

(*val int64Minus : int64 -> int64 -> int64*)

let instance_Num_NumMinus_Num_int64_dict =({

  numMinus_method = Int64.sub})

(*val int64Succ : int64 -> int64*)

let instance_Num_NumSucc_Num_int64_dict =({

  succ_method = Int64.succ})

(*val int64Pred : int64 -> int64*)
let instance_Num_NumPred_Num_int64_dict =({

  pred_method = Int64.pred})

(*val int64Mult : int64 -> int64 -> int64*)

let instance_Num_NumMult_Num_int64_dict =({

  numMult_method = Int64.mul})


(*val int64Pow : int64 -> nat -> int64*)
let int64Pow = (gen_pow(Int64.of_int 1) Int64.mul)

let instance_Num_NumPow_Num_int64_dict =({

  numPow_method = int64Pow})

(*val int64Div : int64 -> int64 -> int64*)

let instance_Num_NumIntegerDivision_Num_int64_dict =({

  div_method = Nat_num.int64_div})

let instance_Num_NumDivision_Num_int64_dict =({

  numDivision_method = Nat_num.int64_div})

(*val int64Mod : int64 -> int64 -> int64*)

let instance_Num_NumRemainder_Num_int64_dict =({

  mod_method = Nat_num.int64_mod})

(*val int64Min : int64 -> int64 -> int64*)

(*val int64Max : int64 -> int64 -> int64*)

let instance_Basic_classes_OrdMaxMin_Num_int64_dict =({

  max_method = max;

  min_method = min})


(* ----------------------- *)
(* integer                 *)
(* ----------------------- *)

(*val integerFromNumeral : numeral -> integer*)

(*val integerEq : integer -> integer -> bool*)
let instance_Basic_classes_Eq_Num_integer_dict =({

  isEqual_method = Big_int.eq_big_int;

  isInequal_method = (fun n1 n2->not (Big_int.eq_big_int n1 n2))})

(*val integerLess : integer -> integer -> bool*)
(*val integerLessEqual : integer -> integer -> bool*)
(*val integerGreater : integer -> integer -> bool*)
(*val integerGreaterEqual : integer -> integer -> bool*)

(*val integerCompare : integer -> integer -> ordering*)

let instance_Basic_classes_Ord_Num_integer_dict =({

  compare_method = Big_int.compare_big_int;

  isLess_method = Big_int.lt_big_int;

  isLessEqual_method = Big_int.le_big_int;

  isGreater_method = Big_int.gt_big_int;

  isGreaterEqual_method = Big_int.ge_big_int})

let instance_Basic_classes_SetType_Num_integer_dict =({

  setElemCompare_method = Big_int.compare_big_int})

(*val integerNegate : integer -> integer*)

let instance_Num_NumNegate_Num_integer_dict =({

  numNegate_method = Big_int.minus_big_int})

(*val integerAbs : integer -> integer*) (* TODO: check *)

let instance_Num_NumAbs_Num_integer_dict =({

  abs_method = Big_int.abs_big_int})

(*val integerAdd : integer -> integer -> integer*)

let instance_Num_NumAdd_Num_integer_dict =({

  numAdd_method = Big_int.add_big_int})

(*val integerMinus : integer -> integer -> integer*)

let instance_Num_NumMinus_Num_integer_dict =({

  numMinus_method = Big_int.sub_big_int})

(*val integerSucc : integer -> integer*)
let instance_Num_NumSucc_Num_integer_dict =({

  succ_method = Big_int.succ_big_int})

(*val integerPred : integer -> integer*)
let instance_Num_NumPred_Num_integer_dict =({

  pred_method = Big_int.pred_big_int})

(*val integerMult : integer -> integer -> integer*)

let instance_Num_NumMult_Num_integer_dict =({

  numMult_method = Big_int.mult_big_int})


(*val integerPow : integer -> nat -> integer*)

let instance_Num_NumPow_Num_integer_dict =({

  numPow_method = Big_int.power_big_int_positive_int})

(*val integerDiv : integer -> integer -> integer*)

let instance_Num_NumIntegerDivision_Num_integer_dict =({

  div_method = Big_int.div_big_int})

let instance_Num_NumDivision_Num_integer_dict =({

  numDivision_method = Big_int.div_big_int})

(*val integerMod : integer -> integer -> integer*)

let instance_Num_NumRemainder_Num_integer_dict =({

  mod_method = Big_int.mod_big_int})

(*val integerMin : integer -> integer -> integer*)

(*val integerMax : integer -> integer -> integer*)

let instance_Basic_classes_OrdMaxMin_Num_integer_dict =({

  max_method = Big_int.max_big_int;

  min_method = Big_int.min_big_int})



(* ========================================================================== *)
(* Translation between number types                                           *)
(* ========================================================================== *)

(******************)
(* integerFrom... *)
(******************)

(*val integerFromInt : int -> integer*)


(*val integerFromNat : nat -> integer*)

(*val integerFromNatural : natural -> integer*)


(*val integerFromInt32 : int32 -> integer*)


(*val integerFromInt64 : int64 -> integer*)


(******************)
(* naturalFrom... *)
(******************)

(*val naturalFromNat : nat -> natural*)

(*val naturalFromInteger : integer -> natural*)


(******************)
(* intFrom ...    *)
(******************)

(*val intFromInteger : integer -> int*)

(*val intFromNat : nat -> int*)


(******************)
(* natFrom ...    *)
(******************)

(*val natFromNatural : natural -> nat*)

(*val natFromInt : int -> nat*)


(******************)
(* int32From ...  *)
(******************)

(*val int32FromNat : nat -> int32*)

(*val int32FromNatural : natural -> int32*)

(*val int32FromInteger : integer -> int32*)
(*let int32FromInteger i = (
  let abs_int32 = int32FromNatural (naturalFromInteger i) in
  if ((Instance_Basic_classes_Ord_Num_integer.<) i 0) then (Instance_Num_NumNegate_Num_int32.~ abs_int32) else abs_int32 
)*)

(*val int32FromInt : int -> int32*)
(*let int32FromInt i = int32FromInteger (integerFromInt i)*)


(*val int32FromInt64 : int64 -> int32*)
(*let int32FromInt64 i = int32FromInteger (integerFromInt64 i)*)




(******************)
(* int64From ...  *)
(******************)

(*val int64FromNat : nat -> int64*)

(*val int64FromNatural : natural -> int64*)

(*val int64FromInteger : integer -> int64*)
(*let int64FromInteger i = (
  let abs_int64 = int64FromNatural (naturalFromInteger i) in
  if ((Instance_Basic_classes_Ord_Num_integer.<) i 0) then (Instance_Num_NumNegate_Num_int64.~ abs_int64) else abs_int64 
)*)

(*val int64FromInt : int -> int64*)
(*let int64FromInt i = int64FromInteger (integerFromInt i)*)


(*val int64FromInt32 : int32 -> int64*)
(*let int64FromInt32 i = int64FromInteger (integerFromInt32 i)*)


(******************)
(* what's missing *)
(******************)

(*val naturalFromInt : int -> natural*)
(*val naturalFromInt32 : int32 -> natural*)
(*val naturalFromInt64 : int64 -> natural*)


(*val intFromNatural : natural -> int*)
(*val intFromInt32 : int32 -> int*)
(*val intFromInt64 : int64 -> int*)

(*val natFromInteger : integer -> nat*)
(*val natFromInt32 : int32 -> nat*)
(*val natFromInt64 : int64 -> nat*)

(*val string_of_natural : natural -> string*)
