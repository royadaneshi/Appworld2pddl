(define (problem task-0d01c76-2)
  (:domain appworld-0d01c76-2)
  (:objects
    glen-moore - person
    gl-moore-at-gmail-com - username
    file-system-password simple-note-password - password
    fs-token sn-token - token
    dir-documents-personal-simple-note - directory-path
    md-file-1 md-file-2 md-file-3 non-md-file-1 - file
    md-file-1-path md-file-2-path md-file-3-path non-md-file-1-path - file-path
    title-1 title-2 title-3 - note-title
    content-1 content-2 content-3 - note-content
  )
  (:init
    (password-for file-system file-system-password)
    (password-for simple-note simple-note-password)
    (in-directory md-file-1 dir-documents-personal-simple-note)
    (in-directory md-file-2 dir-documents-personal-simple-note)
    (in-directory md-file-3 dir-documents-personal-simple-note)
    (in-directory non-md-file-1 dir-documents-personal-simple-note)
    (path-of md-file-1 md-file-1-path)
    (path-of md-file-2 md-file-2-path)
    (path-of md-file-3 md-file-3-path)
    (path-of non-md-file-1 non-md-file-1-path)
    (is-markdown md-file-1)
    (is-markdown md-file-2)
    (is-markdown md-file-3)
    (title-of md-file-1 title-1)
    (title-of md-file-2 title-2)
    (title-of md-file-3 title-3)
    (content-of md-file-1 content-1)
    (content-of md-file-2 content-2)
    (content-of md-file-3 content-3)
  )
  (:goal (and
    (imported md-file-1)
    (imported md-file-2)
    (imported md-file-3)
    (task-completed)
  ))
)
