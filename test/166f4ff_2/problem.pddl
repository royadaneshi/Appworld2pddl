(define (problem task-166f4ff-2)
  (:domain appworld-166f4ff-2)
  (:objects
    grant-martinez - person
    gra-martinez-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    amount-requested-last-10-days - amount)
  (:init
    (password-for venmo venmo-password))
  (:goal (and (found-requested-total amount-requested-last-10-days) (task-completed)))
)
