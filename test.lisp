(in-package :sudoku-solver)

(defparameter *solved-solution*
  (let* ((puzzle (make-instance 'sudoku-puzzle)))
    (setf (grid puzzle)
          #2A((4 1 7 3 6 9 8 2 5)
              (6 3 2 1 5 8 9 4 7)
              (9 5 8 7 2 4 3 1 6)
              (8 2 5 4 3 7 1 6 9)
              (7 9 1 5 8 6 4 3 2)
              (3 4 6 9 1 2 7 5 8)
              (2 8 9 6 4 3 5 7 1)
              (5 7 3 2 9 1 6 8 4)
              (1 6 4 8 7 5 2 9 3)))
    puzzle))

(def-suite sudoku-solver-suite)

(in-suite sudoku-solver-suite)

(test sanity
  (is (= 42 42)))

(defun run-tests ()
  (run! 'sudoku-solver-suite))
