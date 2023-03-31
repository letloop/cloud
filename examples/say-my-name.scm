#!chezscheme
(library (example)
  (export hyper)
  (import (letloop v1))

  (define render
    (lambda (title name)
      `(html
        (head
         (link (@ (href "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css")
                  (rel "stylesheet")
                  (integrity "sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD")
                  (crossorigin "anonymous")))

         (title "Welcome to the loop!"))

        (body
         (div (@ (style "width: 777px; padding: 30px; margin: auto"))
              (h1 "Hello " ,title " " ,name "!")
              (p "I can say your name:")
              (form (@ (method "POST"))
                    (p (input (@ (class "form-control")
                                 (type "text")
                                 (name "title")
                                 (placeholder "title"))))
                    (p (input (@ (class "form-control")
                                 (type "text")
                                 (name "name")
                                 (placeholder "name"))))
                    (p (input (@ (class "btn btn-primary")
                                 (type "submit")
                                 (value "submit"))))))))))

  (define hyper
    (lambda (method uri headers body)

      (define or*
        (lambda (x o)
          (if (string=? "" x)
              o
              x)))     

      (if (eq? method 'POST)
          (let ((body (www-form-urlencoded-read body)))
            (values 200
                    "Ok"
                    '((content-type . "text/html"))
                    (render (or* (cdr (assq 'title body)) "dear")
                            (or* (cdr (assq 'name body )) "visitor"))))
          (values 200
                  "Ok"
                  '((content-type . "text/html"))
                  (render "dear" "visitor"))))))
