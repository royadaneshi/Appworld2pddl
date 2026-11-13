(define (problem task-6d59d90-2)
  (:domain appworld-6d59d90-2)
  (:objects
    jessica - person
    jes-mill-at-gmail-com - username
    amazon-password venmo-password - password
    amazon-token venmo-token - token
    safety-goggles - product-type
    price-ascending - sort-key
    days-3 - day-limit
    cheapest-safety-goggles - product
    quantity-1 - quantity
    true-flag - flag
    order-total - amount
    amazon-card venmo-card - card
    jessica-home-address - address)
  (:init
    (credential-of-app amazon jes-mill-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (credential-of-app venmo jes-mill-at-gmail-com)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for amazon jes-mill-at-gmail-com)
    (username-for venmo jes-mill-at-gmail-com)
    (password-for amazon amazon-password)
    (password-for venmo venmo-password)
    (sorts-by-price price-ascending)
    (max-delivery-days days-3)
    (target-product cheapest-safety-goggles safety-goggles days-3)
    (single-unit quantity-1)
    (is-true true-flag)
    (order-total-of cheapest-safety-goggles order-total)
    (home-address jessica-home-address)
    (card-on-amazon amazon-card)
    (card-on-venmo venmo-card)
    (same-card amazon-card venmo-card))
  (:goal (and (money-transferred) (order-placed) (task-completed)))
)
