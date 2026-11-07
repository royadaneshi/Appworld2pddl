(define (problem task-6c2c621-2)
  (:domain appworld-6c2c621-2)
  (:objects
    spencer-powell - person
    spencer-powell-at-gmail-com - username
    simple-note-password file-system-password - password
    simple-note-token file-system-token - token
    note-1 note-2 note-3 - note
    content-note-1 content-note-2 content-note-3 - content
    backups-notes-note-1-md backups-notes-note-2-md backups-notes-note-3-md - file-path)
  (:init
    (username-of spencer-powell spencer-powell-at-gmail-com)
    (password-for simple-note simple-note-password)
    (password-for file-system file-system-password)
    (note-content note-1 content-note-1)
    (note-content note-2 content-note-2)
    (note-content note-3 content-note-3)
    (note-file note-1 backups-notes-note-1-md)
    (note-file note-2 backups-notes-note-2-md)
    (note-file note-3 backups-notes-note-3-md))
  (:goal (and (exported note-1) (exported note-2) (exported note-3) (task-completed)))
)
