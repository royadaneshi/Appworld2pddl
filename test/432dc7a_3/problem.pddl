(define (problem task-432dc7a-3)
  (:domain appworld-432dc7a-3)
  (:objects
    jared - person
    jar-calhoun-at-gmail-com - username
    gmail-password amazon-password - password
    gmail-token amazon-token - token
    query-amazon-promo - query
    amazon-promo-thread - email-thread
    promo-code-existing promo-code-new promo-code-best - promo-code
    address-home - address
    amazon-card - payment-card
    cart-order - order
  )
  (:init
    (username-for gmail jar-calhoun-at-gmail-com)
    (username-for amazon jar-calhoun-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for amazon amazon-password)
    (thread-matches query-amazon-promo amazon-promo-thread)
    (thread-contains-code amazon-promo-thread promo-code-new)
    (applied-promo promo-code-existing)
    (cart-check-reveals promo-code-existing promo-code-existing)
    (cart-check-reveals promo-code-new promo-code-best)
    (best-deal promo-code-best)
    (home-address address-home)
  )
  (:goal (and (order-placed cart-order) (task-completed)))
)
