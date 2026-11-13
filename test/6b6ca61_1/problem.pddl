(define (problem task-6b6ca61-1)
  (:domain appworld-6b6ca61-1)
  (:objects
    lindsey - person
    lindseysimpson - username
    file-system-password venmo-password splitwise-password - password
    file-system-token venmo-token splitwise-token - token
    lindseysimpson-at-gmail-com email-owee-1 email-owee-2 email-owee-3 email-owee-4 email-owee-5 - email
    amount-owee-1 amount-owee-2 amount-owee-3 amount-owee-4 amount-owee-5 - amount
    description-owee-1 description-owee-2 description-owee-3 description-owee-4 description-owee-5 - description
    private-true - privacy
    owe-list-csv receipt-owee-pdf-1 receipt-owee-pdf-2 receipt-owee-pdf-3 - file-path
  )
  (:init
    (credential-of-app file-system lindseysimpson)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (credential-of-app file-system lindseysimpson-at-gmail-com)
    (credential-of-app venmo lindseysimpson)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (credential-of-app venmo lindseysimpson-at-gmail-com)
    (credential-of-app splitwise lindseysimpson)
    (credential-of-app splitwise splitwise-password)
    (credential-of-app splitwise splitwise-token)
    (credential-of-app splitwise lindseysimpson-at-gmail-com)
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
    (person-email owee-4 email-owee-4)
    (person-email owee-5 email-owee-5)
    (owes owee-1 amount-owee-1 description-owee-1)
    (owes owee-2 amount-owee-2 description-owee-2)
    (owes owee-3 amount-owee-3 description-owee-3)
    (owes owee-4 amount-owee-4 description-owee-4)
    (owes owee-5 amount-owee-5 description-owee-5)
    (receipt-for owee-3 receipt-owee-pdf-1)
    (receipt-for owee-4 receipt-owee-pdf-2)
    (receipt-for owee-5 receipt-owee-pdf-3)
    (has-venmo-account owee-1)
    (has-venmo-account owee-2))
  (:goal (and
    (venmo-paid owee-1)
    (venmo-paid owee-2)
    (splitwise-expense-recorded owee-3)
    (splitwise-expense-recorded owee-4)
    (splitwise-expense-recorded owee-5)
    (task-completed)))
)
