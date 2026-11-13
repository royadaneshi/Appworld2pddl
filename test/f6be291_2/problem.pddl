(define (problem task-f6be291-2)
  (:domain appworld-f6be291-2)
  (:objects
    timothy wife - person
    timothy-whit-at-gmail-com - username
    gmail-password file-system-password amazon-password - password
    gmail-token file-system-token amazon-token - token
    query-checklist query-product-1 query-product-2 query-product-3 query-product-4 query-product-5 - query
    checklist-thread - email-thread
    checklist-attachment - attachment
    checklist-file-path - file-path
    product-1 product-2 product-3 product-4 product-5 - product
    qty-product-1 qty-product-2 qty-product-3 qty-product-4 qty-product-5 - quantity
    count-0 count-1 count-2 count-3 count-4 count-5 - count
    timothy-home-address - address
    amazon-payment-card - payment-card
  )
  (:init
    (username-for gmail timothy-whit-at-gmail-com)
    (username-for file-system timothy-whit-at-gmail-com)
    (username-for amazon timothy-whit-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (password-for amazon amazon-password)
    (token-for gmail gmail-token)
    (token-for file-system file-system-token)
    (token-for amazon amazon-token)
    (wife-of wife timothy)
    (sent-by checklist-thread wife)
    (thread-query query-checklist checklist-thread)
    (attachment-of checklist-attachment checklist-thread)
    (download-path checklist-attachment checklist-file-path)
    (product-query query-product-1 product-1)
    (product-query query-product-2 product-2)
    (product-query query-product-3 product-3)
    (product-query query-product-4 product-4)
    (product-query query-product-5 product-5)
    (on-checklist product-1 qty-product-1)
    (on-checklist product-2 qty-product-2)
    (on-checklist product-3 qty-product-3)
    (on-checklist product-4 qty-product-4)
    (on-checklist product-5 qty-product-5)
    (zero-count count-0)
    (is-home-address timothy-home-address)
    (next-count count-0 count-1)
    (next-count count-1 count-2)
    (next-count count-2 count-3)
    (next-count count-3 count-4)
    (next-count count-4 count-5)
    (checklist-size count-5))
  (:goal (and
    (order-placed)
    (task-completed))))
