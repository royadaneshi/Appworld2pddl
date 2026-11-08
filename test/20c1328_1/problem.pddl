(define (problem task-20c1328-1)
  (:domain appworld-20c1328-1)
  (:objects
    jose-harrison - person
    joseharr-at-gmail-com username-2474975253 - username
    amazon-password phone-password - password
    amazon-token phone-token - token
    query-picture-frame - query
    type-picture-frame - product-type
    price-10 price-20 - price
    sort-by-rating-desc - sort-key
    relationship-roommate - relationship
    quantity-roommate-count - quantity
    flag-true - flag
    top-picture-frame - product
    home-address - address
    amazon-payment-card - payment-card)
  (:init
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (username-for amazon joseharr-at-gmail-com)
    (username-for phone username-2474975253)
    (is-roommates relationship-roommate)
    (count-result relationship-roommate quantity-roommate-count)
    (search-spec query-picture-frame type-picture-frame price-10 price-20 sort-by-rating-desc)
    (search-result top-picture-frame)
    (clear-first flag-true)
    (is-home home-address))
  (:goal (and
    (ordered top-picture-frame quantity-roommate-count home-address)
    (task-completed)))
)
