(define (problem task-2e9b91e-1)
  (:domain appworld-2e9b91e-1)
  (:objects
    norman denise - person
    normansmit-at-gmail-com phone-5708520672 - username
    amazon-password phone-password venmo-password - password
    amazon-token phone-token venmo-token - token
    denise-email - email
    query-denise - query
    relationship-friend - relationship
    amount-cart-total - amount
    description-amazon-cart-items - description)
  (:init
    (credential-of-app amazon normansmit-at-gmail-com)
    (credential-of-app phone phone-5708520672)
    (credential-of-app venmo normansmit-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (cart-cost amount-cart-total)
    (contact-query denise query-denise)
    (contact-relationship denise relationship-friend)
    (contact-email denise denise-email))
  (:goal (and (requested-from denise amount-cart-total) (task-completed)))
)
