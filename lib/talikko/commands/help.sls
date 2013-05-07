
(library (talikko commands help)
    (export help)
  (import
    (silta base)
    (silta write))

  (begin

    (define (help)
      (display
          "Usage: talikko <command>
                 commands
                 update
                 install
                 deinstall
                 reinstall
                 info
                 search
                 help")
      (newline))

    ))
