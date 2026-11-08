(define (problem task-1b2bae9-1)
  (:domain appworld-1b2bae9-1)
  (:objects
    robertmartinez-at-gmail-com - username
    amazon-password file-system-password - password
    amazon-token file-system-token - token
    query-ikea-lerhamn-dining-table - query
    ikea-lerhamn-dining-table - product
    quantity-1 - quantity
    flag-true - flag
    home-address - address
    payment-card-default - payment-card
    order-new - order
    dir-bills - directory
    receipt-file-path - file-path)
  (:init
    (password-for amazon amazon-password)
    (password-for file-system file-system-password)
    (matches-query query-ikea-lerhamn-dining-table ikea-lerhamn-dining-table)
    (is-home home-address)
    (receipt-path-for receipt-file-path order-new dir-bills))
  (:goal (and
    (order-placed order-new ikea-lerhamn-dining-table quantity-1 home-address)
    (receipt-saved order-new receipt-file-path)
    (task-completed))))
