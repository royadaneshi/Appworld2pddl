(define (problem task-f6be291-3)
  (:domain appworld-f6be291-3)
  (:objects
    valerie partner - person
    va-blac-at-gmail-com phone-5822399497 - username
    phone-password gmail-password file-system-password amazon-password - password
    phone-token gmail-token file-system-token amazon-token - token
    rel-partner - relationship
    partner-email - email
    query-checklist query-item-1 query-item-2 query-item-3 - query
    checklist-thread - email-thread
    checklist-attachment - attachment
    checklist-file - file
    checklist-start item-1 item-2 item-3 - checklist-item
    product-1 product-2 product-3 - product
    quantity-1 quantity-2 quantity-3 - quantity
    home-address - address
    payment-card-1 - payment-card
  )
  (:init
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
    (product-query product-1 query-item-1)
    (product-query product-2 query-item-2)
    (product-query product-3 query-item-3)
    (next-item checklist-start item-1)
    (next-item item-1 item-2)
    (next-item item-2 item-3)
    (last-item item-3)
    (cart-covers checklist-start)
    (is-home-address home-address)
  )
  (:goal (and (order-placed) (task-completed)))
)
