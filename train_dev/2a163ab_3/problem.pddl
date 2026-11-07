(define (problem task-2a163ab-3)
  (:domain appworld-2a163ab-3)
  (:objects
    james-solomon coworker-1 coworker-2 non-coworker-friend - person
    phone-number-8683971586 ja-solomon-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-coworker - query
  )
  (:init
    (username-for phone phone-number-8683971586)
    (username-for venmo ja-solomon-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (query-for query-coworker coworker)
    (has-relationship coworker-1 coworker)
    (has-relationship coworker-2 coworker)
    (in-social-feed txn-recent-coworker-1)
    (in-social-feed txn-recent-coworker-2)
    (in-social-feed txn-old-coworker)
    (in-social-feed txn-recent-noncoworker)
    (created-yesterday-or-today txn-recent-coworker-1)
    (created-yesterday-or-today txn-recent-coworker-2)
    (created-yesterday-or-today txn-recent-noncoworker)
    (involves txn-recent-coworker-1 coworker-1)
    (involves txn-recent-coworker-2 coworker-2)
    (involves txn-old-coworker coworker-1)
    (involves txn-recent-noncoworker non-coworker-friend)
  )
  (:goal (and
    (liked txn-recent-coworker-1)
    (liked txn-recent-coworker-2)
    (not (liked txn-old-coworker))
    (not (liked txn-recent-noncoworker))
    (task-completed)
  ))
)
