(define (problem task-f323bae-1)
  (:domain appworld-f323bae-1)
  (:objects
    troy-solomon - person
    tr-solo-at-gmail-com - username
    simple-note-password file-system-password - password
    simple-note-token file-system-token - token
    query-habit - query
    habit-tracker-note - note)
  (:init
    (password-for simple-note simple-note-password)
    (password-for file-system file-system-password)
    (query-finds query-habit habit-tracker-note)
    (content-for habit-csv-content habit-tracker-note))
  (:goal (and
    (file-created downloads-habit-tracker-csv habit-csv-content)
    (task-completed))))
