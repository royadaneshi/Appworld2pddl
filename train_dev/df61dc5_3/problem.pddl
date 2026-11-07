(define (problem task-df61dc5-3)
  (:domain appworld-df61dc5-3)
  (:objects
    melissa coworker-a coworker-b - person
    phone-3383946795 mel-bailey-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    coworker-a-email coworker-b-email - email
    query-coworker - query
    date-2023-01-01 - datetime
    txn-a1 txn-a2 txn-b1 - transaction
  )
  (:init
    (username-for phone phone-3383946795)
    (username-for venmo mel-bailey-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (query-for query-coworker coworker)
    (has-relationship coworker-a coworker)
    (has-relationship coworker-b coworker)
    (contact-email coworker-a coworker-a-email)
    (contact-email coworker-b coworker-b-email)
    (year-start date-2023-01-01)
    (transaction-with txn-a1 coworker-a)
    (transaction-with txn-a2 coworker-a)
    (transaction-with txn-b1 coworker-b)
  )
  (:goal (and
    (liked txn-a1)
    (liked txn-a2)
    (liked txn-b1)
    (task-completed)
  ))
)
