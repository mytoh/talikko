
(library (talikko commands package)
    (export
      package)
  (import
    (silta base)
    (silta write)
    (maali)
    (loitsu message)
    (loitsu file)
    (loitsu process)
    (loitsu string))

  (begin

    (define (install args)
      (let ((packages (cddr args)))
        (for-each
            (lambda (p)
              (set-current-directory! (build-path "/usr/ports" p))
              (ohei (string-append "install package " p "..."))
              (run-command '(sudo make install)))
          packages)))

    (define (package)
      (let* ((config (build-path (home-directory) ".talikko/ports"))
             (pkgs (file->string-list config)))
        (display pkgs)))

    ))
