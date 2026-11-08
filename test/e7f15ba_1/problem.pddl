(define (problem task-e7f15ba-1)
  (:domain appworld-e7f15ba-1)
  (:objects
    edwin-wilson parents - person
    ed-wilson-at-gmail-com phone-8506051563 - username
    amazon-password phone-password - password
    amazon-token phone-token - token
    query-codenames-board-game query-garmin-forerunner-245 query-rusch-wall-clock - query
    codenames-board-game garmin-forerunner-245 rusch-wall-clock - product
    quantity-4 quantity-3 quantity-2 - quantity
    relationship-parent - relationship
    parents-home-address - address
    parents-home-addr-name - addr-name
    parents-home-street - street
    parents-home-city - city
    parents-home-state - state
    parents-home-country - country
    parents-home-zipcode - zipcode
    supervisor-payment-card - payment-card)
  (:init
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (username-for amazon ed-wilson-at-gmail-com)
    (username-for phone phone-8506051563)
    (query-for codenames-board-game query-codenames-board-game)
    (query-for garmin-forerunner-245 query-garmin-forerunner-245)
    (query-for rusch-wall-clock query-rusch-wall-clock)
    (desired-quantity codenames-board-game quantity-4)
    (desired-quantity garmin-forerunner-245 quantity-3)
    (desired-quantity rusch-wall-clock quantity-2)
    (relationship-of parents relationship-parent)
    (home-address-of parents parents-home-address)
    (address-parts parents-home-address parents-home-addr-name parents-home-street parents-home-city parents-home-state parents-home-country parents-home-zipcode))
  (:goal (and
    (cart-has codenames-board-game quantity-4)
    (cart-has garmin-forerunner-245 quantity-3)
    (cart-has rusch-wall-clock quantity-2)
    (order-placed)
    (order-shipped-to parents-home-address)
    (task-completed)))
)
