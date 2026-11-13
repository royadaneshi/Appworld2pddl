(define (problem task-df61dc5-1)
  (:domain appworld-df61dc5-1)
  (:objects
    phone-3643463570 anita-burch-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-roommate - query
    rel-roommate - relationship
    date-2023-01-01 - date
    anita-burch roommate-anthony-harrison roommate-melissa-bailey roommate-nicholas-weber - person
    email-anthony-harrison email-melissa-bailey email-nicholas-weber - email
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
    (has-relationship roommate-anthony-harrison rel-roommate)
    (has-relationship roommate-melissa-bailey rel-roommate)
    (has-relationship roommate-nicholas-weber rel-roommate)
    (email-of roommate-anthony-harrison email-anthony-harrison)
    (email-of roommate-melissa-bailey email-melissa-bailey)
    (email-of roommate-nicholas-weber email-nicholas-weber)
    (transaction-with tx-1245 email-anthony-harrison)
    (transaction-with tx-3809 email-nicholas-weber)
    (transaction-with tx-3813 email-nicholas-weber)
    (transaction-with tx-6221 email-melissa-bailey)
    (transaction-with tx-6224 email-melissa-bailey)
    (created-on-or-after tx-1245 date-2023-01-01)
    (created-on-or-after tx-3809 date-2023-01-01)
    (created-on-or-after tx-3813 date-2023-01-01)
    (created-on-or-after tx-6221 date-2023-01-01)
    (created-on-or-after tx-6224 date-2023-01-01))
  (:goal (and
    (liked tx-1245)
    (liked tx-3809)
    (liked tx-3813)
    (liked tx-6221)
    (liked tx-6224)
    (task-completed))))
