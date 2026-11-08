(define (problem task-1c4bd27-1)
  (:domain appworld-1c4bd27-1)
  (:objects
    tammy-weaver - person
    ta-weav-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    order-last-1 order-last-2 - order
    product-1a product-1b product-2a product-2b - product
    qty-1a qty-1b qty-2a qty-2b - quantity
    fedex - deliverer)
  (:init
    (password-for amazon amazon-password)
    (recent-order order-last-1)
    (recent-order order-last-2)
    (item-of order-last-1 product-1a qty-1a)
    (item-of order-last-1 product-1b qty-1b)
    (item-of order-last-2 product-2a qty-2a)
    (item-of order-last-2 product-2b qty-2b)
    (fedex-deliverer fedex))
  (:goal (and
    (return-initiated order-last-1 product-1a)
    (return-initiated order-last-1 product-1b)
    (return-initiated order-last-2 product-2a)
    (return-initiated order-last-2 product-2b)
    (task-completed)))
)
