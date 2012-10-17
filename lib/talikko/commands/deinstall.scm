
;; -*- coding: utf-8 -*-

(define-module talikko.commands.deinstall
  (export
    deinstall-package)
   (use file.util)
   (use text.csv)
   (require-extension (srfi 1 11 13))
   (use talikko)
   )
(select-module talikko.commands.deinstall)

; deinstall {{{
(define (deinstall-package package)
  (current-directory (build-path ports-directory package))
  (print (colour-string colour-symbol ":: ")
                  (colour-string colour-message "Deinstalling ")
                  (colour-string colour-package package))
  (colour-command "sudo make deinstall"
                  #/^(===>  )Patching (.*$)/   "[38;5;99m *[0m Applying patch \\2"
                  #/^===>/   "[38;5;39m>>>[0m"
                  #/\*\*\*.*$/    "[38;5;3m\\0[0m"))

; }}}
