(define (problem task-dc5c5c6-3)
  (:domain appworld-dc5c5c6-3)
  (:objects
    nicholas sister-1 sister-2 - person
    phone-9503658964 nicholas-weber-at-gmail-com - username
    phone-password amazon-password - password
    phone-token amazon-token - token
    relationship-sister - relationship
    query-portable-air-conditioner - query
    product-type-portable-air-conditioner - product-type
    sort-by-rating-desc - sort-key
    top-rated-portable-air-conditioner - product
    amazon-card - payment-card
    addr-sister-1 addr-sister-2 - address
    sister-1-name sister-1-street sister-1-city sister-1-state sister-1-country sister-1-zip
    sister-2-name sister-2-street sister-2-city sister-2-state sister-2-country sister-2-zip - address-field
    quantity-1 - quantity
    flag-true - flag
  )
  (:init
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (has-relationship sister-1 relationship-sister)
    (has-relationship sister-2 relationship-sister)
    (home-name sister-1 sister-1-name)
    (home-street sister-1 sister-1-street)
    (home-city sister-1 sister-1-city)
    (home-state sister-1 sister-1-state)
    (home-country sister-1 sister-1-country)
    (home-zip sister-1 sister-1-zip)
    (home-name sister-2 sister-2-name)
    (home-street sister-2 sister-2-street)
    (home-city sister-2 sister-2-city)
    (home-state sister-2 sister-2-state)
    (home-country sister-2 sister-2-country)
    (home-zip sister-2 sister-2-zip)
    (address-of sister-1 addr-sister-1)
    (address-of sister-2 addr-sister-2)
  )
  (:goal (and
    (ordered-for sister-1)
    (ordered-for sister-2)
    (task-completed)
  ))
)
