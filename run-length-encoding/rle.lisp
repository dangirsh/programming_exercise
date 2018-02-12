(defun run-length-encoding (to-encode)
  (flet ((accumulator (encoded-list next-element)
           (destructuring-bind ((elem . count) . remainder-encoded-list) encoded-list
             (if (eql elem next-element)
                 (cons (cons next-element (+ count 1)) remainder-encoded-list)
                 (cons (cons next-element 1) encoded-list)))))
    (reverse (reduce #'accumulator
                     to-encode
                     :initial-value (list (cons (car to-encode) 0))))))


;; Tests

(run-length-encoding '())

(run-length-encoding '(1))

(run-length-encoding
 '(1 1 1 2 2 3 2 3 3))
