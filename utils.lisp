(in-package :sudoku-solver)

(defvar *cell-values* (alexandria:iota 9 :start 1))

(defun subgrid-corner-cell (row col)
  (values (- row (rem row 3))
	  (- col (rem col 3))))

(defun group-into (n list)
  ;; CREDIT: stassats
  (if (<= n 0) list
      (loop while list collect
	   (loop repeat n while list
	      collect (pop list)))))
