(define (problem task-383cbac-1)
  (:domain appworld-383cbac-1)
  (:objects
    ashlee-martinez - person
    phone-3506492550 ashlee-martinez-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-coworker query-manager - query
    amount-38 total-amount - amount)
  (:init
    (username-for phone phone-3506492550)
    (username-for venmo ashlee-martinez-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (token-for phone phone-token)
    (token-for venmo venmo-token)
    (query-for query-coworker coworker)
    (query-for query-manager manager)
    (my-share amount-38))
  (:goal (and (found-total total-amount) (task-completed)))
)
