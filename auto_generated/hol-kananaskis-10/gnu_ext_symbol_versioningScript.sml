(*Generated by Lem from gnu_extensions/gnu_ext_symbol_versioning.lem.*)
open HolKernel Parse boolLib bossLib;
open lem_numTheory lem_listTheory lem_basic_classesTheory lem_boolTheory lem_maybeTheory lem_stringTheory showTheory missing_pervasivesTheory errorTheory byte_sequenceTheory endiannessTheory elf_types_native_uintTheory elf_headerTheory elf_section_header_tableTheory elf_symbol_tableTheory elf_fileTheory elf_dynamicTheory gnu_ext_dynamicTheory gnu_ext_section_header_tableTheory;

val _ = numLib.prefer_num();



val _ = new_theory "gnu_ext_symbol_versioning"

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
val _ = type_abbrev( "gnu_ext_elf32_symbol_version_table" , ``: uint16
  list``);
  
val _ = type_abbrev( "gnu_ext_elf64_symbol_version_table" , ``: uint16
  list``);

(*val obtain_gnu_ext_elf32_symbol_version_table : elf32_file -> byte_sequence -> error gnu_ext_elf32_symbol_version_table*)
val _ = Define `
 (obtain_gnu_ext_elf32_symbol_version_table f1 bs0=  
 (let sht = (f1.elf32_file_section_header_table) in
  let endian = (get_elf32_header_endianness f1.elf32_file_header) in
  let vers = (FILTER (\ ent . 
    ent.elf32_sh_type = (n2w : num -> uint32) sht_gnu_versym
  ) sht)
  in
    (case vers of
        []    => return []
      | [ver] =>
        let off = (w2n  ver.elf32_sh_offset) in
        let siz = (w2n ver.elf32_sh_size) in
        let lnk = (w2n ver.elf32_sh_link) in
        get_elf32_symbol_table_by_index f1 lnk >>= (\ symtab . 
        let dlen = (((LENGTH symtab):num)) in
        byte_sequence$offset_and_cut off siz bs0         >>= (\ ver      . 
        error$repeatM' dlen bs0 (read_elf32_half endian) >>= 
  (\p .  (case (p ) of ( (ver, _) ) => return ver ))))
      | _     => fail0 "obtain_gnu_ext_elf32_symbol_version_table: multiple sections of type .gnu_versym present in file"
    )))`;

 
(*val obtain_gnu_ext_elf64_symbol_version_table : endianness -> elf64_section_header_table -> elf64_symbol_table -> byte_sequence -> error gnu_ext_elf64_symbol_version_table*)
val _ = Define `
 (obtain_gnu_ext_elf64_symbol_version_table endian sht dynsym bs0=  
 (let dlen = (((LENGTH dynsym):num)) in
    if dlen =( 0:num) then
      return []
    else
      let vers = (FILTER (\ ent . 
          ent.elf64_sh_type = (n2w : num -> uint32) sht_gnu_versym
        ) sht)
      in
        (case vers of
            []    => return []
          | [ver] =>
            let off = (w2n   ver.elf64_sh_offset) in
            let siz = (w2n ver.elf64_sh_size) in
            byte_sequence$offset_and_cut off siz bs0         >>= (\ ver      . 
            error$repeatM' dlen bs0 (read_elf64_half endian) >>= 
  (\p .  (case (p ) of ( (ver, _) ) => return ver )))
          | _     => fail0 "obtain_gnu_ext_elf64_symbol_version_table: multiple sections of type .gnu_versym present in file"
        )))`;

  
val _ = Hol_datatype `
 gnu_ext_elf32_verdef =
  <| gnu_ext_elf32_vd_version : uint16
   ; gnu_ext_elf32_vd_flags   : uint16
   ; gnu_ext_elf32_vd_ndx     : uint16
   ; gnu_ext_elf32_vd_cnt     : uint16
   ; gnu_ext_elf32_vd_hash    : uint32
   ; gnu_ext_elf32_vd_aux     : uint32
   ; gnu_ext_elf32_vd_next    : uint32
   |>`;

   
val _ = Hol_datatype `
 gnu_ext_elf64_verdef =
  <| gnu_ext_elf64_vd_version : uint16
   ; gnu_ext_elf64_vd_flags   : uint16
   ; gnu_ext_elf64_vd_ndx     : uint16
   ; gnu_ext_elf64_vd_cnt     : uint16
   ; gnu_ext_elf64_vd_hash    : uint32
   ; gnu_ext_elf64_vd_aux     : uint32
   ; gnu_ext_elf64_vd_next    : uint32
   |>`;

   
(*val string_of_gnu_ext_elf32_verdef : gnu_ext_elf32_verdef -> string*)
  
(*val string_of_gnu_ext_elf64_verdef : gnu_ext_elf64_verdef -> string*)
   
(*val read_gnu_ext_elf32_verdef : endianness -> byte_sequence -> error (gnu_ext_elf32_verdef * byte_sequence)*)
val _ = Define `
 (read_gnu_ext_elf32_verdef endian bs0=  
 (read_elf32_half endian bs0 >>= (\ (ver, bs0) . 
  read_elf32_half endian bs0 >>= (\ (flg, bs0) . 
  read_elf32_half endian bs0 >>= (\ (ndx, bs0) . 
  read_elf32_half endian bs0 >>= (\ (cnt, bs0) . 
  read_elf32_word endian bs0 >>= (\ (hsh, bs0) . 
  read_elf32_word endian bs0 >>= (\ (aux, bs0) . 
  read_elf32_word endian bs0 >>= (\ (nxt, bs0) . 
    return (<| gnu_ext_elf32_vd_version := ver; gnu_ext_elf32_vd_flags := flg;
      gnu_ext_elf32_vd_ndx := ndx; gnu_ext_elf32_vd_cnt := cnt;
        gnu_ext_elf32_vd_hash := hsh; gnu_ext_elf32_vd_aux := aux;
      gnu_ext_elf32_vd_next := nxt |>, bs0))))))))))`;

      
(*val read_gnu_ext_elf64_verdef : endianness -> byte_sequence -> error (gnu_ext_elf64_verdef * byte_sequence)*)
val _ = Define `
 (read_gnu_ext_elf64_verdef endian bs0=  
 (read_elf64_half endian bs0 >>= (\ (ver, bs0) . 
  read_elf64_half endian bs0 >>= (\ (flg, bs0) . 
  read_elf64_half endian bs0 >>= (\ (ndx, bs0) . 
  read_elf64_half endian bs0 >>= (\ (cnt, bs0) . 
  read_elf64_word endian bs0 >>= (\ (hsh, bs0) . 
  read_elf64_word endian bs0 >>= (\ (aux, bs0) . 
  read_elf64_word endian bs0 >>= (\ (nxt, bs0) . 
    return (<| gnu_ext_elf64_vd_version := ver; gnu_ext_elf64_vd_flags := flg;
      gnu_ext_elf64_vd_ndx := ndx; gnu_ext_elf64_vd_cnt := cnt;
        gnu_ext_elf64_vd_hash := hsh; gnu_ext_elf64_vd_aux := aux;
      gnu_ext_elf64_vd_next := nxt |>, bs0))))))))))`;

      
(*val gnu_ext_elf32_verdef_size : natural*)
val _ = Define `
 (gnu_ext_elf32_verdef_size= (( 160:num)))`;

  
(*val gnu_ext_elf64_verdef_size : natural*)
val _ = Define `
 (gnu_ext_elf64_verdef_size= (( 256:num)))`;

   
val _ = Hol_datatype `
 gnu_ext_elf32_veraux =
  <| gnu_ext_elf32_vda_name : uint32
   ; gnu_ext_elf32_vda_next : uint32
   |>`;

   
val _ = Hol_datatype `
 gnu_ext_elf64_veraux =
  <| gnu_ext_elf64_vda_name : uint32
   ; gnu_ext_elf64_vda_next : uint32
   |>`;

   
(*val gnu_ext_elf32_veraux_size : natural*)
val _ = Define `
 (gnu_ext_elf32_veraux_size= (( 64:num)))`;


(*val gnu_ext_elf64_veraux_size : natural*)
val _ = Define `
 (gnu_ext_elf64_veraux_size= (( 128:num)))`;

   
(*val read_gnu_ext_elf32_veraux : endianness -> byte_sequence -> error (gnu_ext_elf32_veraux * byte_sequence)*)
val _ = Define `
 (read_gnu_ext_elf32_veraux endian bs0=  
 (read_elf32_word endian bs0 >>= (\ (nme, bs0) . 
  read_elf32_word endian bs0 >>= (\ (nxt, bs0) . 
    return (<| gnu_ext_elf32_vda_name := nme; gnu_ext_elf32_vda_next := nxt |>, bs0)))))`;

    
(*val read_gnu_ext_elf64_veraux : endianness -> byte_sequence -> error (gnu_ext_elf64_veraux * byte_sequence)*)
val _ = Define `
 (read_gnu_ext_elf64_veraux endian bs0=  
 (read_elf64_word endian bs0 >>= (\ (nme, bs0) . 
  read_elf64_word endian bs0 >>= (\ (nxt, bs0) . 
    return (<| gnu_ext_elf64_vda_name := nme; gnu_ext_elf64_vda_next := nxt |>, bs0)))))`;

   
val _ = Hol_datatype `
 gnu_ext_elf32_verneed =
  <| gnu_ext_elf32_vn_version : uint16
   ; gnu_ext_elf32_vn_cnt     : uint16
   ; gnu_ext_elf32_vn_file    : uint32
   ; gnu_ext_elf32_vn_aux     : uint32
   ; gnu_ext_elf32_vn_next    : uint32
   |>`;

   
val _ = Hol_datatype `
 gnu_ext_elf64_verneed =
  <| gnu_ext_elf64_vn_version : uint16
   ; gnu_ext_elf64_vn_cnt     : uint16
   ; gnu_ext_elf64_vn_file    : uint32
   ; gnu_ext_elf64_vn_aux     : uint32
   ; gnu_ext_elf64_vn_next    : uint32
   |>`;

   
(*val gnu_ext_elf32_verneed_size : natural*)
val _ = Define `
 (gnu_ext_elf32_verneed_size= (( 128:num)))`;


(*val gnu_ext_elf64_verneed_size : natural*)
val _ = Define `
 (gnu_ext_elf64_verneed_size= (( 224:num)))`;

   
(*val read_gnu_ext_elf32_verneed : endianness -> byte_sequence -> error (gnu_ext_elf32_verneed * byte_sequence)*)
val _ = Define `
 (read_gnu_ext_elf32_verneed endian bs0=  
 (read_elf32_half endian bs0 >>= (\ (ver, bs0) . 
  read_elf32_half endian bs0 >>= (\ (cnt, bs0) . 
  read_elf32_word endian bs0 >>= (\ (fle, bs0) . 
  read_elf32_word endian bs0 >>= (\ (aux, bs0) . 
  read_elf32_word endian bs0 >>= (\ (nxt, bs0) . 
    return (<| gnu_ext_elf32_vn_version := ver; gnu_ext_elf32_vn_cnt := cnt;
      gnu_ext_elf32_vn_file := fle; gnu_ext_elf32_vn_aux := aux;
        gnu_ext_elf32_vn_next := nxt |>, bs0))))))))`;


(*val read_gnu_ext_elf64_verneed : endianness -> byte_sequence -> error (gnu_ext_elf64_verneed * byte_sequence)*)
val _ = Define `
 (read_gnu_ext_elf64_verneed endian bs0=  
 (read_elf64_half endian bs0 >>= (\ (ver, bs0) . 
  read_elf64_half endian bs0 >>= (\ (cnt, bs0) . 
  read_elf64_word endian bs0 >>= (\ (fle, bs0) . 
  read_elf64_word endian bs0 >>= (\ (aux, bs0) . 
  read_elf64_word endian bs0 >>= (\ (nxt, bs0) . 
    return (<| gnu_ext_elf64_vn_version := ver; gnu_ext_elf64_vn_cnt := cnt;
      gnu_ext_elf64_vn_file := fle; gnu_ext_elf64_vn_aux := aux;
        gnu_ext_elf64_vn_next := nxt |>, bs0))))))))`;

   
val _ = Hol_datatype `
 gnu_ext_elf32_vernaux =
  <| gnu_ext_elf32_vna_hash  : uint32
   ; gnu_ext_elf32_vna_flags : uint16
   ; gnu_ext_elf32_vna_other : uint16
   ; gnu_ext_elf32_vna_name  : uint32
   ; gnu_ext_elf32_vna_next  : uint32
   |>`;

   
val _ = Hol_datatype `
 gnu_ext_elf64_vernaux =
  <| gnu_ext_elf64_vna_hash  : uint32
   ; gnu_ext_elf64_vna_flags : uint16
   ; gnu_ext_elf64_vna_other : uint16
   ; gnu_ext_elf64_vna_name  : uint32
   ; gnu_ext_elf64_vna_next  : uint32
   |>`;

   
(*val string_of_gnu_ext_elf32_vernaux : gnu_ext_elf32_vernaux -> string*)
  
(*val string_of_gnu_ext_elf64_vernaux : gnu_ext_elf64_vernaux -> string*)
   
(*val gnu_ext_elf32_vernaux_size : natural*)
val _ = Define `
 (gnu_ext_elf32_vernaux_size= (( 16:num)))`;


(*val gnu_ext_elf64_vernaux_size : natural*)
val _ = Define `
 (gnu_ext_elf64_vernaux_size= (( 224:num)))`;

   
(*val read_gnu_ext_elf32_vernaux : endianness -> byte_sequence -> error (gnu_ext_elf32_vernaux * byte_sequence)*)
val _ = Define `
 (read_gnu_ext_elf32_vernaux endian bs0=  
 (read_elf32_word endian bs0 >>= (\ (hsh, bs0) . 
  read_elf32_half endian bs0 >>= (\ (flg, bs0) . 
  read_elf32_half endian bs0 >>= (\ (otr, bs0) . 
  read_elf32_word endian bs0 >>= (\ (nme, bs0) . 
  read_elf32_word endian bs0 >>= (\ (nxt, bs0) . 
    return (<| gnu_ext_elf32_vna_hash := hsh; gnu_ext_elf32_vna_flags := flg;
      gnu_ext_elf32_vna_other := otr; gnu_ext_elf32_vna_name := nme;
    gnu_ext_elf32_vna_next := nxt |>, bs0))))))))`;


(*val read_gnu_ext_elf64_vernaux : endianness -> byte_sequence -> error (gnu_ext_elf64_vernaux * byte_sequence)*)
val _ = Define `
 (read_gnu_ext_elf64_vernaux endian bs0=  
 (read_elf64_word endian bs0 >>= (\ (hsh, bs0) . 
  read_elf64_half endian bs0 >>= (\ (flg, bs0) . 
  read_elf64_half endian bs0 >>= (\ (otr, bs0) . 
  read_elf64_word endian bs0 >>= (\ (nme, bs0) . 
  read_elf64_word endian bs0 >>= (\ (nxt, bs0) . 
    return (<| gnu_ext_elf64_vna_hash := hsh; gnu_ext_elf64_vna_flags := flg;
      gnu_ext_elf64_vna_other := otr; gnu_ext_elf64_vna_name := nme;
    gnu_ext_elf64_vna_next := nxt |>, bs0))))))))`;

val _ = export_theory()
