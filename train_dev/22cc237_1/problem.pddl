(define (problem task-22cc237-1)
  (:domain appworld-22cc237-1)
  (:objects
    phone-number-7826309761 cod-smith-at-gmail-com - username
    phone-password simple-note-password venmo-password - password
    phone-token simple-note-token venmo-token - token
    query-coworker query-work-dinner - query
    relationship-coworker - relationship
    work-dinner-note - note
    direction-received - direction
    date-2023-05-19 - date
    cody-smith - person
    coworker-email-1 coworker-email-2 coworker-email-3 coworker-email-4 coworker-email-5 coworker-email-6 coworker-email-7 - email
  )
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
    (coworker-email coworker-1 coworker-email-1)
    (coworker-email coworker-5 coworker-email-2)
    (coworker-email coworker-6 coworker-email-3)
    (coworker-email coworker-2 coworker-email-4)
    (coworker-email coworker-3 coworker-email-5)
    (coworker-email coworker-7 coworker-email-6)
    (coworker-email coworker-4 coworker-email-7)
    (share coworker-1 share-coworker-1)
    (share coworker-5 share-coworker-5)
    (share coworker-6 share-coworker-6)
    (share coworker-2 share-coworker-2)
    (share coworker-3 share-coworker-3)
    (share coworker-7 share-coworker-7)
    (share coworker-4 share-coworker-4)
    (already-paid coworker-1)
    (already-paid coworker-2)
    (already-paid coworker-3)
    (already-paid coworker-4))
  (:goal (and
    (payment-request-sent coworker-5 share-coworker-5 work-dinner)
    (payment-request-sent coworker-6 share-coworker-6 work-dinner)
    (payment-request-sent coworker-7 share-coworker-7 work-dinner)
    (task-completed))))
