(define (problem task-d9987f6-1)
  (:domain appworld-d9987f6-1)
  (:objects
    adam-blackburn - person
    ad-blackburn-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-extension-cord - query
    extension-cord - product-type
    rating-4-5 - rating
    extension-cord-product - product
    home-address work-address - address
    payment-card-1 - payment-card
    quantity-1 - quantity)
  (:init
    (password-for amazon amazon-password)
    (wanted-type extension-cord)
    (wanted-rating rating-4-5)
    (product-type-of extension-cord-product extension-cord)
    (rating-above extension-cord-product rating-4-5)
    (is-home home-address)
    (single-unit quantity-1)
    (cart-may-have-items))
  (:goal (and (order-placed) (task-completed))))
