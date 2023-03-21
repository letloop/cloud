# ➰ letloop.cloud ⛅

**A cloud for the parenthetical leaning doers**

letloop.cloud is an easy way, the easiest way, to publish web apps
written with Scheme, or targeting Scheme.

## Hello, world!

You will need `curl`, and `jq`:

```scheme
;> cat <<EOF >> example.scm
;; https://letloop.cloud hello world
(library (mywebapp)
  (export hyper)
  (import (letloop v1))

  (define view
    (lambda ()
      '(html
        (head
         (link (@ (href "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css")
                  (rel "stylesheet")
                  (integrity "sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD")
                  (crossorigin "anonymous")))

         (title "Welcome to the loop!"))

        (body
         (h1 "Welcome to the loop!")))))

  (define hyper
    (lambda (method uri version headers body)
      (values 200
              "Ok"
              '((content-type . "text/html"))
              (view)))))
EOF
```

To deploy use the following:

```shell
;> curl -X PUT --data-binary @example.scm https://letloop.cloud/api/v1 | jq . | tee letloop.cloud.json
```

The previous command will store information, including the secret used
to update the page. You can use it like that:

```shell
;> curl -X POST --data-binary @example.scm $(cat letloop.cloud.json | jq -r '.[2]')
```

Enjoy!

## Using `letloop.py`

You can also use the python client to publish your web
application. First install the python client with the help of the
command `pip`:

```sh
pip install letloop.py
```

See [letloop.py](https://pypi.org/project/letloop.py)

## Reference

The available procedures are a subset of
[SRFI-172](https://srfi.schemers.org/srfi-172/), without set!, and
without mutations:

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
