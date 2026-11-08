(define (problem task-23d431c-1)
  (:domain appworld-23d431c-1)
  (:objects
    dillon-wilson - person
    diwils-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-cutting-board - query
    price-30 - price
    trusted-seller - seller
    past-purchased-product cutting-board-product - product
    cutting-board - product-type
    home-address - address
    primary-payment-card - payment-card
    quantity-1 - quantity)
  (:init
    (password-for amazon amazon-password)
    (purchased-before past-purchased-product)
    (sold-by past-purchased-product trusted-seller)
    (sold-by cutting-board-product trusted-seller)
    (product-type-of cutting-board-product cutting-board)
    (wanted-type cutting-board)
    (query-for query-cutting-board cutting-board)
    (budget price-30)
    (price-at-most cutting-board-product price-30)
    (is-one quantity-1))
  (:goal (and (ordered cutting-board-product quantity-1) (task-completed))))
