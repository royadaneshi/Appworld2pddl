(define (problem task-432dc7a-2)
  (:domain appworld-432dc7a-2)
  (:objects
    anthony-harrison - person
    an-harrison-at-gmail-com - username
    gmail-password amazon-password - password
    gmail-token amazon-token - token
    query-amazon-promo - query
    thread-amazon-promo - email-thread
    promo-old promo-new promo-best - promo-code
    address-workplace - address
    payment-card-default - payment-card)
  (:init
    (username-for gmail an-harrison-at-gmail-com)
    (username-for amazon an-harrison-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for amazon amazon-password)
    (query-for query-amazon-promo thread-amazon-promo)
    (thread-contains-code thread-amazon-promo promo-new)
    (promo-applied promo-old)
    (cart-reveals promo-old promo-old)
    (cart-reveals promo-new promo-best)
    (cart-reveals promo-best promo-best)
    (workplace-address address-workplace)
    (cheapest-promo promo-best))
  (:goal (and (order-placed) (task-completed))))
