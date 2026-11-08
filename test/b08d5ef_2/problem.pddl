(define (problem task-b08d5ef-2)
  (:domain appworld-b08d5ef-2)
  (:objects
    miranda - person
    mir-powe-at-gmail-com username-4885870260 - username
    phone-password amazon-password - password
    phone-token amazon-token - token
    query-codenames-board-game - query
    relationship-parent relationship-sibling - relationship
    name-parents name-sibling-1 name-sibling-2 - addr-name
    street-parents street-sibling-1 street-sibling-2 - street
    city-parents city-sibling-1 city-sibling-2 - city
    state-parents state-sibling-1 state-sibling-2 - state
    country-parents country-sibling-1 country-sibling-2 - country
    zip-parents zip-sibling-1 zip-sibling-2 - zip-code
    amazon-card - payment-card
    quantity-1 quantity-2 - quantity
    clear-cart-true - flag)
  (:init
    (username-for phone username-4885870260)
    (username-for amazon mir-powe-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (search-query codenames-board-game query-codenames-board-game)
    (home-of-relationship home-parents relationship-parent)
    (home-of-relationship home-sibling-1 relationship-sibling)
    (home-of-relationship home-sibling-2 relationship-sibling)
    (home-name home-parents name-parents)
    (home-street home-parents street-parents)
    (home-city home-parents city-parents)
    (home-state home-parents state-parents)
    (home-country home-parents country-parents)
    (home-zip home-parents zip-parents)
    (home-name home-sibling-1 name-sibling-1)
    (home-street home-sibling-1 street-sibling-1)
    (home-city home-sibling-1 city-sibling-1)
    (home-state home-sibling-1 state-sibling-1)
    (home-country home-sibling-1 country-sibling-1)
    (home-zip home-sibling-1 zip-sibling-1)
    (home-name home-sibling-2 name-sibling-2)
    (home-street home-sibling-2 street-sibling-2)
    (home-city home-sibling-2 city-sibling-2)
    (home-state home-sibling-2 state-sibling-2)
    (home-country home-sibling-2 country-sibling-2)
    (home-zip home-sibling-2 zip-sibling-2)
    (needs-quantity home-parents quantity-2)
    (needs-quantity home-sibling-1 quantity-1)
    (needs-quantity home-sibling-2 quantity-1))
  (:goal (and
    (order-placed home-parents codenames-board-game)
    (order-placed home-sibling-1 codenames-board-game)
    (order-placed home-sibling-2 codenames-board-game)
    (task-completed)))
)
