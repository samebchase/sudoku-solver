(in-package :sudoku-solver)

(defvar grid (make-array '(9 9)))

(defun read-puzzle-from-file (path-str)
  (let ((in (open path-str)))
    (when in (loop for line = (read-line in nil) while line
		for i upto 8 do
		  (loop for char across line for j upto 8 do
		       (setf (aref grid i j) (digit-char-p char)))) (close in))))

(defun filled-elements-row (i)
  (if (and (<= i 8) (>= i 0))
      (loop for k upto 8
	 for elt = (aref grid i k)
	 when (/= elt 0) collect elt) nil))

(defun filled-elements-col (j)
  (if (and (<= j 8) (>= j 0))
      (loop for k upto 8
	 for elt = (aref grid k j)
	 when (/= elt 0) collect elt) nil))

(defun subgrid-top-left-corner-cell (i j)
  (let ((x-rem (rem i 3)) (y-rem (rem j 3)))
    (cons (case x-rem
	    (0 i)
	    (1 (- i 1))
	    (2 (- i 2)))
	  (case y-rem
	    (0 j)
	    (1 (- j 1))
	    (2 (- j 2))))))

(defun filled-elements-subgrid (i j)
  (let* ((start-cell (subgrid-top-left-corner-cell i j))
	 (x-index (car start-cell))
	 (y-index (cdr start-cell)))
    (iter outer (for i to 2)
	  (iter (for j to 2) (for elt = (aref grid (+ x-index i) (+ y-index j)))
		(when (/= elt 0)
		  (in outer (collect elt)))))))

(defun grid-to-list ()
  (with-every-cell (in outer (collect (aref grid i j)))))

(defvar 1-to-9 (loop for i from 1 upto 9 collect i))

(defun cell-possibilities (i j)
  (set-difference 1-to-9 (remove-duplicates
			  (append (filled-elements-subgrid i j)
				  (filled-elements-col j)
				  (filled-elements-row i)))))

(defun print-grid ()
  (dotimes (i 9)
    (format t "~%")
    (dotimes (j 9)
      (format t "~a " (aref grid i j)))))

(defun all-possibilites () 
  (with-every-cell (collect (cell-possibilities i j))))

(defun unsolved-cells ()
  (with-every-cell (in outer (when (= (aref grid i j) 0) (collect (cons i j))))))

(defun filledp ()
  (if (= 0 (length (unsolved-cells))) t nil))

;; see if there are any repeated elements in adjacent rows 

;; other rows in subgrid
;; find subgrid corner
;; find the other two rows

(defun repeated-elements-adjacent-row (i j)
  (let* ((corner-row-index (car (subgrid-top-left-corner-cell i j)))
	 (subgrid-relative-row (- i corner-row-index))
	 (other-relative-rows (remove subgrid-relative-row '(0 1 2))))
    (intersection (filled-elements-row (+ corner-row-index (car other-relative-rows)))
		  (filled-elements-row (+ corner-row-index (cadr other-relative-rows))))))

(defmacro with-every-cell (body)
  `(iter outer (for i to 8)
	(iter (for j to 8)
	      (in outer ,body))))

(defun use-brute-force ()
  (loop for k upto 50 do
       (loop for i upto 8 do
	    (loop for j upto 8 for lst = (cell-possibilities i j)
	       when (= (length lst) 1) do (setf (aref grid i j) (car lst))))))

;; (defun smarter-method ()
;;   (let* ((unsolved (unsolved-cells)))
;;     (when (> (length unsolved) 0)
;;       (car unsolved 