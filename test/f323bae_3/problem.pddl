(define (problem task-f323bae-3)
  (:domain appworld-f323bae-3)
  (:objects
    richard-riddle - person
    ric-riddle-at-gmail-com - username
    simple-note-password file-system-password - password
    simple-note-token file-system-token - token
    query-habit - query
    habit-log-note - note
    backups-simple-note-dir habits-csv-path - path
    habits-csv-content - content
    flag-true - flag)
  (:init
    (credential-of-app simple-note ric-riddle-at-gmail-com)
    (credential-of-app simple-note simple-note-password)
    (credential-of-app simple-note simple-note-token)
    (credential-of-app file-system ric-riddle-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (password-for simple-note simple-note-password)
    (password-for file-system file-system-password)
    (query-matches query-habit habit-log-note)
    (derived-from habits-csv-content habit-log-note)
    (is-dir backups-simple-note-dir)
    (parent-dir habits-csv-path backups-simple-note-dir)
    (export-target habits-csv-path habits-csv-content))
  (:goal (and (file-created habits-csv-path habits-csv-content) (task-completed))))
