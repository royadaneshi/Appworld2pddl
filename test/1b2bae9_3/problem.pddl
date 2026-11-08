(define (problem task-1b2bae9-3)
  (:domain appworld-1b2bae9-3)
  (:objects
    kevin - person
    kevin-blac-at-gmail-com - username
    amazon-password file-system-password - password
    amazon-token file-system-token - token
    query-nintendo-switch-lite - query
    nintendo-switch-lite - product
    quantity-1 - quantity
    flag-true - flag
    home-address - address
    amazon-card - payment-card
    new-order - order
    bills-dir - directory-path
    receipt-file-path - file-path
  )
  (:init
    (password-for amazon amazon-password)
    (password-for file-system file-system-password)
    (token-for amazon amazon-token)
    (token-for file-system file-system-token)
    (product-matches nintendo-switch-lite query-nintendo-switch-lite)
    (is-true flag-true)
    (is-home-address home-address)
    (receipt-path-for new-order receipt-file-path bills-dir)
  )
  (:goal (and
    (ordered new-order nintendo-switch-lite quantity-1 home-address)
    (receipt-saved new-order receipt-file-path)
    (task-completed)
  ))
)
