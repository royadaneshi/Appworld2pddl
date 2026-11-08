(define (problem task-21abae1-1)
  (:domain appworld-21abae1-1)
  (:objects
    cody - person
    cod-smith-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    sent - direction
    datetime-2023-05-01t00-00-00 datetime-2023-05-18t12-00-00 - datetime
    sent-total-this-month - amount)
  (:init
    (username-for venmo cod-smith-at-gmail-com)
    (password-for venmo venmo-password)
    (direction-sent sent)
    (month-start datetime-2023-05-01t00-00-00)
    (current-time datetime-2023-05-18t12-00-00))
  (:goal (and (sent-total-known sent-total-this-month)
              (task-completed)))
)
