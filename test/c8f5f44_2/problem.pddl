(define (problem task-c8f5f44-2)
  (:domain appworld-c8f5f44-2)
  (:objects
    jason sister - person
    rel-sister - relationship
    jasonsimp-at-gmail-com phone-5516882990 - username
    phone-password venmo-password amazon-password - password
    phone-token venmo-token amazon-token - token
    sister-email - email
    sister-transaction - transaction
    query-product-name - query
    product-for-sister - product
    quantity-1 - quantity
    home-address - address
    payment-card-1 - payment-card
    comment-thanks - comment
    order-1 - order
  )
  (:init
    (username-for phone phone-5516882990)
    (username-for venmo jasonsimp-at-gmail-com)
    (username-for amazon jasonsimp-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (password-for amazon amazon-password)
    (token-for phone phone-token)
    (token-for venmo venmo-token)
    (token-for amazon amazon-token)
    (has-relationship sister rel-sister)
    (person-email sister sister-email)
    (sent-by sister-transaction sister)
    (transaction-mentions sister-transaction query-product-name)
    (product-matches product-for-sister query-product-name)
    (is-home-address home-address)
  )
  (:goal (and
    (order-placed order-1 product-for-sister quantity-1 home-address)
    (commented sister-transaction comment-thanks)
    (task-completed)
  ))
)
