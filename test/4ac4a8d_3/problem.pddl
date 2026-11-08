(define (problem task-4ac4a8d-3)
  (:domain appworld-4ac4a8d-3)
  (:objects
    bradley nancy glen - person
    bradley-ball-at-gmail-com phone-9294880327 - username
    phone-password gmail-password file-system-password - password
    phone-token gmail-token file-system-token - token
    query-nancy query-glen - query
    nancy-email glen-email - email
    nancy-expenses-thread - thread
    nancy-expenses-email - email-message
    forward-draft - draft
    note-prefixed-body - body
    bradley-trip-expenses-pdf - file-path
    draft-not-send-true - flag)
  (:init
    (username-for phone phone-9294880327)
    (username-for gmail bradley-ball-at-gmail-com)
    (username-for file-system bradley-ball-at-gmail-com)
    (password-for phone phone-password)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (token-for phone phone-token)
    (token-for gmail gmail-token)
    (token-for file-system file-system-token)
    (person-query nancy query-nancy)
    (person-query glen query-glen)
    (email-of nancy nancy-email)
    (email-of glen glen-email)
    (thread-from nancy-expenses-thread nancy-email)
    (email-in-thread nancy-expenses-email nancy-expenses-thread)
    (body-with-prefix note-prefixed-body)
    (is-true draft-not-send-true))
  (:goal (and
    (draft-sent forward-draft)
    (draft-forwards forward-draft nancy-expenses-email glen-email)
    (draft-body-prefixed forward-draft note-prefixed-body)
    (draft-has-attachment forward-draft bradley-trip-expenses-pdf)
    (task-completed)))
)
