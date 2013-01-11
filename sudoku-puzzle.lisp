(in-package :sudoku-solver)

(defclass sudoku-puzzle ()
  ((grid :accessor grid :initform (make-array '(9 9)))
   (unsolved-cells :accessor unsolved-cells :initform (make-hash-table :test 'equal :size 81))))

(defmacro with-every-cell (body)
  `(iter outer (for i to 8)
	(iter (for j to 8)
	      (in outer ,body))))

(defgeneric row (sudoku-puzzle row)
  (:documentation "Gets the row of the matrix"))

(defgeneric column (sudoku-puzzle column)
  (:documentation "Gets the column of the matrix"))

(defgeneric subgrid (sudoku-puzzle row col)
  (:documentation "Gets the column of the matrix"))

(defgeneric solve (sudoku-puzzle)
  (:documentation "Solves the puzzle."))

(defgeneric row-strings-to-puzzle (sudoku-puzzle list)
  (:documentation "Takes a list of eight strings and initialises the grid"))

(defgeneric print-puzzle (sudoku-puzzle)
  (:documentation "Prints the puzzle."))

(defgeneric populate-unsolved-cells (sudoku-puzzle)
  (:documentation "Populates the hash-table."))
