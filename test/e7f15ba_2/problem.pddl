(define (problem task-e7f15ba-2)
  (:domain appworld-e7f15ba-2)
  (:objects
    troy troy-father - person
    father - relationship
    amazon-username-tr-solo-at-gmail-com phone-username-7273731063 - username
    amazon-password phone-password - password
    amazon-token phone-token - token
    query-modern-ceramic-table-lamp query-nintendo-switch-oled-model query-kallax-shelf-unit - query
    modern-ceramic-table-lamp nintendo-switch-oled-model kallax-shelf-unit - product
    qty-3 qty-2 qty-4 - quantity
    father-home-address - address
    father-address-name father-street father-city father-state father-country father-zip - address-part
    father-amazon-address-id - address-id
    amazon-payment-card - payment-card
    order-1 - order)
  (:init
    (username-for amazon amazon-username-tr-solo-at-gmail-com)
    (username-for phone phone-username-7273731063)
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (has-relationship troy-father father)
    (home-address-of troy-father father-home-address)
    (address-name-of father-home-address father-address-name)
    (street-of father-home-address father-street)
    (city-of father-home-address father-city)
    (state-of father-home-address father-state)
    (country-of father-home-address father-country)
    (zip-of father-home-address father-zip)
    (query-for modern-ceramic-table-lamp query-modern-ceramic-table-lamp)
    (query-for nintendo-switch-oled-model query-nintendo-switch-oled-model)
    (query-for kallax-shelf-unit query-kallax-shelf-unit)
    (wanted-quantity modern-ceramic-table-lamp qty-3)
    (wanted-quantity nintendo-switch-oled-model qty-2)
    (wanted-quantity kallax-shelf-unit qty-4))
  (:goal (and
    (in-cart modern-ceramic-table-lamp qty-3)
    (in-cart nintendo-switch-oled-model qty-2)
    (in-cart kallax-shelf-unit qty-4)
    (address-on-amazon father-home-address father-amazon-address-id)
    (order-placed order-1 father-amazon-address-id)
    (task-completed)))
)
