
;; -*- coding: utf-8 -*-

(define-module talikko.commands.commands
  (export
    commands)
  (use file.util)
  (use text.csv)
  (require-extension (srfi 1 11 13))
  (use talikko)
  )
(select-module talikko.commands.commands)

(define-macro (commands)
  (for-each
    print
    `,(map
        (lambda (path) (path-sans-extension path))
        (directory-list (build-path (sys-dirname (current-load-path))
                                    "commands")  
                        :children? #t)))
  )
