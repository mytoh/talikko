
(library (talikko commands update)
  (export update-ports
          update-source-tree)
  (import
    (rnrs)
    (only (srfi :13 strings)
          string-join)
    (loitsu message)
    (loitsu file)
    (except (mosh)
            read-line)
    (loitsu process))

  (begin

    (define(update base addr)
      (let ((base-dir (string-append "/usr/" base)))
      (cond
        ((file-exists? base-dir)
         (set-current-directory! base-dir)
         (ohei (string-append "updating " base " tree" ))
         (cond
           ((file-exists? (string-append base-dir "/.git"))
            (run-command '(sudo git pull)))
           ((file-exists? (string-append base-dir "/.svn"))
            (let ((out (process-output->string (string-append "sudo svn up " base-dir))))
              (format #t "~a\n" out)))))
        (else
          (ohei (string-append "Get " base " tree"))
          (run-command `(sudo "svn" "checkout" "-q" ,addr ,base-dir))))))


    (define(update-ports)
      (update "ports"
              "svn://svn0.us-west.freebsd.org/ports/head"))

    (define (update-source-tree)
      (update "src"
              "svn://svn0.us-west.freebsd.org/base/head"))

    ))
