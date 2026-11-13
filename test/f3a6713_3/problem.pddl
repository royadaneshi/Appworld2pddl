(define (problem task-f3a6713-3)
  (:domain appworld-f3a6713-3)
  (:objects
    gina - person
    gina-ritter-at-gmail-com - username
    gmail-password file-system-password amazon-password - password
    gmail-token file-system-token amazon-token - token
    query-camping query-camping-item-1 query-camping-item-2 query-camping-item-3 - query
    sort-by-rating-desc - sort-key
    camping-checklist-thread - email-thread
    camping-checklist-attachment - attachment
    camping-checklist-file-path - file-path
    camping-item-1 camping-item-2 camping-item-3 - product-type
    best-product-item-1 best-product-item-2 best-product-item-3 - product
    quantity-item-1 quantity-item-2 quantity-item-3 - quantity
    gina-payment-card - payment-card
    gina-address - address
  )
  (:init
    (credential-of-app gmail gina-ritter-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app file-system gina-ritter-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (credential-of-app amazon gina-ritter-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (username-for gmail gina-ritter-at-gmail-com)
    (username-for file-system gina-ritter-at-gmail-com)
    (username-for amazon gina-ritter-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (password-for amazon amazon-password)
    (thread-search-query query-camping)
    (to-order camping-item-1)
    (to-order camping-item-2)
    (to-order camping-item-3)
    (search-query-for camping-item-1 query-camping-item-1)
    (search-query-for camping-item-2 query-camping-item-2)
    (search-query-for camping-item-3 query-camping-item-3)
    (candidate-product camping-item-1 best-product-item-1)
    (candidate-product camping-item-2 best-product-item-2)
    (candidate-product camping-item-3 best-product-item-3)
    (needs-quantity camping-item-1 quantity-item-1)
    (needs-quantity camping-item-2 quantity-item-2)
    (needs-quantity camping-item-3 quantity-item-3))
  (:goal (and
    (order-placed)
    (task-completed)))
)
