(define (problem task-2a163ab-2)
  (:domain appworld-2a163ab-2)
  (:objects
    jeffrey-smith - person
    jefsmith-at-gmail-com phone-3272301258 - username
    venmo-password phone-password - password
    venmo-token phone-token - token
    query-sibling - query
    sibling - relationship
    sibling-txn-1 sibling-txn-2 - transaction
  )
  (:init
    (username-for venmo jefsmith-at-gmail-com)
    (username-for phone phone-3272301258)
    (password-for venmo venmo-password)
    (password-for phone phone-password)
    (token-for venmo venmo-token)
    (token-for phone phone-token)
    (target-relationship sibling)
    (relationship-query sibling query-sibling)
    (on-feed sibling-txn-1)
    (on-feed sibling-txn-2)
    (from-yesterday sibling-txn-1)
    (from-yesterday sibling-txn-2)
    (involves-relative sibling-txn-1)
    (involves-relative sibling-txn-2)
  )
  (:goal (and
    (liked sibling-txn-1)
    (liked sibling-txn-2)
    (task-completed)
  ))
)
