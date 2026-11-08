(define (problem task-d037dc8-1)
  (:domain appworld-d037dc8-1)
  (:objects
    paul-miller roommate-1 roommate-2 - person
    paul-mill-at-gmail-com phone-3379617841 - username
    amazon-password venmo-password phone-password - password
    amazon-token venmo-token phone-token - token
    roommate-1-email roommate-2-email - email
    relationship-roommate - relationship
    amount-share - amount
    note-for-shared-purchases-on-amazon - description
  )
  (:init
    (username-for amazon paul-mill-at-gmail-com)
    (username-for venmo paul-mill-at-gmail-com)
    (username-for phone phone-3379617841)
    (password-for amazon amazon-password)
    (password-for venmo venmo-password)
    (password-for phone phone-password)
    (roommate roommate-1)
    (roommate roommate-2)
    (email-of roommate-1 roommate-1-email)
    (email-of roommate-2 roommate-2-email)
    (roommate-relationship relationship-roommate)
    (share-amount amount-share)
    (request-note note-for-shared-purchases-on-amazon)
  )
  (:goal (and
    (request-sent roommate-1)
    (request-sent roommate-2)
    (task-completed)
  ))
)
