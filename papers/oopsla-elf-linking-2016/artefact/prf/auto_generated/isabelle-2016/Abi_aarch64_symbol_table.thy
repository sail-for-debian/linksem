chapter {* Generated by Lem from abis/aarch64/abi_aarch64_symbol_table.lem. *}

theory "Abi_aarch64_symbol_table" 

imports 
 	 Main
	 "../../lem-libs/isabelle-lib/Lem_basic_classes" 
	 "../../lem-libs/isabelle-lib/Lem_bool" 
	 "Elf_types_native_uint" 
	 "Elf_header" 
	 "Elf_section_header_table" 
	 "Elf_symbol_table" 

begin 

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
definition is_aarch64_weak_reference  :: " elf64_symbol_table_entry \<Rightarrow> bool "  where 
     " is_aarch64_weak_reference ent = (  
(unat(elf64_st_shndx   ent) = shn_undef) \<and>    
(get_elf64_symbol_binding ent = stb_weak))"


(*val is_aarch64_weak_definition : elf64_symbol_table_entry -> bool*)
definition is_aarch64_weak_definition  :: " elf64_symbol_table_entry \<Rightarrow> bool "  where 
     " is_aarch64_weak_definition ent = ( \<not> ((unat(elf64_st_shndx   ent)) = shn_undef) \<and>    
(get_elf64_symbol_binding ent = stb_weak))"

end
