(define (problem task-0d01c76-3)
  (:domain appworld-0d01c76-3)
  (:objects
    stacy - person
    st-maldonado-at-gmail-com - username
    file-system-password simple-note-password - password
    file-system-token simple-note-token - token
    dir-personal-notes - directory
    md-file-1 md-file-2 readme-txt - file
    title-1 title-2 - title
    content-1 content-2 - content
    note-1 note-2 - note
  )
  (:init
    (username-for file-system st-maldonado-at-gmail-com)
    (username-for simple-note st-maldonado-at-gmail-com)
    (password-for file-system file-system-password)
    (password-for simple-note simple-note-password)
    (token-for file-system file-system-token)
    (token-for simple-note simple-note-token)
    (in-directory md-file-1 dir-personal-notes)
    (in-directory md-file-2 dir-personal-notes)
    (in-directory readme-txt dir-personal-notes)
    (markdown md-file-1)
    (markdown md-file-2)
    (title-of md-file-1 title-1)
    (title-of md-file-2 title-2)
    (content-of md-file-1 content-1)
    (content-of md-file-2 content-2)
    (note-for note-1 md-file-1)
    (note-for note-2 md-file-2)
  )
  (:goal (and
    (note-created note-1)
    (note-created note-2)
    (task-completed)
  ))
)
