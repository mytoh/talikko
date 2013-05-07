(library (talikko cli)
    (export runner)
  (import
    (silta base)
    (silta write)
    (loitsu cli)
    (talikko commands))

  (begin

    (define (safe-cadr x)
      (cond ((and (pair? x)
               (> (length x) 1))
             (cadr x))
            (else
                "dummy")))

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
