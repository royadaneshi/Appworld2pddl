(define (problem task-9871968-3)
  (:domain appworld-9871968-3)
  (:objects
    vickie-powell - person
    vicpowe-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    wishlist-product-1 wishlist-product-2 wishlist-product-3 - product
    quantity-of-product-1 quantity-of-product-2 quantity-of-product-3 - quantity
    address-work address-home - address
    payment-card-1 - payment-card
  )
  (:init
    (password-for amazon amazon-password)
    (on-wishlist wishlist-product-1)
    (on-wishlist wishlist-product-2)
    (on-wishlist wishlist-product-3)
    (wishlist-quantity wishlist-product-1 quantity-of-product-1)
    (wishlist-quantity wishlist-product-2 quantity-of-product-2)
    (wishlist-quantity wishlist-product-3 quantity-of-product-3)
    (is-work-address address-work)
  )
  (:goal (and
    (order-placed)
    (moved-to-cart wishlist-product-1)
    (moved-to-cart wishlist-product-2)
    (moved-to-cart wishlist-product-3)
    (task-completed)
  ))
)
