(define (problem task-7847649-3)
  (:domain appworld-7847649-3)
  (:objects
    james - person
    ja-solomon-at-gmail-com - username
    simple-note-password - password
    simple-note-token - token
    query-bucket-list - query
    bucket-list-note - note
    done-count - count)
  (:init
    (password-for simple-note simple-note-password)
    (note-matches-query bucket-list-note query-bucket-list)
    (done-count-of bucket-list-note done-count))
  (:goal (and (found-done-count bucket-list-note done-count)
              (task-completed)))
)
