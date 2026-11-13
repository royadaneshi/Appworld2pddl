(define (problem task-4ac4a8d-2)
  (:domain appworld-4ac4a8d-2)
  (:objects
    allison brandon jeffery - person
    allison-calhoun-at-gmail-com phone-3767193416 - username
    gmail-password phone-password file-system-password - password
    gmail-token phone-token file-system-token - token
    query-brandon query-jeffery - query
    brandon-email jeffery-email - email
    brandon-expenses-thread - thread
    forward-draft - draft
    trip-expenses-allison-pdf - file-path
    body-prefixed-with-split-note - body-text
    flag-true - flag
    datetime-2023-05-17 - datetime)
  (:init
    (credential-of-app phone phone-3767193416)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app gmail allison-calhoun-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app file-system allison-calhoun-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (username-for gmail allison-calhoun-at-gmail-com)
    (username-for file-system allison-calhoun-at-gmail-com)
    (username-for phone phone-3767193416)
    (password-for gmail gmail-password)
    (password-for phone phone-password)
    (password-for file-system file-system-password)
    (query-for query-brandon brandon)
    (query-for query-jeffery jeffery)
    (email-of brandon brandon-email)
    (email-of jeffery jeffery-email)
    (thread-from brandon-expenses-thread brandon)
    (forward-target jeffery)
    (is-true flag-true)
    (yesterday datetime-2023-05-17)
    (prefixed-body body-prefixed-with-split-note)
    (my-expenses-file trip-expenses-allison-pdf))
  (:goal (and
    (forwarded brandon-expenses-thread jeffery-email)
    (sent-with-attachment brandon-expenses-thread trip-expenses-allison-pdf)
    (sent-with-prefix brandon-expenses-thread)
    (task-completed)))
)
