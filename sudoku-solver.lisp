(in-package :sudoku-solver)

(defvar grid (make-array '(9 9)))

(let ((in (open "../test/puzzle.txt")))
  (when in (loop for line = (read-line in nil) while line
	      for i upto 8 do
		(loop for char across line for j upto 8 do
		     (setf (aref grid i j) (digit-char-p char))))
	(close in)))

(defun filled-elements-row (i)
  (loop for k upto 8
     for elt = (aref grid i k)
     when (/= elt 0) collect elt))

(defun filled-elements-col (j)
  (loop for k upto 8
     for elt = (aref grid k j)
     when (/= elt 0)
     collect elt))

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
		  (in
		   outer (collect elt)))))))

(defun grid-to-list ()
  (iter outer (for i below 9)
	(iter (for j below 9)
	      (in outer (collect (aref grid i j))))))

(defun print-grid ()
  (dotimes (i 9)
    (format t "~%")
    (dotimes (j 9)
      (format t "~a " (aref grid i j)))))