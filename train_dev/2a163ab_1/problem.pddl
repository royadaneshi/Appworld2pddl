(define (problem task-2a163ab-1)
  (:domain appworld-2a163ab-1)
  (:objects
    username-3383946795 username-mel-bailey-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-roommate - query
    roommate - relationship
    melissa-bailey roommate-anita-burch roommate-anthony-harrison roommate-nicholas-weber - person
    tx-8230 tx-8219 tx-1245 tx-7294 - transaction
    today - date
  )
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone username-3383946795)
    (username-for venmo username-mel-bailey-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (current-date today)
    (query-for query-roommate roommate)
    (has-relationship roommate-anita-burch roommate)
    (has-relationship roommate-anthony-harrison roommate)
    (has-relationship roommate-nicholas-weber roommate)
    (on-feed tx-8230)
    (on-feed tx-8219)
    (on-feed tx-1245)
    (on-feed tx-7294)
    (transaction-involves tx-8230 roommate-anita-burch)
    (transaction-involves tx-8219 roommate-nicholas-weber)
    (transaction-involves tx-1245 roommate-anita-burch)
    (transaction-involves tx-7294 roommate-nicholas-weber)
    (transaction-on tx-8230 today)
    (transaction-on tx-8219 today)
    (transaction-on tx-1245 today)
    (transaction-on tx-7294 today))
  (:goal (and
    (liked tx-8230)
    (liked tx-8219)
    (liked tx-1245)
    (liked tx-7294)
    (task-completed)))
)
