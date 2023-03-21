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

## Reference

The available procedures are a subset of [SRFI-172](https://srfi.schemers.org/srfi-172/), without set!, and without mutations:

```scheme
define - * / + < <= = => > >= abs acos and angle append apply asin assoc
assq assv atan begin boolean? boolean=? bytevector bytevector? bytevector-copy
bytevector-length bytevector-u8-ref caaaar caaadr caaar caadar caaddr caadr
caar cadaar cadadr cadar caddar cadddr caddr cadr call/cc call-with-current-continuation
call-with-values car case case-lambda cdaaar cdaadr cdaar cdadar cdaddr cdadr
cdar cddaar cddadr cddar cdddar cddddr cdddr cddr cdr ceiling char? char<?
char<=? char=? char>? char>=? char->integer char-alphabetic? char-ci<?
char-ci<=? char-ci=? char-ci>? char-ci>=? char-downcase char-foldcase
char-lower-case? char-numeric? char-upcase char-upper-case? char-whitespace?
complex? cond cons cos denominator do dynamic-wind else eof-object eof-object?
eq? equal? eqv? error even? exact exact? exact-integer-sqrt exp expt finite?
floor for-each gcd guard if imag-part inexact inexact? infinite? integer?
integer->char lambda lcm length let let* let*-values letrec letrec* let-values
list list? list->string  list-copy list-ref list-tail log magnitude make-bytevector
make-list make-parameter make-polar make-rectangular make-string map max member
memq memv min modulo nan? negative? not null? number? number->string numerator
odd? or pair? parameterize positive? procedure? quasiquote quote quotient raise
raise-continuable rational? rationalize real? real-part remainder reverse round
sin sqrt string string? string<? string<=? string=? string>? string>=? string->list
string->number string->utf8 string-append string-ci<? string-ci<=? string-ci=?
string-ci>? string-ci>=? string-copy string-downcase string-foldcase string-for-each
string-length string-ref string-upcase substring symbol? symbol=? symbol->string tan
truncate unless unquote unquote-splicing utf8->string values when with-exception-handler
zero?
```

Also the following procedure helps with html forms:

```scheme
www-form-urlencoded-read
```

The following procedures helps with database:

```scheme
call-with-transaction
db-set!
db-bytes
db-clear!
db-query
```

The following procedures will pack basic Scheme objects into bytes
preserving the natural order:

```scheme
byter-pack
byter-unpack
```

Helpers to play with `bytevector` objects:

```scheme
byter-append
byter-compare
byter-next-prefix
subbytes
```
