(define (problem task-522e5e5-3)
  (:domain appworld-522e5e5-3)
  (:objects
    jason sender-1 sender-2 - person
    jasonsimp-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    sender-1-email sender-2-email - email
    direction-received - direction
    datetime-2023-05-01t00-00-00 - datetime
  )
  (:init
    (password-for venmo venmo-password)
    (received-direction direction-received)
    (month-start datetime-2023-05-01t00-00-00)
    (sender-this-month sender-1)
    (sender-this-month sender-2)
    (email-of sender-1 sender-1-email)
    (email-of sender-2 sender-2-email)
  )
  (:goal (and
    (friend sender-1)
    (friend sender-2)
    (task-completed)
  ))
)
