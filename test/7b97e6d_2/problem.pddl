(define (problem task-7b97e6d-2)
  (:domain appworld-7b97e6d-2)
  (:objects
    kayla - person
    kayla-username - username
    amazon-password - password
    amazon-token - token
    wish-product-1 wish-product-2 wish-product-3 wish-product-4 wish-product-5 wish-product-6 wish-product-7 wish-product-8 wish-product-9 - product
    budget-500 budget-after-1 budget-after-2 budget-after-3 budget-after-4 budget-after-5 budget-1 - budget
    quantity-1 - quantity
    kayla-payment-card - payment-card
    kayla-address - address
    order-1 - order
  )
  (:init
    (password-for amazon amazon-password)
    (budget-remaining budget-500)
    (in-wish-list wish-product-1)
    (in-wish-list wish-product-2)
    (in-wish-list wish-product-3)
    (in-wish-list wish-product-4)
    (in-wish-list wish-product-5)
    (in-wish-list wish-product-6)
    (in-wish-list wish-product-7)
    (in-wish-list wish-product-8)
    (in-wish-list wish-product-9)
    (price-fits wish-product-1 budget-500 budget-after-1)
    (price-fits wish-product-2 budget-after-1 budget-after-2)
    (price-fits wish-product-3 budget-after-2 budget-after-3)
    (price-fits wish-product-4 budget-after-3 budget-after-4)
    (price-fits wish-product-5 budget-after-4 budget-after-5)
    (price-fits wish-product-6 budget-after-5 budget-1)
    (no-more-fits budget-1))
  (:goal (and
    (order-placed order-1)
    (in-cart wish-product-1)
    (in-cart wish-product-2)
    (in-cart wish-product-3)
    (in-cart wish-product-4)
    (in-cart wish-product-5)
    (in-cart wish-product-6)
    (task-completed))))
