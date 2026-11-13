(define (problem task-b08d5ef-1)
  (:domain appworld-b08d5ef-1)
  (:objects
    jordan-harrison parent-1 parent-2 sibling-1 sibling-2 sibling-3 - person
    rel-sibling rel-parent - relationship
    phone-username-2254213734 amazon-username-jo-harr-at-gmail-com - username
    phone-password amazon-password - password
    phone-token amazon-token - token
    query-hurom-hp-slow-juicer - query
    card-1 - payment-card
    quantity-1 quantity-2 - quantity
    name-parents-home name-sibling-1-home name-sibling-2-home name-sibling-3-home - address-name
    street-parents-home street-sibling-1-home street-sibling-2-home street-sibling-3-home - street
    city-parents-home city-sibling-1-home city-sibling-2-home city-sibling-3-home - city
    state-parents-home state-sibling-1-home state-sibling-2-home state-sibling-3-home - state
    country-parents-home country-sibling-1-home country-sibling-2-home country-sibling-3-home - country
    zip-parents-home zip-sibling-1-home zip-sibling-2-home zip-sibling-3-home - zip-code
  )
  (:init
    (username-for phone phone-username-2254213734)
    (username-for amazon amazon-username-jo-harr-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (has-relationship parent-1 rel-parent)
    (has-relationship parent-2 rel-parent)
    (has-relationship sibling-1 rel-sibling)
    (has-relationship sibling-2 rel-sibling)
    (has-relationship sibling-3 rel-sibling)
    (lives-at parent-1 addr-parents-home)
    (lives-at parent-2 addr-parents-home)
    (lives-at sibling-1 addr-sibling-1-home)
    (lives-at sibling-2 addr-sibling-2-home)
    (lives-at sibling-3 addr-sibling-3-home)
    (addr-has-quantity addr-parents-home quantity-2)
    (addr-has-quantity addr-sibling-1-home quantity-1)
    (addr-has-quantity addr-sibling-2-home quantity-1)
    (addr-has-quantity addr-sibling-3-home quantity-1)
    (addr-has-name addr-parents-home name-parents-home)
    (addr-has-street addr-parents-home street-parents-home)
    (addr-has-city addr-parents-home city-parents-home)
    (addr-has-state addr-parents-home state-parents-home)
    (addr-has-country addr-parents-home country-parents-home)
    (addr-has-zip addr-parents-home zip-parents-home)
    (addr-has-name addr-sibling-1-home name-sibling-1-home)
    (addr-has-name addr-sibling-2-home name-sibling-2-home)
    (addr-has-name addr-sibling-3-home name-sibling-3-home)
    (addr-has-street addr-sibling-1-home street-sibling-1-home)
    (addr-has-street addr-sibling-2-home street-sibling-2-home)
    (addr-has-street addr-sibling-3-home street-sibling-3-home)
    (addr-has-city addr-sibling-1-home city-sibling-1-home)
    (addr-has-city addr-sibling-2-home city-sibling-2-home)
    (addr-has-city addr-sibling-3-home city-sibling-3-home)
    (addr-has-state addr-sibling-1-home state-sibling-1-home)
    (addr-has-state addr-sibling-2-home state-sibling-2-home)
    (addr-has-state addr-sibling-3-home state-sibling-3-home)
    (addr-has-country addr-sibling-1-home country-sibling-1-home)
    (addr-has-country addr-sibling-2-home country-sibling-2-home)
    (addr-has-country addr-sibling-3-home country-sibling-3-home)
    (addr-has-zip addr-sibling-1-home zip-sibling-1-home)
    (addr-has-zip addr-sibling-2-home zip-sibling-2-home)
    (addr-has-zip addr-sibling-3-home zip-sibling-3-home)
    (product-query hurom-hp-slow-juicer query-hurom-hp-slow-juicer))
  (:goal (and
    (ordered addr-parents-home hurom-hp-slow-juicer)
    (ordered addr-sibling-1-home hurom-hp-slow-juicer)
    (ordered addr-sibling-2-home hurom-hp-slow-juicer)
    (ordered addr-sibling-3-home hurom-hp-slow-juicer)
    (task-completed))))
