(define (problem task-9aae7da-1)
  (:domain appworld-9aae7da-1)
  (:objects
    jason-simpson - person
    jasonsimp-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    total-cart-and-wishlist-cost - amount)
  (:init
    (password-for amazon amazon-password)
    (is-total-cost total-cart-and-wishlist-cost))
  (:goal (and (found-cart-total)
              (found-wishlist-total)
              (task-completed)))
)
