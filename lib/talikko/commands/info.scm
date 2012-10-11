
;; -*- coding: utf-8 -*-

(define-module talikko.commands.info
  (export
    info)
   (use file.util)
   (require-extension (srfi 1 13))
   (use maali)
   ;; internal libs
   (use talikko.väri)
   (use talikko.env))
(select-module talikko.commands.info)


; info {{{
(define (package-list)
  (map simplify-path
       (directory-list package-directory :children? #t)))

(define (info-find-packages name)
  #| display installed package information|#
  (let1 list-packages (lambda (n)
                        (filter
                          (lambda (s)
                            (string-scan s n))
                          (package-list)))
    (map
      (lambda (s)
        (let* ((full-name (string-split s "-"))
               (version-number (last full-name)))
          (list
            (string-join
              (remove
                (lambda (x) (eq? x version-number)) full-name)
              "-")
            version-number
            (file->string (build-path package-directory s "+COMMENT")))))
      (list-packages name))))

(define (info name)
  (let ((lst (info-find-packages name)))
    (cond
      ((null? lst)
       (print (paint "no package found" colour-message)))
      (else
        (map (lambda (x)
               (print
                 (string-concatenate
                   `(" "
                     ,(paint (car x) colour-package)
                     " "
                     "["
                     ,(paint (cadr x) 172)
                     "]")))
               (display "    ")
               (display (caddr x))
               (newline))
             lst)))))
; }}}
