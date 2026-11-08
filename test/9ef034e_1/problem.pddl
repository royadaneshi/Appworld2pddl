(define (problem task-9ef034e-1)
  (:domain appworld-9ef034e-1)
  (:objects
    connor matthew - person
    username-5734599766 connorbrow-at-gmail-com - username
    phone-password amazon-password venmo-password - password
    phone-token amazon-token venmo-token - token
    query-matthew query-product-from-message - query
    matthew-phone-number - phone-number
    matthew-email - email
    msg-from-matthew - message
    product-from-message - product
    quantity-from-message - quantity
    home-address - address
    card-default - payment-card
    order-new - order
    amount-total - amount
    description-amazon-order - description)
  (:init
    (username-for phone username-5734599766)
    (username-for amazon connorbrow-at-gmail-com)
    (username-for venmo connorbrow-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (password-for venmo venmo-password)
    (token-for phone phone-token)
    (token-for amazon amazon-token)
    (token-for venmo venmo-token)
    (contact-query matthew query-matthew)
    (phone-of matthew matthew-phone-number)
    (email-of matthew matthew-email)
    (message-from msg-from-matthew matthew)
    (requested msg-from-matthew product-from-message)
    (requested-quantity product-from-message quantity-from-message)
    (search-query product-from-message query-product-from-message)
    (is-home-address home-address)
    (total-of order-new amount-total))
  (:goal (and
    (order-placed order-new)
    (ordered product-from-message quantity-from-message)
    (ordered-to order-new home-address)
    (known-total order-new amount-total)
    (payment-request-sent matthew amount-total)
    (task-completed)))
)
