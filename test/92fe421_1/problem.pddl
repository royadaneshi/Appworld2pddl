(define (problem task-92fe421-1)
  (:domain appworld-92fe421-1)
  (:objects
    nancy roommate-a roommate-b roommate-c - person
    nan-ritt-at-gmail-com phone-2307354647 - username
    amazon-password phone-password venmo-password - password
    amazon-token phone-token venmo-token - token
    roommate-a-email roommate-b-email roommate-c-email - email
    amount-share - amount
    note-amazon-subscription - note
    relationship-roommate - relationship
    datetime-2023-05-17t00-00-00 - datetime)
  (:init
    (username-for amazon nan-ritt-at-gmail-com)
    (username-for phone phone-2307354647)
    (username-for venmo nan-ritt-at-gmail-com)
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (token-for amazon amazon-token)
    (token-for phone phone-token)
    (token-for venmo venmo-token)
    (roommate roommate-a)
    (roommate roommate-b)
    (roommate roommate-c)
    (email-of roommate-a roommate-a-email)
    (email-of roommate-b roommate-b-email)
    (email-of roommate-c roommate-c-email)
    (already-paid roommate-c)
    (share-amount amount-share)
    (request-note note-amazon-subscription)
    (roommate-relationship relationship-roommate)
    (yesterday datetime-2023-05-17t00-00-00))
  (:goal (and (request-sent roommate-a) (request-sent roommate-b) (task-completed)))
)
