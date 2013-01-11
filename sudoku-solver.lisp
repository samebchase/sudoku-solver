(in-package :sudoku-solver)

(defvar *values* (alexandria:iota 9 :start 1))
(defvar *path* "/home/samuel/projects/sudoku-solver/src/lisp/sudoku.txt")

(defmethod solve ((sudoku-puzzle sudoku-puzzle))
  (grid sudoku-puzzle))

(mapcar #'solve (loop for string-list in (group-into 9 (remove-if #'first-char-alphap (read-lines *path*)))
	for puzzle = (make-instance 'sudoku-puzzle) do (row-strings-to-puzzle puzzle string-list)
	collect puzzle))
