(define (problem task-a3ba388-1)
  (:domain appworld-a3ba388-1)
  (:objects
    ashley-moore manager - person
    as-moore-at-gmail-com phone-7336094411 - username
    gmail-password phone-password file-system-password - password
    gmail-token phone-token file-system-token - token
    manager-email - email
    query-resignation - query
    relationship-manager - relationship
    resignation-draft - draft
    resignation-pdf-path - file-path
    next-monday-9am - datetime)
  (:init
    (username-for gmail as-moore-at-gmail-com)
    (username-for file-system as-moore-at-gmail-com)
    (username-for phone phone-7336094411)
    (password-for gmail gmail-password)
    (password-for phone phone-password)
    (password-for file-system file-system-password)
    (token-for gmail gmail-token)
    (token-for phone phone-token)
    (token-for file-system file-system-token)
    (relationship-of manager relationship-manager)
    (email-of manager manager-email)
    (is-manager manager)
    (draft-matches query-resignation resignation-draft)
    (file-at resignation-pdf-path)
    (target-send-time next-monday-9am))
  (:goal (and
    (attached resignation-pdf-path resignation-draft)
    (draft-recipient resignation-draft manager-email)
    (draft-scheduled resignation-draft next-monday-9am)
    (task-completed))))
