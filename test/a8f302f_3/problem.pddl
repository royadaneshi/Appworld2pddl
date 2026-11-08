(define (problem task-a8f302f-3)
  (:domain appworld-a8f302f-3)
  (:objects
    cesar-maldonado - person
    ce-maldonado-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    product-type-a product-type-b - product-type
    product-a-cheapest product-a-other-1 product-a-other-2 product-b-cheapest product-b-other-1 - product
    address-primary - address
    payment-card-primary - payment-card
    count-1 count-2 count-3 - count
  )
  (:init
    (password-for amazon amazon-password)
    (of-type product-a-cheapest product-type-a)
    (of-type product-a-other-1 product-type-a)
    (of-type product-a-other-2 product-type-a)
    (of-type product-b-cheapest product-type-b)
    (of-type product-b-other-1 product-type-b)
    (cheapest product-a-cheapest)
    (cheapest product-b-cheapest)
    (in-cart product-a-cheapest)
    (in-cart product-a-other-1)
    (in-cart product-a-other-2)
    (in-cart product-b-cheapest)
    (in-cart product-b-other-1)
    (succ count-0 count-1)
    (succ count-1 count-2)
    (succ count-2 count-3)
    (moves-left count-3)
  )
  (:goal (and (order-placed) (task-completed)))
)
