(define (problem task-a8f302f-2)
  (:domain appworld-a8f302f-2)
  (:objects
    ashlee-martinez - person
    ashlee-martinez-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    product-type-a product-type-b - product-type
    cheapest-of-type-a other-of-type-a-1 other-of-type-a-2 cheapest-of-type-b other-of-type-b-1 - product
    default-address - address
    payment-card-1 - payment-card
  )
  (:init
    (password-for amazon amazon-password)
    (in-cart cheapest-of-type-a)
    (in-cart other-of-type-a-1)
    (in-cart other-of-type-a-2)
    (in-cart cheapest-of-type-b)
    (in-cart other-of-type-b-1)
    (product-type-of cheapest-of-type-a product-type-a)
    (product-type-of other-of-type-a-1 product-type-a)
    (product-type-of other-of-type-a-2 product-type-a)
    (product-type-of cheapest-of-type-b product-type-b)
    (product-type-of other-of-type-b-1 product-type-b)
    (cheapest-in-type cheapest-of-type-a product-type-a)
    (cheapest-in-type cheapest-of-type-b product-type-b)
  )
  (:goal (and
    (order-placed)
    (in-cart cheapest-of-type-a)
    (in-cart cheapest-of-type-b)
    (in-wish-list other-of-type-a-1)
    (in-wish-list other-of-type-a-2)
    (in-wish-list other-of-type-b-1)
    (task-completed)
  ))
)
