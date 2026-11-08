(define (problem task-166f4ff-3)
  (:domain appworld-166f4ff-3)
  (:objects
    sandra-martinez - person
    saritt-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    amount-requested-last-5-days - amount)
  (:init
    (account-username venmo saritt-at-gmail-com)
    (password-for venmo venmo-password))
  (:goal (and (found-requested-total amount-requested-last-5-days)
              (task-completed))))
