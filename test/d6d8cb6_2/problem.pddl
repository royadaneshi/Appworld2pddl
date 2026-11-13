(define (problem task-d6d8cb6-2)
  (:domain appworld-d6d8cb6-2)
  (:objects
    alex carl - person
    alexwhite-at-gmail-com phone-3707865891 - username
    amazon-pw phone-pw gmail-pw - password
    amazon-tok phone-tok gmail-tok - token
    query-eket-cabinet query-carl query-amazon-return-confirmation - query
    eket-cabinet-order - order
    eket-cabinet - product
    usps - deliverer
    qty-1 - quantity
    carl-email - email
    return-confirmation-thread - email-thread
    return-confirmation-email - email-msg)
  (:init
    (credential-of-app amazon alexwhite-at-gmail-com)
    (credential-of-app amazon amazon-pw)
    (credential-of-app amazon amazon-tok)
    (credential-of-app phone phone-3707865891)
    (credential-of-app phone phone-pw)
    (credential-of-app phone phone-tok)
    (credential-of-app gmail alexwhite-at-gmail-com)
    (credential-of-app gmail gmail-pw)
    (credential-of-app gmail gmail-tok)
    (username-for amazon alexwhite-at-gmail-com)
    (username-for gmail alexwhite-at-gmail-com)
    (username-for phone phone-3707865891)
    (password-for amazon amazon-pw)
    (password-for phone phone-pw)
    (password-for gmail gmail-pw)
    (order-query query-eket-cabinet eket-cabinet-order)
    (ordered-product eket-cabinet-order eket-cabinet)
    (contact-query query-carl carl)
    (has-email carl carl-email)
    (confirmation-query query-amazon-return-confirmation)
    (confirmation-thread return-confirmation-thread eket-cabinet-order)
    (in-thread return-confirmation-email return-confirmation-thread))
  (:goal (and
    (return-initiated eket-cabinet-order eket-cabinet usps qty-1)
    (forwarded return-confirmation-email carl-email)
    (task-completed))))
