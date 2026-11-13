(define (problem task-4fab96f-1)
  (:domain appworld-4fab96f-1)
  (:objects
    phone-number-3567801924 lindseysimpson-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-roommates - query
    relationship-roommates - relationship
    status-pending - status
    lindsey roommate-1 roommate-2 roommate-3 - person
    request-roommate-old-1 request-roommate-old-2 request-roommate-old-3 request-roommate-old-4 request-roommate-old-5 request-roommate-old-6 request-roommate-old-7 - payment-request
  )
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone phone-number-3567801924)
    (username-for venmo lindseysimpson-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (is-roommate roommate-1)
    (is-roommate roommate-2)
    (is-roommate roommate-3)
    (request-to request-roommate-old-1 roommate-3)
    (request-to request-roommate-old-2 roommate-2)
    (request-to request-roommate-old-3 roommate-2)
    (request-to request-roommate-old-4 roommate-3)
    (request-to request-roommate-old-5 roommate-3)
    (request-to request-roommate-old-6 roommate-2)
    (request-to request-roommate-old-7 roommate-3)
    (pending request-roommate-old-1)
    (pending request-roommate-old-2)
    (pending request-roommate-old-3)
    (pending request-roommate-old-4)
    (pending request-roommate-old-5)
    (pending request-roommate-old-6)
    (pending request-roommate-old-7)
    (at-least-30-days-old request-roommate-old-1)
    (at-least-30-days-old request-roommate-old-2)
    (at-least-30-days-old request-roommate-old-3)
    (at-least-30-days-old request-roommate-old-4)
    (at-least-30-days-old request-roommate-old-5)
    (at-least-30-days-old request-roommate-old-6)
    (at-least-30-days-old request-roommate-old-7))
  (:goal (and
    (reminded request-roommate-old-1)
    (reminded request-roommate-old-2)
    (reminded request-roommate-old-3)
    (reminded request-roommate-old-4)
    (reminded request-roommate-old-5)
    (reminded request-roommate-old-6)
    (reminded request-roommate-old-7)
    (task-completed)))
)
