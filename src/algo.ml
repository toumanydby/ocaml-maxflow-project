open Graph
open Tools

type path = id list 

  let print_path p =
  match p with
  | None -> "No path found."
  | Some ids ->
      let parts = List.map string_of_int ids in
      "Path: " ^ String.concat " -> " parts


(* On doit utiliser loopNodes dans loopEdges sinon on risque de rater certain chemin
dans notre parcours *)
let find_path graph forbidden id1 id2 =
  (* on verifie si id1 et id2 existent dans le graphe *)
  if node_exists graph id1 && node_exists graph id2 then
    (* Func interne pour boucler sur les arcs *)
    let rec loopEdges arcs forbid src dest path =
      match arcs with
      | [] -> None
      | h :: tail ->
        let next = h.tgt in
        if next = dest then
          Some (List.rev(next::path))
        else if List.mem next forbid then
          loopEdges tail forbid src dest path
        else 
          (* On continue sur le prochain noeud *)
          match loopNodes graph (next::forbid) next dest (next::path) with
          | None -> loopEdges tail forbid src dest path
          | Some p -> Some p

    (* On boucle sur les noeuds *)
    and loopNodes gr forbid src dest path =
      (* On ne visite que les arcs ayant une capacité positive pour eviter les boucles *)
      let arcList = List.filter (fun a -> a.lbl > 0) (out_arcs gr src) in
      match arcList with
      | [] -> None
      (* on marque src visité et on explore ses arcs *)
      | _ -> loopEdges arcList (src::forbid) src dest path
    in

    (* on démarre avec id1 dans notre chemin *)
    loopNodes graph forbidden id1 id2 [id1]

  else
    None

(* Afin de rester le plus generique possible, on utilise cette methode 
pour convertir un path (id list) en 'a arc list, 'a etant le type du graphe*)
let path_to_arcs graph path = 
  let rec aux acc = function 
    | [] -> List.rev acc 
    | [_] -> List.rev acc
    | u :: v :: rest -> 
      (match find_arc graph u v with
        | Some arc -> aux (arc :: acc) (v:: rest)
        | None -> failwith "Invalid path: missing arc from the graph")
    in 
    aux [] path

let find_minimum_path_capacity arcs = 
  List.fold_left (fun acc arc -> if arc.lbl < acc then arc.lbl else acc) max_int arcs

let remove_negative_or_null_capacity graph = 
  e_fold graph (fun g arc -> if arc.lbl <= 0 then g else new_arc g arc) (clone_nodes graph)

let apply_capacity graph arcs capacity = 
  let update_arcs g arc value = 
    let g = add_arc g arc.tgt arc.src value in (* On augmente les capacites inverses *)
    new_arc g { arc with lbl = arc.lbl - value }  (* On decremente les capacites sortantes *)
  in
    List.fold_left (fun g arc -> update_arcs g arc capacity) graph arcs

