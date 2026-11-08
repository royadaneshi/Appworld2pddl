(define (problem task-eb5ad85-2)
  (:domain appworld-eb5ad85-2)
  (:objects
    glenn - person
    glenn-burton-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    order-last-month - order
    amount-spent-last-month - amount)
  (:init
    (password-for amazon amazon-password)
    (placed-last-month order-last-month)
    (answer-for amount-spent-last-month order-last-month))
  (:goal (and (found-total order-last-month) (task-completed)))
)
