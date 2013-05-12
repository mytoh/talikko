
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

    (define (install package)
      (set-current-directory! (build-path "/usr/ports" package))
      (ohei (string-append "install package " package "..."))
      (run-command '(sudo make config))
      (run-command '(sudo make install)))

    (define (package)
      (let* ((config (build-path (home-directory) ".talikko/ports"))
             (pkgs (file->string-list config)))
        (for-each
            install
          pkgs)))

    ))
