Base project for Ocaml project on Ford-Fulkerson. This project contains some simple configuration files to facilitate editing Ocaml in VSCode.

To use, you should install the *OCaml Platform* extension in VSCode.
Then open VSCode in the root directory of this repository (command line: `code path/to/ocaml-maxflow-project`).

Features :
 - full compilation as VSCode build task (Ctrl+Shift+b)
 - highlights of compilation errors as you type
 - code completion
 - view of variable types


A [`Makefile`](Makefile) provides some useful commands:

 - `make build` to compile. This creates an `ftest.exe` executable
 - `make demo` to run the `ftest` program with some arguments
 - `make format` to indent the entire project
 - `make edit` to open the project in VSCode
 - `make clean` to remove build artifacts

In case of trouble with the VSCode extension (e.g. the project does not build, there are strange mistakes), a common workaround is to (1) close vscode, (2) `make clean`, (3) `make build` and (4) reopen vscode (`make edit`).

## NOTES

On doit implementer l'algo max-flot sur un graph de flot en utilisant l'algo de Ford-Fulkerson, et optionnellement l'ameliorer pour qu'il prenne en compte d'autres contraintes (ex: minimiser le cout)

Nos graphes sont immuables !!! On ne peut pas les modifier, donc quand on veut ajouter un arc ou un noeud a un graphe existant, on cree un nouveau graphe avec toutes ces informations.

graph.mli et graph.ml represente les fichiers du module Graph
gfile.mli et gfile.ml represente les fichiers du module Gfile
ftest.ml est le main de notre program. 
