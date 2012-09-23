

;; -*- coding: utf-8 -*-

(define-module talikko.työkalu
  (export
    run-command-sudo
    with-cwd)
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

(define-macro (with-cwd dir . body)
  `(let ((cur (current-directory))
         (dest ,dir))
     (current-directory dest)
     ,@body
     (current-directory cur)))
