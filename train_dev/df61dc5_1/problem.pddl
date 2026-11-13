(define (problem task-df61dc5-1)
  (:domain appworld-df61dc5-1)
  (:objects
    phone-3643463570 anita-burch-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-roommate - query
    rel-roommate - relationship
    date-2023-01-01 - date
    anita-burch roommate-1 roommate-2 roommate-3 - person
    roommate-email-1 roommate-email-2 roommate-email-3 - email
  )
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone phone-3643463570)
    (username-for venmo anita-burch-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (target-relationship rel-roommate)
    (relationship-query query-roommate rel-roommate)
    (year-start date-2023-01-01)
    (has-relationship roommate-1 rel-roommate)
    (has-relationship roommate-2 rel-roommate)
    (has-relationship roommate-3 rel-roommate)
    (email-of roommate-1 roommate-email-1)
    (email-of roommate-2 roommate-email-2)
    (email-of roommate-3 roommate-email-3)
    (transaction-with tx-roommate-1 roommate-email-1)
    (transaction-with tx-roommate-2 roommate-email-3)
    (transaction-with tx-roommate-3 roommate-email-3)
    (transaction-with tx-roommate-4 roommate-email-2)
    (transaction-with tx-roommate-5 roommate-email-2)
    (created-on-or-after tx-roommate-1 date-2023-01-01)
    (created-on-or-after tx-roommate-2 date-2023-01-01)
    (created-on-or-after tx-roommate-3 date-2023-01-01)
    (created-on-or-after tx-roommate-4 date-2023-01-01)
    (created-on-or-after tx-roommate-5 date-2023-01-01))
  (:goal (and
    (liked tx-roommate-1)
    (liked tx-roommate-2)
    (liked tx-roommate-3)
    (liked tx-roommate-4)
    (liked tx-roommate-5)
    (task-completed))))
