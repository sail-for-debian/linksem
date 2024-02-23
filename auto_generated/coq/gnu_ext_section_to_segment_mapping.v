(* Generated by Lem from gnu_extensions/gnu_ext_section_to_segment_mapping.lem. *)

Require Import Arith.
Require Import Bool.
Require Import List.
Require Import String.
Require Import Program.Wf.

Require Import coqharness.

Open Scope nat_scope.
Open Scope string_scope.

(** [gnu_ext_section_to_segment_mapping] contains (GNU specific) functionality
  * relating to calculating the section to segment mapping for an ELF file.  In
  * particular, the test over whether a section is inside a segment is ABI
  * specific.  This module provides that test.
  *)

Require Import lem_basic_classes.
Require Export lem_basic_classes.

Require Import lem_bool.
Require Export lem_bool.

Require Import lem_num.
Require Export lem_num.


Require Import elf_header.
Require Export elf_header.

Require Import elf_program_header_table.
Require Export elf_program_header_table.

Require Import elf_section_header_table.
Require Export elf_section_header_table.

Require Import elf_types_native_uint.
Require Export elf_types_native_uint.


Require Import lem_string.
Require Export lem_string.

Require Import show.
Require Export show.


Require Import gnu_ext_program_header_table.
Require Export gnu_ext_program_header_table.

(* [?]: removed value specification. *)

Definition elf32_section_flags0  (sec_hdr : elf32_section_header_table_entry ) (typ : nat )  : bool :=  negb (elf32_word_equal (elf32_word_land(elf32_sh_flags sec_hdr) (elf32_word_of_nat typ)) (elf32_word_of_nat( 0))).
(* [?]: removed value specification. *)

Definition elf64_section_flags0  (sec_hdr : elf64_section_header_table_entry ) (typ : nat )  : bool :=  negb (elf64_xword_equal (elf64_xword_land(elf64_sh_flags sec_hdr) (elf64_xword_of_nat typ)) (elf64_xword_of_nat( 0))).
(* [?]: removed value specification. *)

Definition elf32_section_of_type  (sec_hdr : elf32_section_header_table_entry ) (typ : nat )  : bool :=  elf32_word_equal(elf32_sh_type
  sec_hdr) (elf32_word_of_nat typ).
(* [?]: removed value specification. *)

Definition elf64_section_of_type  (sec_hdr : elf64_section_header_table_entry ) (typ : nat )  : bool :=  elf64_word_equal(elf64_sh_type
  sec_hdr) (elf64_word_of_nat typ).
(* [?]: removed value specification. *)

Definition elf32_segment_of_type  (segment : elf32_program_header_table_entry ) (typ : nat )  : bool :=  elf32_word_equal(elf32_p_type
  segment) (elf32_word_of_nat typ).
(* [?]: removed value specification. *)

Definition elf64_segment_of_type  (segment : elf64_program_header_table_entry ) (typ : nat )  : bool :=  elf64_word_equal(elf64_p_type
  segment) (elf64_word_of_nat typ).
(* [?]: removed value specification. *)

Definition elf32_section_in_segment1  (sec_hdr : elf32_section_header_table_entry ) (segment : elf32_program_header_table_entry )  : bool := 
  (elf32_section_flags0 sec_hdr shf_tls &&
  (elf32_segment_of_type segment elf_pt_tls ||    
(elf32_segment_of_type segment elf_pt_gnu_relro ||
    elf32_segment_of_type segment elf_pt_load))) ||
  (negb (elf32_section_flags0 sec_hdr shf_tls)
  && (negb (elf32_segment_of_type segment elf_pt_tls)
  && negb (elf32_segment_of_type segment elf_pt_phdr))).
(* [?]: removed value specification. *)

Definition elf64_section_in_segment1  (sec_hdr : elf64_section_header_table_entry ) (segment : elf64_program_header_table_entry )  : bool := 
  (elf64_section_flags0 sec_hdr shf_tls &&
  (elf64_segment_of_type segment elf_pt_tls ||    
(elf64_segment_of_type segment elf_pt_gnu_relro ||
    elf64_segment_of_type segment elf_pt_load))) ||
  (negb (elf64_section_flags0 sec_hdr shf_tls)
  && (negb (elf64_segment_of_type segment elf_pt_tls)
  && negb (elf64_segment_of_type segment elf_pt_phdr))).
(* [?]: removed value specification. *)

Definition elf32_section_in_segment2  (sec_hdr : elf32_section_header_table_entry ) (segment : elf32_program_header_table_entry )  : bool := 
  negb ((negb (elf32_section_flags0 sec_hdr shf_alloc)) &&
       (elf32_segment_of_type segment elf_pt_load ||        
(elf32_segment_of_type segment elf_pt_dynamic ||        
(elf32_segment_of_type segment elf_pt_gnu_eh_frame ||        
(elf32_segment_of_type segment elf_pt_gnu_relro ||
        elf32_segment_of_type segment elf_pt_gnu_stack))))).
(* [?]: removed value specification. *)

Definition elf64_section_in_segment2  (sec_hdr : elf64_section_header_table_entry ) (segment : elf64_program_header_table_entry )  : bool := 
  negb ((negb (elf64_section_flags0 sec_hdr shf_alloc)) &&
       (elf64_segment_of_type segment elf_pt_load ||        
(elf64_segment_of_type segment elf_pt_dynamic ||        
(elf64_segment_of_type segment elf_pt_gnu_eh_frame ||        
(elf64_segment_of_type segment elf_pt_gnu_relro ||
        elf64_segment_of_type segment elf_pt_gnu_stack))))).
(* [?]: removed value specification. *)

Definition elf32_sect_size  (hdr : elf32_header ) (sec_hdr : elf32_section_header_table_entry ) (segment : elf32_program_header_table_entry )  : nat := 
  if is_elf32_tbss_special sec_hdr segment then 0
  else
    nat_of_elf32_half ((elf32_shentsizehdr)).
(* [?]: removed value specification. *)

Definition elf64_sect_size  (hdr : elf64_header ) (sec_hdr : elf64_section_header_table_entry ) (segment : elf64_program_header_table_entry )  : nat := 
  if is_elf64_tbss_special sec_hdr segment then 0
  else
    nat_of_elf64_half ((elf64_shentsizehdr)).
(* [?]: removed value specification. *)

Definition elf32_section_in_segment3  (hdr : elf32_header ) (sec_hdr : elf32_section_header_table_entry ) (segment : elf32_program_header_table_entry )  : bool := 
  let sec_off := (Zpred (Zpos (P_of_succ_nat (nat_of_elf32_off(elf32_sh_offset  sec_hdr))))) in
  let seg_off := (Zpred (Zpos (P_of_succ_nat (nat_of_elf32_off(elf32_p_offset  segment))))) in
  let seg_fsz := (Zpred (Zpos (P_of_succ_nat (nat_of_elf32_word(elf32_p_filesz segment))))) in
  let sec_siz := (Zpred (Zpos (P_of_succ_nat (elf32_sect_size hdr sec_hdr segment)))) in
    elf32_section_of_type sec_hdr sht_nobits ||
    ( int_gteb sec_off seg_off &&    
(( int_lteb( Coq.ZArith.BinInt.Zminus sec_off seg_off) ( Coq.ZArith.BinInt.Zminus seg_fsz((Zpred (Zpos (P_of_succ_nat 1)))))) &&
    ( int_lteb (Coq.ZArith.BinInt.Zminus sec_off ( Coq.ZArith.BinInt.Zplus seg_off sec_siz)) seg_fsz))).
(* [?]: removed value specification. *)

Definition elf64_section_in_segment3  (hdr : elf64_header ) (sec_hdr : elf64_section_header_table_entry ) (segment : elf64_program_header_table_entry )  : bool := 
  let sec_off := (Zpred (Zpos (P_of_succ_nat (nat_of_elf64_off(elf64_sh_offset   sec_hdr))))) in
  let seg_off := (Zpred (Zpos (P_of_succ_nat (nat_of_elf64_off(elf64_p_offset   segment))))) in
  let seg_fsz := (Zpred (Zpos (P_of_succ_nat (nat_of_elf64_xword(elf64_p_filesz segment))))) in
  let sec_siz := (Zpred (Zpos (P_of_succ_nat (elf64_sect_size hdr sec_hdr segment)))) in
    elf64_section_of_type sec_hdr sht_nobits ||
    ( int_gteb sec_off seg_off &&    
(( int_lteb( Coq.ZArith.BinInt.Zminus sec_off seg_off) ( Coq.ZArith.BinInt.Zminus seg_fsz((Zpred (Zpos (P_of_succ_nat 1)))))) &&
    ( int_lteb (Coq.ZArith.BinInt.Zminus sec_off ( Coq.ZArith.BinInt.Zplus seg_off sec_siz)) seg_fsz))).
(* [?]: removed value specification. *)

Definition elf32_section_in_segment4  (hdr : elf32_header ) (sec_hdr : elf32_section_header_table_entry ) (segment : elf32_program_header_table_entry )  : bool := 
  let sec_addr := (Zpred (Zpos (P_of_succ_nat (nat_of_elf32_addr(elf32_sh_addr sec_hdr))))) in
  let seg_vadr := (Zpred (Zpos (P_of_succ_nat (nat_of_elf32_addr(elf32_p_vaddr segment))))) in
  let seg_mmsz := (Zpred (Zpos (P_of_succ_nat (nat_of_elf32_word(elf32_p_memsz segment))))) in
  let sec_size := (Zpred (Zpos (P_of_succ_nat (elf32_sect_size hdr sec_hdr segment)))) in
    (negb (elf32_section_flags0 sec_hdr shf_alloc) || int_gteb
     sec_addr seg_vadr) && (int_lteb (Coq.ZArith.BinInt.Zminus
     sec_addr seg_vadr) (Coq.ZArith.BinInt.Zminus seg_mmsz((Zpred (Zpos (P_of_succ_nat 1))))) && int_lteb (Coq.ZArith.BinInt.Zminus
     sec_addr ( Coq.ZArith.BinInt.Zplus seg_vadr sec_size)) seg_mmsz).
(* [?]: removed value specification. *)

Definition elf64_section_in_segment4  (hdr : elf64_header ) (sec_hdr : elf64_section_header_table_entry ) (segment : elf64_program_header_table_entry )  : bool := 
  let sec_addr := (Zpred (Zpos (P_of_succ_nat (nat_of_elf64_addr(elf64_sh_addr  sec_hdr))))) in
  let seg_vadr := (Zpred (Zpos (P_of_succ_nat (nat_of_elf64_addr(elf64_p_vaddr  segment))))) in
  let seg_mmsz := (Zpred (Zpos (P_of_succ_nat (nat_of_elf64_xword(elf64_p_memsz segment))))) in
  let sec_size := (Zpred (Zpos (P_of_succ_nat (elf64_sect_size hdr sec_hdr segment)))) in
     (negb (elf64_section_flags0 sec_hdr shf_alloc) || int_gteb
     sec_addr seg_vadr) && (int_lteb (Coq.ZArith.BinInt.Zminus
     sec_addr seg_vadr) (Coq.ZArith.BinInt.Zminus seg_mmsz((Zpred (Zpos (P_of_succ_nat 1))))) && int_lteb (Coq.ZArith.BinInt.Zminus
     sec_addr ( Coq.ZArith.BinInt.Zplus seg_vadr sec_size)) seg_mmsz).
(* [?]: removed value specification. *)

Definition elf32_section_in_segment5  (sec_hdr : elf32_section_header_table_entry ) (segment : elf32_program_header_table_entry )  : bool := 
  let sec_siz := (Zpred (Zpos (P_of_succ_nat (nat_of_elf32_word(elf32_sh_size sec_hdr))))) in
  let seg_msz := (Zpred (Zpos (P_of_succ_nat (nat_of_elf32_word(elf32_p_memsz segment))))) in
  let sec_off := (Zpred (Zpos (P_of_succ_nat (nat_of_elf32_off(elf32_sh_offset  sec_hdr))))) in
  let seg_off := (Zpred (Zpos (P_of_succ_nat (nat_of_elf32_off(elf32_p_offset  segment))))) in
  let seg_fsz := (Zpred (Zpos (P_of_succ_nat (nat_of_elf32_word(elf32_p_filesz segment))))) in
  let sec_adr := (Zpred (Zpos (P_of_succ_nat (nat_of_elf32_addr(elf32_sh_addr sec_hdr))))) in
  let seg_vad := (Zpred (Zpos (P_of_succ_nat (nat_of_elf32_addr(elf32_p_vaddr segment))))) in
    (negb (elf32_segment_of_type segment elf_pt_dynamic)) || (negb (Z.eqb sec_siz((Zpred (Zpos (P_of_succ_nat 0))))) || (Z.eqb
    seg_msz((Zpred (Zpos (P_of_succ_nat 0)))) ||
    ((elf32_section_of_type sec_hdr sht_nobits ||
      ( int_gtb sec_off seg_off && int_ltb (Coq.ZArith.BinInt.Zminus
       sec_off seg_off) seg_fsz)) &&
       (negb (elf32_section_flags0 sec_hdr shf_alloc) ||
        ( int_gtb sec_adr seg_vad && int_ltb (Coq.ZArith.BinInt.Zminus
         sec_adr seg_vad) seg_msz))))).
(* [?]: removed value specification. *)

Definition elf64_section_in_segment5  (sec_hdr : elf64_section_header_table_entry ) (segment : elf64_program_header_table_entry )  : bool := 
  let sec_siz := (Zpred (Zpos (P_of_succ_nat (nat_of_elf64_xword(elf64_sh_size sec_hdr))))) in
  let seg_msz := (Zpred (Zpos (P_of_succ_nat (nat_of_elf64_xword(elf64_p_memsz segment))))) in
  let sec_off := (Zpred (Zpos (P_of_succ_nat (nat_of_elf64_off(elf64_sh_offset   sec_hdr))))) in
  let seg_off := (Zpred (Zpos (P_of_succ_nat (nat_of_elf64_off(elf64_p_offset   segment))))) in
  let seg_fsz := (Zpred (Zpos (P_of_succ_nat (nat_of_elf64_xword(elf64_p_filesz segment))))) in
  let sec_adr := (Zpred (Zpos (P_of_succ_nat (nat_of_elf64_addr(elf64_sh_addr  sec_hdr))))) in
  let seg_vad := (Zpred (Zpos (P_of_succ_nat (nat_of_elf64_addr(elf64_p_vaddr  segment))))) in
    (negb (elf64_segment_of_type segment elf_pt_dynamic)) || (negb (Z.eqb sec_siz((Zpred (Zpos (P_of_succ_nat 0))))) || (Z.eqb
    seg_msz((Zpred (Zpos (P_of_succ_nat 0)))) ||
    ((elf64_section_of_type sec_hdr sht_nobits ||
      ( int_gtb sec_off seg_off && int_ltb (Coq.ZArith.BinInt.Zminus
       sec_off seg_off) seg_fsz)) &&
       (negb (elf64_section_flags0 sec_hdr shf_alloc) ||
        ( int_gtb sec_adr seg_vad && int_ltb (Coq.ZArith.BinInt.Zminus
         sec_adr seg_vad) seg_msz))))).
(* [?]: removed value specification. *)

Definition elf32_section_in_segment  (hdr : elf32_header ) (sec_hdr : elf32_section_header_table_entry ) (segment : elf32_program_header_table_entry )  : bool := 
  elf32_section_in_segment1 sec_hdr segment &&  
(elf32_section_in_segment2 sec_hdr segment &&  
(elf32_section_in_segment3 hdr sec_hdr segment &&  
(elf32_section_in_segment4 hdr sec_hdr segment &&
  elf32_section_in_segment5 sec_hdr segment))).
(* [?]: removed value specification. *)

Definition elf64_section_in_segment  (hdr : elf64_header ) (sec_hdr : elf64_section_header_table_entry ) (segment : elf64_program_header_table_entry )  : bool := 
  elf64_section_in_segment1 sec_hdr segment &&  
(elf64_section_in_segment2 sec_hdr segment &&  
(elf64_section_in_segment3 hdr sec_hdr segment &&  
(elf64_section_in_segment4 hdr sec_hdr segment &&
  elf64_section_in_segment5 sec_hdr segment))).
