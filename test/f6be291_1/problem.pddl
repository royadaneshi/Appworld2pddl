(define (problem task-f6be291-1)
  (:domain appworld-f6be291-1)
  (:objects
    patricia - person
    pa-ritter-at-gmail-com - username
    gmail-password file-system-password amazon-password - password
    gmail-token file-system-token amazon-token - token
    query-checklist - query
    checklist-thread - email-thread
    checklist-attachment - attachment
    checklist-file - file-path
    product-1 product-2 product-3 product-4 - product
    quantity-1 quantity-2 quantity-3 quantity-4 - quantity
    count-0 count-1 count-2 count-3 count-4 - count
    address-home - address
    payment-card-1 - payment-card
  )
  (:init
    (credential-of-app gmail pa-ritter-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app file-system pa-ritter-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (credential-of-app amazon pa-ritter-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (username-for gmail pa-ritter-at-gmail-com)
    (username-for file-system pa-ritter-at-gmail-com)
    (username-for amazon pa-ritter-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (password-for amazon amazon-password)
    (thread-matches checklist-thread query-checklist)
    (from-husband checklist-thread)
    (attachment-of checklist-thread checklist-attachment)
    (on-checklist product-1 quantity-1)
    (on-checklist product-2 quantity-2)
    (on-checklist product-3 quantity-3)
    (on-checklist product-4 quantity-4)
    (items-added count-0)
    (home-address address-home)
    (next-count count-0 count-1)
    (next-count count-1 count-2)
    (next-count count-2 count-3)
    (next-count count-3 count-4)
    (checklist-size count-4))
  (:goal (and
    (order-placed)
    (task-completed)))
)
