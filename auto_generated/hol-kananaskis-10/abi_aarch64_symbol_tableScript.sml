(*Generated by Lem from abis/aarch64/abi_aarch64_symbol_table.lem.*)
open HolKernel Parse boolLib bossLib;
open lem_basic_classesTheory lem_boolTheory elf_types_native_uintTheory elf_headerTheory elf_section_header_tableTheory elf_symbol_tableTheory;

val _ = numLib.prefer_num();



val _ = new_theory "abi_aarch64_symbol_table"

(** [abi_aarch64_symbol_table], symbol table specific defintions for the AARCH64
  * ABI.
  *)

(*open import Basic_classes*)
(*open import Bool*)

(*open import Elf_header*)
(*open import Elf_symbol_table*)
(*open import Elf_section_header_table*)
(*open import Elf_types_native_uint*)

(** Two types of weak symbol are defined in the AARCH64 ABI.  See Section 4.5.
  *)
(*val is_aarch64_weak_reference : elf64_symbol_table_entry -> bool*)
val _ = Define `
 (is_aarch64_weak_reference ent=
   ((w2n ent.elf64_st_shndx = shn_undef) /\    
(get_elf64_symbol_binding ent = stb_weak)))`;


(*val is_aarch64_weak_definition : elf64_symbol_table_entry -> bool*)
val _ = Define `
 (is_aarch64_weak_definition ent=  (~ ((w2n ent.elf64_st_shndx) = shn_undef) /\    
(get_elf64_symbol_binding ent = stb_weak)))`;

val _ = export_theory()
