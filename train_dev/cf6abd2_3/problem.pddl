(define (problem task-cf6abd2-3)
  (:domain appworld-cf6abd2-3)
  (:objects
    supervisor - person
    ja-solomon-at-gmail-com - username
    simple-note-password - password
    simple-note-token - token
    query-bucket-list - query
    bucket-list-note - note
    bucket-list-content bucket-list-content-eclipse-done - content
    witnessing-total-solar-eclipse - activity)
  (:init
    (password-for simple-note simple-note-password)
    (supervisor-username ja-solomon-at-gmail-com)
    (query-matches query-bucket-list bucket-list-note)
    (content-of bucket-list-note bucket-list-content)
    (activity-in-note witnessing-total-solar-eclipse bucket-list-note)
    (marks-done bucket-list-content-eclipse-done witnessing-total-solar-eclipse bucket-list-content))
  (:goal (and (activity-done witnessing-total-solar-eclipse bucket-list-note)
              (task-completed)))
)
