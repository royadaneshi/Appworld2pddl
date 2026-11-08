(define (problem task-432dc7a-1)
  (:domain appworld-432dc7a-1)
  (:objects
    joseharr-at-gmail-com - username
    amazon-password gmail-password - password
    amazon-token gmail-token - token
    query-promo - query
    promo-current promo-new promo-best - promo-code
    amazon-promo-thread - email-thread
    addr-home - address
    card-1 - payment-card
    order-1 - order)
  (:init
    (password-for amazon amazon-password)
    (password-for gmail gmail-password)
    (promo-applied promo-current)
    (cart-reveals promo-current promo-current)
    (cart-reveals promo-new promo-best)
    (cart-reveals promo-best promo-best)
    (query-finds query-promo amazon-promo-thread)
    (thread-contains-promo amazon-promo-thread promo-new)
    (home-address addr-home)
    (best-promo promo-best))
  (:goal (and
    (order-placed order-1)
    (order-address order-1 addr-home)
    (order-promo order-1 promo-best)
    (task-completed))))
