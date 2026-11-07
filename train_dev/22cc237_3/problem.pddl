(define (problem task-22cc237-3)
  (:domain appworld-22cc237-3)
  (:objects
    grant-martinez - person
    phone-7056722825 gra-martinez-at-gmail-com - username
    phone-password simple-note-password venmo-password - password
    phone-token simple-note-token venmo-token - token
    query-coworker query-dinner-with-colleagues - query
    relationship-coworker - relationship
    note-dinner-with-colleagues - note
    email-coworker-1 email-coworker-2 email-coworker-3 - email
    amount-share-1 amount-share-2 amount-share-3 - amount
    description-dinner-with-colleagues - description
    received - direction
    date-2023-05-19 - datetime)
  (:init
    (username-for phone phone-7056722825)
    (username-for simple-note gra-martinez-at-gmail-com)
    (username-for venmo gra-martinez-at-gmail-com)
    (password-for phone phone-password)
    (password-for simple-note simple-note-password)
    (password-for venmo venmo-password)
    (token-for phone phone-token)
    (token-for simple-note simple-note-token)
    (token-for venmo venmo-token)
    (contact-query query-coworker)
    (contact-relationship relationship-coworker)
    (note-query query-dinner-with-colleagues)
    (note-for-query note-dinner-with-colleagues query-dinner-with-colleagues)
    (coworker-email coworker-1 email-coworker-1)
    (coworker-email coworker-2 email-coworker-2)
    (coworker-email coworker-3 email-coworker-3)
    (share-in-note note-dinner-with-colleagues coworker-1 amount-share-1)
    (share-in-note note-dinner-with-colleagues coworker-2 amount-share-2)
    (share-in-note note-dinner-with-colleagues coworker-3 amount-share-3)
    (already-paid coworker-3)
    (request-description description-dinner-with-colleagues)
    (direction-received received)
    (date-yesterday date-2023-05-19))
  (:goal (and
    (payment-requested coworker-1)
    (payment-requested coworker-2)
    (not (payment-requested coworker-3))
    (task-completed)))
)
