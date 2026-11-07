(define (problem task-df61dc5-1)
  (:domain appworld-df61dc5-1)
  (:objects
    anita-burch roommate-1 roommate-2 - person
    phone-3643463570 anita-burch-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-roommate - query
    rel-roommate - relationship
    roommate-1-email roommate-2-email - email
    date-2023-01-01 - date)
  (:init
    (username-for phone phone-3643463570)
    (username-for venmo anita-burch-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (target-relationship rel-roommate)
    (relationship-query query-roommate rel-roommate)
    (has-relationship roommate-1 rel-roommate)
    (has-relationship roommate-2 rel-roommate)
    (email-of roommate-1 roommate-1-email)
    (email-of roommate-2 roommate-2-email)
    (year-start date-2023-01-01)
    (transaction-with tx-roommate-1-a roommate-1-email)
    (transaction-with tx-roommate-1-b roommate-1-email)
    (transaction-with tx-roommate-1-old roommate-1-email)
    (transaction-with tx-roommate-2-a roommate-2-email)
    (created-on-or-after tx-roommate-1-a date-2023-01-01)
    (created-on-or-after tx-roommate-1-b date-2023-01-01)
    (created-on-or-after tx-roommate-2-a date-2023-01-01))
  (:goal (and
    (liked tx-roommate-1-a)
    (liked tx-roommate-1-b)
    (liked tx-roommate-2-a)
    (task-completed))))
