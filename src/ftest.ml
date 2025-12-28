open Gfile
open Tools
open Algo

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 6 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n" ^
         "    🟄  outfiledot : output file in the dot format (the format understood by graphviz)\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)
  and outfiledot = Sys.argv.(5)

  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in
  (* test of clone_nodes *)
  (* let graph2 = clone_nodes graph in  *)
  (* test ajout d'un arc *)
  let graph3 =gmap graph int_of_string  in  (*add_arc () 0 2 10 *)
  let graph4 = gmap graph3 string_of_int in

  let path = find_path graph3 [] _source _sink in 
  Printf.printf "%s\n%!" (print_path path);

  let () = export outfiledot graph4 in
  let () = write_file outfile graph4 in
  ()

