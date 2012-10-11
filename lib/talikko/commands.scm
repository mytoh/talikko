
;; -*- coding: utf-8 -*-

(define-module talikko.commands
  (extend
    talikko.commands.update
    talikko.commands.info
    talikko.commands.search
    talikko.commands.install
    talikko.commands.deinstall
    talikko.commands.reinstall
    talikko.commands.commands
    )
  )
(select-module talikko.commands)
