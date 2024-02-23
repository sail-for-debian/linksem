chapter {* Generated by Lem from elf_program_header_table.lem. *}

theory "Elf_program_header_table" 

imports 
 	 Main
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_num" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_list" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_set" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_function" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_basic_classes" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_bool" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_maybe" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_string" 
	 "Show" 
	 "Missing_pervasives" 
	 "Error" 
	 "Byte_sequence" 
	 "Endianness" 
	 "Elf_types_native_uint" 

begin 

(** [elf_program_header_table] contains type, functions and other definitions
  * for working with program header tables and their entries and ELF segments.
  * Related files are [elf_interpreted_segments] which extracts information
  * derived from PHTs presented in this file and converts it into a more usable
  * format for processing.
  *
  * FIXME:
  * Bug in Lem as Lem codebase uses [int] type throughout where [BigInt.t]
  * is really needed, hence chokes on huge constants below, which is why they are
  * written in the way that they are.
  *)

(*open import Basic_classes*)
(*open import Bool*)
(*open import Function*)
(*open import List*)
(*open import Maybe*)
(*open import Num*)
(*open import String*)
(*import Set*)

(*open import Elf_types_native_uint*)
(*open import Endianness*)

(*open import Byte_sequence*)
(*open import Error*)
(*open import Missing_pervasives*)
(*open import Show*)

(** Segment types *)

(** Unused array element.  All other members of the structure are undefined. *)
definition elf_pt_null  :: " nat "  where 
     " elf_pt_null = (( 0 :: nat))"

(** A loadable segment. *)
definition elf_pt_load  :: " nat "  where 
     " elf_pt_load = (( 1 :: nat))"

(** Dynamic linking information. *)
definition elf_pt_dynamic  :: " nat "  where 
     " elf_pt_dynamic = (( 2 :: nat))"

(** Specifies the location and size of a null-terminated path name to be used to
  * invoke an interpreter.
  *)
definition elf_pt_interp  :: " nat "  where 
     " elf_pt_interp = (( 3 :: nat))"

(** Specifies location and size of auxiliary information. *)
definition elf_pt_note  :: " nat "  where 
     " elf_pt_note = (( 4 :: nat))"

(** Reserved but with unspecified semantics.  If the file contains a segment of
  * this type then it is to be regarded as non-conformant with the ABI.
  *)
definition elf_pt_shlib  :: " nat "  where 
     " elf_pt_shlib = (( 5 :: nat))"

(** Specifies the location and size of the program header table. *)
definition elf_pt_phdr  :: " nat "  where 
     " elf_pt_phdr = (( 6 :: nat))"

(** Specifies the thread local storage (TLS) template.  Need not be supported. *)
definition elf_pt_tls  :: " nat "  where 
     " elf_pt_tls = (( 7 :: nat))"

(** Start of reserved indices for operating system specific semantics. *)
definition elf_pt_loos  :: " nat "  where 
     " elf_pt_loos = ((((( 128 :: nat) *( 128 :: nat)) *( 128 :: nat)) *( 256 :: nat)) *( 3 :: nat))"
 (* 1610612736 (* 0x60000000 *) *)
(** End of reserved indices for operating system specific semantics. *)
definition elf_pt_hios  :: " nat "  where 
     " elf_pt_hios = ( (( 469762047 :: nat) *( 4 :: nat)) +( 3 :: nat))"
 (* 1879048191 (* 0x6fffffff *) *)
(** Start of reserved indices for processor specific semantics. *)
definition elf_pt_loproc  :: " nat "  where 
     " elf_pt_loproc = ( (( 469762048 :: nat) *( 4 :: nat)))"
 (* 1879048192 (* 0x70000000 *) *)
(** End of reserved indices for processor specific semantics. *)
definition elf_pt_hiproc  :: " nat "  where 
     " elf_pt_hiproc = ( (( 536870911 :: nat) *( 4 :: nat)) +( 3 :: nat))"
 (* 2147483647 (* 0x7fffffff *) *)

(** [string_of_elf_segment_type os proc st] produces a string representation of
  * the coding of an ELF segment type [st] using [os] and [proc] to render OS-
  * and processor-specific codings.
  *)
(* XXX: is GNU stuff supposed to be hardcoded here? *)
(*val string_of_segment_type : (natural -> string) -> (natural -> string) -> natural -> string*)
definition string_of_segment_type  :: "(nat \<Rightarrow> string)\<Rightarrow>(nat \<Rightarrow> string)\<Rightarrow> nat \<Rightarrow> string "  where 
     " string_of_segment_type os proc pt = (
	if pt = elf_pt_null then
		(''NULL'')
	else if pt = elf_pt_load then
		(''LOAD'')
	else if pt = elf_pt_dynamic then
		(''DYNAMIC'')
	else if pt = elf_pt_interp then
		(''INTERP'')
	else if pt = elf_pt_note then
		(''NOTE'')
	else if pt = elf_pt_shlib then
		(''SHLIB'')
	else if pt = elf_pt_phdr then
		(''PHDR'')
	else if pt = elf_pt_tls then
		(''TLS'')
	else if (pt \<ge> elf_pt_loos) \<and> (pt \<le> elf_pt_hios) then
		os pt
	else if (pt \<ge> elf_pt_loproc) \<and> (pt \<le> elf_pt_hiproc) then
		proc pt
	else
		(''Undefined or invalid segment type''))"

		
(** Segments permission flags *)

(** Execute bit *)
definition elf_pf_x  :: " nat "  where 
     " elf_pf_x = (( 1 :: nat))"

(** Write bit *)
definition elf_pf_w  :: " nat "  where 
     " elf_pf_w = (( 2 :: nat))"

(** Read bit *)
definition elf_pf_r  :: " nat "  where 
     " elf_pf_r = (( 4 :: nat))"

(** The following two bit ranges are reserved for OS- and processor-specific
  * flags respectively.
  *)
definition elf_pf_maskos  :: " nat "  where 
     " elf_pf_maskos = (( 267386880 :: nat))"
      (* 0x0ff00000 *)
definition elf_pf_maskproc  :: " nat "  where 
     " elf_pf_maskproc = (( 4 :: nat) *( 1006632960 :: nat))"
 (* 0xf0000000 *)

(** [exact_permission_of_permission m]: ELF has two interpretations of a RWX-style
  * permission bit [m], an exact permission and an allowable permission.  These
  * permissions allow us to interpret a flag as an upper bound for behaviour and
  * an ABI-compliant implementation can choose to interpret the flag [m] as either.
  *
  * In the exact interpretation, the upper bound is exactly the natural interpretation
  * of the flag.  This is encoded in [exact_permission_of_permission], which is
  * a glorified identity function, though included for completeness.
  *)
(*val exact_permissions_of_permission : natural -> error natural*)
definition exact_permissions_of_permission  :: " nat \<Rightarrow>(nat)error "  where 
     " exact_permissions_of_permission m = (
  if m =( 0 :: nat) then
    error_return(( 0 :: nat))
  else if m = elf_pf_x then
    error_return(( 1 :: nat))
  else if m = elf_pf_w then
    error_return(( 2 :: nat))
  else if m = elf_pf_r then
    error_return(( 4 :: nat))
  else if m = (elf_pf_x + elf_pf_w) then
    error_return(( 3 :: nat))
  else if m = (elf_pf_x + elf_pf_r) then
    error_return(( 5 :: nat))
  else if m = (elf_pf_w + elf_pf_r) then
    error_return(( 6 :: nat))
  else if m = ((elf_pf_x + elf_pf_r) + elf_pf_w) then
    error_return(( 7 :: nat))
  else
    error_fail (''exact_permission_of_permission: invalid permission flag''))"


(** [allowable_permission_of_permission m]: ELF has two interpretations of a RWX-style
  * permission bit [m], an exact permission and an allowable permission.  These
  * permissions allow us to interpret a flag as an upper bound for behaviour and
  * an ABI-compliant implementation can choose to interpret the flag [m] as either.
  *
  * In the allowable interpretation, the upper bound is more lax than the natural
  * interpretation of the flag.
  *)
(*val allowable_permissions_of_permission : natural -> error natural*)
definition allowable_permissions_of_permission  :: " nat \<Rightarrow>(nat)error "  where 
     " allowable_permissions_of_permission m = (
  if m =( 0 :: nat) then
    error_return(( 0 :: nat))
  else if m = elf_pf_x then
    error_return(( 5 :: nat))
  else if m = elf_pf_w then
    error_return(( 7 :: nat))
  else if m = elf_pf_r then
    error_return(( 5 :: nat))
  else if m = (elf_pf_x + elf_pf_w) then
    error_return(( 7 :: nat))
  else if m = (elf_pf_x + elf_pf_r) then
    error_return(( 5 :: nat))
  else if m = (elf_pf_w + elf_pf_r) then
    error_return(( 7 :: nat))
  else if m = ((elf_pf_x + elf_pf_r) + elf_pf_w) then
    error_return(( 7 :: nat))
  else
    error_fail (''exact_permission_of_permission: invalid permission flag''))"

    
(** [string_of_elf_segment_permissions m] produces a string-based representation
  * of an ELF segment's permission field.
  * TODO: expand this as is needed by the validation tests.
  *)
(*val string_of_elf_segment_permissions : natural -> string*)
definition string_of_elf_segment_permissions  :: " nat \<Rightarrow> string "  where 
     " string_of_elf_segment_permissions m = (
  if m =( 0 :: nat) then
    (''  '')
  else if m = elf_pf_x then
    (''  E'')
  else if m = elf_pf_w then
    ('' W '')
  else if m = elf_pf_r then
    (''R  '')
  else if m = (elf_pf_x + elf_pf_w) then
    ('' WE'')
  else if m = (elf_pf_x + elf_pf_r) then
    (''R E'')
  else if m = (elf_pf_w + elf_pf_r) then
    (''RW '')
  else if m = ((elf_pf_x + elf_pf_r) + elf_pf_w) then
    (''RWE'')
  else
    (''Invalid permisssion flag''))"


(** Program header table entry type *)

(** Type [elf32_program_header_table_entry] encodes a program header table entry
  * for 32-bit platforms.  Each entry describes a segment in an executable or
  * shared object file.
  *)
record elf32_program_header_table_entry =
  
 elf32_p_type   ::" uint32 " (** Type of the segment *)
   
 elf32_p_offset ::" uint32 "  (** Offset from beginning of file for segment *)
   
 elf32_p_vaddr  ::" uint32 " (** Virtual address for segment in memory *)
   
 elf32_p_paddr  ::" uint32 " (** Physical address for segment *)
   
 elf32_p_filesz ::" uint32 " (** Size of segment in file, in bytes *)
   
 elf32_p_memsz  ::" uint32 " (** Size of segment in memory image, in bytes *)
   
 elf32_p_flags  ::" uint32 " (** Segment flags *)
   
 elf32_p_align  ::" uint32 " (** Segment alignment memory for memory and file *)
   


(** [compare_elf32_program_header_table_entry ent1 ent2] is an ordering-comparison
  * function on program header table entries suitable for constructing sets,
  * finite maps, and other ordered data types with.
  *)
(*val compare_elf32_program_header_table_entry : elf32_program_header_table_entry ->
  elf32_program_header_table_entry -> ordering*)
definition compare_elf32_program_header_table_entry  :: " elf32_program_header_table_entry \<Rightarrow> elf32_program_header_table_entry \<Rightarrow> ordering "  where 
     " compare_elf32_program_header_table_entry h1 h2 = (    
 (lexicographicCompareBy (genericCompare (op<) (op=)) [unat(elf32_p_type   h1),
    unat(elf32_p_offset   h1),
    unat(elf32_p_vaddr   h1),
    unat(elf32_p_paddr   h1),
    unat(elf32_p_filesz   h1),
    unat(elf32_p_memsz   h1), 
    unat(elf32_p_flags   h1),
    unat(elf32_p_align   h1)]
    [unat(elf32_p_type   h2),
    unat(elf32_p_offset   h2),
    unat(elf32_p_vaddr   h2),
    unat(elf32_p_paddr   h2),
    unat(elf32_p_filesz   h2),
    unat(elf32_p_memsz   h2), 
    unat(elf32_p_flags   h2),
    unat(elf32_p_align   h2)]))"


definition instance_Basic_classes_Ord_Elf_program_header_table_elf32_program_header_table_entry_dict  :: "(elf32_program_header_table_entry)Ord_class "  where 
     " instance_Basic_classes_Ord_Elf_program_header_table_elf32_program_header_table_entry_dict = ((|

  compare_method = compare_elf32_program_header_table_entry,

  isLess_method = (\<lambda> f1 .  (\<lambda> f2 .  (compare_elf32_program_header_table_entry f1 f2 = LT))),

  isLessEqual_method = (\<lambda> f1 .  (\<lambda> f2 .  (op \<in>) (compare_elf32_program_header_table_entry f1 f2) ({LT, EQ}))),

  isGreater_method = (\<lambda> f1 .  (\<lambda> f2 .  (compare_elf32_program_header_table_entry f1 f2 = GT))),

  isGreaterEqual_method = (\<lambda> f1 .  (\<lambda> f2 .  (op \<in>) (compare_elf32_program_header_table_entry f1 f2) ({GT, EQ})))|) )"


(** Type [elf64_program_header_table_entry] encodes a program header table entry
  * for 64-bit platforms.  Each entry describes a segment in an executable or
  * shared object file.
  *)
record elf64_program_header_table_entry =
  
 elf64_p_type   ::" uint32 "  (** Type of the segment *)
   
 elf64_p_flags  ::" uint32 "  (** Segment flags *)
   
 elf64_p_offset ::" uint64 "   (** Offset from beginning of file for segment *)
   
 elf64_p_vaddr  ::" Elf_Types_Local.uint64 "  (** Virtual address for segment in memory *)
   
 elf64_p_paddr  ::" Elf_Types_Local.uint64 "  (** Physical address for segment *)
   
 elf64_p_filesz ::" uint64 " (** Size of segment in file, in bytes *)
   
 elf64_p_memsz  ::" uint64 " (** Size of segment in memory image, in bytes *)
   
 elf64_p_align  ::" uint64 " (** Segment alignment memory for memory and file *)
   


(** [compare_elf64_program_header_table_entry ent1 ent2] is an ordering-comparison
  * function on program header table entries suitable for constructing sets,
  * finite maps, and other ordered data types with.
  *)
(*val compare_elf64_program_header_table_entry : elf64_program_header_table_entry ->
  elf64_program_header_table_entry -> ordering*)
definition compare_elf64_program_header_table_entry  :: " elf64_program_header_table_entry \<Rightarrow> elf64_program_header_table_entry \<Rightarrow> ordering "  where 
     " compare_elf64_program_header_table_entry h1 h2 = (    
 (lexicographicCompareBy (genericCompare (op<) (op=)) [unat(elf64_p_type   h1),
    unat(elf64_p_offset   h1),
    unat(elf64_p_vaddr   h1),
    unat(elf64_p_paddr   h1),
    unat(elf64_p_filesz   h1),
    unat(elf64_p_memsz   h1), 
    unat(elf64_p_flags   h1),
    unat(elf64_p_align   h1)]
    [unat(elf64_p_type   h2),
    unat(elf64_p_offset   h2),
    unat(elf64_p_vaddr   h2),
    unat(elf64_p_paddr   h2),
    unat(elf64_p_filesz   h2),
    unat(elf64_p_memsz   h2), 
    unat(elf64_p_flags   h2),
    unat(elf64_p_align   h2)]))"


definition instance_Basic_classes_Ord_Elf_program_header_table_elf64_program_header_table_entry_dict  :: "(elf64_program_header_table_entry)Ord_class "  where 
     " instance_Basic_classes_Ord_Elf_program_header_table_elf64_program_header_table_entry_dict = ((|

  compare_method = compare_elf64_program_header_table_entry,

  isLess_method = (\<lambda> f1 .  (\<lambda> f2 .  (compare_elf64_program_header_table_entry f1 f2 = LT))),

  isLessEqual_method = (\<lambda> f1 .  (\<lambda> f2 .  (op \<in>) (compare_elf64_program_header_table_entry f1 f2) ({LT, EQ}))),

  isGreater_method = (\<lambda> f1 .  (\<lambda> f2 .  (compare_elf64_program_header_table_entry f1 f2 = GT))),

  isGreaterEqual_method = (\<lambda> f1 .  (\<lambda> f2 .  (op \<in>) (compare_elf64_program_header_table_entry f1 f2) ({GT, EQ})))|) )"


  
(** [string_of_elf32_program_header_table_entry os proc et] produces a string
  * representation of a 32-bit program header table entry using [os] and [proc]
  * to render OS- and processor-specific entries.
  *)
(*val string_of_elf32_program_header_table_entry : (natural -> string) -> (natural -> string) -> elf32_program_header_table_entry -> string*)
definition string_of_elf32_program_header_table_entry  :: "(nat \<Rightarrow> string)\<Rightarrow>(nat \<Rightarrow> string)\<Rightarrow> elf32_program_header_table_entry \<Rightarrow> string "  where 
     " string_of_elf32_program_header_table_entry os proc entry = (
	unlines [		
(([(Char Nibble0 Nibble9)]) @ ((''Segment type: '') @ string_of_segment_type os proc (unat(elf32_p_type   entry))))
	, (([(Char Nibble0 Nibble9)]) @ ((''Offset: '') @ Elf_Types_Local.string_of_uint32(elf32_p_offset   entry)))
	, (([(Char Nibble0 Nibble9)]) @ ((''Virtual address: '') @ Elf_Types_Local.string_of_uint32(elf32_p_vaddr   entry)))
	, (([(Char Nibble0 Nibble9)]) @ ((''Physical address: '') @ Elf_Types_Local.string_of_uint32(elf32_p_paddr   entry)))
	, (([(Char Nibble0 Nibble9)]) @ ((''Segment size (bytes): '') @ Elf_Types_Local.string_of_uint32(elf32_p_filesz   entry)))
	, (([(Char Nibble0 Nibble9)]) @ ((''Segment size in memory image (bytes): '') @ Elf_Types_Local.string_of_uint32(elf32_p_memsz   entry)))
	, (([(Char Nibble0 Nibble9)]) @ ((''Flags: '') @ Elf_Types_Local.string_of_uint32(elf32_p_flags   entry)))
  , (([(Char Nibble0 Nibble9)]) @ ((''Alignment: '') @ Elf_Types_Local.string_of_uint32(elf32_p_align   entry)))
	])"


(** [string_of_elf64_program_header_table_entry os proc et] produces a string
  * representation of a 64-bit program header table entry using [os] and [proc]
  * to render OS- and processor-specific entries.
  *)
(*val string_of_elf64_program_header_table_entry : (natural -> string) -> (natural -> string) -> elf64_program_header_table_entry -> string*)
definition string_of_elf64_program_header_table_entry  :: "(nat \<Rightarrow> string)\<Rightarrow>(nat \<Rightarrow> string)\<Rightarrow> elf64_program_header_table_entry \<Rightarrow> string "  where 
     " string_of_elf64_program_header_table_entry os proc entry = (
  unlines [    
(([(Char Nibble0 Nibble9)]) @ ((''Segment type: '') @ string_of_segment_type os proc (unat(elf64_p_type   entry))))
  , (([(Char Nibble0 Nibble9)]) @ ((''Offset: '') @ Elf_Types_Local.string_of_uint64(elf64_p_offset   entry)))
  , (([(Char Nibble0 Nibble9)]) @ ((''Virtual address: '') @ Elf_Types_Local.string_of_uint64(elf64_p_vaddr   entry)))
  , (([(Char Nibble0 Nibble9)]) @ ((''Physical address: '') @ Elf_Types_Local.string_of_uint64(elf64_p_paddr   entry)))
  , (([(Char Nibble0 Nibble9)]) @ ((''Segment size (bytes): '') @ Elf_Types_Local.string_of_uint64(elf64_p_filesz   entry)))
  , (([(Char Nibble0 Nibble9)]) @ ((''Segment size in memory image (bytes): '') @ Elf_Types_Local.string_of_uint64(elf64_p_memsz   entry)))
  , (([(Char Nibble0 Nibble9)]) @ ((''Flags: '') @ Elf_Types_Local.string_of_uint32(elf64_p_flags   entry)))
  , (([(Char Nibble0 Nibble9)]) @ ((''Alignment: '') @ Elf_Types_Local.string_of_uint64(elf64_p_align   entry)))
  ])"


(** [string_of_elf32_program_header_table_entry_default et] produces a string representation
  * of table entry [et] where OS- and processor-specific entries are replaced with
  * default strings.
  *)
(*val string_of_elf32_program_header_table_entry_default : elf32_program_header_table_entry -> string*)
definition string_of_elf32_program_header_table_entry_default  :: " elf32_program_header_table_entry \<Rightarrow> string "  where 
     " string_of_elf32_program_header_table_entry_default = (
	string_of_elf32_program_header_table_entry
    ((\<lambda> y. (''*Default OS specific print*'')))
      ((\<lambda> y. (''*Default processor specific print*''))))"


(** [string_of_elf64_program_header_table_entry_default et] produces a string representation
  * of table entry [et] where OS- and processor-specific entries are replaced with
  * default strings.
  *)
(*val string_of_elf64_program_header_table_entry_default : elf64_program_header_table_entry -> string*)
definition string_of_elf64_program_header_table_entry_default  :: " elf64_program_header_table_entry \<Rightarrow> string "  where 
     " string_of_elf64_program_header_table_entry_default = (
  string_of_elf64_program_header_table_entry
    ((\<lambda> y. (''*Default OS specific print*'')))
      ((\<lambda> y. (''*Default processor specific print*''))))"

	
definition instance_Show_Show_Elf_program_header_table_elf32_program_header_table_entry_dict  :: "(elf32_program_header_table_entry)Show_class "  where 
     " instance_Show_Show_Elf_program_header_table_elf32_program_header_table_entry_dict = ((|

  show_method = string_of_elf32_program_header_table_entry_default |) )"


definition instance_Show_Show_Elf_program_header_table_elf64_program_header_table_entry_dict  :: "(elf64_program_header_table_entry)Show_class "  where 
     " instance_Show_Show_Elf_program_header_table_elf64_program_header_table_entry_dict = ((|

  show_method = string_of_elf64_program_header_table_entry_default |) )"


(** Parsing and blitting *)

(** [bytes_of_elf32_program_header_table_entry ed ent] blits a 32-bit program
  * header table entry [ent] into a byte sequence assuming endianness [ed].
  *)
(*val bytes_of_elf32_program_header_table_entry : endianness -> elf32_program_header_table_entry -> byte_sequence*)
definition bytes_of_elf32_program_header_table_entry  :: " endianness \<Rightarrow> elf32_program_header_table_entry \<Rightarrow> byte_sequence "  where 
     " bytes_of_elf32_program_header_table_entry endian entry = (
  Byte_sequence.from_byte_lists [
    bytes_of_elf32_word endian(elf32_p_type   entry)
  , bytes_of_elf32_off  endian(elf32_p_offset   entry)
  , bytes_of_elf32_addr endian(elf32_p_vaddr   entry)
  , bytes_of_elf32_addr endian(elf32_p_paddr   entry)
  , bytes_of_elf32_word endian(elf32_p_filesz   entry)
  , bytes_of_elf32_word endian(elf32_p_memsz   entry)
  , bytes_of_elf32_word endian(elf32_p_flags   entry)
  , bytes_of_elf32_word endian(elf32_p_align   entry)
  ])"

  
(** [bytes_of_elf64_program_header_table_entry ed ent] blits a 64-bit program
  * header table entry [ent] into a byte sequence assuming endianness [ed].
  *)
(*val bytes_of_elf64_program_header_table_entry : endianness -> elf64_program_header_table_entry -> byte_sequence*)
definition bytes_of_elf64_program_header_table_entry  :: " endianness \<Rightarrow> elf64_program_header_table_entry \<Rightarrow> byte_sequence "  where 
     " bytes_of_elf64_program_header_table_entry endian entry = (
  Byte_sequence.from_byte_lists [
    bytes_of_elf64_word  endian(elf64_p_type   entry)
  , bytes_of_elf64_word  endian(elf64_p_flags   entry)
  , bytes_of_elf64_off   endian(elf64_p_offset   entry)
  , bytes_of_elf64_addr  endian(elf64_p_vaddr   entry)
  , bytes_of_elf64_addr  endian(elf64_p_paddr   entry)
  , bytes_of_elf64_xword endian(elf64_p_filesz   entry)
  , bytes_of_elf64_xword endian(elf64_p_memsz   entry)
  , bytes_of_elf64_xword endian(elf64_p_align   entry)
  ])"


(** [read_elf32_program_header_table_entry endian bs0] reads an ELF32 program header table
  * entry from byte sequence [bs0] assuming endianness [endian].  If [bs0] is larger
  * than necessary, the excess is returned from the function, too.
  * Fails if the entry cannot be read.
  *)
(*val read_elf32_program_header_table_entry : endianness -> byte_sequence ->
  error (elf32_program_header_table_entry * byte_sequence)*)
definition read_elf32_program_header_table_entry  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>(elf32_program_header_table_entry*byte_sequence)error "  where 
     " read_elf32_program_header_table_entry endian bs = (
	read_elf32_word endian bs >>= (\<lambda> (typ1, bs) . 
	read_elf32_off  endian bs >>= (\<lambda> (offset, bs) . 
	read_elf32_addr endian bs >>= (\<lambda> (vaddr, bs) . 
	read_elf32_addr endian bs >>= (\<lambda> (paddr, bs) . 
	read_elf32_word endian bs >>= (\<lambda> (filesz, bs) . 
	read_elf32_word endian bs >>= (\<lambda> (memsz, bs) . 
	read_elf32_word endian bs >>= (\<lambda> (flags, bs) . 
	read_elf32_word endian bs >>= (\<lambda> (align, bs) . 
		error_return ((| elf32_p_type = typ1, elf32_p_offset = offset,
                elf32_p_vaddr = vaddr, elf32_p_paddr = paddr,
                elf32_p_filesz = filesz, elf32_p_memsz = memsz,
                elf32_p_flags = flags, elf32_p_align = align |), bs))))))))))"


(** [read_elf64_program_header_table_entry endian bs0] reads an ELF64 program header table
  * entry from byte sequence [bs0] assuming endianness [endian].  If [bs0] is larger
  * than necessary, the excess is returned from the function, too.
  * Fails if the entry cannot be read.
  *)
(*val read_elf64_program_header_table_entry : endianness -> byte_sequence ->
  error (elf64_program_header_table_entry * byte_sequence)*)
definition read_elf64_program_header_table_entry  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>(elf64_program_header_table_entry*byte_sequence)error "  where 
     " read_elf64_program_header_table_entry endian bs = (
  read_elf64_word endian bs >>= (\<lambda> (typ1, bs) . 
  read_elf64_word endian bs >>= (\<lambda> (flags, bs) . 
  read_elf64_off  endian bs >>= (\<lambda> (offset, bs) . 
  read_elf64_addr endian bs >>= (\<lambda> (vaddr, bs) . 
  read_elf64_addr endian bs >>= (\<lambda> (paddr, bs) . 
  read_elf64_xword endian bs >>= (\<lambda> (filesz, bs) . 
  read_elf64_xword endian bs >>= (\<lambda> (memsz, bs) . 
  read_elf64_xword endian bs >>= (\<lambda> (align, bs) . 
    error_return ((| elf64_p_type = typ1,
                elf64_p_flags = flags, elf64_p_offset = offset,
                elf64_p_vaddr = vaddr, elf64_p_paddr = paddr,
                elf64_p_filesz = filesz, elf64_p_memsz = memsz, elf64_p_align = align  |), bs))))))))))"


(** Program header table type *)

(** Type [elf32_program_header_table] represents a program header table for 32-bit
  * ELF files.  A program header table is an array (implemented as a list, here)
  * of program header table entries.
  *)
type_synonym elf32_program_header_table =" elf32_program_header_table_entry
  list "

(** Type [elf64_program_header_table] represents a program header table for 64-bit
  * ELF files.  A program header table is an array (implemented as a list, here)
  * of program header table entries.
  *)
type_synonym elf64_program_header_table =" elf64_program_header_table_entry
  list "

(** [bytes_of_elf32_program_header_table ed tbl] blits an ELF32 program header
  * table into a byte sequence assuming endianness [ed].
  *)
definition bytes_of_elf32_program_header_table  :: " endianness \<Rightarrow>(elf32_program_header_table_entry)list \<Rightarrow> byte_sequence "  where 
     " bytes_of_elf32_program_header_table endian tbl = (
  Byte_sequence.concat_byte_sequence (List.map (bytes_of_elf32_program_header_table_entry endian) tbl))"


(** [bytes_of_elf64_program_header_table ed tbl] blits an ELF64 program header
  * table into a byte sequence assuming endianness [ed].
  *)  
definition bytes_of_elf64_program_header_table  :: " endianness \<Rightarrow>(elf64_program_header_table_entry)list \<Rightarrow> byte_sequence "  where 
     " bytes_of_elf64_program_header_table endian tbl = (
  Byte_sequence.concat_byte_sequence (List.map (bytes_of_elf64_program_header_table_entry endian) tbl))"


(** [read_elf32_program_header_table' endian bs0] reads an ELF32 program header table from
  * byte_sequence [bs0] assuming endianness [endian].  The byte_sequence [bs0] is assumed
  * to have exactly the correct size for the table.  For internal use, only.  Use
  * [read_elf32_program_header_table] below instead.
  *)
function (sequential,domintros)  read_elf32_program_header_table'  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>((elf32_program_header_table_entry)list)error "  where 
     " read_elf32_program_header_table' endian bs0 = (
	if Byte_sequence.length0 bs0 =( 0 :: nat) then
  	error_return []
  else
  	read_elf32_program_header_table_entry endian bs0 >>= (\<lambda> (entry, bs1) . 
    read_elf32_program_header_table' endian bs1 >>= (\<lambda> tail . 
    error_return (entry # tail))))" 
by pat_completeness auto


(** [read_elf64_program_header_table' endian bs0] reads an ELF64 program header table from
  * byte_sequence [bs0] assuming endianness [endian].  The byte_sequence [bs0] is assumed
  * to have exactly the correct size for the table.  For internal use, only.  Use
  * [read_elf32_program_header_table] below instead.
  *)
function (sequential,domintros)  read_elf64_program_header_table'  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>((elf64_program_header_table_entry)list)error "  where 
     " read_elf64_program_header_table' endian bs0 = (
  if Byte_sequence.length0 bs0 =( 0 :: nat) then
    error_return []
  else
    read_elf64_program_header_table_entry endian bs0 >>= (\<lambda> (entry, bs1) . 
    read_elf64_program_header_table' endian bs1 >>= (\<lambda> tail . 
    error_return (entry # tail))))" 
by pat_completeness auto


(** [read_elf32_program_header_table table_size endian bs0] reads an ELF32 program header
  * table from byte_sequence [bs0] assuming endianness [endian] based on the size (in bytes) passed in via [table_size].
  * This [table_size] argument should be equal to the number of entries in the
  * table multiplied by the fixed entry size.  Bitstring [bs0] may be larger than
  * necessary, in which case the excess is returned.
  *)
(*val read_elf32_program_header_table : natural -> endianness -> byte_sequence ->
  error (elf32_program_header_table * byte_sequence)*)
definition read_elf32_program_header_table  :: " nat \<Rightarrow> endianness \<Rightarrow> byte_sequence \<Rightarrow>((elf32_program_header_table_entry)list*byte_sequence)error "  where 
     " read_elf32_program_header_table table_size endian bs0 = (
	partition0 table_size bs0 >>= (\<lambda> (eat, rest) . 
	read_elf32_program_header_table' endian eat >>= (\<lambda> table . 
	error_return (table, rest))))"


(** [read_elf64_program_header_table table_size endian bs0] reads an ELF64 program header
  * table from byte_sequence [bs0] assuming endianness [endian] based on the size (in bytes) passed in via [table_size].
  * This [table_size] argument should be equal to the number of entries in the
  * table multiplied by the fixed entry size.  Bitstring [bs0] may be larger than
  * necessary, in which case the excess is returned.
  *)
(*val read_elf64_program_header_table : natural -> endianness -> byte_sequence ->
  error (elf64_program_header_table * byte_sequence)*)
definition read_elf64_program_header_table  :: " nat \<Rightarrow> endianness \<Rightarrow> byte_sequence \<Rightarrow>((elf64_program_header_table_entry)list*byte_sequence)error "  where 
     " read_elf64_program_header_table table_size endian bs0 = (
  partition0 table_size bs0 >>= (\<lambda> (eat, rest) . 
  read_elf64_program_header_table' endian eat >>= (\<lambda> table . 
  error_return (table, rest))))"


(** The [pht_print_bundle] type is used to tidy up other type signatures.  Some of the
  * top-level string_of_ functions require six or more functions passed to them,
  * which quickly gets out of hand.  This type is used to reduce that complexity.
  * The first component of the type is an OS specific print function, the second is
  * a processor specific print function.
  *)
type_synonym pht_print_bundle =" (nat \<Rightarrow> string) * (nat \<Rightarrow> string)"

(** [string_of_elf32_program_header_table os proc tbl] produces a string representation
  * of program header table [tbl] using [os] and [proc] to render OS- and processor-
  * specific entries.
  *)
(*val string_of_elf32_program_header_table : pht_print_bundle -> elf32_program_header_table -> string*)
fun string_of_elf32_program_header_table  :: "(nat \<Rightarrow> string)*(nat \<Rightarrow> string)\<Rightarrow>(elf32_program_header_table_entry)list \<Rightarrow> string "  where 
     " string_of_elf32_program_header_table (os, proc) tbl = (
  unlines (List.map (string_of_elf32_program_header_table_entry os proc) tbl))" 
declare string_of_elf32_program_header_table.simps [simp del]


(** [string_of_elf64_program_header_table os proc tbl] produces a string representation
  * of program header table [tbl] using [os] and [proc] to render OS- and processor-
  * specific entries.
  *)
(*val string_of_elf64_program_header_table : pht_print_bundle -> elf64_program_header_table -> string*)
fun string_of_elf64_program_header_table  :: "(nat \<Rightarrow> string)*(nat \<Rightarrow> string)\<Rightarrow>(elf64_program_header_table_entry)list \<Rightarrow> string "  where 
     " string_of_elf64_program_header_table (os, proc) tbl = (
  unlines (List.map (string_of_elf64_program_header_table_entry os proc) tbl))" 
declare string_of_elf64_program_header_table.simps [simp del]


(** Static/dynamic linkage *)

(** [get_elf32_dynamic_linked pht] tests whether an ELF32 file is a dynamically
  * linked object by traversing the program header table and attempting to find
  * a header describing a segment with the name of an associated interpreter.
  * Returns [true] if any such header is found, [false] --- indicating static
  * linkage --- otherwise.
  *)
(*val get_elf32_dynamic_linked : elf32_program_header_table -> bool*)
definition get_elf32_dynamic_linked  :: "(elf32_program_header_table_entry)list \<Rightarrow> bool "  where 
     " get_elf32_dynamic_linked pht = (
  ((\<exists> x \<in> (set pht).  (\<lambda> p .  unat(elf32_p_type   p) = elf_pt_interp) x)))"


(** [get_elf64_dynamic_linked pht] tests whether an ELF64 file is a dynamically
  * linked object by traversing the program header table and attempting to find
  * a header describing a segment with the name of an associated interpreter.
  * Returns [true] if any such header is found, [false] --- indicating static
  * linkage --- otherwise.
  *)
(*val get_elf64_dynamic_linked : elf64_program_header_table -> bool*)
definition get_elf64_dynamic_linked  :: "(elf64_program_header_table_entry)list \<Rightarrow> bool "  where 
     " get_elf64_dynamic_linked pht = (
  ((\<exists> x \<in> (set pht).  (\<lambda> p .  unat(elf64_p_type   p) = elf_pt_interp) x)))"


(** [get_elf32_static_linked] is a utility function defined as the inverse
  * of [get_elf32_dynamic_linked].
  *)
(*val get_elf32_static_linked : elf32_program_header_table -> bool*)
definition get_elf32_static_linked  :: "(elf32_program_header_table_entry)list \<Rightarrow> bool "  where 
     " get_elf32_static_linked pht = (
  \<not> (get_elf32_dynamic_linked pht))"


(** [get_elf64_static_linked] is a utility function defined as the inverse
  * of [get_elf64_dynamic_linked].
  *)
(*val get_elf64_static_linked : elf64_program_header_table -> bool*)
definition get_elf64_static_linked  :: "(elf64_program_header_table_entry)list \<Rightarrow> bool "  where 
     " get_elf64_static_linked pht = (
  \<not> (get_elf64_dynamic_linked pht))"

  
(** [get_elf32_requested_interpreter ent bs0] extracts the requested interpreter
  * of a dynamically linkable ELF file from that file's program header table
  * entry of type PT_INTERP, [ent].  Interpreter string is extracted from byte
  * sequence [bs0].
  * Fails if [ent] is not of type PT_INTERP, or if transcription otherwise fails.
  *)
(*val get_elf32_requested_interpreter : elf32_program_header_table_entry ->
  byte_sequence -> error string*)
definition get_elf32_requested_interpreter  :: " elf32_program_header_table_entry \<Rightarrow> byte_sequence \<Rightarrow>(string)error "  where 
     " get_elf32_requested_interpreter pent bs0 = (
  if unat(elf32_p_type   pent) = elf_pt_interp then
    (let off = (unat(elf32_p_offset    pent)) in
    (let siz = (unat(elf32_p_filesz   pent)) in
      Byte_sequence.offset_and_cut off (siz -( 1 :: nat)) bs0 >>= (\<lambda> cut1 . 
      error_return (Byte_sequence.string_of_byte_sequence cut1))))
  else
    error_fail (''get_elf32_requested_interpreter: not an INTERP segment header''))"

  
(** [get_elf64_requested_interpreter ent bs0] extracts the requested interpreter
  * of a dynamically linkable ELF file from that file's program header table
  * entry of type PT_INTERP, [ent].  Interpreter string is extracted from byte
  * sequence [bs0].
  * Fails if [ent] is not of type PT_INTERP, or if transcription otherwise fails.
  *)
(*val get_elf64_requested_interpreter : elf64_program_header_table_entry ->
  byte_sequence -> error string*)
definition get_elf64_requested_interpreter  :: " elf64_program_header_table_entry \<Rightarrow> byte_sequence \<Rightarrow>(string)error "  where 
     " get_elf64_requested_interpreter pent bs0 = (
  if unat(elf64_p_type   pent) = elf_pt_interp then
    (let off = (unat(elf64_p_offset     pent)) in
    (let siz = (unat(elf64_p_filesz   pent)) in
      Byte_sequence.offset_and_cut off (siz -( 1 :: nat)) bs0 >>= (\<lambda> cut1 . 
      error_return (Byte_sequence.string_of_byte_sequence cut1))))
  else
    error_fail (''get_elf64_requested_interpreter: not an INTERP segment header''))"

end
