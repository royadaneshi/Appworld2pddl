(define (problem task-b08d5ef-3)
  (:domain appworld-b08d5ef-3)
  (:objects
    denise - person
    phone-6279200672 deniseburch-at-gmail-com - username
    phone-password amazon-password - password
    phone-token amazon-token - token
    query-kallax-shelf-unit - query
    kallax-shelf-unit - product
    payment-card-1 - card
    home-1 home-2 - home
    quantity-1 quantity-2 - quantity
    home-1-name home-2-name - address-name
    home-1-street home-2-street - street
    home-1-city home-2-city - city
    home-1-state home-2-state - state
    home-1-country home-2-country - country
    home-1-zip home-2-zip - zip-code)
  (:init
    (username-for phone phone-6279200672)
    (username-for amazon deniseburch-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (search-query query-kallax-shelf-unit kallax-shelf-unit)
    (home-name home-1 home-1-name)
    (home-street home-1 home-1-street)
    (home-city home-1 home-1-city)
    (home-state home-1 home-1-state)
    (home-country home-1 home-1-country)
    (home-zip home-1 home-1-zip)
    (home-name home-2 home-2-name)
    (home-street home-2 home-2-street)
    (home-city home-2 home-2-city)
    (home-state home-2 home-2-state)
    (home-country home-2 home-2-country)
    (home-zip home-2 home-2-zip)
    (household-size home-1 quantity-2)
    (household-size home-2 quantity-1)
    (cart-dirty))
  (:goal (and
    (ordered home-1 kallax-shelf-unit)
    (ordered home-2 kallax-shelf-unit)
    (task-completed))))
