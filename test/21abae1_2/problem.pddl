(define (problem task-21abae1-2)
  (:domain appworld-21abae1-2)
  (:objects
    brandon-weber - person
    brandon-webe-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    datetime-2023-05-01t00-00-00 - datetime
    direction-received - direction
    total-received-this-month - amount)
  (:init
    (username-for venmo brandon-webe-at-gmail-com)
    (password-for venmo venmo-password)
    (month-start datetime-2023-05-01t00-00-00)
    (received-direction direction-received))
  (:goal (and (found-received-total total-received-this-month)
              (task-completed))))
