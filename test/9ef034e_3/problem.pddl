(define (problem task-9ef034e-3)
  (:domain appworld-9ef034e-3)
  (:objects
    erika marcus - person
    erikabail-at-gmail-com phone-4226809725 - username
    phone-password amazon-password file-system-password gmail-password venmo-password - password
    phone-token amazon-token file-system-token gmail-token venmo-token - token
    query-marcus - query
    marcus-phone-number - phone-number
    marcus-email - email
    marcus-last-message - text-message
    requested-product - product
    requested-quantity - quantity
    home-address - address
    payment-card-1 - payment-card
    order-1 - order
    amount-order-total - amount
    file-path-receipt - file-path
    subject-amazon-order-receipt - subject
    body-amazon-order-receipt - body
  )
  (:init
    (username-for phone phone-4226809725)
    (username-for amazon erikabail-at-gmail-com)
    (username-for file-system erikabail-at-gmail-com)
    (username-for gmail erikabail-at-gmail-com)
    (username-for venmo erikabail-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (password-for venmo venmo-password)
    (token-for phone phone-token)
    (token-for amazon amazon-token)
    (token-for file-system file-system-token)
    (token-for gmail gmail-token)
    (token-for venmo venmo-token)
    (contact-query query-marcus marcus)
    (phone-of marcus marcus-phone-number)
    (email-of marcus marcus-email)
    (message-from marcus marcus-last-message)
    (message-about marcus-last-message requested-product requested-quantity)
    (is-home-address home-address)
  )
  (:goal (and
    (order-placed order-1 home-address)
    (order-contains order-1 requested-product requested-quantity)
    (receipt-emailed marcus order-1)
    (payment-requested marcus order-1 amount-order-total)
    (task-completed)
  ))
)
