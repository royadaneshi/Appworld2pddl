(define (problem task-f99d726-3)
  (:domain appworld-f99d726-3)
  (:objects
    jennifer-powell - person
    jepowell-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    flip-flops - product-type
    last-flip-flops-order - order
    last-flip-flops-product replacement-flip-flops - product
    return-deliverer - deliverer
    ordered-quantity - return-quantity
    quantity-1 - cart-quantity
    true-flag - flag
    amazon-payment-card - payment-card
    amazon-address - address)
  (:init
    (password-for amazon amazon-password))
  (:goal (and
    (return-initiated last-flip-flops-order last-flip-flops-product)
    (ordered replacement-flip-flops quantity-1)
    (task-completed))))
