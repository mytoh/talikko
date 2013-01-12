

(library (talikko commands deinstall)
  (export deinstall)
  (import
    (silta base)
    (only (srfi :13 strings)
          string-join)
    (loitsu message)
    (loitsu file)
    (loitsu process))

  (begin

    (define (deinstall args)
      (let ((packages (cddr args)))
        (for-each
          (lambda (p)
            (set-current-directory! (build-path "/usr/ports" p))
            (ohei (string-append "deinstall package " p))
            (run-command '(sudo make deinstall)))
          packages)))

    ))
