;; -*- coding: utf-8 -*-

(define-module talikko.commands.install
  (export
    install)
   (use file.util)
   (use text.csv)
   (require-extension (srfi 1 11 13))
   (use talikko)
   )
(select-module talikko.commands.install)


; install {{{
(define (install package)
  (with-cwd (build-path ports-directory package)
            (print (string-append (colour-string colour-symbol ":: ")
                           (colour-string colour-message "Installing ")
                           (colour-string colour-package package)))
            (run-command-sudo '(make clean))
            (run-command-sudo '(make config-recursive))
            (colour-command "sudo make install clean"
                            #/^(===>  )Patching (.*$)/   "[38;5;99m *[0m Applying patch \\2"
                            #/^===>/   "[38;5;39m>>>[0m"
                            #/^=>/   "[38;5;99m>>>[0m"
                            #/\*\*\*.*$/    "[38;5;3m\\0[0m")))
; }}}



