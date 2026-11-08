(define (problem task-83a7951-3)
  (:domain appworld-83a7951-3)
  (:objects
    matthew payee-1 payee-2 - person
    username-matthew-blac-at-gmail-com - username
    venmo-password splitwise-password file-system-password - password
    venmo-token splitwise-token file-system-token - token
    matthew-blac-at-gmail-com payee-1-email payee-2-email - email
    txn-1 txn-2 - transaction
    group-1 group-2 - group
    amount-1 amount-2 - amount
    receipt-path-1 receipt-path-2 - file-path
    note-payment-made-on-venmo - note
    direction-sent - direction
    datetime-2023-05-20t00-00-00 - datetime
  )
  (:init
    (username-for venmo username-matthew-blac-at-gmail-com)
    (username-for splitwise username-matthew-blac-at-gmail-com)
    (username-for file-system username-matthew-blac-at-gmail-com)
    (password-for venmo venmo-password)
    (password-for splitwise splitwise-password)
    (password-for file-system file-system-password)
    (token-for venmo venmo-token)
    (token-for splitwise splitwise-token)
    (token-for file-system file-system-token)
    (supervisor-email matthew-blac-at-gmail-com)
    (email-of matthew matthew-blac-at-gmail-com)
    (email-of payee-1 payee-1-email)
    (email-of payee-2 payee-2-email)
    (venmo-payment-today txn-1 payee-1 amount-1)
    (venmo-payment-today txn-2 payee-2 amount-2)
    (expense-in-group payee-1 group-1)
    (expense-in-group payee-2 group-2)
    (receipt-path-for txn-1 receipt-path-1)
    (receipt-path-for txn-2 receipt-path-2)
  )
  (:goal (and
    (payment-recorded txn-1 group-1 note-payment-made-on-venmo)
    (receipt-attached txn-1 group-1)
    (payment-recorded txn-2 group-2 note-payment-made-on-venmo)
    (receipt-attached txn-2 group-2)
    (task-completed)
  ))
)
