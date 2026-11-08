(define (problem task-9aae7da-2)
  (:domain appworld-9aae7da-2)
  (:objects
    deniseburch-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    cart-total wishlist-total combined-total - amount)
  (:init
    (password-for amazon amazon-password)
    (sum-of cart-total wishlist-total combined-total))
  (:goal (and (found-cart-total cart-total)
              (found-wishlist-total wishlist-total)
              (task-completed)))
)
