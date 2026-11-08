(define (problem task-32616b5-3)
  (:domain appworld-32616b5-3)
  (:objects
    leslie - person
    note-trips - note
    group-trip-a group-trip-b - splitwise-group
    les-ball-at-gmail-com - username
    simple-note-password splitwise-password - password
    simple-note-token splitwise-token - token
    query-trip - query
    payer-a1-email payer-a2-email payer-b1-email payer-b2-email - email
    description-a1 description-a2 description-b1 description-b2 - description
    amount-a1 amount-a2 amount-b1 amount-b2 - amount
    debtors-a1 debtors-a2 debtors-b1 debtors-b2 - email-list
    debt-amounts-a1 debt-amounts-a2 debt-amounts-b1 debt-amounts-b2 - amount-list)
  (:init
    (username-for simple-note les-ball-at-gmail-com)
    (username-for splitwise les-ball-at-gmail-com)
    (password-for simple-note simple-note-password)
    (password-for splitwise splitwise-password)
    (token-for simple-note simple-note-token)
    (token-for splitwise splitwise-token)
    (query-for query-trip note-trips)
    (described-in expense-a1 note-trips)
    (described-in expense-a2 note-trips)
    (described-in expense-b1 note-trips)
    (described-in expense-b2 note-trips)
    (expense-description expense-a1 description-a1)
    (expense-description expense-a2 description-a2)
    (expense-description expense-b1 description-b1)
    (expense-description expense-b2 description-b2)
    (expense-amount expense-a1 amount-a1)
    (expense-amount expense-a2 amount-a2)
    (expense-amount expense-b1 amount-b1)
    (expense-amount expense-b2 amount-b2)
    (expense-payer expense-a1 payer-a1-email)
    (expense-payer expense-a2 payer-a2-email)
    (expense-payer expense-b1 payer-b1-email)
    (expense-payer expense-b2 payer-b2-email)
    (expense-debtors expense-a1 debtors-a1)
    (expense-debtors expense-a2 debtors-a2)
    (expense-debtors expense-b1 debtors-b1)
    (expense-debtors expense-b2 debtors-b2)
    (expense-debt-amounts expense-a1 debt-amounts-a1)
    (expense-debt-amounts expense-a2 debt-amounts-a2)
    (expense-debt-amounts expense-b1 debt-amounts-b1)
    (expense-debt-amounts expense-b2 debt-amounts-b2)
    (expense-group expense-a1 group-trip-a)
    (expense-group expense-a2 group-trip-a)
    (expense-group expense-b1 group-trip-b)
    (expense-group expense-b2 group-trip-b))
  (:goal (and
    (expense-recorded expense-a1)
    (expense-recorded expense-a2)
    (expense-recorded expense-b1)
    (expense-recorded expense-b2)
    (task-completed)))
)
