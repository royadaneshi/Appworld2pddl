(define (problem task-6c2c621-3)
  (:domain appworld-6c2c621-3)
  (:objects
    patricia-ritter - person
    pa-ritter-at-gmail-com - username
    simple-note-password file-system-password - password
    simple-note-token file-system-token - token
    note-1 note-2 note-3 - note
    content-of-note-1 content-of-note-2 content-of-note-3 - content
    backup-path-note-1 backup-path-note-2 backup-path-note-3 - file-path)
  (:init
    (supervisor patricia-ritter)
    (supervisor-username pa-ritter-at-gmail-com)
    (password-for simple-note simple-note-password)
    (password-for file-system file-system-password)
    ; every note has a content and a target path ~/backups/simple_notes/<title with spaces as _>.md
    (note-content note-1 content-of-note-1)
    (note-content note-2 content-of-note-2)
    (note-content note-3 content-of-note-3)
    (note-file-path note-1 backup-path-note-1)
    (note-file-path note-2 backup-path-note-2)
    (note-file-path note-3 backup-path-note-3)
    ; enumeration order of the notes returned by search_notes; no-more-notes marks the end of the list
    (next-note note-1 note-2)
    (next-note note-2 note-3)
    (next-note note-3 no-more-notes)
    (all-exported-before note-1))
  ; (all-exported-before no-more-notes) holds exactly when every note has been exported as a .md file
  (:goal (and (all-exported-before no-more-notes) (task-completed)))
)
