(define (problem task-6c2c621-1)
  (:domain appworld-6c2c621-1)
  (:objects
    anita-burch - person
    anita-burch-at-gmail-com - username
    simple-note-password file-system-password - password
    simple-note-token file-system-token - token
    note-1 note-2 note-3 - note
    content-note-1 content-note-2 content-note-3 - content
    backup-file-note-1 backup-file-note-2 backup-file-note-3 - file-path
  )
  (:init
    (supervisor anita-burch)
    (supervisor-username anita-burch-at-gmail-com)
    (password-for simple-note simple-note-password)
    (password-for file-system file-system-password)
    (token-for simple-note simple-note-token)
    (token-for file-system file-system-token)
    (content-of note-1 content-note-1)
    (content-of note-2 content-note-2)
    (content-of note-3 content-note-3)
    (backup-file-of note-1 backup-file-note-1)
    (backup-file-of note-2 backup-file-note-2)
    (backup-file-of note-3 backup-file-note-3)
    (next-note note-1 note-2)
    (next-note note-2 note-3)
    (next-note note-3 end-of-notes)
    (export-cursor note-1)
  )
  (:goal (and
    (export-cursor end-of-notes)
    (task-completed)
  ))
)
