(*Generated by Lem from abis/aarch64/abi_aarch64_section_header_table.lem.*)
open HolKernel Parse boolLib bossLib;
open lem_numTheory lem_basic_classesTheory;

val _ = numLib.prefer_num();



val _ = new_theory "abi_aarch64_section_header_table"

(** [abi_aarch64_section_header_table], AARCH64 ABI specific definitions related
  * to the section header table.
  *)

(*open import Basic_classes*)
(*open import Num*)

(** AARCH64 specific section types *)

(** Contains build attributes.  What these are is not specified, and compilers
  * are free to insert their own proprietary information in this section.  See
  * Section 4.3.
  *)
val _ = Define `
 (sht_aarch64_attributes : num=  ((( 939524097:num) *( 2:num)) +( 1:num)))`;
 (* 0x70000003 *)

(** [string_of_aarch64_section_type m] produces a string based representation of
  * AARCH64 section type [m].
  *)
(*val string_of_aarch64_section_type : natural -> string*)
val _ = export_theory()
