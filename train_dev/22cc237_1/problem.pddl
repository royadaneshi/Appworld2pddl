(define (problem task-22cc237-1)
  (:domain appworld-22cc237-1)
  (:objects
    cody-smith coworker-1 - person
    phone-number-7826309761 cod-smith-at-gmail-com - username
    phone-password simple-note-password venmo-password - password
    phone-token simple-note-token venmo-token - token
    coworker-1-email coworker-2-email coworker-3-email - email
    query-coworker query-work-dinner - query
    relationship-coworker - relationship
    work-dinner-note - note
    share-coworker-1 - amount
    direction-received - direction
    date-2023-05-19 - date)
  (:init
    (username-for phone phone-number-7826309761)
    (username-for simple-note cod-smith-at-gmail-com)
    (username-for venmo cod-smith-at-gmail-com)
    (password-for phone phone-password)
    (password-for simple-note simple-note-password)
    (password-for venmo venmo-password)
    (token-of phone phone-token)
    (token-of simple-note simple-note-token)
    (token-of venmo venmo-token)
    (contact-query query-coworker)
    (note-query query-work-dinner)
    (coworker-email coworker-1 coworker-1-email)
    (coworker-email coworker-2 coworker-2-email)
    (coworker-email coworker-3 coworker-3-email)
    (share coworker-1 share-coworker-1)
    (share coworker-2 share-coworker-2)
    (share coworker-3 share-coworker-3)
    (already-paid coworker-1))
  (:goal (and
    (payment-request-sent coworker-2 share-coworker-2 work-dinner)
    (payment-request-sent coworker-3 share-coworker-3 work-dinner)
    (task-completed))))
