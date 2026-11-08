(define (problem task-a30375d-1)
  (:domain appworld-a30375d-1)
  (:objects
    angela - person
    angriddle-at-gmail-com - username
    pw-simple-note - password
    token-simple-note - token
    query-funny-quotes - query
    note-funny-quotes - note
    funny-quote - quote)
  (:init
    (password-for simple-note pw-simple-note)
    (note-matches query-funny-quotes note-funny-quotes)
    (quote-in-note funny-quote note-funny-quotes))
  (:goal (and (found-quote funny-quote) (task-completed)))
)
