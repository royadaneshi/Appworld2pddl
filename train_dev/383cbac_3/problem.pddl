(define (problem task-383cbac-3)
  (:domain appworld-383cbac-3)
  (:objects
    jordan-harrison - person
    phone-username-2254213734 venmo-username-jo-harr-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-coworker query-manager - query
    amount-34 total-dinner-amount - amount)
  (:init
    (username-for phone phone-username-2254213734)
    (username-for venmo venmo-username-jo-harr-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (query-for-relationship query-coworker coworker)
    (query-for-relationship query-manager manager)
    (my-share amount-34)
    (answer-slot total-dinner-amount))
  (:goal (and (found-total total-dinner-amount)
              (task-completed))))
