(define (problem task-83a7951-2)
  (:domain appworld-83a7951-2)
  (:objects
    paul-miller payee-1 payee-2 - person
    username-paul-mill-at-gmail-com - username
    venmo-password file-system-password splitwise-password - password
    venmo-token file-system-token splitwise-token - token
    paul-mill-at-gmail-com payee-1-email payee-2-email - email
    amount-1 amount-2 - amount
    txn-1 txn-2 - transaction
    group-1 group-2 - splitwise-group
    receipt-path-1 receipt-path-2 - file-path
    note-paid-via-venmo-see-attached-receipt - description
    sent - direction
    dt-2023-05-20t00-00-00 - datetime
  )
  (:init
    (username-for venmo username-paul-mill-at-gmail-com)
    (username-for file-system username-paul-mill-at-gmail-com)
    (username-for splitwise username-paul-mill-at-gmail-com)
    (password-for venmo venmo-password)
    (password-for file-system file-system-password)
    (password-for splitwise splitwise-password)
    (supervisor-email paul-mill-at-gmail-com)
    (email-of paul-miller paul-mill-at-gmail-com)
    (email-of payee-1 payee-1-email)
    (email-of payee-2 payee-2-email)
    (venmo-paid-today txn-1 payee-1 amount-1)
    (venmo-paid-today txn-2 payee-2 amount-2)
    (owed-in-group payee-1 group-1 amount-1)
    (owed-in-group payee-2 group-2 amount-2)
    (receipt-path-for txn-1 receipt-path-1)
    (receipt-path-for txn-2 receipt-path-2)
    (payment-note note-paid-via-venmo-see-attached-receipt)
    (is-sent-direction sent)
    (is-start-of-today dt-2023-05-20t00-00-00)
  )
  (:goal (and
    (payment-recorded txn-1)
    (payment-recorded txn-2)
    (task-completed)
  ))
)
