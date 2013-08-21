(in-package :sudoku-solver)

(def-suite sudoku-solver-suite)

(in-suite sudoku-solver-suite)

(test sanity
  (is (= 42 42)))

(defun run-tests ()
  (run! 'sudoku-solver-suite))
