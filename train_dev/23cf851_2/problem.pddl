(define (problem task-23cf851-2)
  (:domain appworld-23cf851-2)
  (:objects
    paul - person
    paul-mill-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    dir-received - direction
    date-2023-01-01 - datetime
    like-count-1 - like-count
    total-likes - count)
  (:init
    (supervisor-email paul-mill-at-gmail-com)
    (password-for venmo venmo-password)
    (received-direction dir-received)
    (year-start date-2023-01-01)
    (min-like-count-one like-count-1))
  (:goal (and (found-total-likes total-likes) (task-completed)))
)
