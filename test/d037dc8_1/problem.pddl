(define (problem task-d037dc8-1)
  (:domain appworld-d037dc8-1)
  (:objects
    paul-miller roommate-1 roommate-2 roommate-3 - person
    paul-mill-at-gmail-com phone-3379617841 - username
    amazon-password venmo-password phone-password - password
    amazon-token venmo-token phone-token - token
    roommate-1-email roommate-2-email roommate-3-email - email
    relationship-roommate - relationship
    amount-share - amount
    note-for-shared-purchases-on-amazon - description
  )
  (:init
    (credential-of-app phone phone-3379617841)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app amazon paul-mill-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (credential-of-app venmo paul-mill-at-gmail-com)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for amazon paul-mill-at-gmail-com)
    (username-for venmo paul-mill-at-gmail-com)
    (username-for phone phone-3379617841)
    (password-for amazon amazon-password)
    (password-for venmo venmo-password)
    (password-for phone phone-password)
    (roommate roommate-1)
    (roommate roommate-2)
    (roommate roommate-3)
    (email-of roommate-1 roommate-1-email)
    (email-of roommate-2 roommate-2-email)
    (email-of roommate-3 roommate-3-email)
    (roommate-relationship relationship-roommate)
    (share-amount amount-share)
    (request-note note-for-shared-purchases-on-amazon))
  (:goal (and
    (request-sent roommate-1)
    (request-sent roommate-2)
    (request-sent roommate-3)
    (task-completed)))
)
