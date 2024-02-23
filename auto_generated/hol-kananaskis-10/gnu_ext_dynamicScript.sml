(*Generated by Lem from gnu_extensions/gnu_ext_dynamic.lem.*)
open HolKernel Parse boolLib bossLib;
open lem_numTheory lem_basic_classesTheory lem_boolTheory lem_stringTheory showTheory errorTheory elf_types_native_uintTheory string_tableTheory elf_dynamicTheory;

val _ = numLib.prefer_num();



val _ = new_theory "gnu_ext_dynamic"

(** [gnu_ext_dynamic] contains GNU extension specific definitions related to the
  * .dynamic section of an ELF file.
  *)

(*open import Basic_classes*)
(*open import Bool*)
(*open import Num*)
(*open import String*)

(*open import Error*)
(*open import Show*)
(*open import String_table*)

(*open import Elf_dynamic*)
(*open import Elf_types_native_uint*)

(** Additional dynamic entries, see LSB section 11.3.2.2.
  * All values taken from elf.c from binutils and GLIBC as the LSB does not
  * specify them.
  *
  *  98 #define OLD_DT_LOOS     0x60000000
  *  99 #define DT_LOOS         0x6000000d
  * 100 #define DT_HIOS         0x6ffff000
  * 101 #define DT_VALRNGLO     0x6ffffd00
  * 102 #define DT_VALRNGHI     0x6ffffdff
  * 103 #define DT_ADDRRNGLO    0x6ffffe00
  * 104 #define DT_ADDRRNGHI    0x6ffffeff
  * 105 #define DT_VERSYM       0x6ffffff0
  * 106 #define DT_RELACOUNT    0x6ffffff9
  * 107 #define DT_RELCOUNT     0x6ffffffa
  * 108 #define DT_FLAGS_1      0x6ffffffb
  * 109 #define DT_VERDEF       0x6ffffffc
  * 110 #define DT_VERDEFNUM    0x6ffffffd
  * 111 #define DT_VERNEED      0x6ffffffe
  * 112 #define DT_VERNEEDNUM   0x6fffffff
  * 113 #define OLD_DT_HIOS     0x6fffffff
  * 114 #define DT_LOPROC       0x70000000
  * 115 #define DT_HIPROC       0x7fffffff
  *)

val _ = Define `
 (elf_dt_gnu_addrrnghi  : num=  ((( 939523967:num) *( 2:num)) +( 1:num)))`;
  (*0x6ffffeff*)
val _ = Define `
 (elf_dt_gnu_addrrnglo  : num= (( 939523840:num) *( 2:num)))`;
        (*0x6ffffe00*)
val _ = Define `
 (elf_dt_gnu_auxiliary  : num=  ((( 1073741822:num) *( 2:num)) +( 1:num)))`;
 (*0x7ffffffd*)
val _ = Define `
 (elf_dt_gnu_filter     : num=  ((( 1073741823:num) *( 2:num)) +( 1:num)))`;
 (*0x7fffffff*)
(** The following is "specified" in the LSB document but is not present in the
  * elf.c file so taken from elf.h from GLIBC:
  *)
val _ = Define `
 (elf_dt_gnu_num        : num= (( 32:num)))`;
 (** ??? This should match something *)
val _ = Define `
 (elf_dt_gnu_posflag_1  : num=  ((( 939523838:num) *( 2:num)) +( 1:num)))`;
 (*0x6ffffdfd*)
val _ = Define `
 (elf_dt_gnu_relcount   : num= (( 939524093:num) *( 2:num)))`;
       (*0x6ffffffa*)
val _ = Define `
 (elf_dt_gnu_relacount  : num=  ((( 939524092:num) *( 2:num)) +( 1:num)))`;
 (*0x6FFFFFF9*)
val _ = Define `
 (elf_dt_gnu_syminent   : num=  ((( 939523839:num) *( 2:num)) +( 1:num)))`;
 (*0x6ffffdff*)
val _ = Define `
 (elf_dt_gnu_syminfo    : num=  ((( 939523967:num) *( 2:num)) +( 1:num)))`;
 (*0x6ffffeff*)
val _ = Define `
 (elf_dt_gnu_syminsz    : num= (( 939523839:num) *( 2:num)))`;
       (*0x6ffffdfe*)
val _ = Define `
 (elf_dt_gnu_valrnghi   : num=  ((( 939523839:num) *( 2:num)) +( 1:num)))`;
 (*0x6ffffdff*)
val _ = Define `
 (elf_dt_gnu_valrnglo   : num=  (( 939523712:num) *( 2:num)))`;
     (*0x6ffffd00*)
val _ = Define `
 (elf_dt_gnu_verdef     : num= (( 939524094:num) *( 2:num)))`;
       (*0x6ffffffc*)
val _ = Define `
 (elf_dt_gnu_verdefnum  : num=  ((( 939524094:num) *( 2:num)) +( 1:num)))`;
 (*0x6ffffffd*)
val _ = Define `
 (elf_dt_gnu_verneed    : num= (( 939524095:num) *( 2:num)))`;
       (*0x6ffffffe*)
val _ = Define `
 (elf_dt_gnu_verneednum : num=  ((( 939524095:num) *( 2:num)) +( 1:num)))`;
 (*0x6fffffff*)
val _ = Define `
 (elf_dt_gnu_versym     : num= (( 939524088:num) *( 2:num)))`;
       (*0x6ffffff0*)

(** Not present in the LSB but turns up in "real" ELF files... *)

val _ = Define `
 (elf_dt_gnu_hash      : num=  ((( 939523962:num) *( 2:num)) +( 1:num)))`;
 (*0x6ffffef5*)
val _ = Define `
 (elf_dt_gnu_flags_1   : num=  ((( 939524093:num) *( 2:num)) +( 1:num)))`;
 (*0x6ffffffb*)
val _ = Define `
 (elf_dt_gnu_checksum  : num=  (( 939523836:num) *( 2:num)))`;
     (* 0x6FFFFDF8 *)
val _ = Define `
 (elf_dt_gnu_prelinked : num=  ((( 2:num) *( 939523834:num)) +( 1:num)))`;
 (* 0x6FFFFDF5 *)

(** Extended DT flags for FLAGS_1 dynamic section types.  Taken from GLibC source
  * as they appear to be completely unspecified!
  *)
  
val _ = Define `
 (gnu_df_1_now        : num= (( 1:num)))`;
     (*0x00000001*)
val _ = Define `
 (gnu_df_1_global     : num= (( 2:num)))`;
     (*0x00000002*)
val _ = Define `
 (gnu_df_1_group      : num= (( 4:num)))`;
     (*0x00000004*)
val _ = Define `
 (gnu_df_1_nodelete   : num= (( 8:num)))`;
     (*0x00000008*)
val _ = Define `
 (gnu_df_1_loadfltr   : num= (( 16:num)))`;
    (*0x00000010*)
val _ = Define `
 (gnu_df_1_initfirst  : num= (( 32:num)))`;
    (*0x00000020*)
val _ = Define `
 (gnu_df_1_noopen     : num= (( 64:num)))`;
    (*0x00000040*)
val _ = Define `
 (gnu_df_1_origin     : num= (( 128:num)))`;
   (*0x00000080*)
val _ = Define `
 (gnu_df_1_direct     : num= (( 256:num)))`;
   (*0x00000100*)
val _ = Define `
 (gnu_df_1_trans      : num= (( 512:num)))`;
   (*0x00000200*)
val _ = Define `
 (gnu_df_1_interpose  : num= (( 1024:num)))`;
  (*0x00000400*)
val _ = Define `
 (gnu_df_1_nodeflib   : num= (( 2048:num)))`;
  (*0x00000800*)
val _ = Define `
 (gnu_df_1_nodump     : num= (( 4096:num)))`;
  (*0x00001000*)
val _ = Define `
 (gnu_df_1_confalt    : num= (( 8192:num)))`;
  (*0x00002000*)
val _ = Define `
 (gnu_df_1_endfiltee  : num= (( 16384:num)))`;
 (*0x00004000*)
val _ = Define `
 (gnu_df_1_dispreldne : num= (( 32768:num)))`;
 (*0x00008000*)
val _ = Define `
 (gnu_df_1_disprelpnd : num= (( 65536:num)))`;
 (*0x00010000*)

(** [gnu_string_of_dt_flag1 m] produces a string based representation of GNU
  * extensions flag_1 value [m].
  *)
(*val gnu_string_of_dt_flag_1 : natural -> string*)

(** [gnu_ext_os_additional_ranges m] checks whether dynamic section type [m]
  * lies within the ranges set aside for GNU specific functionality.
  * NB: quite ad hoc as this is not properly specified anywhere.
  *)
(*val gnu_ext_os_additional_ranges : natural -> bool*)
val _ = Define `
 (gnu_ext_os_additional_ranges m=  
 (if (m >= elf_dt_gnu_addrrnglo) /\ (m <= elf_dt_gnu_addrrnghi) then
    T
  else    
( (* ad hoc extensions go here... *)m = elf_dt_gnu_verneed) \/
    ((m = elf_dt_gnu_verneednum) \/
    ((m = elf_dt_gnu_versym) \/
    ((m = elf_dt_gnu_verdef) \/
    ((m = elf_dt_gnu_verdefnum) \/
    ((m = elf_dt_gnu_flags_1) \/
    ((m = elf_dt_gnu_relcount) \/
    ((m = elf_dt_gnu_relacount) \/
    ((m = elf_dt_gnu_checksum) \/    
(m = elf_dt_gnu_prelinked)))))))))))`;


(** [gnu_ext_tag_correspondence_of_tag0 m] produces a tag correspondence for the
  * extended GNU-specific dynamic section types [m].  Used to provide the ABI
  * specific functionality expected of the corresponding function in the elf_dynamic
  * module.
  *)
(*val gnu_ext_tag_correspondence_of_tag0 : natural -> error tag_correspondence*)
val _ = Define `
 (gnu_ext_tag_correspondence_of_tag0 m=  
 (if m = elf_dt_gnu_hash then
    return C_Ptr
  else if m = elf_dt_gnu_flags_1 then
    return C_Val
  else if m = elf_dt_gnu_versym then
    return C_Ptr
  else if m = elf_dt_gnu_verneednum then
    return C_Val
  else if m = elf_dt_gnu_verneed then
    return C_Ptr
  else if m = elf_dt_gnu_verdef then
    return C_Ptr
  else if m = elf_dt_gnu_verdefnum then
    return C_Val
  else if m = elf_dt_gnu_relcount then
    return C_Val
  else if m = elf_dt_gnu_relacount then
    return C_Val
  else if m = elf_dt_gnu_checksum then
    return C_Val
  else if m = elf_dt_gnu_prelinked then
    return C_Val
  else
    fail0 "gnu_ext_tag_correspondence_of_tag0: invalid dynamic tag"))`;


(** [gnu_ext_tag_correspondence_of_tag m] produces a tag correspondence for the
  * extended GNU-specific dynamic section types [m].  Used to provide the ABI
  * specific functionality expected of the corresponding function in the elf_dynamic
  * module.
  * TODO: examine whether this and the function above really need separating into
  * two functions.
  *)
(*val gnu_ext_tag_correspondence_of_tag : natural -> error tag_correspondence*)
val _ = Define `
 (gnu_ext_tag_correspondence_of_tag m=  
 (if (m >= elf_dt_gnu_addrrnglo) /\ (m <= elf_dt_gnu_addrrnghi) then
    return C_Ptr
  else if (m >= elf_dt_gnu_valrnglo) /\ (m <= elf_dt_gnu_valrnghi) then
    return C_Val
  else if gnu_ext_os_additional_ranges m then
    gnu_ext_tag_correspondence_of_tag0 m
  else if m = elf_dt_gnu_syminsz then
    return C_Val (** unsure *)
  else if m = elf_dt_gnu_syminfo then
    return C_Ptr (** unsure *)
  else if m = elf_dt_gnu_syminent then
    return C_Val (** unsure *)
  else if m = elf_dt_gnu_posflag_1 then
    return C_Val (** unsure *)
  else if m = elf_dt_gnu_num then
    return C_Ignored
  else if m = elf_dt_gnu_filter then
    return C_Val (** unsure *)
  else if m = elf_dt_gnu_auxiliary then
    return C_Val (** unsure *)
  else
    fail0 ("gnu_ext_tag_correspondence_of_tag: unrecognised GNU dynamic tag")))`;

    
(** [gnu_ext_elf32_value_of_elf32_dyn0 dyn] extracts a dynamic value from the
  * dynamic section entry [dyn] under the assumption that its type is a GNU
  * extended dynamic section type.  Fails otherwise.  Used to provide the
  * ABI-specific functionality expected of the corresponding functions in
  * elf_dynamic.lem.
  *)
(*val gnu_ext_elf32_value_of_elf32_dyn0 : elf32_dyn -> string_table -> error elf32_dyn_value*)
val _ = Define `
 (gnu_ext_elf32_value_of_elf32_dyn0 dyn stbl=  
 (let tag = (Num (ABS (w2i dyn.elf32_dyn_tag))) in
    if tag = elf_dt_gnu_hash then
      (case dyn.elf32_dyn_d_un of
          D_Val     v => fail0 "gnu_ext_elf32_value_of_elf32_dyn: GNU_HASH must be a PTR"
        | D_Ptr     p => return p
        | D_Ignored i => fail0 "gnu_ext_elf32_value_of_elf32_dyn: GNU_HASH must be a PTR"
      ) >>= (\ addr . 
      return (Address addr))
    else if tag = elf_dt_gnu_flags_1 then
      (case dyn.elf32_dyn_d_un of
          D_Val     v => return v
        | D_Ptr     p => fail0 "gnu_ext_elf32_value_of_elf32_dyn: FLAGS_1 must be a Val"
        | D_Ignored i => fail0 "gnu_ext_elf32_value_of_elf32_dyn: FlAGS_1 must be a Val"
      ) >>= (\ f . 
      return (Flags1 (w2n f)))
    else if tag = elf_dt_gnu_versym then
      (case dyn.elf32_dyn_d_un of
          D_Val     v => fail0 "gnu_ext_elf32_value_of_elf32_dyn: VERSYM must be a PTR"
        | D_Ptr     p => return p
        | D_Ignored i => fail0 "gnu_ext_elf32_value_of_elf32_dyn: VERSYM must be a PTR"
      ) >>= (\ addr . 
      return (Address addr))
    else if tag = elf_dt_gnu_verdef then
      (case dyn.elf32_dyn_d_un of
          D_Val     v => fail0 "gnu_ext_elf32_value_of_elf32_dyn: VERDEF must be a PTR"
        | D_Ptr     p => return p
        | D_Ignored i => fail0 "gnu_ext_elf32_value_of_elf32_dyn: VERDEF must be a PTR"
      ) >>= (\ addr . 
      return (Address addr))
    else if tag = elf_dt_gnu_verdefnum then
      (case dyn.elf32_dyn_d_un of
          D_Val     v => return v
        | D_Ptr     p => fail0 "gnu_ext_elf32_value_of_elf32_dyn: VERDEFNUM must be a Val"
        | D_Ignored i => fail0 "gnu_ext_elf32_value_of_elf32_dyn: VERDEFNUM must be a Val"
      ) >>= (\ sz . 
      return (Numeric (w2n sz)))
    else if tag = elf_dt_gnu_verneednum then
      (case dyn.elf32_dyn_d_un of
          D_Val     v => return v
        | D_Ptr     p => fail0 "gnu_ext_elf32_value_of_elf32_dyn: VERNEEDNUM must be a Val"
        | D_Ignored i => fail0 "gnu_ext_elf32_value_of_elf32_dyn: VERNEEDNUM must be a Val"
      ) >>= (\ sz . 
      return (Numeric (w2n sz)))
    else if tag = elf_dt_gnu_verneed then
      (case dyn.elf32_dyn_d_un of
          D_Val     v => fail0 "gnu_ext_elf32_value_of_elf32_dyn: VERNEED must be a PTR"
        | D_Ptr     p => return p
        | D_Ignored i => fail0 "gnu_ext_elf32_value_of_elf32_dyn: VERNEED must be a PTR"
      ) >>= (\ addr . 
      return (Address addr))
    else if tag = elf_dt_gnu_relcount then
      (case dyn.elf32_dyn_d_un of
          D_Val     v => return v
        | D_Ptr     p => fail0 "gnu_ext_elf32_value_of_elf32_dyn: RELCOUNT must be a Val"
        | D_Ignored i => fail0 "gnu_ext_elf32_value_of_elf32_dyn: RELCOUNT must be a Val"
      ) >>= (\ sz . 
      return (Numeric (w2n sz)))
    else if tag = elf_dt_gnu_relacount then
      (case dyn.elf32_dyn_d_un of
          D_Val     v => return v
        | D_Ptr     p => fail0 "gnu_ext_elf32_value_of_elf32_dyn: RELACOUNT must be a Val"
        | D_Ignored i => fail0 "gnu_ext_elf32_value_of_elf32_dyn: RELACOUNT must be a Val"
      ) >>= (\ sz . 
      return (Numeric (w2n sz)))
    else if tag = elf_dt_gnu_checksum then
      (case dyn.elf32_dyn_d_un of
          D_Val     v => return v
        | D_Ptr     p => fail0 "gnu_ext_elf32_value_of_elf32_dyn: CHECKSUM must be a Val"
        | D_Ignored i => fail0 "gnu_ext_elf32_value_of_elf32_dyn: CHECKSUM must be a Val"
      ) >>= (\ sz . 
      return (Checksum (w2n sz)))
    else if tag = elf_dt_gnu_prelinked then
      (case dyn.elf32_dyn_d_un of
          D_Val     v => return v
        | D_Ptr     p => fail0 "gnu_ext_elf32_value_of_elf32_dyn: GNU_PRELINKED must be a Val"
        | D_Ignored i => fail0 "gnu_ext_elf32_value_of_elf32_dyn: GNU_PRELINKED must be a Val"
      ) >>= (\ off . 
      return (Timestamp (w2n off)))
    else
      fail0 "gnu_ext_elf32_value_of_elf32_dyn0: unrecognised GNU dynamic tag"))`;

      
(** [gnu_ext_elf64_value_of_elf64_dyn0 dyn] extracts a dynamic value from the
  * dynamic section entry [dyn] under the assumption that its type is a GNU
  * extended dynamic section type.  Fails otherwise.  Used to provide the
  * ABI-specific functionality expected of the corresponding functions in
  * elf_dynamic.lem.
  *)
(*val gnu_ext_elf64_value_of_elf64_dyn0 : elf64_dyn -> string_table -> error elf64_dyn_value*)
val _ = Define `
 (gnu_ext_elf64_value_of_elf64_dyn0 dyn stbl=  
 (let tag = (Num (ABS (w2i dyn.elf64_dyn_tag))) in
    if tag = elf_dt_gnu_hash then
      (case dyn.elf64_dyn_d_un of
          D_Val     v => fail0 "gnu_ext_elf64_value_of_elf64_dyn: GNU_HASH must be a PTR"
        | D_Ptr     p => return p
        | D_Ignored i => fail0 "gnu_ext_elf64_value_of_elf64_dyn: GNU_HASH must be a PTR"
      ) >>= (\ addr . 
      return (Address addr))
    else if tag = elf_dt_gnu_flags_1 then
      (case dyn.elf64_dyn_d_un of
          D_Val     v => return v
        | D_Ptr     p => fail0 "gnu_ext_elf64_value_of_elf64_dyn: FLAGS_1 must be a Val"
        | D_Ignored i => fail0 "gnu_ext_elf64_value_of_elf64_dyn: FlAGS_1 must be a Val"
      ) >>= (\ f . 
      return (Flags1 (w2n f)))
    else if tag = elf_dt_gnu_versym then
      (case dyn.elf64_dyn_d_un of
          D_Val     v => fail0 "gnu_ext_elf64_value_of_elf64_dyn: VERSYM must be a PTR"
        | D_Ptr     p => return p
        | D_Ignored i => fail0 "gnu_ext_elf64_value_of_elf64_dyn: VERSYM must be a PTR"
      ) >>= (\ addr . 
      return (Address addr))
    else if tag = elf_dt_gnu_verdef then
      (case dyn.elf64_dyn_d_un of
          D_Val     v => fail0 "gnu_ext_elf64_value_of_elf64_dyn: VERDEF must be a PTR"
        | D_Ptr     p => return p
        | D_Ignored i => fail0 "gnu_ext_elf64_value_of_elf64_dyn: VERDEF must be a PTR"
      ) >>= (\ addr . 
      return (Address addr))
    else if tag = elf_dt_gnu_verdefnum then
      (case dyn.elf64_dyn_d_un of
          D_Val     v => return v
        | D_Ptr     p => fail0 "gnu_ext_elf32_value_of_elf64_dyn: VERDEFNUM must be a Val"
        | D_Ignored i => fail0 "gnu_ext_elf32_value_of_elf64_dyn: VERDEFNUM must be a Val"
      ) >>= (\ sz . 
      return (Numeric (w2n sz)))
    else if tag = elf_dt_gnu_verneednum then
      (case dyn.elf64_dyn_d_un of
          D_Val     v => return v
        | D_Ptr     p => fail0 "gnu_ext_elf64_value_of_elf64_dyn: VERNEEDNUM must be a Val"
        | D_Ignored i => fail0 "gnu_ext_elf64_value_of_elf64_dyn: VERNEEDNUM must be a Val"
      ) >>= (\ sz . 
      return (Numeric (w2n sz)))
    else if tag = elf_dt_gnu_verneed then
      (case dyn.elf64_dyn_d_un of
          D_Val     v => fail0 "gnu_ext_elf64_value_of_elf64_dyn: VERNEED must be a PTR"
        | D_Ptr     p => return p
        | D_Ignored i => fail0 "gnu_ext_elf64_value_of_elf64_dyn: VERNEED must be a PTR"
      ) >>= (\ addr . 
      return (Address addr))
    else if tag = elf_dt_gnu_relcount then
      (case dyn.elf64_dyn_d_un of
          D_Val     v => return v
        | D_Ptr     p => fail0 "gnu_ext_elf64_value_of_elf64_dyn: RELCOUNT must be a Val"
        | D_Ignored i => fail0 "gnu_ext_elf64_value_of_elf64_dyn: RELCOUNT must be a Val"
      ) >>= (\ sz . 
      return (Numeric (w2n sz)))
    else if tag = elf_dt_gnu_relacount then
      (case dyn.elf64_dyn_d_un of
          D_Val     v => return v
        | D_Ptr     p => fail0 "gnu_ext_elf64_value_of_elf64_dyn: RELACOUNT must be a Val"
        | D_Ignored i => fail0 "gnu_ext_elf64_value_of_elf64_dyn: RELACOUNT must be a Val"
      ) >>= (\ sz . 
      return (Numeric (w2n sz)))
    else if tag = elf_dt_gnu_checksum then
      (case dyn.elf64_dyn_d_un of
          D_Val     v => return v
        | D_Ptr     p => fail0 "gnu_ext_elf64_value_of_elf64_dyn: CHECKSUM must be a Val"
        | D_Ignored i => fail0 "gnu_ext_elf64_value_of_elf64_dyn: CHECKSUM must be a Val"
      ) >>= (\ sz . 
      return (Checksum (w2n sz)))
    else if tag = elf_dt_gnu_prelinked then
      (case dyn.elf64_dyn_d_un of
          D_Val     v => return v
        | D_Ptr     p => fail0 "gnu_ext_elf64_value_of_elf64_dyn: GNU_PRELINKED must be a Val"
        | D_Ignored i => fail0 "gnu_ext_elf64_value_of_elf64_dyn: GNU_PRELINKED must be a Val"
      ) >>= (\ off . 
      return (Timestamp (w2n off)))
    else
      fail0 "gnu_ext_elf64_value_of_elf64_dyn0: unrecognised GNU dynamic tag"))`;

      
(** [gnu_ext_elf32_value_of_elf32_dyn dyn] extracts a dynamic value from the
  * dynamic section entry [dyn] under the assumption that its type is a GNU
  * extended dynamic section type.  Fails otherwise.  Used to provide the
  * ABI-specific functionality expected of the corresponding functions in
  * elf_dynamic.lem.
  * TODO: some of these cases are missing as they have never come up in "real"
  * ELF files that have been processed as part of validation.  Try and find some
  * files that do actually exhibit these.
  *)
(*val gnu_ext_elf32_value_of_elf32_dyn : elf32_dyn -> string_table -> error elf32_dyn_value*)
val _ = Define `
 (gnu_ext_elf32_value_of_elf32_dyn dyn stbl=  
 (let tag = (Num (ABS (w2i dyn.elf32_dyn_tag))) in
    if gnu_ext_os_additional_ranges tag then (* this should cover valrngs and addrrngs *)
      gnu_ext_elf32_value_of_elf32_dyn0 dyn stbl
    else if tag = elf_dt_gnu_syminsz then
      (case dyn.elf32_dyn_d_un of
          D_Val     v => return v
        | D_Ptr     p => fail0 "gnu_ext_elf32_value_of_elf32_dyn: SYMINSZ must be a VAL"
        | D_Ignored i => fail0 "gnu_ext_elf32_value_of_elf32_dyn: SYMINSZ must be a VAL"
      ) >>= (\ sz . 
      return (Size sz))
    else if tag = elf_dt_gnu_syminfo then
      fail0 "SYMINFO" (* XXX: never seen in 32-bit ELF *)
    else if tag = elf_dt_gnu_syminent then
      fail0 "SYMINENT" (* XXX: never seen in 32-bit ELF *)
    else if tag = elf_dt_gnu_posflag_1 then
      fail0 "POSFLAG_1" (* XXX: never seen in 32-bit ELF *)
    else if tag = elf_dt_gnu_num then
      fail0 "NUM" (* XXX: never seen in 32-bit ELF *)
    else if tag = elf_dt_gnu_filter then
      fail0 "FILTER" (* XXX: never seen in 32-bit ELF *)
    else if tag = elf_dt_gnu_auxiliary then
      fail0 "AUXILIARY" (* XXX: never seen in 32-bit ELF *)
    else
      fail0 "gnu_ext_elf32_value_of_elf32_dyn: unrecognised GNU dynamic tag"))`;

      
(** [gnu_ext_elf64_value_of_elf64_dyn dyn] extracts a dynamic value from the
  * dynamic section entry [dyn] under the assumption that its type is a GNU
  * extended dynamic section type.  Fails otherwise.  Used to provide the
  * ABI-specific functionality expected of the corresponding functions in
  * elf_dynamic.lem.
  * TODO: some of these cases are missing as they have never come up in "real"
  * ELF files that have been processed as part of validation.  Try and find some
  * files that do actually exhibit these.
  *)
(*val gnu_ext_elf64_value_of_elf64_dyn : elf64_dyn -> string_table -> error elf64_dyn_value*)
val _ = Define `
 (gnu_ext_elf64_value_of_elf64_dyn dyn stbl=  
 (let tag = (Num (ABS (w2i dyn.elf64_dyn_tag))) in
    if gnu_ext_os_additional_ranges tag then (* this should cover valrngs and addrrngs *)
      gnu_ext_elf64_value_of_elf64_dyn0 dyn stbl
    else if tag = elf_dt_gnu_syminsz then
      (case dyn.elf64_dyn_d_un of
          D_Val     v => return v
        | D_Ptr     p => fail0 "gnu_ext_elf64_value_of_elf64_dyn: SYMINSZ must be a VAL"
        | D_Ignored i => fail0 "gnu_ext_elf64_value_of_elf64_dyn: SYMINSZ must be a VAL"
      ) >>= (\ sz . 
      return (Size sz))
    else if tag = elf_dt_gnu_syminfo then
      fail0 "SYMINFO" (* XXX: fill in as seen *)
    else if tag = elf_dt_gnu_syminent then
      fail0 "SYMINENT" (* XXX: fill in as seen *)
    else if tag = elf_dt_gnu_posflag_1 then
      fail0 "POSFLAG_1" (* XXX: fill in as seen *)
    else if tag = elf_dt_gnu_num then
      fail0 "NUM" (* XXX: fill in as seen *)
    else if tag = elf_dt_gnu_filter then
      fail0 "FILTER" (* XXX: fill in as seen *)
    else if tag = elf_dt_gnu_auxiliary then
      fail0 "AUXILIARY" (* XXX: fill in as seen *)
    else
      fail0 "gnu_ext_elf64_value_of_elf64_dyn: unrecognised GNU dynamic tag"))`;

    
(** [string_of_gnu_ext_dynamic_tag0 m] produces a string based representation of
  * GNU extensions dynamic tag value [m].
  *)
(*val string_of_gnu_ext_dynamic_tag0 : natural -> string*)
    
(** [string_of_gnu_ext_dynamic_tag m] produces a string based representation of
  * GNU extensions dynamic tag value [m].
  *)
(*val string_of_gnu_ext_dynamic_tag : natural -> string*)
val _ = export_theory()
