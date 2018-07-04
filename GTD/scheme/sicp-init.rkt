(define (square x) (* x x))
(define (cube x) (* x x x))
(define (inc n) (+ n 1))
(define (factorial n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))
