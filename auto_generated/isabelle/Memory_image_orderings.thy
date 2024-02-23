chapter {* Generated by Lem from memory_image_orderings.lem. *}

theory "Memory_image_orderings" 

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
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_assert_extra" 
	 "Show" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_sorting" 
	 "Missing_pervasives" 
	 "Byte_sequence" 
	 "Elf_types_native_uint" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_tuple" 
	 "Elf_header" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_map" 
	 "Elf_program_header_table" 
	 "Elf_section_header_table" 
	 "Elf_interpreted_section" 
	 "Elf_interpreted_segment" 
	 "Elf_symbol_table" 
	 "Elf_file" 
	 "Elf_relocation" 
	 "Multimap" 
	 "Memory_image" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abi_classes" 

begin 

(*open import Basic_classes*)
(*open import Function*)
(*open import String*)
(*open import Tuple*)
(*open import Bool*)
(*open import List*)
(*open import Sorting*)
(*open import Map*)
(*open import Set*)
(*open import Multimap*)
(*open import Num*)
(*open import Maybe*)
(*open import Assert_extra*)
(*open import Show*)

(*open import Byte_sequence*)
(*open import Elf_file*)
(*open import Elf_header*)
(*open import Elf_interpreted_segment*)
(*open import Elf_interpreted_section*)
(*open import Elf_program_header_table*)
(*open import Elf_section_header_table*)
(*open import Elf_symbol_table*)
(*open import Elf_types_native_uint*)
(*open import Elf_relocation*)
(*open import Memory_image*)
(*open import Abi_classes*)
(* open import Abis *)

(*open import Missing_pervasives*)

(*val elfFileFeatureCompare : elf_file_feature -> elf_file_feature -> Basic_classes.ordering*)
fun elfFileFeatureCompare  :: " elf_file_feature \<Rightarrow> elf_file_feature \<Rightarrow> ordering "  where 
     " elfFileFeatureCompare (ElfHeader(x1)) (ElfHeader(x2)) = ( (* equal tags, so ... *) elf64_header_compare x1 x2 )"
|" elfFileFeatureCompare (ElfHeader(x1)) _ = ( LT )"
|" elfFileFeatureCompare (ElfSectionHeaderTable(x1)) (ElfHeader(x2)) = ( GT )"
|" elfFileFeatureCompare (ElfSectionHeaderTable(x1)) (ElfSectionHeaderTable(x2)) = ( ( (* equal tags, so ... *)lexicographicCompareBy compare_elf64_section_header_table_entry x1 x2))"
|" elfFileFeatureCompare (ElfSectionHeaderTable(x1)) _ = ( LT )"
|" elfFileFeatureCompare (ElfProgramHeaderTable(x1)) (ElfHeader(x2)) = ( GT )"
|" elfFileFeatureCompare (ElfProgramHeaderTable(x1)) (ElfSectionHeaderTable(x2)) = ( GT )"
|" elfFileFeatureCompare (ElfProgramHeaderTable(x1)) (ElfProgramHeaderTable(x2)) = ( (lexicographicCompareBy compare_elf64_program_header_table_entry x1 x2))"
|" elfFileFeatureCompare (ElfProgramHeaderTable(x1)) _ = ( LT )"
|" elfFileFeatureCompare (ElfSection(x1)) (ElfHeader(x2)) = ( GT )"
|" elfFileFeatureCompare (ElfSection(x1)) (ElfSectionHeaderTable(x2)) = ( GT )"
|" elfFileFeatureCompare (ElfSection(x1)) (ElfProgramHeaderTable(x2)) = ( GT )"
|" elfFileFeatureCompare (ElfSection(x1)) (ElfSection(x2)) = ( (pairCompare (genericCompare (op<) (op=)) compare_elf64_interpreted_section x1 x2))"
|" elfFileFeatureCompare (ElfSection(x1)) _ = ( LT )"
|" elfFileFeatureCompare (ElfSegment(x1)) (ElfHeader(x2)) = ( GT )"
|" elfFileFeatureCompare (ElfSegment(x1)) (ElfSectionHeaderTable(x2)) = ( GT )"
|" elfFileFeatureCompare (ElfSegment(x1)) (ElfProgramHeaderTable(x2)) = ( GT )"
|" elfFileFeatureCompare (ElfSegment(x1)) (ElfSection(x2)) = ( GT )"
|" elfFileFeatureCompare (ElfSegment(x1)) (ElfSegment(x2)) = ( (pairCompare (genericCompare (op<) (op=)) compare_elf64_interpreted_segment x1 x2))" 
declare elfFileFeatureCompare.simps [simp del]


(*val elfFileFeatureTagEquiv : elf_file_feature -> elf_file_feature -> bool*)
fun elfFileFeatureTagEquiv  :: " elf_file_feature \<Rightarrow> elf_file_feature \<Rightarrow> bool "  where 
     " elfFileFeatureTagEquiv (ElfHeader(x1)) (ElfHeader(x2)) = ( (* equal tags, so ... *) True )"
|" elfFileFeatureTagEquiv (ElfSectionHeaderTable(x1)) (ElfSectionHeaderTable(x2)) = ( True )"
|" elfFileFeatureTagEquiv (ElfProgramHeaderTable(x1)) (ElfProgramHeaderTable(x2)) = ( True )"
|" elfFileFeatureTagEquiv (ElfSection(x1)) (ElfSection(x2)) = ( True )"
|" elfFileFeatureTagEquiv (ElfSegment(x1)) (ElfSegment(x2)) = ( True )"
|" elfFileFeatureTagEquiv _ _ = ( False )" 
declare elfFileFeatureTagEquiv.simps [simp del]


definition instance_Basic_classes_Ord_Memory_image_elf_file_feature_dict  :: "(elf_file_feature)Ord_class "  where 
     " instance_Basic_classes_Ord_Memory_image_elf_file_feature_dict = ((|

  compare_method = elfFileFeatureCompare,

  isLess_method = (\<lambda> f1 .  (\<lambda> f2 .  (elfFileFeatureCompare f1 f2 = LT))),

  isLessEqual_method = (\<lambda> f1 .  (\<lambda> f2 .  (op \<in>) (elfFileFeatureCompare f1 f2) ({LT, EQ}))),

  isGreater_method = (\<lambda> f1 .  (\<lambda> f2 .  (elfFileFeatureCompare f1 f2 = GT))),

  isGreaterEqual_method = (\<lambda> f1 .  (\<lambda> f2 .  (op \<in>) (elfFileFeatureCompare f1 f2) ({GT, EQ})))|) )"


(*val tagCompare : forall 'abifeature. Ord 'abifeature =>
    range_tag 'abifeature -> range_tag 'abifeature -> Basic_classes.ordering*)
fun tagCompare  :: " 'abifeature Ord_class \<Rightarrow> 'abifeature range_tag \<Rightarrow> 'abifeature range_tag \<Rightarrow> ordering "  where 
     " tagCompare dict_Basic_classes_Ord_abifeature ImageBase ImageBase = ( EQ )"
|" tagCompare dict_Basic_classes_Ord_abifeature ImageBase _ = ( LT )"
|" tagCompare dict_Basic_classes_Ord_abifeature EntryPoint ImageBase = ( GT )"
|" tagCompare dict_Basic_classes_Ord_abifeature EntryPoint EntryPoint = ( EQ )"
|" tagCompare dict_Basic_classes_Ord_abifeature EntryPoint _ = ( LT )"
|" tagCompare dict_Basic_classes_Ord_abifeature (SymbolDef(_)) ImageBase = ( GT )"
|" tagCompare dict_Basic_classes_Ord_abifeature (SymbolDef(_)) EntryPoint = ( GT )"
|" tagCompare dict_Basic_classes_Ord_abifeature (SymbolDef(x1)) (SymbolDef(x2)) = ( symDefCompare x1 x2 )"
|" tagCompare dict_Basic_classes_Ord_abifeature (SymbolDef(_)) _ = ( LT )"
|" tagCompare dict_Basic_classes_Ord_abifeature (SymbolRef(_)) ImageBase = ( GT )"
|" tagCompare dict_Basic_classes_Ord_abifeature (SymbolRef(_)) EntryPoint = ( GT )"
|" tagCompare dict_Basic_classes_Ord_abifeature (SymbolRef(_)) (SymbolDef(_)) = ( GT )"
|" tagCompare dict_Basic_classes_Ord_abifeature (SymbolRef(x1)) (SymbolRef(x2)) = ( symRefAndRelocSiteCompare x1 x2 )"
|" tagCompare dict_Basic_classes_Ord_abifeature (SymbolRef(_)) _ = ( LT )"
|" tagCompare dict_Basic_classes_Ord_abifeature (FileFeature(_)) ImageBase = ( GT )"
|" tagCompare dict_Basic_classes_Ord_abifeature (FileFeature(_)) EntryPoint = ( GT )"
|" tagCompare dict_Basic_classes_Ord_abifeature (FileFeature(_)) (SymbolDef(_)) = ( GT )"
|" tagCompare dict_Basic_classes_Ord_abifeature (FileFeature(_)) (SymbolRef(_)) = ( GT )"
|" tagCompare dict_Basic_classes_Ord_abifeature (FileFeature(x1)) (FileFeature(x2)) = ( elfFileFeatureCompare x1 x2 )"
|" tagCompare dict_Basic_classes_Ord_abifeature (FileFeature(_)) _ = ( LT )"
|" tagCompare dict_Basic_classes_Ord_abifeature (AbiFeature(_)) ImageBase = ( GT )"
|" tagCompare dict_Basic_classes_Ord_abifeature (AbiFeature(_)) EntryPoint = ( GT )"
|" tagCompare dict_Basic_classes_Ord_abifeature (AbiFeature(_)) (SymbolDef(_)) = ( GT )"
|" tagCompare dict_Basic_classes_Ord_abifeature (AbiFeature(_)) (SymbolRef(_)) = ( GT )"
|" tagCompare dict_Basic_classes_Ord_abifeature (AbiFeature(_)) (FileFeature(_)) = ( GT )"
|" tagCompare dict_Basic_classes_Ord_abifeature (AbiFeature(x1)) (AbiFeature(x2)) = (
  (compare_method   dict_Basic_classes_Ord_abifeature) x1 x2 )" 
declare tagCompare.simps [simp del]


definition instance_Basic_classes_Ord_Memory_image_range_tag_dict  :: " 'abifeature Ord_class \<Rightarrow>('abifeature range_tag)Ord_class "  where 
     " instance_Basic_classes_Ord_Memory_image_range_tag_dict dict_Basic_classes_Ord_abifeature = ((|

  compare_method = 
  (tagCompare dict_Basic_classes_Ord_abifeature),

  isLess_method = (\<lambda> tag1 .  (\<lambda> tag2 .  (tagCompare 
  dict_Basic_classes_Ord_abifeature tag1 tag2 = LT))),

  isLessEqual_method = (\<lambda> tag1 .  (\<lambda> tag2 .  (op \<in>) (tagCompare 
  dict_Basic_classes_Ord_abifeature tag1 tag2) ({LT, EQ}))),

  isGreater_method = (\<lambda> tag1 .  (\<lambda> tag2 .  (tagCompare 
  dict_Basic_classes_Ord_abifeature tag1 tag2 = GT))),

  isGreaterEqual_method = (\<lambda> tag1 .  (\<lambda> tag2 .  (op \<in>) (tagCompare 
  dict_Basic_classes_Ord_abifeature tag1 tag2) ({GT, EQ})))|) )"


(*val tagEquiv : forall 'abifeature. AbiFeatureTagEquiv 'abifeature => range_tag 'abifeature -> range_tag 'abifeature -> bool*)
fun tagEquiv  :: " 'abifeature AbiFeatureTagEquiv_class \<Rightarrow> 'abifeature range_tag \<Rightarrow> 'abifeature range_tag \<Rightarrow> bool "  where 
     " tagEquiv dict_Abi_classes_AbiFeatureTagEquiv_abifeature ImageBase ImageBase = ( True )"
|" tagEquiv dict_Abi_classes_AbiFeatureTagEquiv_abifeature EntryPoint EntryPoint = ( True )"
|" tagEquiv dict_Abi_classes_AbiFeatureTagEquiv_abifeature (SymbolDef(x1)) (SymbolDef(x2)) = ( True )"
|" tagEquiv dict_Abi_classes_AbiFeatureTagEquiv_abifeature (SymbolRef(_)) (SymbolRef(_)) = ( True )"
|" tagEquiv dict_Abi_classes_AbiFeatureTagEquiv_abifeature (FileFeature(x1)) (FileFeature(x2)) = ( elfFileFeatureTagEquiv x1 x2 )"
|" tagEquiv dict_Abi_classes_AbiFeatureTagEquiv_abifeature (AbiFeature(x1)) (AbiFeature(x2)) = (
  (abiFeatureTagEquiv_method   dict_Abi_classes_AbiFeatureTagEquiv_abifeature) x1 x2 )"
|" tagEquiv dict_Abi_classes_AbiFeatureTagEquiv_abifeature _ _ = ( False )" 
declare tagEquiv.simps [simp del]


(* ------- end of Ord / compare / ConstructorToNaturalList functions *)


(*val unique_tag_matching : forall 'abifeature. Ord 'abifeature, AbiFeatureTagEquiv 'abifeature => range_tag 'abifeature -> annotated_memory_image 'abifeature -> range_tag 'abifeature*)
definition unique_tag_matching  :: " 'abifeature Ord_class \<Rightarrow> 'abifeature AbiFeatureTagEquiv_class \<Rightarrow> 'abifeature range_tag \<Rightarrow> 'abifeature annotated_memory_image \<Rightarrow> 'abifeature range_tag "  where 
     " unique_tag_matching dict_Basic_classes_Ord_abifeature dict_Abi_classes_AbiFeatureTagEquiv_abifeature tag img3 = ( 
    (case  Multimap.lookupBy0 
  (instance_Basic_classes_Ord_Memory_image_range_tag_dict
     dict_Basic_classes_Ord_abifeature) (instance_Basic_classes_Ord_Maybe_maybe_dict
   (instance_Basic_classes_Ord_tup2_dict
      Lem_string_extra.instance_Basic_classes_Ord_string_dict
      (instance_Basic_classes_Ord_tup2_dict
         instance_Basic_classes_Ord_Num_natural_dict
         instance_Basic_classes_Ord_Num_natural_dict)))  (tagEquiv dict_Abi_classes_AbiFeatureTagEquiv_abifeature) tag(by_tag   img3) of
        [] => failwith (''no tag match found'')
        | [(t, r)] => t
        | x => failwith ((''more than one tag match'')) (* (ranges:  ^ 
            (show (List.map (fun (t, r) -> r) x))
            ^  ) when asserted unique) *)
    ))"

    
(*val tagged_ranges_matching_tag : forall 'abifeature. Ord 'abifeature, AbiFeatureTagEquiv 'abifeature => range_tag 'abifeature -> annotated_memory_image 'abifeature -> list (range_tag 'abifeature * maybe element_range)*)
definition tagged_ranges_matching_tag  :: " 'abifeature Ord_class \<Rightarrow> 'abifeature AbiFeatureTagEquiv_class \<Rightarrow> 'abifeature range_tag \<Rightarrow> 'abifeature annotated_memory_image \<Rightarrow>('abifeature range_tag*(element_range)option)list "  where 
     " tagged_ranges_matching_tag dict_Basic_classes_Ord_abifeature dict_Abi_classes_AbiFeatureTagEquiv_abifeature tag img3 = ( 
    Multimap.lookupBy0 
  (instance_Basic_classes_Ord_Memory_image_range_tag_dict
     dict_Basic_classes_Ord_abifeature) (instance_Basic_classes_Ord_Maybe_maybe_dict
   (instance_Basic_classes_Ord_tup2_dict
      Lem_string_extra.instance_Basic_classes_Ord_string_dict
      (instance_Basic_classes_Ord_tup2_dict
         instance_Basic_classes_Ord_Num_natural_dict
         instance_Basic_classes_Ord_Num_natural_dict)))  (tagEquiv dict_Abi_classes_AbiFeatureTagEquiv_abifeature) tag(by_tag   img3))"


(*val element_range_compare : element_range -> element_range -> Basic_classes.ordering*)
definition element_range_compare  :: " string*(nat*nat) \<Rightarrow> string*(nat*nat) \<Rightarrow> ordering "  where 
     " element_range_compare = ( pairCompare (\<lambda> x y. EQ) (pairCompare (genericCompare (op<) (op=)) (genericCompare (op<) (op=))))"


(*val unique_tag_matching_at_range_exact : forall 'abifeature. Ord 'abifeature, AbiFeatureTagEquiv 'abifeature =>
    maybe element_range
    -> range_tag 'abifeature
    -> annotated_memory_image 'abifeature
    -> range_tag 'abifeature*)
definition unique_tag_matching_at_range_exact  :: " 'abifeature Ord_class \<Rightarrow> 'abifeature AbiFeatureTagEquiv_class \<Rightarrow>(element_range)option \<Rightarrow> 'abifeature range_tag \<Rightarrow> 'abifeature annotated_memory_image \<Rightarrow> 'abifeature range_tag "  where 
     " unique_tag_matching_at_range_exact dict_Basic_classes_Ord_abifeature dict_Abi_classes_AbiFeatureTagEquiv_abifeature r tag img3 = ( 
    (* 1. find tags a unique range labelled as ELF section header table. *)
    (let (_, (allRangeMatches :: ( 'abifeature range_tag) list)) = (list_unzip (Multimap.lookupBy0 
  (instance_Basic_classes_Ord_Maybe_maybe_dict
     (instance_Basic_classes_Ord_tup2_dict
        Lem_string_extra.instance_Basic_classes_Ord_string_dict
        (instance_Basic_classes_Ord_tup2_dict
           instance_Basic_classes_Ord_Num_natural_dict
           instance_Basic_classes_Ord_Num_natural_dict))) (instance_Basic_classes_Ord_Memory_image_range_tag_dict
   dict_Basic_classes_Ord_abifeature) (op=) r(by_range   img3)))
    in
    (let (tagAlsoMatches :: ( 'abifeature range_tag) list) = (List.filter (\<lambda> x .  tagEquiv 
  dict_Abi_classes_AbiFeatureTagEquiv_abifeature x tag) allRangeMatches)
    in
    (case  tagAlsoMatches of
        [] => failwith (''no range/tag match when asserted to exist'')
        | [x] => x
        | _ => failwith (''multiple range/tag match when asserted unique'')
    ))))"


(*val symbol_def_ranges : forall 'abifeature. Ord 'abifeature, AbiFeatureTagEquiv 'abifeature => annotated_memory_image 'abifeature -> (list (range_tag 'abifeature) * list (maybe element_range))*)
definition symbol_def_ranges  :: " 'abifeature Ord_class \<Rightarrow> 'abifeature AbiFeatureTagEquiv_class \<Rightarrow> 'abifeature annotated_memory_image \<Rightarrow>('abifeature range_tag)list*((element_range)option)list "  where 
     " symbol_def_ranges dict_Basic_classes_Ord_abifeature dict_Abi_classes_AbiFeatureTagEquiv_abifeature img3 = ( 
    (* find all element ranges labelled as ELF symbols *)
    (let (tags, maybe_ranges) = (list_unzip (
        tagged_ranges_matching_tag 
  dict_Basic_classes_Ord_abifeature dict_Abi_classes_AbiFeatureTagEquiv_abifeature (SymbolDef(null_symbol_definition)) img3
    ))
    in
    (* some symbols, specifically ABS symbols, needn't label a range. *)
    (tags, maybe_ranges)))"


(*val name_of_symbol_def : symbol_definition -> string*)
definition name_of_symbol_def  :: " symbol_definition \<Rightarrow> string "  where 
     " name_of_symbol_def sym1 = ((def_symname   sym1))"


(*val defined_symbols_and_ranges : forall 'abifeature. Ord 'abifeature, AbiFeatureTagEquiv 'abifeature => annotated_memory_image 'abifeature -> list ((maybe element_range) * symbol_definition)*)
definition defined_symbols_and_ranges  :: " 'abifeature Ord_class \<Rightarrow> 'abifeature AbiFeatureTagEquiv_class \<Rightarrow> 'abifeature annotated_memory_image \<Rightarrow>((element_range)option*symbol_definition)list "  where 
     " defined_symbols_and_ranges dict_Basic_classes_Ord_abifeature dict_Abi_classes_AbiFeatureTagEquiv_abifeature img3 = ( 
    Lem_list.mapMaybe (\<lambda> (tag, maybeRange) .  
        (case  tag of
            SymbolDef(ent) => Some (maybeRange, ent)
            | _ => failwith (''impossible: non-symbol def in list of symbol defs'')
        )) (tagged_ranges_matching_tag 
  dict_Basic_classes_Ord_abifeature dict_Abi_classes_AbiFeatureTagEquiv_abifeature (SymbolDef(null_symbol_definition)) img3))"

    
(*val make_ranges_definite : list (maybe element_range) -> list element_range*)
definition make_ranges_definite  :: "((element_range)option)list \<Rightarrow>(string*range)list "  where 
     " make_ranges_definite rs = ( 
    List.map (\<lambda> (maybeR ::  element_range option) .  (case  maybeR of
            Some r => r
            | None => failwith (''impossible: range not definite, but asserted to be'')
        )) rs )"


(*val find_defs_matching : forall 'abifeature. Ord 'abifeature, AbiFeatureTagEquiv 'abifeature => symbol_definition -> annotated_memory_image 'abifeature -> list ((maybe element_range) * symbol_definition)*)
definition find_defs_matching  :: " 'abifeature Ord_class \<Rightarrow> 'abifeature AbiFeatureTagEquiv_class \<Rightarrow> symbol_definition \<Rightarrow> 'abifeature annotated_memory_image \<Rightarrow>((element_range)option*symbol_definition)list "  where 
     " find_defs_matching dict_Basic_classes_Ord_abifeature dict_Abi_classes_AbiFeatureTagEquiv_abifeature bound_def img3 = ( 
    (let (ranges_and_defs :: ( element_range option * symbol_definition) list) = (defined_symbols_and_ranges 
  dict_Basic_classes_Ord_abifeature dict_Abi_classes_AbiFeatureTagEquiv_abifeature img3)
    in 
    (let _ = (())
    in
    Lem_list.mapMaybe (\<lambda> (maybe_some_range, some_def) .  
       (* let _ = errln (Considering one: ` ^ some_def.def_symname ^ ') in *)
       (* match maybe_some_range with
            Nothing -> failwith symbol definition not over a definite range
            | Just some_range -> *)
                (* if some_def.def_symname = bound_def.def_symname 
                && some_def.def_linkable_idx = bound_def.def_linkable_idx then
                if some_def = bound_def 
                    then Just(maybe_some_range, some_def) else Nothing*)
                    (*let _ = errln (Found one in the same linkable: syment is  ^
                        (show some_def.def_syment))
                    in*) 
                (*else*) if some_def = bound_def 
                            then (
                                (let _ = (())
                                in
                                Some(maybe_some_range, some_def))
                            )
                            else if(def_symname   some_def) =(def_symname   bound_def) then
                                (let _ = (())
                                in None)
                            else None
       (* end *)
    ) ranges_and_defs)))"



(*val defined_symbols : forall 'abifeature. Ord 'abifeature, AbiFeatureTagEquiv 'abifeature =>  annotated_memory_image 'abifeature -> list symbol_definition*)
definition defined_symbols  :: " 'abifeature Ord_class \<Rightarrow> 'abifeature AbiFeatureTagEquiv_class \<Rightarrow> 'abifeature annotated_memory_image \<Rightarrow>(symbol_definition)list "  where 
     " defined_symbols dict_Basic_classes_Ord_abifeature dict_Abi_classes_AbiFeatureTagEquiv_abifeature img3 = ( 
    (let (all_symbol_tags, all_symbol_ranges) = (symbol_def_ranges 
  dict_Basic_classes_Ord_abifeature dict_Abi_classes_AbiFeatureTagEquiv_abifeature img3) in
    Lem_list.mapMaybe (\<lambda> tag .  
        (case  tag of
            SymbolDef(ent) => Some ent
            | _ => failwith (''impossible: non-symbol def in list of symbol defs'')
        )) all_symbol_tags))"



definition default_get_reloc_symaddr  :: " 'a Ord_class \<Rightarrow> 'a AbiFeatureTagEquiv_class \<Rightarrow> symbol_definition \<Rightarrow> 'a annotated_memory_image \<Rightarrow> 'b \<Rightarrow> nat "  where 
     " default_get_reloc_symaddr dict_Basic_classes_Ord_a dict_Abi_classes_AbiFeatureTagEquiv_a bound_def_in_input output_img maybe_reloc1 = ( 
    (case  find_defs_matching 
  dict_Basic_classes_Ord_a dict_Abi_classes_AbiFeatureTagEquiv_a bound_def_in_input output_img of
        [] => failwith (([(CHR ''i''), (CHR ''n''), (CHR ''t''), (CHR ''e''), (CHR ''r''), (CHR ''n''), (CHR ''a''), (CHR ''l''), (CHR '' ''), (CHR ''e''), (CHR ''r''), (CHR ''r''), (CHR ''o''), (CHR ''r''), (CHR '':''), (CHR '' ''), (CHR ''b''), (CHR ''o''), (CHR ''u''), (CHR ''n''), (CHR ''d''), (CHR ''-''), (CHR ''t''), (CHR ''o''), (CHR '' ''), (CHR ''s''), (CHR ''y''), (CHR ''m''), (CHR ''b''), (CHR ''o''), (CHR ''l''), (CHR '' ''), (CHR ''(''), (CHR ''n''), (CHR ''a''), (CHR ''m''), (CHR ''e''), (CHR '' ''), (Char Nibble6 Nibble0)]) @ ((def_symname   bound_def_in_input) @ ([(Char Nibble2 Nibble7), (CHR '')''), (CHR '' ''), (CHR ''n''), (CHR ''o''), (CHR ''t''), (CHR '' ''), (CHR ''d''), (CHR ''e''), (CHR ''f''), (CHR ''i''), (CHR ''n''), (CHR ''e''), (CHR ''d'')])))
        | (maybe_range, d) # more1 =>
            (let v =                
 ((case  maybe_range of 
                    Some(el_name, (start, len)) =>
                    (case  element_and_offset_to_address (el_name, start) output_img of
                        Some a => a
                        | None => failwith (''internal error: could not get address for symbol'')
                    )
                    | None =>
                        (* okay, it'd better be an ABS symbol. *)
                        if unat(elf64_st_shndx  (def_syment   d)) = shn_abs
                            then unat(elf64_st_value  (def_syment   d))
                            else failwith (''no range for non-ABS symbol'')
                ))
            in
            (case  more1 of 
                [] => v
                | _ => (let _ = (())
                    in v)
            ))
    ))"

end
