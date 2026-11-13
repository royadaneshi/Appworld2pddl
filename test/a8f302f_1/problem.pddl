(define (problem task-a8f302f-1)
  (:domain appworld-a8f302f-1)
  (:objects
    kayla-burton - person
    ka-burt-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    product-type-1 product-type-2 product-type-3 - product-type
    type1-cheapest type1-other-1 type1-other-2 type1-other-3 type2-cheapest type2-other-1 type2-other-2 type3-cheapest type3-other-1 type3-other-2 - product
    amazon-payment-card-1 - payment-card
    amazon-address-1 - address
  )
  (:init
    (password-for amazon amazon-password)
    (product-type-of type1-cheapest product-type-1)
    (product-type-of type1-other-1 product-type-1)
    (product-type-of type2-cheapest product-type-2)
    (product-type-of type2-other-1 product-type-2)
    (product-type-of type2-other-2 product-type-2)
    (cheapest type1-cheapest)
    (cheapest type2-cheapest)
    (in-cart type1-cheapest)
    (in-cart type1-other-1)
    (in-cart type2-cheapest)
    (in-cart type2-other-1)
    (in-cart type2-other-2)
    (product-type-of type1-other-2 product-type-1)
    (product-type-of type1-other-3 product-type-1)
    (product-type-of type3-cheapest product-type-3)
    (product-type-of type3-other-1 product-type-3)
    (product-type-of type3-other-2 product-type-3)
    (cheapest type3-cheapest)
    (in-cart type1-other-2)
    (in-cart type1-other-3)
    (in-cart type3-cheapest)
    (in-cart type3-other-1)
    (in-cart type3-other-2)
  )
  (:goal (and
    (order-placed)
    (task-completed)
    (in-cart type3-cheapest)
    (in-wish-list type1-other-2)
    (in-wish-list type1-other-3)
    (in-wish-list type3-other-1)
    (in-wish-list type3-other-2)))
)
