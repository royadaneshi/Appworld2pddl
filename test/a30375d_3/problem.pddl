(define (problem task-a30375d-3)
  (:domain appworld-a30375d-3)
  (:objects
    jeffrey - person
    jefsmith-at-gmail-com - username
    simple-note-password - password
    simple-note-token - token
    query-movie-quotes - query
    movie-quotes-note - note
    movie-quote - quote)
  (:init
    (username-for simple-note jefsmith-at-gmail-com)
    (password-for simple-note simple-note-password)
    (note-matches-query query-movie-quotes movie-quotes-note)
    (quote-in-note movie-quote movie-quotes-note))
  (:goal (and (found-quote movie-quote)
              (task-completed)))
)
