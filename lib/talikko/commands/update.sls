
(library (talikko commands update)
  (export update
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

    (define(update)
      (cond
        ((file-exists? "/usr/ports/.git")
         (set-current-directory! "/usr/ports")
         (ohei "updating ports tree" )
         (run-command '(sudo git pull)))
        ((file-exists? "/usr/ports/.svn")
         (set-current-directory! "/usr/ports")
         (ohei "updating ports tree" )
         (run-command '(sudo svn up /usr/ports)))
        (else
          (ohei "Get ports tree")
          (run-command '(sudo "svn" "checkout" "-q" "http://svn.freebsd.org/ports/head" "/usr/ports")))))

    (define (update-source-tree)
      (cond
        ((file-exists? "/usr/src")
         (ohei "update source tree" )
         (set-current-directory! "/usr/src")
         (cond
           ((file-exists? "/usr/src/.git")
            (run-command '(sudo git pull)))
           ((file-exists? "/usr/src/.svn")
            (let ((out (process-output->string "sudo svn up /usr/src")))
              (format #t "~a\n" out)))))
        (else
          (ohei "cloning source tree from svn" )
          (run-command '(sudo svn co -q http://svn.freebsd.org/base/head /usr/src))))))

  ; }}}




  )
