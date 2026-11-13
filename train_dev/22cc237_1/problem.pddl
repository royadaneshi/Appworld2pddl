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
    email-kayla email-sandra email-stephen email-jamie email-anita email-travis email-sabrina - email
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
    (coworker-email coworker-kayla email-kayla)
    (coworker-email coworker-sandra email-sandra)
    (coworker-email coworker-stephen email-stephen)
    (coworker-email coworker-jamie email-jamie)
    (coworker-email coworker-anita email-anita)
    (coworker-email coworker-travis email-travis)
    (coworker-email coworker-sabrina email-sabrina)
    (share coworker-kayla share-kayla)
    (share coworker-sandra share-sandra)
    (share coworker-stephen share-stephen)
    (share coworker-jamie share-jamie)
    (share coworker-anita share-anita)
    (share coworker-travis share-travis)
    (share coworker-sabrina share-sabrina)
    (already-paid coworker-kayla)
    (already-paid coworker-jamie)
    (already-paid coworker-anita)
    (already-paid coworker-sabrina))
  (:goal (and
    (payment-request-sent coworker-sandra share-sandra work-dinner)
    (payment-request-sent coworker-stephen share-stephen work-dinner)
    (payment-request-sent coworker-travis share-travis work-dinner)
    (task-completed))))
