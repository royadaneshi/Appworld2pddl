(define (problem task-7847649-1)
  (:domain appworld-7847649-1)
  (:objects
    caitlin - person
    caiburc-at-gmail-com - username
    simple-note-password - password
    simple-note-token - token
    query-bucket-list - query
    bucket-list-note - note
    completed-count - count)
  (:init
    (password-for simple-note simple-note-password)
    (query-for query-bucket-list bucket-list-note)
    (answer-for bucket-list-note completed-count))
  (:goal (and (found-completed-count completed-count) (task-completed)))
)
