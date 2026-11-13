(define (problem task-f6be291-3)
  (:domain appworld-f6be291-3)
  (:objects
    valerie partner - person
    va-blac-at-gmail-com phone-5822399497 - username
    phone-password gmail-password file-system-password amazon-password - password
    phone-token gmail-token file-system-token amazon-token - token
    rel-partner - relationship
    partner-email - email
    query-checklist query-item-1 query-item-2 query-item-3 query-item-4 query-item-5 query-item-6 - query
    checklist-thread - email-thread
    checklist-attachment - attachment
    checklist-file - file
    checklist-start item-1 item-2 item-3 item-4 item-5 item-6 - checklist-item
    product-1 product-2 product-3 product-4 product-5 product-6 - product
    quantity-1 quantity-2 quantity-3 quantity-4 quantity-5 quantity-6 - quantity
    home-address - address
    payment-card-1 - payment-card
  )
  (:init
    (credential-of-app phone phone-5822399497)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app gmail va-blac-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app file-system va-blac-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (credential-of-app amazon va-blac-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (username-for phone phone-5822399497)
    (username-for gmail va-blac-at-gmail-com)
    (username-for file-system va-blac-at-gmail-com)
    (username-for amazon va-blac-at-gmail-com)
    (password-for phone phone-password)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (password-for amazon amazon-password)
    (contact-relationship partner rel-partner)
    (contact-email partner partner-email)
    (thread-from checklist-thread partner-email)
    (thread-matches checklist-thread query-checklist)
    (attachment-in-thread checklist-thread checklist-attachment)
    (attachment-file checklist-attachment checklist-file)
    (checklist-in-file checklist-file)
    (checklist-entry item-1 product-1 quantity-1)
    (checklist-entry item-2 product-2 quantity-2)
    (checklist-entry item-3 product-3 quantity-3)
    (checklist-entry item-4 product-4 quantity-4)
    (checklist-entry item-5 product-5 quantity-5)
    (checklist-entry item-6 product-6 quantity-6)
    (product-query product-1 query-item-1)
    (product-query product-2 query-item-2)
    (product-query product-3 query-item-3)
    (product-query product-4 query-item-4)
    (product-query product-5 query-item-5)
    (product-query product-6 query-item-6)
    (cart-covers checklist-start)
    (is-home-address home-address)
    (next-item checklist-start item-1)
    (next-item item-1 item-2)
    (next-item item-2 item-3)
    (next-item item-3 item-4)
    (next-item item-4 item-5)
    (next-item item-5 item-6)
    (last-item item-6))
  (:goal (and
    (order-placed)
    (task-completed)))
)
