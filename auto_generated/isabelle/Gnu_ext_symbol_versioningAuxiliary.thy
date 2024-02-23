chapter {* Generated by Lem from gnu_extensions/gnu_ext_symbol_versioning.lem. *}

theory "Gnu_ext_symbol_versioningAuxiliary" 

imports 
 	 Main "~~/src/HOL/Library/Code_Target_Numeral"
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
	 "Gnu_ext_symbol_versioning" 

begin 


(****************************************************)
(*                                                  *)
(* Termination Proofs                               *)
(*                                                  *)
(****************************************************)

termination read_gnu_ext_elf32_verdefs by lexicographic_order

termination read_gnu_ext_elf64_verdefs by lexicographic_order

termination obtain_gnu_ext_elf32_veraux by lexicographic_order

termination obtain_gnu_ext_elf64_veraux by lexicographic_order

termination read_gnu_ext_elf32_verneeds by lexicographic_order

termination read_gnu_ext_elf64_verneeds by lexicographic_order

termination read_gnu_ext_elf32_vernauxs by lexicographic_order

termination obtain_gnu_ext_elf32_vernaux by lexicographic_order

termination obtain_gnu_ext_elf64_vernaux by lexicographic_order



end
