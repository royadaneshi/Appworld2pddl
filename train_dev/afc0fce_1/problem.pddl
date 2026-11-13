(define (problem task-afc0fce-1)
  (:domain appworld-afc0fce-1)
  (:objects
    phone-4288705164 jepowell-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-coworker - query
    relationship-coworker - relationship
    date-2023-05-31 - date
    dir-received - direction
    comment-thank-you - comment-text
    jennifer coworker-1 coworker-2 coworker-3 coworker-4 coworker-5 coworker-6 - person
    email-coworker-1 email-coworker-2 email-coworker-3 email-coworker-4 email-coworker-5 email-coworker-6 - email
    tx-1 tx-2 tx-3 tx-4 tx-5 tx-6 tx-7 tx-8 tx-9 - transaction
  )
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone phone-4288705164)
    (username-for venmo jepowell-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (search-query relationship-coworker query-coworker)
    (threshold-date date-2023-05-31)
    (direction-received dir-received)
    (comment-to-post comment-thank-you)
    (has-relationship coworker-1 relationship-coworker)
    (has-relationship coworker-2 relationship-coworker)
    (has-relationship coworker-3 relationship-coworker)
    (has-relationship coworker-4 relationship-coworker)
    (has-relationship coworker-5 relationship-coworker)
    (has-relationship coworker-6 relationship-coworker)
    (email-of coworker-1 email-coworker-1)
    (email-of coworker-2 email-coworker-2)
    (email-of coworker-3 email-coworker-3)
    (email-of coworker-4 email-coworker-4)
    (email-of coworker-5 email-coworker-5)
    (email-of coworker-6 email-coworker-6)
    (recent-payment-from tx-1 email-coworker-1)
    (recent-payment-from tx-2 email-coworker-5)
    (recent-payment-from tx-3 email-coworker-2)
    (recent-payment-from tx-4 email-coworker-6)
    (recent-payment-from tx-5 email-coworker-3)
    (recent-payment-from tx-6 email-coworker-5)
    (recent-payment-from tx-7 email-coworker-6)
    (recent-payment-from tx-8 email-coworker-1)
    (recent-payment-from tx-9 email-coworker-5))
  (:goal (and
    (liked tx-1)
    (liked tx-2)
    (liked tx-3)
    (liked tx-4)
    (liked tx-5)
    (liked tx-6)
    (liked tx-7)
    (liked tx-8)
    (liked tx-9)
    (commented tx-1 comment-thank-you)
    (commented tx-2 comment-thank-you)
    (commented tx-3 comment-thank-you)
    (commented tx-4 comment-thank-you)
    (commented tx-5 comment-thank-you)
    (commented tx-6 comment-thank-you)
    (commented tx-7 comment-thank-you)
    (commented tx-8 comment-thank-you)
    (commented tx-9 comment-thank-you)
    (task-completed)))
)
