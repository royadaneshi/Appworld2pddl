(define (problem task-3c13f5a-1)
  (:domain appworld-3c13f5a-1)
  (:objects
    joseharr-at-gmail-com phone-number-2474975253 - username
    phone-password file-system-password venmo-password - password
    phone-token file-system-token venmo-token - token
    query-roommate - query
    relationship-roommate - relationship
    dir-home - directory-path
    substring-electricity - substring
    entry-type-files - entry-type
    last-month-electricity-receipt - file-path
    amount-bill-share - amount
    note-for-electricity-bill - note
    jose roommate-1 roommate-2 roommate-3 - person
    roommate-email-1 roommate-email-2 roommate-email-3 - email
  )
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone phone-number-2474975253)
    (username-for file-system joseharr-at-gmail-com)
    (username-for venmo joseharr-at-gmail-com)
    (password-for phone phone-password)
    (password-for file-system file-system-password)
    (password-for venmo venmo-password)
    (roommate roommate-1)
    (roommate roommate-2)
    (roommate roommate-3)
    (contact-email roommate-1 roommate-email-1)
    (contact-email roommate-2 roommate-email-2)
    (contact-email roommate-3 roommate-email-3))
  (:goal (and
    (request-sent roommate-1 amount-bill-share note-for-electricity-bill)
    (request-sent roommate-2 amount-bill-share note-for-electricity-bill)
    (request-sent roommate-3 amount-bill-share note-for-electricity-bill)
    (task-completed))))
