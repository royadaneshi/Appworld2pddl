(define (problem task-d037dc8-2)
  (:domain appworld-d037dc8-2)
  (:objects
    edwin-wilson roommate-1 roommate-2 roommate-3 - person
    ed-wilson-at-gmail-com phone-8506051563 - username
    amazon-password phone-password venmo-password - password
    amazon-token phone-token venmo-token - token
    roommate-1-email roommate-2-email roommate-3-email - email
    order-1 order-2 order-3 - order
    share-per-roommate - amount
    note-amazon-purchases - note
    rel-roommate - relationship
  )
  (:init
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (username-for amazon ed-wilson-at-gmail-com)
    (username-for phone phone-8506051563)
    (username-for venmo ed-wilson-at-gmail-com)
    (token-for amazon amazon-token)
    (token-for phone phone-token)
    (token-for venmo venmo-token)
    (recent-order order-1)
    (recent-order order-2)
    (recent-order order-3)
    (share-of order-1 order-2 order-3 share-per-roommate)
    (roommate-relationship rel-roommate)
    (is-roommate roommate-1)
    (is-roommate roommate-2)
    (is-roommate roommate-3)
    (email-of roommate-1 roommate-1-email)
    (email-of roommate-2 roommate-2-email)
    (email-of roommate-3 roommate-3-email)
    (request-note note-amazon-purchases))
  (:goal (and
    (request-sent roommate-1 share-per-roommate note-amazon-purchases)
    (request-sent roommate-2 share-per-roommate note-amazon-purchases)
    (request-sent roommate-3 share-per-roommate note-amazon-purchases)
    (task-completed))))
