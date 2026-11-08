(define (problem task-92fe421-3)
  (:domain appworld-92fe421-3)
  (:objects
    paul-miller roommate-1 roommate-2 roommate-3 - person
    paul-mill-at-gmail-com phone-3379617841 - username
    amazon-password phone-password venmo-password - password
    amazon-token phone-token venmo-token - token
    roommate-1-email roommate-2-email roommate-3-email - email
    amount-prime-share - amount
    description-amazon-prime-subscription - description
    relationship-roommate - relationship
    query-prime - query)
  (:init
    (username-for amazon paul-mill-at-gmail-com)
    (username-for phone phone-3379617841)
    (username-for venmo paul-mill-at-gmail-com)
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (token-for amazon amazon-token)
    (token-for phone phone-token)
    (token-for venmo venmo-token)
    (roommate roommate-1)
    (roommate roommate-2)
    (roommate roommate-3)
    (contact-email roommate-1 roommate-1-email)
    (contact-email roommate-2 roommate-2-email)
    (contact-email roommate-3 roommate-3-email)
    (already-paid roommate-3)
    (share-amount amount-prime-share)
    (request-description description-amazon-prime-subscription)
    (roommate-relationship relationship-roommate)
    (payment-query query-prime))
  (:goal (and (request-sent roommate-1) (request-sent roommate-2) (task-completed))))
