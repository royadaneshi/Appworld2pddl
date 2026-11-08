(define (problem task-7bdaf23-3)
  (:domain appworld-7bdaf23-3)
  (:objects
    denise - person
    deniseburch-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-cairo - query
    thread-cairo-flight - email-thread
    email-cairo-ticket - email
    attachment-cairo-ticket - attachment
    dir-documents-work - path)
  (:init
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (thread-matches query-cairo thread-cairo-flight)
    (thread-contains thread-cairo-flight email-cairo-ticket)
    (email-has-attachment email-cairo-ticket attachment-cairo-ticket)
    (ticket-attachment attachment-cairo-ticket)
    (target-directory dir-documents-work))
  (:goal (and
    (downloaded attachment-cairo-ticket dir-documents-work)
    (task-completed)))
)
