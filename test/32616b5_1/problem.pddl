(define (problem task-32616b5-1)
  (:domain appworld-32616b5-1)
  (:objects
    robin - person
    roburton-at-gmail-com - username
    simple-note-password splitwise-password - password
    simple-note-token splitwise-token - token
    query-trip - query
    note-trip-1 note-trip-2 - note
    group-trip-1 group-trip-2 - group
    trip-1-expense-1 trip-1-expense-2 trip-2-expense-1 - expense
    desc-trip-1-expense-1 desc-trip-1-expense-2 desc-trip-2-expense-1 - description
    amount-trip-1-expense-1 amount-trip-1-expense-2 amount-trip-2-expense-1 - amount
    payer-trip-1-expense-1 payer-trip-1-expense-2 payer-trip-2-expense-1 - email
    debtors-trip-1-expense-1 debtors-trip-1-expense-2 debtors-trip-2-expense-1 - email-list
    debts-trip-1-expense-1 debts-trip-1-expense-2 debts-trip-2-expense-1 - amount-list
  )
  (:init
    (password-for simple-note simple-note-password)
    (password-for splitwise splitwise-password)
    (note-describes note-trip-1 trip-1-expense-1)
    (note-describes note-trip-1 trip-1-expense-2)
    (note-describes note-trip-2 trip-2-expense-1)
    (expense-in-group trip-1-expense-1 group-trip-1)
    (expense-in-group trip-1-expense-2 group-trip-1)
    (expense-in-group trip-2-expense-1 group-trip-2)
    (expense-description trip-1-expense-1 desc-trip-1-expense-1)
    (expense-description trip-1-expense-2 desc-trip-1-expense-2)
    (expense-description trip-2-expense-1 desc-trip-2-expense-1)
    (expense-amount trip-1-expense-1 amount-trip-1-expense-1)
    (expense-amount trip-1-expense-2 amount-trip-1-expense-2)
    (expense-amount trip-2-expense-1 amount-trip-2-expense-1)
    (expense-payer trip-1-expense-1 payer-trip-1-expense-1)
    (expense-payer trip-1-expense-2 payer-trip-1-expense-2)
    (expense-payer trip-2-expense-1 payer-trip-2-expense-1)
    (expense-debtors trip-1-expense-1 debtors-trip-1-expense-1)
    (expense-debtors trip-1-expense-2 debtors-trip-1-expense-2)
    (expense-debtors trip-2-expense-1 debtors-trip-2-expense-1)
    (expense-debts trip-1-expense-1 debts-trip-1-expense-1)
    (expense-debts trip-1-expense-2 debts-trip-1-expense-2)
    (expense-debts trip-2-expense-1 debts-trip-2-expense-1)
  )
  (:goal (and
    (expense-recorded trip-1-expense-1)
    (expense-recorded trip-1-expense-2)
    (expense-recorded trip-2-expense-1)
    (task-completed)
  ))
)
