
;; -*- coding: utf-8 -*-

(define-module talikko.commands.update
  (export
    update
    update-source-tree)
  (use file.util)
  (use maali)
  ;; internal libs
  (use gauche.process)
  (use talikko))
(select-module talikko.commands.update)

; update {{{
(define (update)
  (cond
    ((file-exists? "/usr/ports")
     (cond
       ((file-exists? "/usr/ports/.svn")
        (print (string-append (paint ":: " colour-symbol)
                              (paint "Updating ports tree" colour-message)))
        (run-command-sudo '(svn up /usr/ports))
        (fetch-index-file))
       ((file-exists? "/usr/ports/.git")
        (current-directory "/usr/ports")
        (print (string-append (paint ":: " colour-symbol)
                              (paint "Updating ports tree" colour-message)))
        (run-command-sudo '(git pull))
        (fetch-index-file))))
    (else
      (print (string-append (paint ":: " colour-symbol)
                            (paint "Get ports tree" colour-message)))
      (run-command-sudo '(svn checkout -q http://svn.freebsd.org/ports/head /usr/ports))
      (fetch-index-file))))

(define (fetch-index-file)
  (when (not (file-exists? index-file))
    (print (string-append (paint ":: " colour-symbol)
                          (paint "Fetching INDEX file" colour-message)))
    (with-cwd ports-directory
              (run-command-sudo '(make fetchindex)))))
; }}}

;; srcup {{{
;; update kernel source
(define (update-source-tree)
  (print (string-append (paint ":: " colour-symbol)
                        (paint "Updating source tree" colour-message )))
  (cond
    ((file-exists? "/usr/src")
     (cond
       ((file-exists? "/usr/src/.svn")
        (run-command-sudo '(svn up /usr/src)))
       ((file-exists? "/usr/src/.git")
        (run-process '(sudo git pull)
                     :wait #t
                     :directory "/usr/src"))))
    (else
      (run-command-sudo '(svn co -q http://svn.freebsd.org/base/head /usr/src)))))
;; }}}

