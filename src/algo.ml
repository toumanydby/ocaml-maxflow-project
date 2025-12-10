open Graph


type path = id list 

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
      let arcList = out_arcs gr src in
      match arcList with
      | [] -> None
      (* on marque src visité et on explore ses arcs *)
      | _ -> loopEdges arcList (src::forbid) src dest path
    in

    (* on démarre avec id1 dans notre chemin *)
    loopNodes graph forbidden id1 id2 [id1]

  else
    None


let string_of_path (p : path option) : string =
  match p with
  | None -> "No path found."
  | Some ids ->
      let parts = List.map string_of_int ids in
      "Path: " ^ String.concat " -> " parts
