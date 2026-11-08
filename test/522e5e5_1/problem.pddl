(define (problem task-522e5e5-1)
  (:domain appworld-522e5e5-1)
  (:objects
    james-solomon - person
    ja-solomon-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    datetime-2023-05-01t00-00-00 - datetime
    counterparty-1-email counterparty-2-email - email)
  (:init
    (password-for venmo venmo-password)
    (month-start datetime-2023-05-01t00-00-00)
    (counterparty-this-month counterparty-1)
    (counterparty-this-month counterparty-2)
    (email-of counterparty-1 counterparty-1-email)
    (email-of counterparty-2 counterparty-2-email))
  (:goal (and (friend counterparty-1) (friend counterparty-2) (task-completed)))
)
