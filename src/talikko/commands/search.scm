
;; -*- coding: utf-8 -*-

(define-module talikko.commands.search
  (export
    search)
   (use file.util)
   (use text.csv)
   (require-extension (srfi 1 11 13))
   (use talikko)
   )
(select-module talikko.commands.search)

; search {{{

(define (search-find-package package)
  (let ((index-list
          (call-with-input-file
            (build-path ports-directory
                        index-file)
            (cut port->list
              (make-csv-reader #\|) <>))))
    (filter (^x (let ((x (map (^s (string-downcase s))
                              x)))
                  (or (string-scan (car x) package)
                    (string-scan (cadr x) package)
                    (string-scan (cadddr x) package))))
            index-list)))

(define (fetch-index-file)
  (when (not (file-exists? index-file))
    (print (string-append (colour-string colour-symbol ":: ")
                          (colour-string colour-message "Fetching INDEX file")))
    (with-cwd ports-directory
              (run-command-sudo '(make fetchindex)))))

(define (search package)
  (fetch-index-file)
  (print (string-append (colour-string colour-symbol ":: ")
                        (colour-string colour-message "Searching ")
                        (colour-string colour-package package)))
  (let1 found-list (search-find-package package)
    (for-each
      (lambda (x)
        (let ((package-name
                ; remove "/usr/ports/" from string
                (string-split
                  (string-drop (cadr x) 11)
                  #\/))
              (version
                (last (string-split
                        (car x)
                        #\-))))
          (let-values (((category name)
                        (values
                          (car package-name)
                          (cadr package-name))))
            (display
              (string-concatenate
                `(" "
                  ,(colour-string colour-package-category
                                  category)
                  "/"
                  ,(colour-string colour-package
                                  name))))
            (print
              (string-append " [" (colour-string colour-package-version version) "]"))
            (print
              (string-append "    " (colour-string 244  (cadddr x)))))))
      found-list)))

; }}}