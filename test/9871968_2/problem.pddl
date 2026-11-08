(define (problem task-9871968-2)
  (:domain appworld-9871968-2)
  (:objects
    brenda - person
    brenda-webe-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    product-1 product-2 product-3 - product
    qty-product-1 qty-product-2 qty-product-3 - quantity
    home-address - address
    payment-card-1 - payment-card
    count-0 count-1 count-2 count-3 - count)
  (:init
    (password-for amazon amazon-password)
    (wishlist-entry product-1 qty-product-1)
    (wishlist-entry product-2 qty-product-2)
    (wishlist-entry product-3 qty-product-3)
    (is-home home-address)
    (cart-count count-0)
    (count-next count-0 count-1)
    (count-next count-1 count-2)
    (count-next count-2 count-3)
    (wishlist-size count-3))
  (:goal (and (order-placed) (task-completed))))
