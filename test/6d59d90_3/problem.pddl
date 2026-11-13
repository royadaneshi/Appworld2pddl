(define (problem task-6d59d90-3)
  (:domain appworld-6d59d90-3)
  (:objects
    jose-harrison - person
    joseharr-at-gmail-com - username
    amazon-password venmo-password - password
    amazon-token venmo-token - token
    type-insect-repellent - product-type
    sort-price-asc - sort-key
    flag-true - flag
    cheapest-insect-repellent - product
    amount-order-total - amount
    amazon-card-1 venmo-card-1 - card
    jose-home-address - address)
  (:init
    (credential-of-app amazon joseharr-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (credential-of-app venmo joseharr-at-gmail-com)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for amazon joseharr-at-gmail-com)
    (username-for venmo joseharr-at-gmail-com)
    (password-for amazon amazon-password)
    (password-for venmo venmo-password)
    (search-target type-insect-repellent sort-price-asc cheapest-insect-repellent)
    (is-true flag-true)
    (total-for cheapest-insect-repellent amount-order-total)
    (home-address jose-home-address)
    (amazon-card amazon-card-1)
    (venmo-card venmo-card-1)
    (same-card amazon-card-1 venmo-card-1))
  (:goal (and
    (order-placed cheapest-insect-repellent jose-home-address amazon-card-1)
    (card-funded venmo-card-1 amount-order-total)
    (task-completed)))
)
