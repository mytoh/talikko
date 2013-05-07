(library (talikko cli)
    (export runner)
  (import
    (silta base)
    (loitsu cli)
    (talikko commands))

  (begin

    (define (safe-cadr x)
      (cond ((list? x)
             (cadr x))
            (else
                '())))

    (define (runner args)
      (match-short-command (safe-cadr args)
        ;; commands
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
        ("commands"
         (commands))
        ((or "update" "up")
         (update args))
        (else
            (help))))
    ))
