(define (problem task-9871968-2)
  (:domain appworld-9871968-2)
  (:objects
    brenda - person
    brenda-webe-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    product-1 product-2 product-3 product-4 product-5 product-6 product-7 - product
    qty-product-1 qty-product-2 qty-product-3 qty-product-4 - quantity
    home-address - address
    payment-card-1 - payment-card
    count-0 count-1 count-2 count-3 count-4 count-5 count-6 count-7 - count
  )
  (:init
    (password-for amazon amazon-password)
    (is-home home-address)
    (cart-count count-0)
    (wishlist-entry product-1 qty-product-2)
    (wishlist-entry product-2 qty-product-1)
    (wishlist-entry product-3 qty-product-4)
    (wishlist-entry product-4 qty-product-3)
    (wishlist-entry product-5 qty-product-1)
    (wishlist-entry product-6 qty-product-1)
    (wishlist-entry product-7 qty-product-1)
    (count-next count-0 count-1)
    (count-next count-1 count-2)
    (count-next count-2 count-3)
    (count-next count-3 count-4)
    (count-next count-4 count-5)
    (count-next count-5 count-6)
    (count-next count-6 count-7)
    (wishlist-size count-7))
  (:goal (and
    (order-placed)
    (in-cart product-1)
    (in-cart product-2)
    (in-cart product-3)
    (in-cart product-4)
    (in-cart product-5)
    (in-cart product-6)
    (in-cart product-7)
    (task-completed))))
