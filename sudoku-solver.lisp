(in-package :sudoku-solver)

(defparameter *euler-puzzles-path* "puzzles/euler-puzzles.txt")

(defparameter *sudoku-values* (iota 9 :start 1))

(defmethod solve (puzzle)
  puzzle)

(defun puzzle-list () 
  (loop
     for string-list in
       (group-into 9 (remove-if #'first-char-alphap (read-lines *euler-puzzles-path*)))
     for puzzle = (make-instance 'sudoku-puzzle) do
       (row-strings-to-puzzle puzzle string-list)
     collect puzzle))

(defparameter *puzzles* (puzzle-list))
