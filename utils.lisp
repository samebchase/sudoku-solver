(in-package :sudoku-solver)

(defvar *cell-values* (alexandria:iota 9 :start 1))

(defmacro with-every-cell (body)
  `(iter outer (for i to 8)
         (iter (for j to 8)
               (in outer ,body))))

(defun subgrid-corner-cell (row col)
  (values (- row (rem row 3))
	  (- col (rem col 3))))

(defun group-into (n list)
  ;; stassats wrote this function.
  (if (<= n 0) list
      (loop while list collect
	   (loop repeat n while list
	      collect (pop list)))))
