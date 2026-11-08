(define (problem task-166f4ff-1)
  (:domain appworld-166f4ff-1)
  (:objects
    connor-brown - person
    connorbrow-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    total-requested-since-2023-05-28 - amount)
  (:init
    (username-for venmo connorbrow-at-gmail-com)
    (password-for venmo venmo-password))
  (:goal (and (found-requested-total total-requested-since-2023-05-28) (task-completed)))
)
