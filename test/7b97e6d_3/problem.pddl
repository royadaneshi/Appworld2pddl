(define (problem task-7b97e6d-3)
  (:domain appworld-7b97e6d-3)
  (:objects
    martin-blackburn - person
    mar-blac-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    quantity-1 - quantity
    count-0 count-1 count-2 count-3 count-4 count-5 - count
    budget-600 - amount
    product-1 product-2 product-3 product-4 product-5 - product
    payment-card-1 - payment-card
    address-1 - address)
  (:init
    (password-for amazon amazon-password)
    (in-wish-list product-1)
    (in-wish-list product-2)
    (in-wish-list product-3)
    (in-wish-list product-4)
    (in-wish-list product-5)
    (selected-items count-0)
    (succ count-0 count-1)
    (succ count-1 count-2)
    (succ count-2 count-3)
    (succ count-3 count-4)
    (succ count-4 count-5)
    (budget budget-600)
    (max-count-within-budget count-5 budget-600))
  (:goal (and (order-placed) (task-completed))))
