(define (problem task-1c4bd27-3)
  (:domain appworld-1c4bd27-3)
  (:objects
    angelica-wilson - person
    angelica-wils-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    fedex - deliverer
    order-1 order-2 order-3 order-4 - order
    product-of-order-1 product-of-order-2 product-of-order-3 product-of-order-4 product-of-order-5 product-of-order-6 product-of-order-7 - product
    quantity-of-order-item-1 quantity-of-order-item-2 - quantity
  )
  (:init
    (username-for amazon angelica-wils-at-gmail-com)
    (password-for amazon amazon-password)
    (in-order order-1 product-of-order-1)
    (in-order order-2 product-of-order-2)
    (in-order order-2 product-of-order-3)
    (in-order order-3 product-of-order-4)
    (in-order order-3 product-of-order-5)
    (in-order order-4 product-of-order-6)
    (in-order order-4 product-of-order-7)
    (item-quantity product-of-order-1 quantity-of-order-item-1)
    (item-quantity product-of-order-2 quantity-of-order-item-2)
    (item-quantity product-of-order-3 quantity-of-order-item-2)
    (item-quantity product-of-order-4 quantity-of-order-item-1)
    (item-quantity product-of-order-5 quantity-of-order-item-1)
    (item-quantity product-of-order-6 quantity-of-order-item-2)
    (item-quantity product-of-order-7 quantity-of-order-item-1))
  (:goal (and
    (return-initiated product-of-order-1 fedex)
    (return-initiated product-of-order-2 fedex)
    (return-initiated product-of-order-3 fedex)
    (return-initiated product-of-order-4 fedex)
    (return-initiated product-of-order-5 fedex)
    (return-initiated product-of-order-6 fedex)
    (return-initiated product-of-order-7 fedex)
    (task-completed)))
)
