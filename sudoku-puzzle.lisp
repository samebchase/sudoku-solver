(in-package :sudoku-solver)

(defclass sudoku-puzzle ()
  ((grid :accessor grid
         :initform (make-array '(9 9)))))

(defun row (puzzle row)
  (loop for i upto 8 collect (aref (grid puzzle) row i)))

(defun column (puzzle col)
  (loop for j upto 8 collect (aref (grid puzzle) j col)))

(defun subgrid (puzzle i j)
  (multiple-value-bind (x y) (subgrid-corner-cell i j)
    (iter outer (for i to 2) 
	  (iter (for j to 2)
		(for elt = (aref (grid puzzle) (+ x i) (+ y j)))
		(in outer (collect elt))))))

(defmethod print-object ((puzzle sudoku-puzzle) stream)
  (print-unreadable-object (puzzle stream :type t :identity t)
    (terpri)
    (dotimes (i 9)
      (when (or (= i 3) (= i 6))
        (loop for i upto 20 do
             (if (or (= i 6) (= i 14))
                 (format t "+")
                 (format t "-"))
           finally (format t "~%")))
      (dotimes (j 9)
        (when (or (= j 3) (= j 6)) (format t "| "))
        ;; Prints a "." when zero, prints the number otherwise.
        (format t "~[.~:;~:*~d~] " (aref (grid puzzle) i j)))
      (terpri))
    (terpri)))
