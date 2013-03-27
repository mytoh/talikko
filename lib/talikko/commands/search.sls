(library (talikko commands search)
    (export
      search)
  (import
    (silta base)
    (silta cxr)
    (silta write)
    (only (srfi :1 lists)
          last
          drop-right
          filter)
    (only (srfi :13 strings)
          string-contains-ci
          string-join)
    (srfi :48 intermediate-format-strings)
    (maali)
    (loitsu message)
    (loitsu file)
    (loitsu process)
    (loitsu string))

  (begin

    (define index-file
      (let ((version (car (string-split (process-output->string "uname -r")
                                        #\.))))
        (string-append "/usr/ports/INDEX-" version)))

    (define (search args)
      (let* ((package (caddr args))
             (found-list (find-package package)))
        (for-each
            (lambda (x)
              (let ((name (if (< 2 (length (string-split (car x) #\-)))
                            (string-join
                                (drop-right (string-split (car x) #\-) 1)
                              "-")
                            (car (string-split (car x) #\-))))
                    (version (last (string-split (car x) #\-)))
                    (category (last (string-split (path-dirname (cadr x))
                                                  #\/)))
                    (desc (cadddr x)))
                (format #t "~a/~a [~a]\n"
                        (paint category 94)
                        (paint name 111)
                        (paint version 58))
                (format #t "    ~a\n" desc)))
          found-list)))

    (define (get-index)
      (when (not (file-exists? index-file))
        (ohei "fetching index file")
        (set-current-directory! "/usr/ports")
        (run-command '(sudo make fetchindex))))

    (define (find-package package)
      (get-index)
      (ohei (string-append
                "Searching " package))
      (let ((index-list (map (lambda (s) (string-split s #\|))
                          (file->string-list index-file))))
        (filter (lambda (x)
                  (or (string-contains-ci (car x) package)
                    (string-contains-ci (cadr x) package)
                    (string-contains-ci (cadddr x) package)))
          index-list)))

    ))
