(define (problem task-21abae1-3)
  (:domain appworld-21abae1-3)
  (:objects
    jordan-harrison - person
    jo-harr-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    dt-2023-05-01t00-00-00 - datetime
    dt-2023-05-18t12-00-00 - datetime
    total-amount-this-month - amount)
  (:init
    (username-for venmo jo-harr-at-gmail-com)
    (password-for venmo venmo-password)
    (month-start dt-2023-05-01t00-00-00)
    (now dt-2023-05-18t12-00-00)
    (answer-amount total-amount-this-month))
  (:goal (and (transactions-retrieved sent)
              (transactions-retrieved received)
              (task-completed)))
)
