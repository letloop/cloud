# ➰ letloop.cloud ⛅

**A cloud for the parenthetical leaning doers**

letloop.cloud is an easy way, the easiest way, to publish web apps
written with Scheme, or targeting Scheme.

## Getting started

Create a file called `mywebapp.scm`, and put the following inside it:

```scheme
(library (mywebapp)
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
              (h1 "Hello " ,title " " ,name)
              (img (@ (src "http://letloop.cloud/static/letloop.png")))
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
    (lambda (method uri version headers body)

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
```

Then you can use the python client to publish your web application. First install
the python client with the help of the command `pip`:

```sh
pip install letloop.py
```

You can now publish the application with:

```shell
#;> letloop.py mywebapp.scm

➰ It is online at: https://9a498kflib7cn.letloop.xyz

➿ Spawning a new shell... Improve the code, push, and make it shine with the same command:

      letloop.py mywebapp.scm

#;>
```

And that is all :)
