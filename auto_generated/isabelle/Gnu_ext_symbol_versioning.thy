chapter {* Generated by Lem from gnu_extensions/gnu_ext_symbol_versioning.lem. *}

theory "Gnu_ext_symbol_versioning" 

imports 
 	 Main
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_num" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_list" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_basic_classes" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_bool" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_maybe" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_string" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Show" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Missing_pervasives" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Error" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Byte_sequence" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Endianness" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Elf_types_native_uint" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Elf_header" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Elf_section_header_table" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Elf_symbol_table" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Elf_file" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Elf_dynamic" 
	 "Gnu_ext_dynamic" 
	 "Gnu_ext_section_header_table" 

begin 

(** The [gnu_ext_symbol_versioning] defines constants, types and functions
  * relating to the GNU symbol versioning extensions (i.e. contents of
  * GNU_VERSYM sections).
  *
  * TODO: work out what is going on with symbol versioning.  The specification
  * is completely opaque.
  *)

(*open import Basic_classes*)
(*open import Bool*)
(*open import List*)
(*open import Maybe*)
(*open import Num*)
(*open import String*)

(*open import Byte_sequence*)
(*open import Endianness*)
(*open import Error*)

(*open import Elf_dynamic*)
(*open import Elf_file*)
(*open import Elf_header*)
(*open import Elf_section_header_table*)
(*open import Elf_symbol_table*)
(*open import Elf_types_native_uint*)

(*open import Missing_pervasives*)
(*open import Show*)

(*open import Gnu_ext_dynamic*)
(*open import Gnu_ext_section_header_table*)

(** [gnu_ext_elf32_symbol_version_table] is an array (linked list, here) of
  * [elf32_half] entries.
  *)
type_synonym gnu_ext_elf32_symbol_version_table =" uint16
  list "
  
type_synonym gnu_ext_elf64_symbol_version_table =" uint16
  list "

(*val obtain_gnu_ext_elf32_symbol_version_table : elf32_file -> byte_sequence -> error gnu_ext_elf32_symbol_version_table*)
definition obtain_gnu_ext_elf32_symbol_version_table  :: " elf32_file \<Rightarrow> byte_sequence \<Rightarrow>((uint16)list)error "  where 
     " obtain_gnu_ext_elf32_symbol_version_table f1 bs0 = (
  (let sht = ((elf32_file_section_header_table   f1)) in
  (let endian = (get_elf32_header_endianness(elf32_file_header   f1)) in
  (let vers = (List.filter (\<lambda> ent . (elf32_sh_type  
    ent) = Elf_Types_Local.uint32_of_nat sht_gnu_versym
  ) sht)
  in
    (case  vers of
        []    => error_return []
      | [ver] =>
        (let off = (unat(elf32_sh_offset    ver)) in
        (let siz = (unat(elf32_sh_size   ver)) in
        (let lnk = (unat(elf32_sh_link   ver)) in
        get_elf32_symbol_table_by_index f1 lnk >>= (\<lambda> symtab . 
        (let dlen = ( (List.length symtab)) in
        Byte_sequence.offset_and_cut off siz bs0         >>= (\<lambda> ver      . 
        Error.repeatM' dlen bs0 (read_elf32_half endian) >>= (\<lambda> (ver, _) . 
        error_return ver)))))))
      | _     => error_fail (''obtain_gnu_ext_elf32_symbol_version_table: multiple sections of type .gnu_versym present in file'')
    )))))"

 
(*val obtain_gnu_ext_elf64_symbol_version_table : endianness -> elf64_section_header_table -> elf64_symbol_table -> byte_sequence -> error gnu_ext_elf64_symbol_version_table*)
definition obtain_gnu_ext_elf64_symbol_version_table  :: " endianness \<Rightarrow>(elf64_section_header_table_entry)list \<Rightarrow>(elf64_symbol_table_entry)list \<Rightarrow> byte_sequence \<Rightarrow>((uint16)list)error "  where 
     " obtain_gnu_ext_elf64_symbol_version_table endian sht dynsym bs0 = (
  (let dlen = ( (List.length dynsym)) in
    if dlen =( 0 :: nat) then
      error_return []
    else
      (let vers = (List.filter (\<lambda> ent . (elf64_sh_type  
          ent) = Elf_Types_Local.uint32_of_nat sht_gnu_versym
        ) sht)
      in
        (case  vers of
            []    => error_return []
          | [ver] =>
            (let off = (unat(elf64_sh_offset     ver)) in
            (let siz = (unat(elf64_sh_size   ver)) in
            Byte_sequence.offset_and_cut off siz bs0         >>= (\<lambda> ver      . 
            Error.repeatM' dlen bs0 (read_elf64_half endian) >>= (\<lambda> (ver, _) . 
            error_return ver))))
          | _     => error_fail (''obtain_gnu_ext_elf64_symbol_version_table: multiple sections of type .gnu_versym present in file'')
        ))))"

  
record gnu_ext_elf32_verdef =
  
 gnu_ext_elf32_vd_version ::" uint16 "
   
 gnu_ext_elf32_vd_flags   ::" uint16 "
   
 gnu_ext_elf32_vd_ndx     ::" uint16 "
   
 gnu_ext_elf32_vd_cnt     ::" uint16 "
   
 gnu_ext_elf32_vd_hash    ::" uint32 "
   
 gnu_ext_elf32_vd_aux     ::" uint32 "
   
 gnu_ext_elf32_vd_next    ::" uint32 "
   

   
record gnu_ext_elf64_verdef =
  
 gnu_ext_elf64_vd_version ::" uint16 "
   
 gnu_ext_elf64_vd_flags   ::" uint16 "
   
 gnu_ext_elf64_vd_ndx     ::" uint16 "
   
 gnu_ext_elf64_vd_cnt     ::" uint16 "
   
 gnu_ext_elf64_vd_hash    ::" uint32 "
   
 gnu_ext_elf64_vd_aux     ::" uint32 "
   
 gnu_ext_elf64_vd_next    ::" uint32 "
   

   
(*val string_of_gnu_ext_elf32_verdef : gnu_ext_elf32_verdef -> string*)
  
(*val string_of_gnu_ext_elf64_verdef : gnu_ext_elf64_verdef -> string*)
   
(*val read_gnu_ext_elf32_verdef : endianness -> byte_sequence -> error (gnu_ext_elf32_verdef * byte_sequence)*)
definition read_gnu_ext_elf32_verdef  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>(gnu_ext_elf32_verdef*byte_sequence)error "  where 
     " read_gnu_ext_elf32_verdef endian bs0 = (
  read_elf32_half endian bs0 >>= (\<lambda> (ver, bs0) . 
  read_elf32_half endian bs0 >>= (\<lambda> (flg, bs0) . 
  read_elf32_half endian bs0 >>= (\<lambda> (ndx, bs0) . 
  read_elf32_half endian bs0 >>= (\<lambda> (cnt, bs0) . 
  read_elf32_word endian bs0 >>= (\<lambda> (hsh, bs0) . 
  read_elf32_word endian bs0 >>= (\<lambda> (aux, bs0) . 
  read_elf32_word endian bs0 >>= (\<lambda> (nxt, bs0) . 
    error_return ((| gnu_ext_elf32_vd_version = ver, gnu_ext_elf32_vd_flags = flg,
      gnu_ext_elf32_vd_ndx = ndx, gnu_ext_elf32_vd_cnt = cnt,
        gnu_ext_elf32_vd_hash = hsh, gnu_ext_elf32_vd_aux = aux,
      gnu_ext_elf32_vd_next = nxt |), bs0)))))))))"

      
(*val read_gnu_ext_elf64_verdef : endianness -> byte_sequence -> error (gnu_ext_elf64_verdef * byte_sequence)*)
definition read_gnu_ext_elf64_verdef  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>(gnu_ext_elf64_verdef*byte_sequence)error "  where 
     " read_gnu_ext_elf64_verdef endian bs0 = (
  read_elf64_half endian bs0 >>= (\<lambda> (ver, bs0) . 
  read_elf64_half endian bs0 >>= (\<lambda> (flg, bs0) . 
  read_elf64_half endian bs0 >>= (\<lambda> (ndx, bs0) . 
  read_elf64_half endian bs0 >>= (\<lambda> (cnt, bs0) . 
  read_elf64_word endian bs0 >>= (\<lambda> (hsh, bs0) . 
  read_elf64_word endian bs0 >>= (\<lambda> (aux, bs0) . 
  read_elf64_word endian bs0 >>= (\<lambda> (nxt, bs0) . 
    error_return ((| gnu_ext_elf64_vd_version = ver, gnu_ext_elf64_vd_flags = flg,
      gnu_ext_elf64_vd_ndx = ndx, gnu_ext_elf64_vd_cnt = cnt,
        gnu_ext_elf64_vd_hash = hsh, gnu_ext_elf64_vd_aux = aux,
      gnu_ext_elf64_vd_next = nxt |), bs0)))))))))"

      
(*val gnu_ext_elf32_verdef_size : natural*)
definition gnu_ext_elf32_verdef_size  :: " nat "  where 
     " gnu_ext_elf32_verdef_size = (( 160 :: nat))"

  
(*val gnu_ext_elf64_verdef_size : natural*)
definition gnu_ext_elf64_verdef_size  :: " nat "  where 
     " gnu_ext_elf64_verdef_size = (( 256 :: nat))"

   
record gnu_ext_elf32_veraux =
  
 gnu_ext_elf32_vda_name ::" uint32 "
   
 gnu_ext_elf32_vda_next ::" uint32 "
   

   
record gnu_ext_elf64_veraux =
  
 gnu_ext_elf64_vda_name ::" uint32 "
   
 gnu_ext_elf64_vda_next ::" uint32 "
   

   
(*val gnu_ext_elf32_veraux_size : natural*)
definition gnu_ext_elf32_veraux_size  :: " nat "  where 
     " gnu_ext_elf32_veraux_size = (( 64 :: nat))"


(*val gnu_ext_elf64_veraux_size : natural*)
definition gnu_ext_elf64_veraux_size  :: " nat "  where 
     " gnu_ext_elf64_veraux_size = (( 128 :: nat))"

   
(*val read_gnu_ext_elf32_veraux : endianness -> byte_sequence -> error (gnu_ext_elf32_veraux * byte_sequence)*)
definition read_gnu_ext_elf32_veraux  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>(gnu_ext_elf32_veraux*byte_sequence)error "  where 
     " read_gnu_ext_elf32_veraux endian bs0 = (
  read_elf32_word endian bs0 >>= (\<lambda> (nme, bs0) . 
  read_elf32_word endian bs0 >>= (\<lambda> (nxt, bs0) . 
    error_return ((| gnu_ext_elf32_vda_name = nme, gnu_ext_elf32_vda_next = nxt |), bs0))))"

    
(*val read_gnu_ext_elf64_veraux : endianness -> byte_sequence -> error (gnu_ext_elf64_veraux * byte_sequence)*)
definition read_gnu_ext_elf64_veraux  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>(gnu_ext_elf64_veraux*byte_sequence)error "  where 
     " read_gnu_ext_elf64_veraux endian bs0 = (
  read_elf64_word endian bs0 >>= (\<lambda> (nme, bs0) . 
  read_elf64_word endian bs0 >>= (\<lambda> (nxt, bs0) . 
    error_return ((| gnu_ext_elf64_vda_name = nme, gnu_ext_elf64_vda_next = nxt |), bs0))))"

   
record gnu_ext_elf32_verneed =
  
 gnu_ext_elf32_vn_version ::" uint16 "
   
 gnu_ext_elf32_vn_cnt     ::" uint16 "
   
 gnu_ext_elf32_vn_file    ::" uint32 "
   
 gnu_ext_elf32_vn_aux     ::" uint32 "
   
 gnu_ext_elf32_vn_next    ::" uint32 "
   

   
record gnu_ext_elf64_verneed =
  
 gnu_ext_elf64_vn_version ::" uint16 "
   
 gnu_ext_elf64_vn_cnt     ::" uint16 "
   
 gnu_ext_elf64_vn_file    ::" uint32 "
   
 gnu_ext_elf64_vn_aux     ::" uint32 "
   
 gnu_ext_elf64_vn_next    ::" uint32 "
   

   
(*val gnu_ext_elf32_verneed_size : natural*)
definition gnu_ext_elf32_verneed_size  :: " nat "  where 
     " gnu_ext_elf32_verneed_size = (( 128 :: nat))"


(*val gnu_ext_elf64_verneed_size : natural*)
definition gnu_ext_elf64_verneed_size  :: " nat "  where 
     " gnu_ext_elf64_verneed_size = (( 224 :: nat))"

   
(*val read_gnu_ext_elf32_verneed : endianness -> byte_sequence -> error (gnu_ext_elf32_verneed * byte_sequence)*)
definition read_gnu_ext_elf32_verneed  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>(gnu_ext_elf32_verneed*byte_sequence)error "  where 
     " read_gnu_ext_elf32_verneed endian bs0 = (
  read_elf32_half endian bs0 >>= (\<lambda> (ver, bs0) . 
  read_elf32_half endian bs0 >>= (\<lambda> (cnt, bs0) . 
  read_elf32_word endian bs0 >>= (\<lambda> (fle, bs0) . 
  read_elf32_word endian bs0 >>= (\<lambda> (aux, bs0) . 
  read_elf32_word endian bs0 >>= (\<lambda> (nxt, bs0) . 
    error_return ((| gnu_ext_elf32_vn_version = ver, gnu_ext_elf32_vn_cnt = cnt,
      gnu_ext_elf32_vn_file = fle, gnu_ext_elf32_vn_aux = aux,
        gnu_ext_elf32_vn_next = nxt |), bs0)))))))"


(*val read_gnu_ext_elf64_verneed : endianness -> byte_sequence -> error (gnu_ext_elf64_verneed * byte_sequence)*)
definition read_gnu_ext_elf64_verneed  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>(gnu_ext_elf64_verneed*byte_sequence)error "  where 
     " read_gnu_ext_elf64_verneed endian bs0 = (
  read_elf64_half endian bs0 >>= (\<lambda> (ver, bs0) . 
  read_elf64_half endian bs0 >>= (\<lambda> (cnt, bs0) . 
  read_elf64_word endian bs0 >>= (\<lambda> (fle, bs0) . 
  read_elf64_word endian bs0 >>= (\<lambda> (aux, bs0) . 
  read_elf64_word endian bs0 >>= (\<lambda> (nxt, bs0) . 
    error_return ((| gnu_ext_elf64_vn_version = ver, gnu_ext_elf64_vn_cnt = cnt,
      gnu_ext_elf64_vn_file = fle, gnu_ext_elf64_vn_aux = aux,
        gnu_ext_elf64_vn_next = nxt |), bs0)))))))"

   
record gnu_ext_elf32_vernaux =
  
 gnu_ext_elf32_vna_hash  ::" uint32 "
   
 gnu_ext_elf32_vna_flags ::" uint16 "
   
 gnu_ext_elf32_vna_other ::" uint16 "
   
 gnu_ext_elf32_vna_name  ::" uint32 "
   
 gnu_ext_elf32_vna_next  ::" uint32 "
   

   
record gnu_ext_elf64_vernaux =
  
 gnu_ext_elf64_vna_hash  ::" uint32 "
   
 gnu_ext_elf64_vna_flags ::" uint16 "
   
 gnu_ext_elf64_vna_other ::" uint16 "
   
 gnu_ext_elf64_vna_name  ::" uint32 "
   
 gnu_ext_elf64_vna_next  ::" uint32 "
   

   
(*val string_of_gnu_ext_elf32_vernaux : gnu_ext_elf32_vernaux -> string*)
  
(*val string_of_gnu_ext_elf64_vernaux : gnu_ext_elf64_vernaux -> string*)
   
(*val gnu_ext_elf32_vernaux_size : natural*)
definition gnu_ext_elf32_vernaux_size  :: " nat "  where 
     " gnu_ext_elf32_vernaux_size = (( 16 :: nat))"


(*val gnu_ext_elf64_vernaux_size : natural*)
definition gnu_ext_elf64_vernaux_size  :: " nat "  where 
     " gnu_ext_elf64_vernaux_size = (( 224 :: nat))"

   
(*val read_gnu_ext_elf32_vernaux : endianness -> byte_sequence -> error (gnu_ext_elf32_vernaux * byte_sequence)*)
definition read_gnu_ext_elf32_vernaux  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>(gnu_ext_elf32_vernaux*byte_sequence)error "  where 
     " read_gnu_ext_elf32_vernaux endian bs0 = (
  read_elf32_word endian bs0 >>= (\<lambda> (hsh, bs0) . 
  read_elf32_half endian bs0 >>= (\<lambda> (flg, bs0) . 
  read_elf32_half endian bs0 >>= (\<lambda> (otr, bs0) . 
  read_elf32_word endian bs0 >>= (\<lambda> (nme, bs0) . 
  read_elf32_word endian bs0 >>= (\<lambda> (nxt, bs0) . 
    error_return ((| gnu_ext_elf32_vna_hash = hsh, gnu_ext_elf32_vna_flags = flg,
      gnu_ext_elf32_vna_other = otr, gnu_ext_elf32_vna_name = nme,
    gnu_ext_elf32_vna_next = nxt |), bs0)))))))"


(*val read_gnu_ext_elf64_vernaux : endianness -> byte_sequence -> error (gnu_ext_elf64_vernaux * byte_sequence)*)
definition read_gnu_ext_elf64_vernaux  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>(gnu_ext_elf64_vernaux*byte_sequence)error "  where 
     " read_gnu_ext_elf64_vernaux endian bs0 = (
  read_elf64_word endian bs0 >>= (\<lambda> (hsh, bs0) . 
  read_elf64_half endian bs0 >>= (\<lambda> (flg, bs0) . 
  read_elf64_half endian bs0 >>= (\<lambda> (otr, bs0) . 
  read_elf64_word endian bs0 >>= (\<lambda> (nme, bs0) . 
  read_elf64_word endian bs0 >>= (\<lambda> (nxt, bs0) . 
    error_return ((| gnu_ext_elf64_vna_hash = hsh, gnu_ext_elf64_vna_flags = flg,
      gnu_ext_elf64_vna_other = otr, gnu_ext_elf64_vna_name = nme,
    gnu_ext_elf64_vna_next = nxt |), bs0)))))))"

end