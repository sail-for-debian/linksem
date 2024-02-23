(* Generated by Lem from archive.lem. *)

Require Import Arith.
Require Import Bool.
Require Import List.
Require Import String.
Require Import Program.Wf.

Require Import coqharness.

Open Scope nat_scope.
Open Scope string_scope.

Require Import lem_basic_classes.
Require Export lem_basic_classes.

Require Import lem_bool.
Require Export lem_bool.

Require Import lem_list.
Require Export lem_list.

Require Import lem_num.
Require Export lem_num.

Require Import lem_maybe.
Require Export lem_maybe.

Require Import lem_string.
Require Export lem_string.

Require Import show.
Require Export show.

Require Import lem_assert_extra.
Require Export lem_assert_extra.


Require Import missing_pervasives.
Require Export missing_pervasives.

Require Import byte_sequence.
Require Export byte_sequence.

Require Import error.
Require Export error.


Record archive_entry_header : Type :=
  { name      : string 
   ; timestamp : nat 
   ; uid       : nat 
   ; gid       : nat 
   ; mode      : nat 
   ; size      : nat  (* 1GB should be enough *)
   }.
Notation "{[ r 'with' 'name' := e ]}" := ({| name := e; timestamp := timestamp r; uid := uid r; gid := gid r; mode := mode r; size := size r |}).
Notation "{[ r 'with' 'timestamp' := e ]}" := ({| timestamp := e; name := name r; uid := uid r; gid := gid r; mode := mode r; size := size r |}).
Notation "{[ r 'with' 'uid' := e ]}" := ({| uid := e; name := name r; timestamp := timestamp r; gid := gid r; mode := mode r; size := size r |}).
Notation "{[ r 'with' 'gid' := e ]}" := ({| gid := e; name := name r; timestamp := timestamp r; uid := uid r; mode := mode r; size := size r |}).
Notation "{[ r 'with' 'mode' := e ]}" := ({| mode := e; name := name r; timestamp := timestamp r; uid := uid r; gid := gid r; size := size r |}).
Notation "{[ r 'with' 'size' := e ]}" := ({| size := e; name := name r; timestamp := timestamp r; uid := uid r; gid := gid r; mode := mode r |}).
Definition archive_entry_header_default: archive_entry_header  := {| name := string_default; timestamp := nat_default; uid := nat_default; gid := nat_default; mode := nat_default; size := nat_default |}.

Definition archive_global_header : Type := 
  list  ascii .
Definition archive_global_header_default: archive_global_header  := DAEMON.
(* [?]: removed value specification. *)

Definition string_of_byte_sequence0  (seq : byte_sequence )  : string := 
  match ( seq) with 
    | Sequence bs => string_from_char_list (List.map char_of_byte bs)
  end.
(* [?]: removed value specification. *)

Definition read_archive_entry_header  (seq_length : nat ) (seq : byte_sequence )  : error ((archive_entry_header *nat *byte_sequence ) % type):= 
  let magic_bytes := [byte_of_nat( 96) (* 0x60 *); byte_of_nat( 10)] (* 0x0a *) in
        let header_length := 60 in
        (* let _ = Missing_pervasives.errs ("Archive entry header? " ^ (show (take 16 bs)) ^ "? ") in *)
        partition_with_length header_length seq_length seq >>= 
  (fun (p : (byte_sequence *byte_sequence ) % type) =>
     match ( (p) ) with ( (header,  rest)) =>
       offset_and_cut ( 58) ( 2) header >>=
       (fun (magic : byte_sequence ) =>
          offset_and_cut ( 0) ( 16) header >>=
          (fun (name1 : byte_sequence ) =>
             offset_and_cut ( 16) ( 12) header >>=
             (fun (timestamp_str : byte_sequence ) =>
                offset_and_cut ( 28) ( 6) header >>=
                (fun (uid_str : byte_sequence ) =>
                   offset_and_cut ( 34) ( 6) header >>=
                   (fun (gid_str : byte_sequence ) =>
                      offset_and_cut ( 40) ( 8) header >>=
                      (fun (mode_str : byte_sequence ) =>
                         offset_and_cut ( 48) ( 10) header >>=
                         (fun (size_str : byte_sequence ) =>
                            let size2 := natural_of_decimal_string
                                           (string_of_byte_sequence0 size_str) in
                            (* let _ = Missing_pervasives.errln (": yes, size " ^ (show size)) in *)
                            return0
                              ({|name := (string_of_byte_sequence0 name1);timestamp := (
                               0 : nat ) (* FIXME *) ;uid :=( 0) (* FIXME *) ;gid :=(
                               0) (* FIXME *) ;mode :=( 0) (* FIXME *) ;size := (
                              id size2) (* FIXME *) |}, Coq.Init.Peano.minus
                                                          seq_length
                                                          header_length, rest))))))))
     end).
(* [?]: removed value specification. *)

Definition read_archive_global_header  (seq : byte_sequence )  : error ((list (ascii )*byte_sequence ) % type):= 
  match ( seq) with 
    | Sequence bs =>
            (* let _ = Missing_pervasives.errs ("Archive? " ^ (show (take 16 bs)) ^ "? ")
            in*)
      let chars := List.map char_of_byte (take0( 8) bs) in 
        if (string_equal (string_from_char_list chars) "!<arch>
") then
          (* let _ = Missing_pervasives.errln ": yes" in *)
          return0 (chars, Sequence(drop0( 8) bs))
        else
          (* let _ = Missing_pervasives.errln ": no" in *)
          fail0 "read_archive_global_header: not an archive"
    end.
(* [?]: removed value specification. *)

Program Fixpoint accum_archive_contents  (accum : list ((string *byte_sequence ) % type)) (extended_filenames : option (string ) ) (whole_seq_length : nat ) (whole_seq : byte_sequence )  : error (list ((string *byte_sequence ) % type)):=  
  (* let _ = Missing_pervasives.errs "Can read a header? " in *)
  if negb (beq_nat (byte_sequence.length0 whole_seq) whole_seq_length) then
    lem_assert_extra.fail (* invariant: whole_seq_length always equal to length of whole_seq, so the length is only
      computed one.  This "fail" needed for Isabelle termination proofs... *)
  else
  match ( (read_archive_entry_header whole_seq_length whole_seq)) with 
    | Fail _ => return0 accum
    | Success (hdr,  seq_length,  seq) =>
    match ( seq) with 
      | Sequence next_bs =>
        (* let _ = Missing_pervasives.errln ("yes; next_bs has length " ^ (show (List.length next_bs))) in *)
        let amount_to_drop :=
          if beq_nat (Coq.Numbers.Natural.Peano.NPeano.modulo(size hdr)( 2))( 0) then
            ((size hdr))
          else Coq.Init.Peano.plus
            ((size hdr))( 1)
        in
        if beq_nat amount_to_drop( 0) then
          fail0 "accum_archive_contents: amount to drop from byte sequence is 0"
        else
        (*let _ = Missing_pervasives.errln ("amount_to_drop is " ^ (show amount_to_drop)) in*)
        let chunk := (Sequence(lem_list.take(size hdr) next_bs))
        in (*let _ = Missing_pervasives.errs ("Processing archive header named " ^ hdr.name)
        in*)
 match ( let name1 := string_to_char_list (name hdr) in
 if (list_equal_by
       (fun (left : ascii ) (right : ascii )=> (char_equal left right)) 
     name1 [/;  ;  ;  ;  ;  ;  ;  ;  ;  ;  ;  ;  ;  ;  ;  ]) then
   (* SystemV symbol lookup table; we skip this *) (accum, extended_filenames)
 else
   match ( name1) with | x::xs =>
     if (char_equal x /) then
       match ( xs) with | y::ys =>
         if (char_equal y /) then
           (accum, Some (string_of_byte_sequence0 chunk)) else
           let index2 := natural_of_decimal_string (string_from_char_list xs) in
           match ( extended_filenames) with | None => DAEMON | Some s =>
             let table_suffix := match ( string_suffix index2 s) with
                                     Some x => x | None => "" end in
           let index2 := match ( string_index_of / table_suffix) with
                             Some x => x | None =>
                           ( (String.length table_suffix)) end in
           let ext_name := match ( string_prefix index2 table_suffix) with
                               Some x => x | None => "" end in
           (*let _ = Missing_pervasives.errln ("Got ext_name " ^ ext_name) in*)
           (((ext_name, chunk) :: accum), extended_filenames) end | [] =>
         let index2 := natural_of_decimal_string (string_from_char_list xs) in
       match ( extended_filenames) with | None => DAEMON | Some s =>
         let table_suffix := match ( string_suffix index2 s) with Some x => x
                               | None => "" end in
       let index2 := match ( string_index_of / table_suffix) with Some x => x
                       | None => ( (String.length table_suffix)) end in
       let ext_name := match ( string_prefix index2 table_suffix) with
                           Some x => x | None => "" end in
       (*let _ = Missing_pervasives.errln ("Got ext_name " ^ ext_name) in*)
       (((ext_name, chunk) :: accum), extended_filenames) end end else
       ((((namehdr), chunk) :: accum), extended_filenames) | [] =>
     ((((namehdr), chunk) :: accum), extended_filenames) end) with
     (new_accum,  new_extended_filenames) =>
   match ( (byte_sequence.dropbytes amount_to_drop seq)) with | Fail _ =>
     return0 accum | Success new_seq =>
     accum_archive_contents new_accum new_extended_filenames
       ( Coq.Init.Peano.minus seq_length amount_to_drop) new_seq end end
    end
  end.
(* [?]: removed value specification. *)

Definition read_archive  (bs : byte_sequence )  : error (list ((string *byte_sequence ) % type)):=  
    read_archive_global_header bs >>= 
  (fun (p : (list (ascii )*byte_sequence ) % type) =>
     match ( (p) ) with ( (hdr,  seq)) =>
       let result := accum_archive_contents [] None
                       (byte_sequence.length0 seq) seq in
     (* let _ = Missing_pervasives.errln "Finished reading archive" in *)
     match ( result) with Success r => Success (List.rev r) | Fail x =>
       Fail x end end).