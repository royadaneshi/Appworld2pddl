(define (problem task-a30375d-2)
  (:domain appworld-a30375d-2)
  (:objects
    michael-burch - person
    mi-burch-at-gmail-com - username
    simple-note-password - password
    simple-note-token - token
    query-inspirational - query
    inspirational-quotes-note - note
    random-inspirational-quote - quote)
  (:init
    (password-for simple-note simple-note-password)
    (note-about inspirational-quotes-note query-inspirational)
    (quote-in-note random-inspirational-quote inspirational-quotes-note))
  (:goal (and (found-quote random-inspirational-quote) (task-completed)))
)
