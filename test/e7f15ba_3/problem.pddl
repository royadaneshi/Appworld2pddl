(define (problem task-e7f15ba-3)
  (:domain appworld-e7f15ba-3)
  (:objects
    james-solomon supervisors-mother - person
    ja-solomon-at-gmail-com username-8683971586 - username
    amazon-password phone-password - password
    amazon-token phone-token - token
    mother - relationship
    mother-home-address - address
    mother-name - addr-name
    mother-street - street
    mother-city - city
    mother-state - state
    mother-country - country
    mother-zip - zip-code
    gregory-baltoro-65-pack taotronics-led-desk-lamp parrot-anafi-drone - product
    query-gregory-baltoro-65-pack query-taotronics-led-desk-lamp query-parrot-anafi-drone - query
    quantity-4 quantity-3 quantity-2 - quantity
    amazon-card - payment-card)
  (:init
    (username-for amazon ja-solomon-at-gmail-com)
    (username-for phone username-8683971586)
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (token-for amazon amazon-token)
    (token-for phone phone-token)
    (relationship-of supervisors-mother mother)
    (home-address-of supervisors-mother mother-home-address)
    (address-fields mother-home-address mother-name mother-street mother-city mother-state mother-country mother-zip)
    (query-for gregory-baltoro-65-pack query-gregory-baltoro-65-pack)
    (query-for taotronics-led-desk-lamp query-taotronics-led-desk-lamp)
    (query-for parrot-anafi-drone query-parrot-anafi-drone)
    (wants-quantity gregory-baltoro-65-pack quantity-4)
    (wants-quantity taotronics-led-desk-lamp quantity-3)
    (wants-quantity parrot-anafi-drone quantity-2))
  (:goal (and (order-placed mother-home-address) (task-completed))))
