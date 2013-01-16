
(library (talikko commands update)
  (export update-ports
          update-source-tree)
  (import
    (silta base)
    (only (srfi :13 strings)
          string-contains
          string-join)
    (loitsu message)
    (loitsu file)
    (except (mosh)
            include
            read-line)
    (loitsu process))

  (begin

    (define (url-git? url)
      (string-contains url "git://"))

    (define (url-svn? url)
      (string-contains url "svn://"))

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
            (cond
              ((url-svn? addr)
               (run-command `(sudo "svn" "checkout" "-q" ,addr ,base-dir)))
              ((url-git? addr)
               (run-command `(sudo git clone ,addr ,base-dir))))))))


    (define(update-ports)
      (update "ports"
              "svn://svn0.us-west.freebsd.org/ports/head"))

    (define (update-source-tree)
      (update "src"
              "svn://svn0.us-west.freebsd.org/base/head"
              ; "git://github.com/freebsd/freebsd"
              ))

    ))
