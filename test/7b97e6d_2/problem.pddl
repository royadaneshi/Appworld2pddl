(define (problem task-7b97e6d-2)
  (:domain appworld-7b97e6d-2)
  (:objects
    kayla - person
    kayla-username - username
    amazon-password - password
    amazon-token - token
    wish-product-1 wish-product-2 wish-product-3 wish-product-4 wish-product-5 - product
    budget-500 budget-after-1 budget-after-2 budget-after-3 budget-after-4 budget-after-5 - budget
    quantity-1 - quantity
    kayla-payment-card - payment-card
    kayla-address - address
    order-1 - order)
  (:init
    (password-for amazon amazon-password)
    (in-wish-list wish-product-1)
    (in-wish-list wish-product-2)
    (in-wish-list wish-product-3)
    (in-wish-list wish-product-4)
    (in-wish-list wish-product-5)
    (budget-remaining budget-500)
    (price-fits wish-product-1 budget-500 budget-after-1)
    (price-fits wish-product-2 budget-after-1 budget-after-2)
    (price-fits wish-product-3 budget-after-2 budget-after-3)
    (price-fits wish-product-4 budget-after-3 budget-after-4)
    (price-fits wish-product-5 budget-after-4 budget-after-5)
    (no-more-fits budget-after-5))
  (:goal (and (order-placed order-1) (task-completed))))
