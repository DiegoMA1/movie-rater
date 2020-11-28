#|
Working with CSV files

Gil Echeverria
02/10/2020
|#

#lang racket

(define (read-csv filename-in)
    " Read the data contained in the file provided
    Return a list of lists with the data "
    (call-with-input-file filename-in 
        (lambda (in)
            (let loop
                ([line (read-line in)]
                 [result empty])
                (if (eof-object? line)
                    result
                    (loop
                        (read-line in)
                        (append
                            result
                            (list (string-split (string-trim line) ",")))))))))

(define (average-list data)
    (/ (foldl + 0 data) (length data)))

(define (average-rows-sample filename-in)
    " Compute the average in each row of the file
    Return a list with the averages "
    (define data (read-csv filename-in))
    (map
        (lambda (row)
           (average-list (map string->number row))) 
        (cdr data)))
#|
    (let loop
        ([data (cdr data)]
         [result empty])
        (if (empty? data)
            result
            (loop
                (cdr data)
                (append
                    result
                    (list (average-list (map string->number (car data)))))))))
    |#

(define (average-rows-solar filename-in)
    " Compute the average in each row of the file
    Return a list with the averages "
    (define data (read-csv filename-in))
    (map
        (lambda (row)
           (average-list (map string->number (cddddr row)))) 
        (cdr data)))
