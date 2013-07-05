(library (talikko commands update)
    (export
      update)
  (import
    (silta base)
    (silta write)
    (silta cxr)
    (only (srfi :13 strings)
          string-contains
          string-join)
    (loitsu match)
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

    (define (get-source url base)
      (let ((base-dir (string-append "/usr/" base)))
        (ohei (string-append "get" ))
        (cond
          ((url-svn? url)
           (run-command `(sudo "svnlite" "checkout" "-q" ,url ,base-dir)))
          ((url-git? url)
           (run-command `(sudo git clone ,url ,base-dir))))))

    (define (fetch-index)
      (run-command '("sudo" "make" "-C"  "/usr/ports" "fetchindex")))

    (define (%update base url)
      (let ((base-dir (string-append "/usr/" base)))
        (cond
          ((file-exists? base-dir)
           (set-current-directory! base-dir)
           (ohei (string-append "updating " base " tree" ))
           (cond
             ((file-exists? (string-append base-dir "/.git"))
              (run-command '(sudo git pull)))
             ((file-exists? (string-append base-dir "/.svn"))
              (let ((out (process-output->string (string-append "sudo svnlite up " base-dir))))
                (format #t "~a\n" out)))))
          (else
              (get-source url base)))))


    (define(update-ports)
      (%update "ports"
               "svn://svn0.us-west.freebsd.org/ports/head")
      (fetch-index))

    (define (update-source-tree)
      (%update "src"
               "svn://svn0.us-west.freebsd.org/base/head"
               ;; "git://github.com/freebsd/freebsd"
               ))


    (define (update args)
      (match (cddr args)
        (() (update-ports))
        (("ports")
         (update-ports))
        (("source")
         (update-source-tree))))


    ))
