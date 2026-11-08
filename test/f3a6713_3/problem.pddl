(define (problem task-f3a6713-3)
  (:domain appworld-f3a6713-3)
  (:objects
    gina - person
    gina-ritter-at-gmail-com - username
    gmail-password file-system-password amazon-password - password
    gmail-token file-system-token amazon-token - token
    query-camping query-camping-item-1 query-camping-item-2 - query
    sort-by-rating-desc - sort-key
    camping-checklist-thread - email-thread
    camping-checklist-attachment - attachment
    camping-checklist-file-path - file-path
    camping-item-1 camping-item-2 - product-type
    best-product-item-1 best-product-item-2 - product
    quantity-item-1 quantity-item-2 - quantity
    gina-payment-card - payment-card
    gina-address - address
  )
  (:init
    (username-for gmail gina-ritter-at-gmail-com)
    (username-for file-system gina-ritter-at-gmail-com)
    (username-for amazon gina-ritter-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (password-for amazon amazon-password)
    (thread-search-query query-camping)
    (to-order camping-item-1)
    (to-order camping-item-2)
    (search-query-for camping-item-1 query-camping-item-1)
    (search-query-for camping-item-2 query-camping-item-2)
    (candidate-product camping-item-1 best-product-item-1)
    (candidate-product camping-item-2 best-product-item-2)
    (needs-quantity camping-item-1 quantity-item-1)
    (needs-quantity camping-item-2 quantity-item-2)
  )
  (:goal (and (order-placed) (task-completed)))
)
