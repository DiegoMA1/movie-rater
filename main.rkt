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
        (if (< rating (string->number  (car (cdr (car data)))))
            (loop (cdr data) (append result (list (car data))))
            (loop (cdr data) result ))))           
)


(define (getId dataset)
  (car(cdr(cdr(cdr(cdr(cdr(cdr (cdr (cdr (cdr (cdr (cdr (cdr (cdr dataset)))))))))))))))


(define (eliminate-bad-movies-from-dataset dataset-fileName ratings-fileName)
    (define good-movies (eliminate-bad-movies "data/ratings_prom.csv" 4))
    (define dataset (read-csv "data/movies_metadata.csv"))
    (let row-datset-loop
        ([good-movies good-movies]
         [dataset (cdr dataset)]
         [good-moviesUntouched good-movies]
         [result empty])
        (if (empty? dataset)
            result
            (row-datset-loop
                 good-movies
                 (cdr dataset)
                 good-moviesUntouched
                 (append result
                         (let good-movies-row-loop
                             ([dataset dataset]
                              [good-movies good-movies]
                              [good-moviesUntouched good-moviesUntouched]
                              [result result])



                           
                                  (if (empty? good-movies)
                                      ()
                                      (if (equals? (string->number (getId (car dataset))) (car (car good-movies)))
                                          (list (car dataset))
                                          (good-movies-row-loop (cdr good-movies) (cdr dataset) datasetUntouched good-moviesUntouched result)
                                          )


                 
(define (main f )
    " Eliminates al the bad movies (above rating 4) "
  (define dataset (read-csv "data/movies_metadata.csv"))
  (getId (car (cdr dataset)))
)
