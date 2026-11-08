(define (problem task-eb5ad85-1)
  (:domain appworld-eb5ad85-1)
  (:objects
    patricia-ritter - person
    pa-ritter-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    orders-this-year - order
    amount-total-spent-this-year - amount
    year-2023 - year)
  (:init
    (password-for amazon amazon-password)
    (current-year year-2023)
    (order-in-year orders-this-year year-2023))
  (:goal (and
    (found-order-total orders-this-year amount-total-spent-this-year)
    (answered amount-total-spent-this-year)
    (task-completed)))
)
