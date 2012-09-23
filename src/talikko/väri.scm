
;; -*- coding: utf-8 -*-

(define-module talikko.väri
  (export
    colour-string
    colour-message
    colour-symbol
    colour-package
    colour-package-category
    colour-package-description
    colour-package-version)
  (use srfi-13))
(select-module talikko.väri)

(define (colour-string colour-number s)
  ;; take number, string -> return string
  (cond
    ((string? s)
     (string-concatenate
       `("[38;5;" ,(number->string colour-number) "m"
         ,s
         "[0m")))
    (else
     (string-concatenate
       `("[38;5;" ,(number->string colour-number) "m"
         ,s
         "[0m")))))

;; colour values, 256 terminal colour
(define-constant colour-message  138)
(define-constant colour-symbol   97)
(define-constant colour-package  49)
(define-constant colour-package-category 172)
(define-constant colour-package-version  142)
(define-constant colour-package-description  244)
