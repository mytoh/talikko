

;; -*- coding: utf-8 -*-

(define-module talikko.työkalu
  (export
    run-command-sudo)
  (use gauche.process))
(select-module talikko.työkalu)

(define (run-command-sudo command)
  (run-process (append '(sudo) command) :wait #t))


(define-syntax run-command
  ; run processes
  (syntax-rules ()
    ((_ c1 )
     (run-process c1 :wait #t))
    ((_ c1 c2 ...)
     (begin
       (run-process c1 :wait #t)
       (run-command c2 ...)))))
