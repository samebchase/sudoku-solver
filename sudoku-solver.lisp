(defvar grid (make-array '(9 9)))

(let ((in (open "../test/puzzle.txt")))
  (when in
    (loop for line = (read-line in nil) while line
       for i upto 8 do
	 (loop for char across line for j upto 8 do
	      (setf (aref grid i j) (parse-integer (coerce (list char) 'string)))))
    (close in)))

(print grid)
