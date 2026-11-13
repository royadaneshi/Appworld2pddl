(define (problem task-9871968-3)
  (:domain appworld-9871968-3)
  (:objects
    vickie-powell - person
    vicpowe-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    wishlist-product-1 wishlist-product-2 wishlist-product-3 wishlist-product-4 wishlist-product-5 wishlist-product-6 wishlist-product-7 - product
    quantity-of-product-1 quantity-of-product-2 quantity-of-product-3 quantity-of-product-4 - quantity
    address-work address-home - address
    payment-card-1 - payment-card
  )
  (:init
    (password-for amazon amazon-password)
    (is-work-address address-work)
    (on-wishlist wishlist-product-1)
    (on-wishlist wishlist-product-2)
    (on-wishlist wishlist-product-3)
    (on-wishlist wishlist-product-4)
    (on-wishlist wishlist-product-5)
    (on-wishlist wishlist-product-6)
    (on-wishlist wishlist-product-7)
    (wishlist-quantity wishlist-product-1 quantity-of-product-1)
    (wishlist-quantity wishlist-product-2 quantity-of-product-3)
    (wishlist-quantity wishlist-product-3 quantity-of-product-4)
    (wishlist-quantity wishlist-product-4 quantity-of-product-1)
    (wishlist-quantity wishlist-product-5 quantity-of-product-4)
    (wishlist-quantity wishlist-product-6 quantity-of-product-2)
    (wishlist-quantity wishlist-product-7 quantity-of-product-3))
  (:goal (and
    (order-placed)
    (moved-to-cart wishlist-product-1)
    (moved-to-cart wishlist-product-2)
    (moved-to-cart wishlist-product-3)
    (moved-to-cart wishlist-product-4)
    (moved-to-cart wishlist-product-5)
    (moved-to-cart wishlist-product-6)
    (moved-to-cart wishlist-product-7)
    (task-completed)))
)
