(define (problem task-5800354-1)
  (:domain appworld-5800354-1)
  (:objects
    jennifer roommate - person
    username-4288705164 jepowell-at-gmail-com - username
    phone-password amazon-password venmo-password - password
    phone-token amazon-token venmo-token - token
    relationship-roommate - relationship
    roommate-phone-number - phone-number
    roommate-email - email
    return-message - text-message
    returned-product - product
    query-returned-product - query
    the-order - order
    return-deliverer - deliverer
    order-quantity - quantity
    order-cost - amount)
  (:init
    (credential-of-app phone username-4288705164)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app amazon jepowell-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (credential-of-app venmo jepowell-at-gmail-com)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone username-4288705164)
    (username-for amazon jepowell-at-gmail-com)
    (username-for venmo jepowell-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (password-for venmo venmo-password)
    (has-relationship roommate relationship-roommate)
    (contact-phone roommate roommate-phone-number)
    (contact-email roommate roommate-email)
    (message-from return-message roommate)
    (message-about return-message returned-product)
    (product-query returned-product query-returned-product)
    (order-contains the-order returned-product)
    (order-item-quantity the-order returned-product order-quantity)
    (order-item-cost the-order returned-product order-cost))
  (:goal (and (return-initiated the-order returned-product)
              (money-sent roommate order-cost)
              (task-completed))))
