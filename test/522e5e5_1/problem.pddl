(define (problem task-522e5e5-1)
  (:domain appworld-522e5e5-1)
  (:objects
    james-solomon - person
    ja-solomon-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    datetime-2023-05-01t00-00-00 - datetime
    counterparty-email-1 counterparty-email-2 counterparty-email-3 counterparty-email-4 counterparty-email-5 counterparty-email-6 counterparty-email-7 counterparty-email-8 counterparty-email-9 counterparty-email-10 - email
  )
  (:init
    (password-for venmo venmo-password)
    (month-start datetime-2023-05-01t00-00-00)
    (counterparty-this-month counterparty-1)
    (counterparty-this-month counterparty-2)
    (counterparty-this-month counterparty-3)
    (counterparty-this-month counterparty-4)
    (counterparty-this-month counterparty-5)
    (counterparty-this-month counterparty-6)
    (counterparty-this-month counterparty-7)
    (counterparty-this-month counterparty-8)
    (counterparty-this-month counterparty-9)
    (counterparty-this-month counterparty-10)
    (email-of counterparty-1 counterparty-email-1)
    (email-of counterparty-2 counterparty-email-2)
    (email-of counterparty-3 counterparty-email-3)
    (email-of counterparty-4 counterparty-email-4)
    (email-of counterparty-5 counterparty-email-5)
    (email-of counterparty-6 counterparty-email-6)
    (email-of counterparty-7 counterparty-email-7)
    (email-of counterparty-8 counterparty-email-8)
    (email-of counterparty-9 counterparty-email-9)
    (email-of counterparty-10 counterparty-email-10))
  (:goal (and
    (friend counterparty-1)
    (friend counterparty-2)
    (friend counterparty-3)
    (friend counterparty-4)
    (friend counterparty-5)
    (friend counterparty-6)
    (friend counterparty-7)
    (friend counterparty-8)
    (friend counterparty-9)
    (friend counterparty-10)
    (task-completed)))
)
