(define (problem task-9aae7da-3)
  (:domain appworld-9aae7da-3)
  (:objects
    brenda - person
    brenda-webe-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    total-cost - amount)
  (:init
    (username-for amazon brenda-webe-at-gmail-com)
    (password-for amazon amazon-password)
    (answer-total total-cost))
  (:goal (and (found-cart-cost)
              (found-wishlist-cost)
              (task-completed)))
)
