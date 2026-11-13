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
    (credential-of-app simple-note tr-solo-at-gmail-com)
    (credential-of-app simple-note simple-note-password)
    (credential-of-app simple-note simple-note-token)
    (credential-of-app file-system tr-solo-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (password-for simple-note simple-note-password)
    (password-for file-system file-system-password)
    (query-finds query-habit habit-tracker-note)
    (content-for habit-csv-content habit-tracker-note))
  (:goal (and
    (file-created downloads-habit-tracker-csv habit-csv-content)
    (task-completed))))
