(define (problem task-dbc0276-2)
  (:domain appworld-dbc0276-2)
  (:objects
    jeffery-simpson wife - person
    je-simpson-at-gmail-com username-9654124977 - username
    amazon-password phone-password - password
    amazon-token phone-token - token
    product-1 product-2 - product
    c0 c1 c2 - count
    relationship-wife - relationship
    wife-phone-number - phone-number
    message-itemized-wish-list - message
  )
  (:init
    (username-for amazon je-simpson-at-gmail-com)
    (password-for amazon amazon-password)
    (username-for phone username-9654124977)
    (password-for phone phone-password)
    (in-wish-list product-1)
    (in-wish-list product-2)
    (succ c0 c1)
    (succ c1 c2)
    (resolved-count c0)
    (wish-list-size c2)
    (has-relationship wife relationship-wife)
    (phone-of wife wife-phone-number)
    (message-itemizes-wish-list message-itemized-wish-list)
  )
  (:goal (and
    (text-sent wife-phone-number message-itemized-wish-list)
    (task-completed)
  ))
)
