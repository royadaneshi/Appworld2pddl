(define (problem task-5800354-2)
  (:domain appworld-5800354-2)
  (:objects
    troy roommate - person
    username-7273731063 username-tr-solo-at-gmail-com - username
    phone-password amazon-password venmo-password - password
    phone-token amazon-token venmo-token - token
    relationship-roommate - relationship
    query-return-product - query
    roommate-phone-number - phone-number
    roommate-email - email
    roommate-return-message - message
    roommate-order - order
    return-product - product
    return-deliverer - deliverer
    return-quantity - quantity
    amount-order-cost - amount)
  (:init
    (username-for phone username-7273731063)
    (username-for amazon username-tr-solo-at-gmail-com)
    (username-for venmo username-tr-solo-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (password-for venmo venmo-password)
    (has-relationship roommate relationship-roommate)
    (has-phone roommate roommate-phone-number)
    (has-email roommate roommate-email)
    (message-from roommate-return-message roommate)
    (message-mentions roommate-return-message return-product)
    (product-query return-product query-return-product)
    (order-contains roommate-order return-product)
    (order-item-quantity roommate-order return-product return-quantity)
    (order-item-cost roommate-order return-product amount-order-cost))
  (:goal (and
    (return-initiated roommate-order return-product)
    (transaction-sent roommate amount-order-cost)
    (task-completed))))
