(define (problem task-9ef034e-1)
  (:domain appworld-9ef034e-1)
  (:objects
    connor matthew - person
    username-5734599766 connorbrow-at-gmail-com - username
    phone-password amazon-password venmo-password - password
    phone-token amazon-token venmo-token - token
    query-matthew query-product-from-message-1 query-product-from-message-2 query-product-from-message-3 query-product-from-message-4 - query
    matthew-phone-number - phone-number
    matthew-email - email
    msg-from-matthew - message
    product-from-message-1 product-from-message-2 product-from-message-3 product-from-message-4 - product
    quantity-from-message-1 quantity-from-message-2 quantity-from-message-3 quantity-from-message-4 - quantity
    home-address - address
    card-default - payment-card
    order-new - order
    amount-total - amount
    description-amazon-order - description
  )
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
    (requested msg-from-matthew product-from-message-1)
    (requested msg-from-matthew product-from-message-2)
    (requested msg-from-matthew product-from-message-3)
    (requested msg-from-matthew product-from-message-4)
    (requested-quantity product-from-message-1 quantity-from-message-1)
    (requested-quantity product-from-message-2 quantity-from-message-2)
    (requested-quantity product-from-message-3 quantity-from-message-3)
    (requested-quantity product-from-message-4 quantity-from-message-4)
    (search-query product-from-message-1 query-product-from-message-1)
    (search-query product-from-message-2 query-product-from-message-2)
    (search-query product-from-message-3 query-product-from-message-3)
    (search-query product-from-message-4 query-product-from-message-4)
    (is-home-address home-address)
    (total-of order-new amount-total))
  (:goal (and
    (order-placed order-new)
    (ordered product-from-message-1 quantity-from-message-1)
    (ordered product-from-message-2 quantity-from-message-2)
    (ordered product-from-message-3 quantity-from-message-3)
    (ordered product-from-message-4 quantity-from-message-4)
    (ordered-to order-new home-address)
    (known-total order-new amount-total)
    (payment-request-sent matthew amount-total)
    (task-completed)))
)
