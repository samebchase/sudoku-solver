(in-package :sudoku-solver)

(defclass sudoku-puzzle ()
  ((grid :accessor grid :initform (make-array '(9 9)))))

(defun read-lines (path-str)
  (with-open-file (stream path-str)
    (loop for line = (read-line stream nil) while line collect line)))

(defun group-into (n list)
;; Thanks to stassats for replacing an ugly recursive version with this one
  (loop while list collect
        (loop repeat n while list
              collect (pop list))))

(defun take (size list)
  (loop for i to size for elt in list 
     while (< i size) collect elt))

(defun first-char-alphap (string)
  (alpha-char-p (aref string 0)))

(defmethod row-strings-to-puzzle ((sudoku-puzzle sudoku-puzzle) list)
  (loop for i to 8 for string in list do
       (loop for j to 8 for char across string do
	    (setf (aref (grid sudoku-puzzle) i j) (digit-char-p char)))))k

(defvar *path* "/home/samuel/projects/sudoku-solver/src/lisp/sudoku.txt")

(defmethod print-puzzle ((sudoku-puzzle sudoku-puzzle))
  (dotimes (i 9)
    (format t "~%")
    (dotimes (j 9)
      (format t "~a " (aref (grid sudoku-puzzle) i j))))
  (format t "~%"))

;; (mapcar #'print-puzzle (loop for string-list in (group-into 9 (remove-if #'first-char-alphap (read-lines *path*)))
;; 	for puzzle = (make-instance 'sudoku-puzzle) do (row-strings-to-puzzle puzzle string-list)
;; 	collect puzzle))

;; collect lines

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

;; (defun filled-elements-row (grid i)
;;   (if (and (<= i 8) (>= i 0))
;;       (loop for k upto 8
;; 	 for elt = (aref grid i k)
;; 	 when (/= elt 0) collect elt) nil))

;; (defun filled-elements-col (grid j)
;;   (if (and (<= j 8) (>= j 0))
;;       (loop for k upto 8
;; 	 for elt = (aref grid k j)
;; 	 when (/= elt 0) collect elt) nil))

;; (defun filled-elements-subgrid (grid i j)
;;   (let* ((start-cell (subgrid-top-left-corner-cell grid i j))
;; 	 (x-index (car start-cell))
;; 	 (y-index (cdr start-cell)))
;;     (iter outer (for i to 2)
;; 	  (iter (for j to 2) (for elt = (aref grid (+ x-index i) (+ y-index j)))
;; 		(when (/= elt 0)
;; 		  (in outer (collect elt)))))))

;; (defun subgrid-top-left-corner-cell (grid i j)
;;   (cons (- i (rem i 3)) (- j (rem j 3))))

;; (defun grid-to-list (grid)
;;   (with-every-cell (in outer (collect (aref grid i j)))))

;; (defun cell-possibilities (grid i j)
;;   (set-difference (loop for i from 1 upto 9 collect i)
;; 		  (remove-duplicates (append (filled-elements-subgrid grid i j)
;; 					     (filled-elements-col grid j)
;; 					     (filled-elements-row grid i)))))

;; (defun all-possibilities (grid) 
;;   (with-every-cell (collect (cell-possibilities grid i j))))

;; (defun unsolved-cells (grid)
;;   (with-every-cell (in outer (when (= (aref grid i j) 0) (collect (cons i j))))))

;; (defun filledp (grid)
;;   (if (= 0 (length (unsolved-cells grid))) t nil))

;; (defmacro with-every-cell (body)
;;   `(iter outer (for i to 8)
;; 	(iter (for j to 8)
;; 	      (in outer ,body))))

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
