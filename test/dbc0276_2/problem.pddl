(define (problem task-dbc0276-2)
  (:domain appworld-dbc0276-2)
  (:objects
    jeffery-simpson wife - person
    je-simpson-at-gmail-com username-9654124977 - username
    amazon-password phone-password - password
    amazon-token phone-token - token
    product-1 product-2 product-3 product-4 product-5 - product
    c0 c1 c2 c3 c4 c5 - count
    relationship-wife - relationship
    wife-phone-number - phone-number
    message-itemized-wish-list - message
  )
  (:init
    (credential-of-app amazon je-simpson-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (credential-of-app phone username-9654124977)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (username-for amazon je-simpson-at-gmail-com)
    (password-for amazon amazon-password)
    (username-for phone username-9654124977)
    (password-for phone phone-password)
    (in-wish-list product-1)
    (in-wish-list product-2)
    (in-wish-list product-3)
    (in-wish-list product-4)
    (in-wish-list product-5)
    (resolved-count c0)
    (has-relationship wife relationship-wife)
    (phone-of wife wife-phone-number)
    (message-itemizes-wish-list message-itemized-wish-list)
    (succ c0 c1)
    (succ c1 c2)
    (succ c2 c3)
    (succ c3 c4)
    (succ c4 c5)
    (wish-list-size c5))
  (:goal (and
    (text-sent wife-phone-number message-itemized-wish-list)
    (task-completed)))
)
