
(library (talikko cli)
  (export runner)
  (import
    (rnrs)
    (match)
    (talikko commands))

  (begin

  (define (runner args)
    (match (cadr args)
      ; commands
      ("info"
       (info args))
      ((or "install" "i")
       (install args))
      ((or "deinstall" "remove" "rm")
       (deinstall args))
      ((or "re" "reinstall")
       (reinstall args))
      ("search"
       (search args))
      ("srcup"
       (update-source-tree))
      ("commands"
       (commands))
      ((or "update" "up")
       (update))
      )
    ))




  )