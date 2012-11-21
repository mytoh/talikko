
(library (talikko commands info)
  (export
    info)
  (import
    (scheme base)
    (scheme file)
    (scheme write)
    (only (srfi :1)
          find)
    (srfi :2 and-let*)
    (irregex)
    (loitsu maali)
    (loitsu message)
    (loitsu file)
    (loitsu process)
    (loitsu string)
    )

  (begin

    (define (package-installed? package)
      (find
        (lambda (p)
          (irregex-search package p))
        (directory-list2 "/var/db/pkg")))

    (define (info args)
      (let ((packages (cddr args)))
        (if (null? packages)
          (let ((installed-packages (directory-list2 "/var/db/pkg")))
            (display packages)
            (newline)
            (display installed-packages))
          (for-each
            (lambda (p)
              (let ((pac (package-installed? p)))
                (cond
                  (pac
                  (display (paint pac 172))
                  (newline))
                  (else
                  (display (string-append (paint p 172) " is not installed"))
                  (newline)))))
            packages))))

    ))
