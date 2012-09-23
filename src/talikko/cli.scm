;; -*- coding: utf-8 -*-

(define-module talikko.cli
  (export
    runner)
  (use gauche.parseopt)
  (require-extension (srfi 11))
  (use util.match)
  (use talikko.commands))
(select-module talikko.cli)

(define (usage status)
  (exit status "usage: ~a <command> <package-name>\n" "talikko"))

(define (runner args)
  (let-args (cdr args)
    ((do-search "S|search=s")
     (#f "h|help" (usage 0))
     . rest)
    (cond
      (do-search
        (search do-search))
      (else
        (match (car rest)
          ; commands
          ("info"
           (info (cadr rest)))
          ((or "update" "up")
           (update))
          ("install"
           (install (cadr rest)))
          ((or "deinstall" "remove")
           (deinstall-package (cadr rest)))
          ("reinstall"
           (reinstall-package (cadr rest)))
          ("search"
           (search (cadr rest)))
          ("srcup"
           (update-source-tree))
          (_ (usage 1))))))
  0)

