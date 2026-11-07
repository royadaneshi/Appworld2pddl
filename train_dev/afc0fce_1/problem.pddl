(define (problem task-afc0fce-1)
  (:domain appworld-afc0fce-1)
  (:objects
    jennifer coworker-1 coworker-2 - person
    phone-4288705164 jepowell-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-coworker - query
    relationship-coworker - relationship
    email-coworker-1 email-coworker-2 - email
    date-2023-05-31 - date
    dir-received - direction
    comment-thank-you - comment-text
    tx-1 tx-2 tx-3 - transaction
  )
  (:init
    (username-for phone phone-4288705164)
    (username-for venmo jepowell-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (search-query relationship-coworker query-coworker)
    (has-relationship coworker-1 relationship-coworker)
    (has-relationship coworker-2 relationship-coworker)
    (email-of coworker-1 email-coworker-1)
    (email-of coworker-2 email-coworker-2)
    (threshold-date date-2023-05-31)
    (direction-received dir-received)
    (comment-to-post comment-thank-you)
    (recent-payment-from tx-1 email-coworker-1)
    (recent-payment-from tx-2 email-coworker-1)
    (recent-payment-from tx-3 email-coworker-2)
  )
  (:goal (and
    (liked tx-1)
    (liked tx-2)
    (liked tx-3)
    (commented tx-1 comment-thank-you)
    (commented tx-2 comment-thank-you)
    (commented tx-3 comment-thank-you)
    (task-completed)
  ))
)
