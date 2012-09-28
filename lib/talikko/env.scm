
;; -*- coding: utf-8 -*-

(define-module talikko.env
  (export
    package-directory
    ports-directory
    index-file)
  )
(select-module talikko.env)

(define-constant package-directory "/var/db/pkg")
(define-constant ports-directory   "/usr/ports")
(define-constant index-file   (string-append
                                "INDEX-"
                                (car (string-split
                                       (caddr (sys-uname))
                                       "."))))

