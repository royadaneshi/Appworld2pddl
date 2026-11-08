(define (problem task-b6d1f70-1)
  (:domain appworld-b6d1f70-1)
  (:objects
    melissa-bailey - person
    mel-bailey-at-gmail-com phone-3383946795 - username
    amazon-password phone-password - password
    amazon-token phone-token - token
    query-wireless-earbuds - query
    rating-3-9 - rating
    wireless-earbuds - product
    relationship-parent - relationship
    parents-home-address - address
    parents-home-name - address-name
    parents-street - street
    parents-city - city
    parents-state - state
    parents-country - country
    parents-zip - zip
    home-address-id parents-address-id - address-id
    amazon-card - card
    order-parents order-home - order
    quantity-1 - quantity
    flag-true - flag)
  (:init
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (search-criteria query-wireless-earbuds rating-3-9)
    (product-query wireless-earbuds query-wireless-earbuds)
    (contact-address relationship-parent parents-home-address)
    (addr-name parents-home-address parents-home-name)
    (addr-street parents-home-address parents-street)
    (addr-city parents-home-address parents-city)
    (addr-state parents-home-address parents-state)
    (addr-country parents-home-address parents-country)
    (addr-zip parents-home-address parents-zip)
    (address-for parents-address-id parents-home-address)
    (amazon-listed home-address-id)
    (unit-quantity quantity-1)
    (true-flag flag-true)
    (order-wrap order-parents wrapped)
    (order-wrap order-home unwrapped)
    (order-destination order-parents parents-address-id)
    (order-destination order-home home-address-id))
  (:goal (and
    (order-placed order-parents wireless-earbuds parents-address-id)
    (order-placed order-home wireless-earbuds home-address-id)
    (task-completed)))
)
