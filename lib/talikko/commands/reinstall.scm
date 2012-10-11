
;; -*- coding: utf-8 -*-

(define-module talikko.commands.reinstall
  (export
    reinstall)
   (use file.util)
   (use text.csv)
   (use maali)
   (require-extension (srfi 1 11 13))
   (use talikko)
   (use talikko.commands.deinstall)
   )
(select-module talikko.commands.reinstall)


; reinstall {{{
(define (reinstall package)
  (current-directory (build-path ports-directory package))
  (print (string-append (paint ":: " colour-symbol)
                        (paint "Reinstalling " colour-message)
                        (paint package colour-package )))
  (run-command-sudo '(make clean))
  (run-command-sudo '(make config))
  (colour-command "sudo make"
                  #/^(===>  )Patching (.*$)/   "[38;5;99m *[0m Applying patch \\2"
                  #/^===>/   "[38;5;39m>>>[0m"
                  #/^=>/   "[38;5;99m>>>[0m"
                  #/\*\*\*.*$/    "[38;5;3m\\0[0m")
  (deinstall-package package)
  (colour-command "sudo make install clean"
                  #/^(===>  )Patching (.*$)/   "[38;5;99m *[0m Applying patch \\2"
                  #/^===>/   "[38;5;39m>>>[0m"
                  #/^=>/   "[38;5;99m>>>[0m"
                  #/\*\*\*.*$/    "[38;5;3m\\0[0m"))
; }}}
