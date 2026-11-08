(define (problem task-b6d1f70-2)
  (:domain appworld-b6d1f70-2)
  (:objects
    paul-miller father - person
    paul-mill-at-gmail-com phone-3379617841 - username
    amazon-password phone-password - password
    amazon-token phone-token - token
    relationship-father - relationship
    product-type-gaming-console-controller - product-type
    rating-3-8 - rating
    quantity-1 - quantity
    bool-true - bool
    father-addr-name - addr-name
    father-street - street
    father-city - city
    father-state - state
    father-country - country
    father-zip - zipcode
    controller-product - product
    home-address father-home-address - address
    payment-card-1 - payment-card
    order-father order-home - order
  )
  (:init
    (username-for amazon paul-mill-at-gmail-com)
    (username-for phone phone-3379617841)
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (relationship-of father relationship-father)
    (home-address-of father father-home-address)
    (address-details father-home-address father-addr-name father-street father-city father-state father-country father-zip)
    (amazon-stored-address home-address)
    (search-criteria product-type-gaming-console-controller rating-3-8)
    (deliver-wrapped order-father father-home-address)
    (deliver-plain order-home home-address)
  )
  (:goal (and
    (order-placed order-father)
    (order-product order-father controller-product)
    (order-address order-father father-home-address)
    (order-wrap order-father wrapped)
    (order-placed order-home)
    (order-product order-home controller-product)
    (order-address order-home home-address)
    (order-wrap order-home unwrapped)
    (task-completed)
  ))
)
