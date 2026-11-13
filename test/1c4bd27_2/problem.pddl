(define (problem task-1c4bd27-2)
  (:domain appworld-1c4bd27-2)
  (:objects
    kiara-bailey - person
    kia-bailey-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    quantity-1 quantity-2 - quantity
  )
  (:init
    (password-for amazon amazon-password)
    (order-contains order-1 product-1a-1)
    (order-contains order-1 product-1a-2)
    (order-contains order-2 product-1a-3)
    (order-contains order-2 product-1a-4)
    (order-contains order-3 product-1a-5)
    (order-contains order-3 product-1a-6)
    (item-quantity order-1 product-1a-1 quantity-2)
    (item-quantity order-1 product-1a-2 quantity-1)
    (item-quantity order-2 product-1a-3 quantity-2)
    (item-quantity order-2 product-1a-4 quantity-2)
    (item-quantity order-3 product-1a-5 quantity-1)
    (item-quantity order-3 product-1a-6 quantity-1))
  (:goal (and
    (return-initiated order-1 product-1a-1 fedex)
    (return-initiated order-1 product-1a-2 fedex)
    (return-initiated order-2 product-1a-3 fedex)
    (return-initiated order-2 product-1a-4 fedex)
    (return-initiated order-3 product-1a-5 fedex)
    (return-initiated order-3 product-1a-6 fedex)
    (task-completed)))
)
