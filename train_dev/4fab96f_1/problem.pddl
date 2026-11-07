(define (problem task-4fab96f-1)
  (:domain appworld-4fab96f-1)
  (:objects
    lindsey roommate-1 roommate-2 other-contact - person
    phone-number-3567801924 lindseysimpson-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-roommates - query
    relationship-roommates - relationship
    status-pending - status
    request-roommate-1-old request-roommate-2-old request-roommate-1-recent request-other-old - payment-request
  )
  (:init
    (username-for phone phone-number-3567801924)
    (username-for venmo lindseysimpson-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (is-roommate roommate-1)
    (is-roommate roommate-2)
    (request-to request-roommate-1-old roommate-1)
    (request-to request-roommate-2-old roommate-2)
    (request-to request-roommate-1-recent roommate-1)
    (request-to request-other-old other-contact)
    (pending request-roommate-1-old)
    (pending request-roommate-2-old)
    (pending request-roommate-1-recent)
    (pending request-other-old)
    (at-least-30-days-old request-roommate-1-old)
    (at-least-30-days-old request-roommate-2-old)
    (at-least-30-days-old request-other-old)
  )
  (:goal (and
    (reminded request-roommate-1-old)
    (reminded request-roommate-2-old)
    (task-completed)
  ))
)
