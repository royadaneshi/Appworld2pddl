(define (problem task-4ac4a8d-1)
  (:domain appworld-4ac4a8d-1)
  (:objects
    james denise glenn - person
    ja-solomon-at-gmail-com phone-8683971586 - username
    phone-password gmail-password file-system-password - password
    phone-token gmail-token file-system-token - token
    query-denise query-glenn - query
    denise-email glenn-email - email
    denise-expenses-thread - thread
    forward-draft - draft
    body-with-note - body
    expenses-james-pdf - filepath
    true - boolean)
  (:init
    (password-for phone phone-password)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (query-for query-denise denise)
    (query-for query-glenn glenn)
    (contact-email denise denise-email)
    (contact-email glenn glenn-email)
    (thread-from denise-expenses-thread denise)
    (flag-true true)
    (note-prefixed-body body-with-note)
    (attachment-file expenses-james-pdf))
  (:goal (and (thread-forwarded denise-expenses-thread glenn-email) (task-completed))))
