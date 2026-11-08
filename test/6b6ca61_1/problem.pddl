(define (problem task-6b6ca61-1)
  (:domain appworld-6b6ca61-1)
  (:objects
    lindsey - person
    lindseysimpson - username
    file-system-password venmo-password splitwise-password - password
    file-system-token venmo-token splitwise-token - token
    lindseysimpson-at-gmail-com email-owee-1 email-owee-2 email-owee-3 - email
    amount-owee-1 amount-owee-2 amount-owee-3 - amount
    description-owee-1 description-owee-2 description-owee-3 - description
    private-true - privacy
    owe-list-csv receipt-owee-1-pdf receipt-owee-2-pdf receipt-owee-3-pdf - file-path
  )
  (:init
    (username-for file-system lindseysimpson)
    (username-for venmo lindseysimpson)
    (username-for splitwise lindseysimpson)
    (password-for file-system file-system-password)
    (password-for venmo venmo-password)
    (password-for splitwise splitwise-password)
    (supervisor-email lindseysimpson-at-gmail-com)
    (is-private private-true)
    (csv-file owe-list-csv)
    (person-email owee-1 email-owee-1)
    (person-email owee-2 email-owee-2)
    (person-email owee-3 email-owee-3)
    (owes owee-1 amount-owee-1 description-owee-1)
    (owes owee-2 amount-owee-2 description-owee-2)
    (owes owee-3 amount-owee-3 description-owee-3)
    (receipt-for owee-1 receipt-owee-1-pdf)
    (receipt-for owee-2 receipt-owee-2-pdf)
    (receipt-for owee-3 receipt-owee-3-pdf)
    (has-venmo-account owee-1)
    (has-venmo-account owee-2)
  )
  (:goal (and
    (venmo-paid owee-1)
    (venmo-paid owee-2)
    (splitwise-expense-recorded owee-3)
    (task-completed)
  ))
)
