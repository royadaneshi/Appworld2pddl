(define (problem task-2a163ab-1)
  (:domain appworld-2a163ab-1)
  (:objects
    username-3383946795 username-mel-bailey-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-roommate - query
    roommate - relationship
    melissa-bailey roommate-1 roommate-2 friend-1 - person
    tx-today-roommate-1 tx-today-roommate-2 tx-yesterday-roommate-1 tx-yesterday-roommate-2 - transaction
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
    (has-relationship roommate-1 roommate)
    (has-relationship roommate-2 roommate)
    (has-relationship friend-1 roommate)
    (on-feed tx-today-roommate-1)
    (on-feed tx-today-roommate-2)
    (on-feed tx-yesterday-roommate-1)
    (on-feed tx-yesterday-roommate-2)
    (transaction-involves tx-today-roommate-1 roommate-1)
    (transaction-involves tx-today-roommate-2 friend-1)
    (transaction-involves tx-yesterday-roommate-1 roommate-1)
    (transaction-involves tx-yesterday-roommate-2 friend-1)
    (transaction-on tx-today-roommate-1 today)
    (transaction-on tx-today-roommate-2 today)
    (transaction-on tx-yesterday-roommate-1 today)
    (transaction-on tx-yesterday-roommate-2 today))
  (:goal (and
    (liked tx-today-roommate-1)
    (liked tx-today-roommate-2)
    (liked tx-yesterday-roommate-1)
    (liked tx-yesterday-roommate-2)
    (task-completed)))
)
