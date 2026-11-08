(define (problem task-5800354-3)
  (:domain appworld-5800354-3)
  (:objects
    matthew-blackburn roommate - person
    phone-username-4886643554 amazon-username-matthew-blac-at-gmail-com venmo-username-matthew-blac-at-gmail-com - username
    phone-password amazon-password venmo-password - password
    phone-token amazon-token venmo-token - token
    relationship-roommate - relationship
    roommate-phone-number - phone-number
    roommate-email - email
    return-request-message - message
    query-returned-product - query
    roommate-order - order
    roommate-product - product
    return-deliverer - deliverer
    return-quantity - quantity
    amount-order-cost - amount)
  (:init
    (username-for phone phone-username-4886643554)
    (username-for amazon amazon-username-matthew-blac-at-gmail-com)
    (username-for venmo venmo-username-matthew-blac-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (password-for venmo venmo-password)
    (contact-relationship roommate relationship-roommate)
    (phone-of roommate roommate-phone-number)
    (email-of roommate roommate-email)
    (message-from return-request-message roommate)
    (message-mentions return-request-message query-returned-product)
    (order-matches roommate-order query-returned-product)
    (order-contains roommate-order roommate-product)
    (item-quantity roommate-order roommate-product return-quantity)
    (order-cost roommate-order amount-order-cost))
  (:goal (and (return-initiated roommate-order roommate-product)
              (money-sent roommate amount-order-cost)
              (task-completed)))
)
