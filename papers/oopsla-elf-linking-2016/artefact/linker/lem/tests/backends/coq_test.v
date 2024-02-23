(* Generated by Lem from coq_test.lem. *)

Require Import Arith.
Require Import Bool.
Require Import List.
Require Import String.
Require Import Program.Wf.

Open Scope nat_scope.
Open Scope string_scope.

 Require Import Pervasives_non_pure.


Definition a : Type := num.
Definition a_default: a := num_default .
Definition b {a: Type} : Type := (a *a) % type.
Definition b_default{a: Type} : b := (DAEMON, a_default) (a:=a).
Definition c  {a: Type} {b: Type} : Type := (a *b) % type.
Definition c_default {a: Type} {b: Type} : c := (DAEMON, DAEMON) (a:=a) (b:=b).

Definition d  :=  (1 :  a).
Definition e  :=  ((1,  2) :  b).
Definition f  :=  ((1,  false) :  c).

Record g : Type := { field_one: num; field_two:  bool }.
Notation "{[ r 'with' 'field_one' := e ]}" := ({| field_one := e; field_two := field_two r |}).
Notation "{[ r 'with' 'field_two' := e ]}" := ({| field_two := e; field_one := field_one r |}).
Definition g_default: g := {| field_one := num_default; field_two := bool_default |} .
Record h {a: Type} : Type := { field_three: a; field_four:  bool }.
Notation "{[ r 'with' 'field_three' := e ]}" := ({| field_three := e; field_four := field_four r |}).
Notation "{[ r 'with' 'field_four' := e ]}" := ({| field_four := e; field_three := field_three r |}).
Definition h_default{a: Type} : h := {| field_three := DAEMON; field_four := bool_default |} (a:=a).
Record i  {a: Type} {b: Type} : Type := { field_five: a; field_six: b }.
Notation "{[ r 'with' 'field_five' := e ]}" := ({| field_five := e; field_six := field_six r |}).
Notation "{[ r 'with' 'field_six' := e ]}" := ({| field_six := e; field_five := field_five r |}).
Definition i_default {a: Type} {b: Type} : i := {| field_five := DAEMON; field_six := DAEMON |} (a:=a) (b:=b).
Record j : Type := { field_seven:  g }.

Definition j_default: j := {| field_seven := g_default |} .

Definition k  :=  ({| field_one := 1; field_two := true |} :  g).
Definition l  :=  ({| field_three := (1,  true); field_four := false |} :  h).
Definition m  :=  ({| field_seven := {| field_one := 1; field_two := true |} |}).

Definition n {a : Type}  : i (a -> a) (h (num )) :=  ({| field_five := (fun (x0 : a) => x0); field_six :=
           {| field_three := 1; field_four := true |} |} :   i).

Inductive o : Type :=  A: a -> o.
Definition o_default: o := A a_default .

Inductive p : Type :=
   B: a -> p
  | C:  (b num) -> p
  | D: g -> p.
Definition p_default: p := B a_default .

Inductive q : Type :=
   E: num -> q
  | F: i g  (h a) -> q
  | G: r -> q
with r : Type :=
   H: q -> r.
Definition q_default: q := E num_default .
Definition r_default: r := H q_default .

Definition s  :=  (B 1 :  p).
Definition t  :=  (G (H (E 1)) :  q).

Inductive bool0 : Type := 
  True: bool0
| False: bool0.
Definition bool_default: bool := True  .

Inductive mynat : Type := 
  Zero: mynat
| Succ: mynat -> mynat.
Definition mynat_default: mynat := Zero  .

Inductive heap {a : Type} : Type := 
  Nil: heap
| Node: mynat -> heap a -> a -> heap a -> heap.
Definition heap_default{a: Type} : heap := Nil  (a:=a).

Inductive u {a : Type} : Type :=  I: a -> u.
Definition u_default{a: Type} : u := I DAEMON (a:=a).

Inductive v {a : Type} {b : Type} {c : Type} : Type :=
   J: a -> v
  | K: b -> v
  | L:  (w c) -> v
with w {a : Type} : Type := 
  | M:  (a ->a) -> v num num num -> w.
Definition v_default {a: Type} {b: Type} {c: Type} : v := J DAEMON (a:=a) (b:=b) (c:=c).
Definition w_default{a: Type} : w := M (fun (x0 : a) => DAEMON) v_default (a:=a).

Inductive x {a : Type} : Type := 
  | N: y a -> x
with y {a : Type} : Type := 
  | O: x a -> y.
Definition x_default{a: Type} : x := N y_default (a:=a).
Definition y_default{a: Type} : y := O x_default (a:=a).