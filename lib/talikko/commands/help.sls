
(library (talikko commands help)
    (export help)
  (import
    (silta base)
    (silta write))

  (begin

    (define (help)
      (display
          "Usage: talikko <command>
        install
        reinstall
        search <name>")
      (newline))

    ))
