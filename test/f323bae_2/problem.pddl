(define (problem task-f323bae-2)
  (:domain appworld-f323bae-2)
  (:objects
    spencer-powell - person
    spencer-powell-at-gmail-com - username
    simple-note-password file-system-password - password
    simple-note-token file-system-token - token
    query-habit - query
    habit-tracking-log-note - note
    csv-habit-log - content
    backups-habit-log-csv - filepath
    backups-dir - dirpath
  )
  (:init
    (password-for simple-note simple-note-password)
    (password-for file-system file-system-password)
    (note-matches query-habit habit-tracking-log-note)
    (derives-csv habit-tracking-log-note csv-habit-log)
    (parent-dir backups-habit-log-csv backups-dir)
  )
  (:goal (and
    (file-created backups-habit-log-csv csv-habit-log)
    (task-completed)
  ))
)
