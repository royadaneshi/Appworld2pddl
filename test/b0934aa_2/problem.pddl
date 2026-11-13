(define (problem task-b0934aa-2)
  (:domain appworld-b0934aa-2)
  (:objects
    grant-martinez - person
    gra-martinez-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-external-hard-drive - query
    ptype-external-hard-drive - product-type
    price-50 - price
    rating-3-8 - rating
    quantity-1 - quantity
    flag-true - flag
    external-hard-drive - product
    work-address - address
    amazon-card - payment-card
    work-address-name work-address-street work-address-city work-address-state work-address-country work-address-zip - address-field
  )
  (:init
    (password-for amazon amazon-password)
    (search-criteria query-external-hard-drive ptype-external-hard-drive price-50 rating-3-8)
    (quantity-one quantity-1)
    (clear-cart-flag flag-true)
    (target-delivery work-address)
    (address-name work-address work-address-name)
    (address-street work-address work-address-street)
    (address-city work-address work-address-city)
    (address-state work-address work-address-state)
    (address-country work-address work-address-country)
    (address-zip work-address work-address-zip)
  )
  (:goal (and
    (ordered external-hard-drive work-address)
    (task-completed)
  ))
)
