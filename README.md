# ➰ letloop.cloud ⛅

**A cloud for the parenthetical leaning doers**

letloop.cloud is an easy way, the easiest way, to publish web apps
written with Scheme, or targeting Scheme.

## Hello, world!

You will need `curl`, and `jq`:

```scheme
;> cat <<EOF >> example.scm
;; https://letloop.cloud hello world
(library (hello)
  (export hyper)
  (import (letloop v1))

  (define hyper
    (lambda (method uri headers body)
      (values 200
              "Ok"
              '((content-type . "text/plain"))
              "Héllo world!"))))
EOF
```

To deploy use the following:

```shell
;> curl -T example.scm https://letloop.cloud/api/v1 | jq . | tee letloop.cloud.json
```

The previous command will store information, including the secret used
to update the page. You can use it like that:

```shell
;> curl -X POST --data-binary @example.scm $(cat letloop.cloud.json | jq -r '.[2]')
```

They are more examples in
[letloop.cloud/examples/](https://github.com/letloop/letloop.cloud/tree/main/examples/)
directory.

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

### Base

The available procedures are a subset of
[SRFI-172](https://srfi.schemers.org/srfi-172/), without set!, and
without mutations. If you are unsure about those, look at
[scheme.rs/scheme/base](https://scheme.rs/scheme/base/#container):

```scheme
* + - / < <= = => > >= abs acos and angle append apply asin assoc assq
assv atan begin boolean=? boolean? bytevector bytevector-copy bytevector-length
bytevector-u8-ref bytevector? caaaar caaadr caaar caadar caaddr caadr caar
cadaar cadadr cadar caddar cadddr caddr cadr call-with-current-continuation
call-with-values call/cc car case case-lambda cdaaar cdaadr cdaar cdadar
cdaddr cdadr cdar cddaar cddadr cddar cdddar cddddr cdddr cddr cdr ceiling
char->integer char-alphabetic? char-ci<=? char-ci<? char-ci=? char-ci>=?
char-ci>? char-downcase char-foldcase char-lower-case? char-numeric? char-upcase
char-upper-case? char-whitespace? char<=? char<? char=? char>=? char>? char?
complex? cond cons cos define denominator do dynamic-wind else eof-object
eof-object? eq? equal? eqv? error even? exact exact-integer-sqrt exact? exp
expt finite? floor for-each gcd guard if imag-part inexact inexact? infinite?
integer->char integer? lambda lcm length let let* let*-values let-values letrec
letrec* list list->string list-copy list-ref list-tail list? log magnitude
make-bytevector make-list make-parameter make-polar make-rectangular make-string
map max member memq memv min modulo nan? negative? not null? number->string number?
numerator odd? or pair? parameterize positive? procedure? quasiquote quote quotient
raise raise-continuable rational? rationalize real-part real? remainder reverse round
sin sqrt string string->list string->number string->utf8 string-append string-ci<=?
string-ci<? string-ci=? string-ci>=? string-ci>? string-copy string-downcase
string-foldcase string-for-each string-length string-ref string-upcase string<=?
string<? string=? string>=? string>? string? substring symbol->string symbol=?
symbol? tan truncate unless unquote unquote-splicing utf8->string values when
with-exception-handler
zero?
```

### Forms

The procedure `www-form-urlencoded-read` helps html query string, and
forms:

```scheme
(assert (equal? (www-form-urlencoded-read "example=foo&example=bar&qux&baz=baz")
                '((example . "foo")
                  (example . "bar")
                  (qux)
                  (baz "baz"))))
```

### Database

#### `(call-with-transaction proc)`

Start a transaction and pass it to `PROC`. A transaction object is
noted `tx`.

#### `(db-set! tx key value)`

Associated `KEY` with `VALUE`. Override existing association if any.

#### `(db-bytes tx key other)`

Return the approximate count of bytes between keys `KEY` and `OTHER`.

#### `(db-clear! tx key other)`

Delete key-value associations between keys `KEY` and `OTHER`.

#### `(db-query tx key other)`

Return an association list made of the ordered keys between `KEY` and
`OTHER`. `OTHER` is never part of the returned list.

### Byter

```scheme
(assert (equal? object (byter-unpack (byter-pack object))))
```

#### `(byter-pack object)`

Return a bytevector representation of `object`.

#### `(byter-unpack bytevector)`

Parse `BYTEVECTOR`.

#### `(byter-append . bvs)`

Return a bytevector made of `BVS`.

#### `(byter-compare bytevector other)`

Return a symbol describing the position of `BYTEVECTOR`, compared to
`OTHER`:

- `'smaller` then `BYTEVECTOR` is smaller than `OTHER` (aka. before)

- `'equal` then `BYTEVECTOR` is equal to `OTHER`

- `'bigger` then `BYTEVECTOR` is bigger than `OTHER` (aka. after)

#### `(byter-next-prefix bytevector)`

Return the first bytevector bigger than `BYTEVECTOR` that is not
prefix of `BYTEVECTOR`.
