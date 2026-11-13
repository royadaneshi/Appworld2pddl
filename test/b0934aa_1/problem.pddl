(define (problem task-b0934aa-1)
  (:domain appworld-b0934aa-1)
  (:objects
    hunter-weaver - person
    hun-weaver-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-board-game - query
    board-game - product-type
    amount-20 - amount
    rating-3-9 - rating
    qualifying-board-game - product
    quantity-1 - quantity
    clear-cart-true - flag
    home-address - address
    amazon-payment-card - payment-card
    home-address-name home-address-street home-address-city home-address-state home-address-country home-address-zip - address-field
  )
  (:init
    (password-for amazon amazon-password)
    (query-for-type query-board-game board-game)
    (price-limit amount-20)
    (rating-limit rating-3-9)
    (product-of-type qualifying-board-game board-game)
    (unit-quantity quantity-1)
    (clear-first clear-cart-true)
    (is-home-address home-address)
    (address-name home-address home-address-name)
    (address-street home-address home-address-street)
    (address-city home-address home-address-city)
    (address-state home-address home-address-state)
    (address-country home-address home-address-country)
    (address-zip home-address home-address-zip)
  )
  (:goal (and (order-placed qualifying-board-game home-address) (task-completed))))
