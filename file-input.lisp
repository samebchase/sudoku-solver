(in-package :sudoku-solver)

(defun first-char-alphap (string)
  (alpha-char-p (aref string 0)))

(defun read-lines (path-str)
  (with-open-file (stream path-str)
    (loop
       for line = (read-line stream nil)
       while line
       collect line)))

(defun row-strings-to-puzzle (puzzle list)
  (loop for i to 8
     for string in list do
       (loop
          for j to 8
          for char across string do
            (setf (aref (grid puzzle) i j)
                  (digit-char-p char)))))
