
;; -*- coding: utf-8 -*-

(define-module talikko.commands.update
  (export
    update
    update-source-tree)
  (use file.util)
  ;; internal libs
  (use talikko.väri)
  (use talikko.työkalu)
  (use talikko.env))
(select-module talikko.commands.update)

; update {{{
(define (update)
  (cond
    ((file-exists? "/usr/ports")
     (cond
       ((file-exists? "/usr/ports/.svn")
        (print (string-append (colour-string colour-symbol ":: ")
                              (colour-string colour-message "Updating ports tree")))
        (run-command-sudo '(svn up /usr/ports))
        (fetch-index-file))
       ((file-exists? "/usr/ports/.git")
        (current-directory "/usr/ports")
        (print (string-append (colour-string colour-symbol ":: ")
                              (colour-string colour-message "Updating ports tree")))
        (run-command-sudo '(git pull))
        (fetch-index-file))))
    (else
      (print (string-append (colour-string colour-symbol ":: ")
                            (colour-string colour-message "Get ports tree")))
      (run-command-sudo '(svn checkout -q http://svn.freebsd.org/ports/head /usr/ports))
      (fetch-index-file))))

(define (fetch-index-file)
  (when (not (file-exists? index-file))
    (print (string-append (colour-string colour-symbol ":: ")
                          (colour-string colour-message "Fetching INDEX file")))
    (with-cwd ports-directory
              (run-command-sudo '(make fetchindex)))))
; }}}

;; srcup {{{
;; update kernel source
(define (update-source-tree)
  (print (string-append (colour-string colour-symbol ":: ")
                        (colour-string colour-message "Updating source tree")))
  (cond
    ((file-exists? "/usr/src")
     (cond
       ((file-exists? "/usr/src/.svn")
        (run-command-sudo '(svn up /usr/src)))
       ((file-exists? "/usr/src/.git")
        (run-command-sudo '(git pull)
                     :directory "/usr/src"))))
    (else
      (run-command-sudo '(svn co -q http://svn.freebsd.org/base/head /usr/src)))))
;; }}}

