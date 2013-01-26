(in-package :sudoku-solver)

(defclass sudoku-puzzle ()
  ((grid :accessor grid :initform (make-array '(9 9)))
   (unsolved-cells :accessor unsolved-cells :initform '())))

(defgeneric row (puzzle row)
  (:documentation "Gets the row of the matrix"))

(defgeneric column (puzzle column)
  (:documentation "Gets the column of the matrix"))

(defgeneric subgrid (puzzle row col)
  (:documentation "Gets the column of the matrix"))

(defgeneric solve (puzzle)
  (:documentation "Solves the puzzle."))

(defgeneric row-strings-to-puzzle (puzzle list)
  (:documentation "Takes a list of eight strings and initialises the grid"))

(defgeneric print-puzzle (puzzle)
  (:documentation "Prints the puzzle."))

(defgeneric populate-unsolved-cells (puzzle)
  (:documentation "Populates the hash-table."))

(defgeneric mark-cell-as-solved (puzzle cell)
  (:documentation "Removes cell from unsolved list."))

(defgeneric row-col-subgrid-possibilities (puzzle i j)
  (:documentation "All possibilities from the row, column and subgrid of the cell."))
