(in-package :sudoku-solver)

(define-constant +typical-solved-puzzle+
  (make-sudoku-puzzle
   #2A((4 1 7 3 6 9 8 2 5)
       (6 3 2 1 5 8 9 4 7)
       (9 5 8 7 2 4 3 1 6)
       (8 2 5 4 3 7 1 6 9)
       (7 9 1 5 8 6 4 3 2)
       (3 4 6 9 1 2 7 5 8)
       (2 8 9 6 4 3 5 7 1)
       (5 7 3 2 9 1 6 8 4)
       (1 6 4 8 7 5 2 9 3)))
  :test #'equalp)

(define-constant +typical-unsolved-puzzle+
  (make-sudoku-puzzle
   #2A((0 0 3 0 2 0 6 0 0)
       (9 0 0 3 0 5 0 0 1)
       (0 0 1 8 0 6 4 0 0)
       (0 0 8 1 0 2 9 0 0)
       (7 0 0 0 0 0 0 0 8)
       (0 0 6 7 0 8 2 0 0)
       (0 0 2 6 0 9 5 0 0)
       (8 0 0 2 0 3 0 0 9)
       (0 0 5 0 1 0 3 0 0)))
  :test #'equalp)

(def-suite sudoku-solver-suite)

(in-suite sudoku-solver-suite)

(test sanity
  (is (= 42 42)))

;; TODO: write some test for the peer functions

(defun run-tests ()
  (run! 'sudoku-solver-suite))
