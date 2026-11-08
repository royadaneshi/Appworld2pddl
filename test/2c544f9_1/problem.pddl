(define (problem task-2c544f9-1)
  (:domain appworld-2c544f9-1)
  (:objects
    brandon catherine - person
    brandon-webe-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    catherine-email - email
    query-catherine - query
    amount-250 - amount
    venmo-card - payment-card
    txn-catherine-250 - transaction)
  (:init
    (username-for venmo brandon-webe-at-gmail-com)
    (password-for venmo venmo-password)
    (query-for catherine query-catherine)
    (email-of catherine catherine-email))
  (:goal (and
    (transaction-sent txn-catherine-250 catherine amount-250)
    (task-completed))))
