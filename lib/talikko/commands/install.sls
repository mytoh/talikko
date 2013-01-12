
(library (talikko commands install)
  (export install)
  (import
    (silta base)
    (loitsu message)
    (loitsu file)
    (loitsu process))

  (begin

    (define (install args)
      (let ((packages (cddr args)))
        (for-each
          (lambda (p)
            (set-current-directory! (build-path "/usr/ports" p))
            (ohei (string-append "install package " p "..."))
            (run-command '(sudo make install)))
          packages)))

    )
  )
