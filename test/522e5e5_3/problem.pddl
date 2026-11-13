(define (problem task-522e5e5-3)
  (:domain appworld-522e5e5-3)
  (:objects
    jasonsimp-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    direction-received - direction
    datetime-2023-05-01t00-00-00 - datetime
    jason sender-1 sender-2 sender-3 sender-4 sender-5 - person
    sender-email-1 sender-email-2 sender-email-3 sender-email-4 sender-email-5 - email
  )
  (:init
    (password-for venmo venmo-password)
    (received-direction direction-received)
    (month-start datetime-2023-05-01t00-00-00)
    (sender-this-month sender-1)
    (sender-this-month sender-2)
    (sender-this-month sender-3)
    (sender-this-month sender-4)
    (sender-this-month sender-5)
    (email-of sender-1 sender-email-1)
    (email-of sender-2 sender-email-2)
    (email-of sender-3 sender-email-3)
    (email-of sender-4 sender-email-4)
    (email-of sender-5 sender-email-5))
  (:goal (and
    (friend sender-1)
    (friend sender-2)
    (friend sender-3)
    (friend sender-4)
    (friend sender-5)
    (task-completed)))
)
