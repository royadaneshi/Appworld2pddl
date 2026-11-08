(define (problem task-0d01c76-1)
  (:domain appworld-0d01c76-1)
  (:objects
    adam-blackburn - person
    ad-blackburn-at-gmail-com - username
    file-system-password simple-note-password - password
    file-system-token simple-note-token - token
    dir-documents-personal-notes - directory
    md-file-1 md-file-2 md-file-3 - file
    title-1 title-2 title-3 - title
    content-1 content-2 content-3 - content
  )
  (:init
    (username-for file-system ad-blackburn-at-gmail-com)
    (username-for simple-note ad-blackburn-at-gmail-com)
    (password-for file-system file-system-password)
    (password-for simple-note simple-note-password)
    (file-in-directory md-file-1 dir-documents-personal-notes)
    (file-in-directory md-file-2 dir-documents-personal-notes)
    (file-in-directory md-file-3 dir-documents-personal-notes)
    (markdown-file md-file-1)
    (markdown-file md-file-2)
    (markdown-file md-file-3)
    (title-of md-file-1 title-1)
    (title-of md-file-2 title-2)
    (title-of md-file-3 title-3)
    (file-content md-file-1 content-1)
    (file-content md-file-2 content-2)
    (file-content md-file-3 content-3)
  )
  (:goal (and
    (imported md-file-1)
    (imported md-file-2)
    (imported md-file-3)
    (task-completed)
  ))
)
