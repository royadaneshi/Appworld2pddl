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
    description-dinner-with-colleagues - description
    received - direction
    date-2023-05-19 - datetime
    share-stephen share-sabrina share-jamie share-allison share-stacy share-travis share-kristin share-anita share-kayla - amount
    email-stephen email-sabrina email-jamie email-allison email-stacy email-travis email-kristin email-anita email-kayla - email
  )
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
    (request-description description-dinner-with-colleagues)
    (direction-received received)
    (date-yesterday date-2023-05-19)
    (coworker-email coworker-stephen email-stephen)
    (coworker-email coworker-sabrina email-sabrina)
    (coworker-email coworker-jamie email-jamie)
    (coworker-email coworker-allison email-allison)
    (coworker-email coworker-stacy email-stacy)
    (coworker-email coworker-travis email-travis)
    (coworker-email coworker-kristin email-kristin)
    (coworker-email coworker-anita email-anita)
    (coworker-email coworker-kayla email-kayla)
    (share-in-note note-dinner-with-colleagues coworker-stephen share-stephen)
    (share-in-note note-dinner-with-colleagues coworker-sabrina share-sabrina)
    (share-in-note note-dinner-with-colleagues coworker-jamie share-jamie)
    (share-in-note note-dinner-with-colleagues coworker-allison share-allison)
    (share-in-note note-dinner-with-colleagues coworker-stacy share-stacy)
    (share-in-note note-dinner-with-colleagues coworker-travis share-travis)
    (share-in-note note-dinner-with-colleagues coworker-kristin share-kristin)
    (share-in-note note-dinner-with-colleagues coworker-anita share-anita)
    (share-in-note note-dinner-with-colleagues coworker-kayla share-kayla)
    (already-paid coworker-allison)
    (already-paid coworker-stacy)
    (already-paid coworker-travis)
    (already-paid coworker-kristin)
    (already-paid coworker-kayla))
  (:goal (and
    (payment-requested coworker-stephen)
    (payment-requested coworker-sabrina)
    (payment-requested coworker-jamie)
    (payment-requested coworker-anita)
    (not (payment-requested coworker-allison))
    (not (payment-requested coworker-stacy))
    (not (payment-requested coworker-travis))
    (not (payment-requested coworker-kristin))
    (not (payment-requested coworker-kayla))
    (task-completed)))
)
