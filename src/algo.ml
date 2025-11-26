open Graph


type path = id list 

(* On doit utiliser loopNodes dans loopEdges sinon on risque de rater certain chemin
dans notre parcours *)
(* NON FONCTIONNEL !!!! *)
let find_path graph forbidden id1 id2 =
  (* on verifie si id1 et id2 existent dans le graphe *)
  if node_exists graph id1 && node_exists graph id2 then
    (* Func interne pour boucler sur les arcs *)
    let rec loopEdges arcs forbid src dest path =
      match arcs with
      | [] -> None
      | h :: tail ->
        if h.tgt = dest then
          Some (path @ [h.tgt])
        else
          (* iCI PAS BON MON GARS *)
          loopEdges tail forbid src dest path

    (* On boucle sur les noeuds *)
    and loopNodes gr forbid src dest path =
      let arcList = out_arcs gr src in
      match arcList with
      | [] -> None
      | arc :: tail -> 
        if List.mem arc.src forbid then
          loopEdges tail forbid src dest path
        else
          let forbid = arc.src::forbidden in
          let path2 = arc.src::path in 
          match loopEdges arcList forbid arc.src dest path2 with
          | None -> None
          | Some p -> Some p
    in

    loopNodes graph forbidden id1 id2 [id1]

  else
    None
