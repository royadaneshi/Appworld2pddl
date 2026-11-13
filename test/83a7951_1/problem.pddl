(define (problem task-83a7951-1)
  (:domain appworld-83a7951-1)
  (:objects
    jennifer-powell payee-1 payee-2 payee-3 - person
    jepowell-at-gmail-com - username
    venmo-password splitwise-password file-system-password - password
    venmo-token splitwise-token file-system-token - token
    email-jepowell-at-gmail-com email-payee-1 email-payee-2 email-payee-3 - email
    amount-txn-1 amount-txn-2 amount-txn-3 - amount
    note-sent-on-venmo-see-receipt - note
    txn-1 txn-2 txn-3 - transaction
    group-1 group-2 - group
    file-path-1 file-path-2 file-path-3 - file-path
    direction-sent - direction
    datetime-2023-05-20t00-00-00 - datetime
  )
  (:init
    (password-for venmo venmo-password)
    (password-for splitwise splitwise-password)
    (password-for file-system file-system-password)
    (token-for venmo venmo-token)
    (token-for splitwise splitwise-token)
    (token-for file-system file-system-token)
    (supervisor-email email-jepowell-at-gmail-com)
    (payment-note note-sent-on-venmo-see-receipt)
    (sent-today txn-1 payee-1)
    (txn-amount txn-1 amount-txn-1)
    (person-email payee-1 email-payee-1)
    (expense-group payee-1 group-1)
    (receipt-path-for txn-1 file-path-1)
    (sent-today txn-2 payee-2)
    (txn-amount txn-2 amount-txn-2)
    (person-email payee-2 email-payee-2)
    (expense-group payee-2 group-1)
    (receipt-path-for txn-2 file-path-2)
    (sent-today txn-3 payee-3)
    (txn-amount txn-3 amount-txn-3)
    (person-email payee-3 email-payee-3)
    (expense-group payee-3 group-2)
    (receipt-path-for txn-3 file-path-3))
  (:goal (and
    (payment-recorded txn-1)
    (payment-recorded txn-2)
    (payment-recorded txn-3)
    (task-completed))))
