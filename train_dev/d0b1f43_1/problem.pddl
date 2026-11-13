(define (problem task-d0b1f43-1)
  (:domain appworld-d0b1f43-1)
  (:objects
    edwin-wilson roommate - person
    phone-8506051563 ed-wilson-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    roommate-email - email
    query-roommates - query
    roommates - relationship
    date-2023-01-01 - datetime
    direction-sent - direction
    amount-total-sent - amount)
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone phone-8506051563)
    (username-for venmo ed-wilson-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (relationship-query query-roommates roommates)
    (contact-relationship roommate roommates)
    (contact-email roommate roommate-email)
    (threshold-date date-2023-01-01)
    (sent-direction direction-sent))
  (:goal (and (answer-known amount-total-sent) (task-completed)))
)
