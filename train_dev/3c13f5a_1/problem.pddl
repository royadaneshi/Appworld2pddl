(define (problem task-3c13f5a-1)
  (:domain appworld-3c13f5a-1)
  (:objects
    jose roommate-1 roommate-2 - person
    joseharr-at-gmail-com phone-number-2474975253 - username
    phone-password file-system-password venmo-password - password
    phone-token file-system-token venmo-token - token
    roommate-1-email roommate-2-email - email
    query-roommate - query
    relationship-roommate - relationship
    dir-home - directory-path
    substring-electricity - substring
    entry-type-files - entry-type
    last-month-electricity-receipt - file-path
    amount-bill-share - amount
    note-for-electricity-bill - note)
  (:init
    (username-for phone phone-number-2474975253)
    (username-for file-system joseharr-at-gmail-com)
    (username-for venmo joseharr-at-gmail-com)
    (password-for phone phone-password)
    (password-for file-system file-system-password)
    (password-for venmo venmo-password)
    (roommate roommate-1)
    (roommate roommate-2)
    (contact-email roommate-1 roommate-1-email)
    (contact-email roommate-2 roommate-2-email))
  (:goal (and
    (request-sent roommate-1 amount-bill-share note-for-electricity-bill)
    (request-sent roommate-2 amount-bill-share note-for-electricity-bill)
    (task-completed))))
