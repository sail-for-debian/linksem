(*Generated by Lem from elf_interpreted_segment.lem.*)
open HolKernel Parse boolLib bossLib;
open lem_numTheory lem_basic_classesTheory lem_boolTheory lem_stringTheory showTheory missing_pervasivesTheory byte_sequenceTheory elf_types_native_uintTheory elf_program_header_tableTheory hex_printingTheory;

val _ = numLib.prefer_num();



val _ = new_theory "elf_interpreted_segment"

(** [elf_interpreted_segment] defines interpreted segments, i.e. the contents of
  * a program header table entry converted to more amenable types, and operations
  * built on top of them.
  *)

(*open import Basic_classes*)
(*open import Bool*)
(*open import Num*)
(*open import String*)

(*open import Elf_types_native_uint*)
(*open import Elf_program_header_table*)

(*open import Byte_sequence*)
(*open import Missing_pervasives*)
(*open import Show*)

(*open import Hex_printing*)

(** [elf32_interpreted_segment] represents an ELF32 interpreted segment, i.e. the
  * contents of an ELF program header table entry converted into more amenable
  * (infinite precision) types, for manipulation.
  * Invariant: the nth entry of the program header table corresponds to the nth
  * entry of the list of interpreted segments in an [elf32_file] record.  The
  * lengths of the two lists are exactly the same.
  *)
val _ = Hol_datatype `
 elf32_interpreted_segment =
  <| elf32_segment_body  : byte_sequence        (** Body of the segment *)
   ; elf32_segment_type  : num              (** Type of the segment *)
   ; elf32_segment_size  : num              (** Size of the segment in bytes *)
   ; elf32_segment_memsz : num              (** Size of the segment in memory in bytes *)
   ; elf32_segment_base  : num              (** Base address of the segment *)
   ; elf32_segment_paddr : num              (** Physical address of segment *)
   ; elf32_segment_align : num              (** Alignment of the segment *)
   ; elf32_segment_offset : num             (** Offset of the segment *)
   ; elf32_segment_flags : (bool # bool # bool) (** READ, WRITE, EXECUTE flags. *)
   |>`;


(** [elf64_interpreted_segment] represents an ELF64 interpreted segment, i.e. the
  * contents of an ELF program header table entry converted into more amenable
  * (infinite precision) types, for manipulation.
  * Invariant: the nth entry of the program header table corresponds to the nth
  * entry of the list of interpreted segments in an [elf64_file] record.  The
  * lengths of the two lists are exactly the same.
  *)
val _ = Hol_datatype `
 elf64_interpreted_segment =
  <| elf64_segment_body  : byte_sequence        (** Body of the segment *)
   ; elf64_segment_type  : num              (** Type of the segment *)
   ; elf64_segment_size  : num              (** Size of the segment in bytes *)
   ; elf64_segment_memsz : num              (** Size of the segment in memory in bytes *)
   ; elf64_segment_base  : num              (** Base address of the segment *)
   ; elf64_segment_paddr : num              (** Physical address of segment *)
   ; elf64_segment_align : num              (** Alignment of the segment *)
   ; elf64_segment_offset : num             (** Offset of the segment *)
   ; elf64_segment_flags : (bool # bool # bool) (** READ, WRITE, EXECUTE flags. *)
   |>`;

   
(** [compare_elf64_interpreted_segment seg1 seg2] is an ordering comparison function
  * on interpreted segments suitable for constructing sets, finite maps and other
  * ordered data types out of.
  *)
(*val compare_elf64_interpreted_segment : elf64_interpreted_segment ->
  elf64_interpreted_segment -> ordering*)
val _ = Define `
 (compare_elf64_interpreted_segment s1 s2=   
 (tripleCompare compare_byte_sequence (lem_list$lexicographic_compare (genericCompare (<) (=))) (lem_list$lexicographic_compare (genericCompare (<) (=))) 
    (s1.elf64_segment_body,
    [s1.elf64_segment_type  ;
     s1.elf64_segment_size  ;
     s1.elf64_segment_memsz ;
     s1.elf64_segment_base  ;
     s1.elf64_segment_paddr ;
     s1.elf64_segment_align ;
     s1.elf64_segment_offset],     
 (let (f1, f2, f3) = (s1.elf64_segment_flags) in
       MAP natural_of_bool [f1; f2; f3]))
    (s2.elf64_segment_body,
    [s2.elf64_segment_type  ;
     s2.elf64_segment_size  ;
     s2.elf64_segment_memsz ;
     s2.elf64_segment_base  ;
     s2.elf64_segment_paddr ;
     s2.elf64_segment_align ;
     s2.elf64_segment_offset],     
(let (f1, f2, f3) = (s2.elf64_segment_flags) in
       MAP natural_of_bool [f1; f2; f3]))))`;


val _ = Define `
(instance_Basic_classes_Ord_Elf_interpreted_segment_elf64_interpreted_segment_dict= (<|

  compare_method := compare_elf64_interpreted_segment;

  isLess_method := (\ f1 .  (\ f2 .  (compare_elf64_interpreted_segment f1 f2 = LT)));

  isLessEqual_method := (\ f1 .  (\ f2 .  let result = (compare_elf64_interpreted_segment f1 f2) in (result = LT) \/ (result = EQ)));

  isGreater_method := (\ f1 .  (\ f2 .  (compare_elf64_interpreted_segment f1 f2 = GT)));

  isGreaterEqual_method := (\ f1 .  (\ f2 .  let result = (compare_elf64_interpreted_segment f1 f2) in (result = GT) \/ (result = EQ)))|>))`;


val _ = type_abbrev( "elf32_interpreted_segments" , ``: elf32_interpreted_segment list``);
val _ = type_abbrev( "elf64_interpreted_segments" , ``: elf64_interpreted_segment list``);

(** [elf32_interpreted_program_header_flags w] extracts a boolean triple of flags
  * from the flags field of an interpreted segment.
  *)
(*val elf32_interpret_program_header_flags : elf32_word -> (bool * bool * bool)*)
val _ = Define `
 (elf32_interpret_program_header_flags flags=  
 (let zero = ((n2w : num -> uint32) (( 0:num))) in
  let one1  = ((n2w : num -> uint32) (( 1:num))) in
  let two  = ((n2w : num -> uint32) (( 2:num))) in
  let four = ((n2w : num -> uint32) (( 4:num))) in
    (~ (word_and flags one1 = zero),
      ~ (word_and flags two = zero),
      ~ (word_and flags four = zero))))`;


(** [elf64_interpreted_program_header_flags w] extracts a boolean triple of flags
  * from the flags field of an interpreted segment.
  *)
(*val elf64_interpret_program_header_flags : elf64_word -> (bool * bool * bool)*)
val _ = Define `
 (elf64_interpret_program_header_flags flags=  
 (let zero = ((n2w : num -> uint32) (( 0:num))) in
  let one1  = ((n2w : num -> uint32) (( 1:num))) in
  let two  = ((n2w : num -> uint32) (( 2:num))) in
  let four = ((n2w : num -> uint32) (( 4:num))) in
    (~ (word_and flags one1 = zero),
      ~ (word_and flags two = zero),
      ~ (word_and flags four = zero))))`;


(** [string_of_flags bs] produces a string-based representation of an interpreted
  * segments flags (represented as a boolean triple).
  *)
(*val string_of_flags : (bool * bool * bool) -> string*)

(** [string_of_elf32_interpreted_segment seg] produces a string-based representation
  * of interpreted segment [seg].
  *)
(*val string_of_elf32_interpreted_segment : elf32_interpreted_segment -> string*)

(** [string_of_elf64_interpreted_segment seg] produces a string-based representation
  * of interpreted segment [seg].
  *)
(*val string_of_elf64_interpreted_segment : elf64_interpreted_segment -> string*)
val _ = export_theory()

