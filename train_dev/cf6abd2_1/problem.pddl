(define (problem task-cf6abd2-1)
  (:domain appworld-cf6abd2-1)
  (:objects
    ronald - person
    ron-harrison-at-gmail-com - username
    simple-note-password - password
    simple-note-token - token
    query-bucket-list - query
    bucket-list-note - note
    bucket-list-content - content
    bucket-list-content-cooking-done - content
    cooking-signature-dish - activity)
  (:init
    (supervisor-username ron-harrison-at-gmail-com)
    (password-for simple-note simple-note-password)
    (owns-note ronald bucket-list-note)
    (matches-query bucket-list-note query-bucket-list)
    (note-has-content bucket-list-note bucket-list-content)
    (note-contains bucket-list-note cooking-signature-dish)
    (content-marks-done bucket-list-content-cooking-done bucket-list-content cooking-signature-dish))
  (:goal (and
    (activity-marked-done bucket-list-note cooking-signature-dish)
    (task-completed))))
