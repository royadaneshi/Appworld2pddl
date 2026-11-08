(define (problem task-30e8586-1)
  (:domain appworld-30e8586-1)
  (:objects
    grant jose brenda nicholas - person
    username-7863159797 username-ka-ball-at-gmail-com - username
    password-phone password-amazon - password
    token-phone token-amazon - token
    query-grant query-jose query-brenda query-nicholas query-popcorn-maker - query
    popcorn-maker-top - product
    quantity-1 - quantity
    card-main - card
    address-grant address-jose address-brenda address-nicholas - address
    name-grant name-jose name-brenda name-nicholas - fullname
    street-grant street-jose street-brenda street-nicholas - street
    city-grant city-jose city-brenda city-nicholas - city
    state-grant state-jose state-brenda state-nicholas - state
    country-grant country-jose country-brenda country-nicholas - country
    zip-grant zip-jose zip-brenda zip-nicholas - zipcode
    duration-monthly - duration
  )
  (:init
    (username-for phone username-7863159797)
    (username-for amazon username-ka-ball-at-gmail-com)
    (password-for phone password-phone)
    (password-for amazon password-amazon)
    (query-for query-grant grant)
    (query-for query-jose jose)
    (query-for query-brenda brenda)
    (query-for query-nicholas nicholas)
    (product-query query-popcorn-maker)
    (unit-quantity quantity-1)
    (monthly duration-monthly)
    (address-of address-grant grant)
    (address-of address-jose jose)
    (address-of address-brenda brenda)
    (address-of address-nicholas nicholas)
    (address-name grant name-grant)
    (address-street grant street-grant)
    (address-city grant city-grant)
    (address-state grant state-grant)
    (address-country grant country-grant)
    (address-zip grant zip-grant)
    (address-name jose name-jose)
    (address-street jose street-jose)
    (address-city jose city-jose)
    (address-state jose state-jose)
    (address-country jose country-jose)
    (address-zip jose zip-jose)
    (address-name brenda name-brenda)
    (address-street brenda street-brenda)
    (address-city brenda city-brenda)
    (address-state brenda state-brenda)
    (address-country brenda country-brenda)
    (address-zip brenda zip-brenda)
    (address-name nicholas name-nicholas)
    (address-street nicholas street-nicholas)
    (address-city nicholas city-nicholas)
    (address-state nicholas state-nicholas)
    (address-country nicholas country-nicholas)
    (address-zip nicholas zip-nicholas)
    (prime-needed)
  )
  (:goal (and
    (ordered grant)
    (ordered jose)
    (ordered brenda)
    (ordered nicholas)
    (task-completed)
  ))
)
