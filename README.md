# letloop.cloud · cloud for the parenthetical leaning doers

➰ letloop.cloud ⛅ is an easy way, the easiest way, to publish web
apps written with Scheme, or targeting Scheme.

## Getting started

Create a file called `mywebapp.scm`, and put the following inside it:

```scheme
(library (counter)
  (export hyper)
  (import (letloop v1))

  (define render
    (lambda (title name)
      `(html
        (head
         (title "Welcome to the loop!"))
        (body
         (h1 "Hello " ,title " " ,name)
         (p "I can say your name:")
         (form (@ (method "POST"))
               (p (input (@ (type "text") (name "title") (placeholder "title"))))
               (p (input (@ (type "text") (name "name") (placeholder "name"))))
               (p (input (@ (type "submit") (value "submit")))))))))

  (define hyper
    (lambda (method uri version headers body)

      (define or*
        (lambda (x o)
          (if (string=? "" x)
              o
              x)))

      (if (eq? method 'POST)
          (let ((body (www-form-urlencoded-read body)))
            ;; after a POST, usually it needs a redirect, to limit
            ;; double postings, but here since there is no session,
            ;; reply 200...
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

➰ It is online at: http://9a6kmemqqhpmo.letloop.xyz

➿ Spawning a new shell... Improve the code, push, and make it shine with the same command:

      letloop.py mywebapp.scm

```

And that is all :)
