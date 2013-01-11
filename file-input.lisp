(in-package :sudoku-solver)

(defun read-lines (path-str)
  (with-open-file (stream path-str)
    (loop for line = (read-line stream nil) while line collect line)))

(defun first-char-alphap (string)
  (alpha-char-p (aref string 0)))

(defmethod row-strings-to-puzzle ((sudoku-puzzle sudoku-puzzle) list)
  (loop for i to 8 for string in list do
       (loop for j to 8 for char across string do
	    (setf (aref (grid sudoku-puzzle) i j) (digit-char-p char)))))
