#|
Main file
Final Project
Programming Languages

Created by:
  Saul Montes de Oca A01025975
  Diego Moreno A01022113

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
                            (list (string-split (string-trim line) ","))))))))); appending list of the splitingline of the csv


(define (eliminate-bad-movies filename-in rating)
    " Eliminates al the bad movies (above rating) "
    (define data (read-csv filename-in))
  (let loop
    ([data data]
     [result empty])
    (if (empty? data)
        result
        (if (< rating (string->number (car (cdr (car data))))); if the rating of the movie is above the specified rating
            (loop (cdr data) (append result (list (car data)))); adding it to the result
            (loop (cdr data) result ))))           ; if not just continue
)

; gets the id of a specified row
(define (getId dataset)
      (car dataset)
)

; eliminate bad movies from a dataset function
(define (eliminate-bad-movies-from-dataset dataset-fileName ratings-fileName rating)
    (define good-movies (eliminate-bad-movies ratings-fileName rating)); fetching all the good movies
    (define dataset (read-csv dataset-fileName)); fetching all the dataset
    (let row-datset-loop;dataset row loop
        ([good-movies good-movies]
         [dataset (cdr dataset)]
         [result empty])
        (if (empty? dataset) ; if there are no more rows in data set
            result; return result
            (row-datset-loop ; if not keep looping
                 good-movies
                 (cdr dataset)
                 (append result
                         (let good-movies-row-loop ; good movies row loop
                             ([datasetRow (car dataset)]
                              [good-movies good-movies])
                                  (if (empty? good-movies); if the movie was not found in the good movies list
                                      '(); return empty list
                                      (if (equal? (string->number (getId datasetRow))  (string->number (car (car good-movies)))); if the movies' id match
                                          (list datasetRow); add this row into the result 
                                          (good-movies-row-loop datasetRow (cdr good-movies)))))))))); if not just continue


; gets the name of a movie in a dataset
(define (get-movie-name row)
  (car(cdr(cdr(cdr row))))
)
; gets the popularity of a movie in a dataset
(define (get-popularity row)
  (car(cdr(cdr(cdr(cdr row)))))
)
; gets the revenue of a movie in a dataset
(define (get-revenue row)
  (car(cdr(cdr(cdr(cdr(cdr row))))))
)

;create new dataset function
(define (create-new-dataset dataset)
  "Creates a new data with movie name, id, popularity
   and revenue given a specific dataset"
    (let loop
          ([great-movies dataset]
            [result empty])
            (if (empty? great-movies); if there are no more great movies rows return result
                result
                (loop
                    (cdr great-movies)
                    ; appending all the key factors a movie has that made it a great movie
                    (append result (list (get-movie-name (car great-movies)) (getId (car great-movies)) (get-popularity (car great-movies)) (get-revenue (car great-movies))))))))


; gets the language a dataset
(define (get-movie-language row)
    (car(cdr(cdr row))))

(define (language-count language great-movies)
  "Parameters: language wanted as a string and the dataset to look in
   Returns the count of how many movies matched the specified language"
    (let loop
        ([great-movies great-movies]
        [n 0])
        (if (empty? great-movies)
            n
            (loop
                (cdr great-movies)
                (if (string=? (get-movie-language (car great-movies)) language)
                    (add1 n)
                    n
                )))))

(define (main file1 file2)
  " Eliminates al the bad movies from dataset above a specific rating (In this case,
    as we are going to be picky, we want all above rating 8)"
  (define great-movies (eliminate-bad-movies-from-dataset file1 file2 8))

  ;(create-new-dataset great-movies)
  (language-count "fr" great-movies)

)
