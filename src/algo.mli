open Graph

(* A path is a list of nodes. *)
type path = id list

val print_path: path option -> string

(* find_path gr forbidden id1 id2 
 *   returns None if no path can be found.
 *   returns Some p if a path p from id1 to id2 has been found. 
 *
 *  forbidden is a list of forbidden nodes (they have already been visited)
 *)
val find_path: int graph -> id list -> id -> id -> path option

(* Convert a path (list of nodes) into a list of arcs *)
val path_to_arcs: int graph -> path -> id arc list
