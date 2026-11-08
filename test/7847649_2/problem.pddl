(define (problem task-7847649-2)
  (:domain appworld-7847649-2)
  (:objects
    tammy-weaver - person
    ta-weav-at-gmail-com - username
    simple-note-password - password
    simple-note-token - token
    query-bucket-list - query
    bucket-list-note - note
    count-remaining - count)
  (:init
    (password-for simple-note simple-note-password)
    (note-matches query-bucket-list bucket-list-note)
    (answer-of bucket-list-note count-remaining))
  (:goal (and (found-remaining-count count-remaining)
              (task-completed)))
)
