(define (problem task-efc3cea-3)
  (:domain appworld-efc3cea-3)
  (:objects
    lindsey - person
    lindseysimpson-at-gmail-com - username
    gmail-password amazon-password - password
    gmail-token amazon-token - token
    query-flight - query
    flight-confirmation-thread - email-thread
    product-type-board-game - product-type
    the-board-game - product
    quantity-3 - quantity
    flag-true - flag
    home-address - address
    payment-card-1 - payment-card)
  (:init
    (password-for gmail gmail-password)
    (password-for amazon amazon-password)
    (is-home-address home-address))
  (:goal (and
    (order-placed the-board-game quantity-3)
    (gift-wrapped the-board-game quantity-3)
    (task-completed))))
