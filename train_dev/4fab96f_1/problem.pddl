(define (problem task-4fab96f-1)
  (:domain appworld-4fab96f-1)
  (:objects
    phone-number-3567801924 lindseysimpson-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-roommates - query
    relationship-roommates - relationship
    status-pending - status
    lindsey roommate-chris-mccoy roommate-jose-harrison roommate-paul-miller - person
    request-3464 request-3457 request-3455 request-3463 request-3470 request-3456 request-3461 - payment-request
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
    (is-roommate roommate-chris-mccoy)
    (is-roommate roommate-jose-harrison)
    (is-roommate roommate-paul-miller)
    (request-to request-3464 roommate-paul-miller)
    (request-to request-3457 roommate-jose-harrison)
    (request-to request-3455 roommate-jose-harrison)
    (request-to request-3463 roommate-paul-miller)
    (request-to request-3470 roommate-paul-miller)
    (request-to request-3456 roommate-jose-harrison)
    (request-to request-3461 roommate-paul-miller)
    (pending request-3464)
    (pending request-3457)
    (pending request-3455)
    (pending request-3463)
    (pending request-3470)
    (pending request-3456)
    (pending request-3461)
    (at-least-30-days-old request-3464)
    (at-least-30-days-old request-3457)
    (at-least-30-days-old request-3455)
    (at-least-30-days-old request-3463)
    (at-least-30-days-old request-3470)
    (at-least-30-days-old request-3456)
    (at-least-30-days-old request-3461))
  (:goal (and
    (reminded request-3464)
    (reminded request-3457)
    (reminded request-3455)
    (reminded request-3463)
    (reminded request-3470)
    (reminded request-3456)
    (reminded request-3461)
    (task-completed)))
)
