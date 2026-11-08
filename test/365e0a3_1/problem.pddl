(define (problem task-365e0a3-1)
  (:domain appworld-365e0a3-1)
  (:objects
    cory-wilson - person
    corwils-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    amount-total-prime-paid - amount)
  (:init
    (username-for amazon corwils-at-gmail-com)
    (password-for amazon amazon-password))
  (:goal (and (found-prime-total amount-total-prime-paid)
              (task-completed)))
)
