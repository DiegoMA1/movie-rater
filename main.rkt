#|
Main file
Final Project
Programming Languages

Created by:
  Saul Montes de Oca A01025975
  Diego Moreno A01022113

|#

#lang racket
;(require "03_csv_data.rkt"
 ;        )
;(provide read-csv)

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


(define (eliminate-bad-movies filename-in rating)
    " Eliminates al the bad movies (above rating 4) "
    (define data (read-csv filename-in))
  (let loop
    ([data data]
     [result empty])
    (if (empty? data)
        result
        (if (< rating (string->number (car (cdr (car data)))))
            (loop (cdr data) (append result (list (car data))))
            (loop (cdr data) result ))))           
)


(define (getId dataset)
      (car dataset))

(define (eliminate-bad-movies-from-dataset dataset-fileName ratings-fileName rating)
    (define good-movies (eliminate-bad-movies ratings-fileName rating))
    (define dataset (read-csv dataset-fileName))
    (let row-datset-loop
        ([good-movies good-movies]
         [dataset (cdr dataset)]
         [result empty])
        (if (empty? dataset)
            result
            (row-datset-loop
                 good-movies
                 (cdr dataset)
                 (append result
                         (let good-movies-row-loop
                             ([datasetRow (car dataset)]
                              [good-movies good-movies])
                                  (if (empty? good-movies)
                                      '()
                                      (if (equal? (string->number (getId datasetRow))  (string->number (car (car good-movies))))
                                          (list datasetRow)
                                          (good-movies-row-loop datasetRow (cdr good-movies))))))))))


                 
(define (main f )

  " Eliminates al the bad movies (above a specific rating) "
    (eliminate-bad-movies-from-dataset "data/movies_metadata.csv" "data/ratings_prom.csv" 8.9)
)
