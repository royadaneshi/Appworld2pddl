(define (problem task-cf6abd2-2)
  (:domain appworld-cf6abd2-2)
  (:objects
    sierra-white - person
    siwhit-at-gmail-com - username
    simple-note-password - password
    simple-note-token - token
    query-bucket-list - query
    bucket-list-note - note
    content-bucket-list-unchecked - content
    taking-a-solo-backpacking-trip - activity
  )
  (:init
    (username-for simple-note siwhit-at-gmail-com)
    (password-for simple-note simple-note-password)
    (query-finds query-bucket-list bucket-list-note)
    (item-of bucket-list-note taking-a-solo-backpacking-trip)
    (unchecks content-bucket-list-unchecked taking-a-solo-backpacking-trip)
    (target-activity taking-a-solo-backpacking-trip)
  )
  (:goal (and
    (marked-not-done taking-a-solo-backpacking-trip)
    (task-completed)
  ))
)
