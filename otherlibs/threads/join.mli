(***********************************************************************)
(*                                                                     *)
(*                           Objective Caml                            *)
(*                                                                     *)
(*            Luc Maranget, projet Moscova, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 2004 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

(* $Id$ *)

open Join_types

type site

val here : site

val create_process : (unit -> unit) -> unit

val get_queue : automaton -> int -> 'a
val init_unit_queue : automaton -> int -> unit

val create_automaton : int -> automaton

(* create_automaton nchans *)
val create_automaton_debug : int -> string array -> automaton
val wrap_automaton : automaton -> stub


val patch_table : automaton -> reaction array -> unit

(* Asynchronous channels *)

val create_async : stub -> int -> 'a async
val create_alone : ('a -> unit) -> 'a async
val alloc_alone : unit -> 'a async
val patch_alone : 'a async -> ('a -> unit) -> unit

val local_send_async : automaton -> int -> 'a -> unit
val local_tail_send_async : automaton -> int -> 'a -> unit
val local_send_alone : ('a -> unit) -> 'a -> unit
val local_tail_send_alone : ('a -> unit) -> 'a -> unit

val send_async : 'a async -> 'a -> unit
val tail_send_async : 'a async -> 'a -> unit

(* Synchronous channels are plain fonctions *)
val local_send_sync : automaton -> int -> 'a -> 'b

val create_sync : stub -> int -> ('a -> 'b)
val create_sync_alone : ('a -> 'b) -> ('a -> 'b)


val alloc_stub_guard : unit -> stub
val alloc_sync_alone : stub -> ('a -> 'b)
val patch_sync_alone : stub  -> ('a -> 'b) -> unit

(* Explicit reply to continuation *)
val reply_to : 'a -> continuation -> unit
val reply_to_exn : exn -> continuation -> unit

(* Silent suicide of a join thread (compiler use only) *)
val raise_join_exit : unit -> 'a

(* Hook for 'at_exit' will somehow control termination of program.
   More precisely, program terminates when they is no more
   work to achieve.
   This does not apply to program engaged in distribution. *)
val exit_hook : unit -> unit

(* Register an exception as a global one, compiler use *)
val exn_global : (string * int * int) -> Obj.t -> unit

(* register a channel to be sent to when site fails *)
val at_fail : site -> unit channel -> unit

(* Give message to distant sites a chance to leave *)
val flush_space : unit -> unit

(* Various levels of debuging as directed by the
   environment variable VERBOSE *)
val debug : string -> string -> unit
val debug0 : string -> string -> unit
val debug1 : string -> string -> unit
val debug2 : string -> string -> unit
val debug3 : string -> string -> unit

