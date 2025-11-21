open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes (graph_to_clone:'a graph) = 
  n_fold graph_to_clone (fun new_graph id -> new_node new_graph id) empty_graph

(* maps all arcs of gr by function f. (⩽3 lines) *)
let gmap gr f = 
  e_fold gr (fun accu_graph arc -> 
    let arcf = {arc with lbl = f arc.lbl} in
      new_arc accu_graph (arcf)) (clone_nodes gr)

(* val add_acr: int graph -> id -> id -> int -> int graph  *)
let add_arc g id1 id2 n = 
  match (find_arc g id1 id2) with
  | None -> new_arc g { src=id1; tgt=id2; lbl=n}
  | Some a -> new_arc g { a with lbl = a.lbl + n }

