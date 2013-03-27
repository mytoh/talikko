(library (talikko commands reinstall)
    (export
      reinstall)
  (import
    (silta base)
    (talikko commands deinstall)
    (loitsu file)
    (loitsu message)
    (loitsu process)
    (maali))

  (begin

    (define (reinstall args)
      (let ((packages (cddr args)))
        (for-each
            (lambda (package)
              (let ((package-path (build-path "/usr/ports" package)))
                (set-current-directory! package-path)
                (ohei (string-append "reinstalling " package))
                (run-command '(sudo make clean))
                (run-command '(sudo make config))
                (run-command '(sudo make))
                (run-command '(sudo make deinstall))
                (run-command '(sudo make install clean))))
          packages)))

    ))
