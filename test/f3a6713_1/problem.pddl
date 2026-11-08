(define (problem task-f3a6713-1)
  (:domain appworld-f3a6713-1)
  (:objects
    debra - person
    de-ritt-at-gmail-com - username
    gmail-password file-system-password amazon-password - password
    gmail-token file-system-token amazon-token - token
    query-camping - query
    camping-checklist-thread - email-thread
    checklist-attachment - attachment
    checklist-file-path - file-path
    sort-by-rating-desc - sort-key
    remaining-type-1 remaining-type-2 - product-type
    best-product-1 best-product-2 - product
    qty-type-1 qty-type-2 - quantity
    home-address - address
    default-payment-card - payment-card)
  (:init
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (password-for amazon amazon-password)
    (candidate-product best-product-1 remaining-type-1)
    (candidate-product best-product-2 remaining-type-2)
    (checklist-quantity remaining-type-1 qty-type-1)
    (checklist-quantity remaining-type-2 qty-type-2))
  (:goal (and (order-placed) (task-completed)))
)
