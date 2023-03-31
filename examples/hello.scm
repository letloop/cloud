(library (hello)
  (export hyper)
  (import (letloop v1))

  (define hyper
    (lambda (method uri headers body)
      (values 200
              "Ok"
              '((content-type . "text/plain"))
              "Héllo world!"))))
