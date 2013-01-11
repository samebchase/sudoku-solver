(in-package :sudoku-solver)

(defvar *cell-values* (alexandria:iota 9 :start 1))

(defmethod row ((sudoku-puzzle sudoku-puzzle) row)
  (loop for i upto 8 collect (aref (grid sudoku-puzzle) row i)))

(defmethod column ((sudoku-puzzle sudoku-puzzle) col)
  (loop for j upto 8 collect (aref (grid sudoku-puzzle) j col)))

(defmethod subgrid ((sudoku-puzzle sudoku-puzzle) i j)
  (let* ((corner-cell (subgrid-corner-cell i j))
	 (x (car corner-cell))
	 (y (cdr corner-cell)))
    (iter outer (for i to 2)
	  (iter (for j to 2) (for elt = (aref (grid sudoku-puzzle) (+ x i) (+ y j)))
		(in outer (collect elt))))))

(defun subgrid-corner-cell (row col)
  (cons (- row (rem row 3)) (- col (rem col 3))))

(defmethod print-puzzle ((sudoku-puzzle sudoku-puzzle))
  (dotimes (i 9)
    (format t "~%")
    (dotimes (j 9)
      (format t "~a " (aref (grid sudoku-puzzle) i j))))
  (format t "~%"))

(defun group-into (n list)
;; Thanks to stassats from #lisp for replacing an ugly recursive
;; version with one that used loop instead.
  (if (<= n 0) list
      (loop while list collect
        (loop repeat n while list
	   collect (pop list)))))

(defun filled-values (list)
  (remove-if #'zerop list))

(defmethod populate-unsolved-cells ((sudoku-puzzle sudoku-puzzle))
  (with-every-cell
      (when (zerop (aref (grid sudoku-puzzle) i j))
	(setf (gethash (cons i j) (unsolved-cells sudoku-puzzle)) (cons i j)))))

(defmethod unsolved ((sudoku-puzzle sudoku-puzzle))
  (loop for value being the hash-values of (unsolved-cells sudoku-puzzle) collect value))

(defmethod mark-cell-as-solved ((sudoku-puzzle sudoku-puzzle) cell)
  (remhash cell (unsolved-cells sudoku-puzzle)))

(defmethod row-col-subgrid-possibilities ((sudoku-puzzle sudoku-puzzle) i j)
  (set-difference *cell-values*
		  (remove-duplicates (append (subgrid sudoku-puzzle i j)
					     (row sudoku-puzzle i)
					     (column sudoku-puzzle j)))))

;; (defun unsolved-cells (grid)
;;   (with-every-cell (in outer (when (= (aref grid i j) 0) (collect (cons i j))))))

;; (defun filledp (grid)
;;   (if (= 0 (length (unsolved-cells grid))) t nil))

;; (defmacro with-grid-component (component var)
;;   `(loop for k upto 8
;;       for elt = ,(cond (`(eq row ,component) `(aref grid ,var k))
;; 		       (`(eq column ,component) `(aref grid k ,var)))  
;;       when (/= elt 0) collect elt))

;; ;; This works
;; ;; (let ((component 'column)
;; ;; 		     (var 3)) (cond ((eq 'row component) `(aref grid ,var k))
;; ;; 			  ((eq 'column component) `(aref grid k ,var))))
;; ;; (AREF GRID K 3)

;; ;; filled-elements-row and filled-elements-col should be implemented
;; ;; using with-grid-component as appropriate

;; (defun grid-to-list (grid)
;;   (with-every-cell (in outer (collect (aref grid i j)))))

;; (defun all-possibilities (grid) 
;;   (with-every-cell (collect (cell-possibilities grid i j))))

;; (defun all-subgrids (grid)
;;   (iter outer (for i to 6 by 3)
;; 	(iter (for j to 6 by 3)
;; 	      (in outer (collect (filled-elements-subgrid grid i j))))))

;; ;; Solving Heuristic
;; ;; 1. Find unsolved list
;; ;; 2. Solve and pop from unsolved list.

;; (defun use-brute-force (grid)
;;   (loop for k upto 50 do
;;        (loop for i upto 8 do
;; 	    (loop for j upto 8 for lst = (cell-possibilities grid i j)
;; 	       when (= (length lst) 1) do (setf (aref grid i j) (car lst))))
;;        return grid))

;; ;; (defun repeated-elements-adjacent-row (grid i j)
;; ;;   (let* ((corner-row-index (car (subgrid-top-left-corner-cell i j)))
;; ;; 	 (subgrid-relative-row (- i corner-row-index))
;; ;; 	 (other-relative-rows (remove subgrid-relative-row '(0 1 2))))
;; ;;     (intersection (filled-elements-row (+ corner-row-index (car other-relative-rows)))
;; ;; 		  (filled-elements-row (+ corner-row-index (cadr other-relative-rows))))))

;; ;; (defun repeated-elements-adjacent-col (grid i j)
;; ;;   (let* ((corner-col-index (car (subgrid-top-left-corner-cell i j)))
;; ;; 	 (subgrid-relative-col (- j corner-col-index))
;; ;; 	 (other-relative-cols (remove subgrid-relative-col '(0 1 2))))
;; ;;     (intersection (filled-elements-col (+ corner-col-index (car other-relative-cols)))
;; ;; 		  (filled-elements-col (+ corner-col-index (cadr other-relative-cols))))))
