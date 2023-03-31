#!chezscheme
(library (example)
  (export hyper)
  (import (letloop v1))

  (define render
    (lambda (counter)
      `(html
        (head
         (link (@ (href "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css")
                  (rel "stylesheet")
                  (integrity "sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD")
                  (crossorigin "anonymous")))

         (title "Welcome to the loop!"))

        (body
         (div (@ (style "width: 777px; padding: 30px; margin: auto"))
              (p "Hello dear visitor, your are number " ,counter))))))

  (define hyper
    (lambda (method uri headers body)

      (define or*
        (lambda (x o)
          (if (string=? "" x)
              o
              x)))
      
      ;; (define counter 1337)

      (define counter
        (guard (ex (else (raise ex) 0))
          (call-with-transaction
           (lambda (tx)
             (let* ((counter (db-query tx (bytevector 42)))
                     (counter (+ (or (and counter
                                          (byter-unpack counter))
                                     0)
                                 1)))
               (db-set! tx (bytevector 42) (byter-pack counter))
               counter)))))

      (values 200
              "Ok"
              '((content-type . "text/html"))
              (render counter)))))
