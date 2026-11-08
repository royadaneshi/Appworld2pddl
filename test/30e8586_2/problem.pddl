(define (problem task-30e8586-2)
  (:domain appworld-30e8586-2)
  (:objects
    caitlin kyle kayla - person
    phone-username-5896230193 amazon-username-caiburc-at-gmail-com - username
    phone-password amazon-password - password
    phone-token amazon-token - token
    query-kyle query-kayla - query
    product-type-gaming-console - product-type
    sort-by-rating-desc - sort-key
    top-gaming-console - product
    quantity-1 - quantity
    amazon-card - payment-card
    duration-monthly - duration
    address-kyle address-kayla - address
    kyle-name kayla-name - address-name
    kyle-street kayla-street - street
    kyle-city kayla-city - city
    kyle-state kayla-state - state
    kyle-country kayla-country - country
    kyle-zip kayla-zip - zipcode
    order-kyle order-kayla - order)
  (:init
    (username-for phone phone-username-5896230193)
    (username-for amazon amazon-username-caiburc-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (query-for query-kyle kyle)
    (query-for query-kayla kayla)
    (home-address-parts kyle kyle-name kyle-street kyle-city kyle-state kyle-country kyle-zip)
    (home-address-parts kayla kayla-name kayla-street kayla-city kayla-state kayla-country kayla-zip)
    (console-type product-type-gaming-console)
    (rating-desc sort-by-rating-desc)
    (monthly duration-monthly)
    (quantity-one quantity-1)
    (address-for address-kyle kyle)
    (address-for address-kayla kayla)
    (order-for order-kyle kyle)
    (order-for order-kayla kayla)
    (prime-beneficial))
  (:goal (and
    (order-placed order-kyle)
    (order-placed order-kayla)
    (prime-handled)
    (task-completed)))
)
