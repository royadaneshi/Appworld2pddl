(define (problem task-1c4bd27-2)
  (:domain appworld-1c4bd27-2)
  (:objects
    kiara-bailey - person
    kia-bailey-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    quantity-1 quantity-2 - quantity)
  (:init
    (password-for amazon amazon-password)
    (order-contains order-1 product-1a)
    (order-contains order-1 product-1b)
    (order-contains order-2 product-2a)
    (order-contains order-3 product-3a)
    (order-contains order-3 product-3b)
    (item-quantity order-1 product-1a quantity-1)
    (item-quantity order-1 product-1b quantity-2)
    (item-quantity order-2 product-2a quantity-1)
    (item-quantity order-3 product-3a quantity-1)
    (item-quantity order-3 product-3b quantity-1))
  (:goal (and
    (return-initiated order-1 product-1a fedex)
    (return-initiated order-1 product-1b fedex)
    (return-initiated order-2 product-2a fedex)
    (return-initiated order-3 product-3a fedex)
    (return-initiated order-3 product-3b fedex)
    (task-completed)))
)
