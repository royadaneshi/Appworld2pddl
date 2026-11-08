(define (problem task-c8f5f44-3)
  (:domain appworld-c8f5f44-3)
  (:objects
    kathryn brother - person
    phone-username-2473084266 kathrynmaldonado-at-gmail-com - username
    phone-password venmo-password amazon-password - password
    phone-token venmo-token amazon-token - token
    relationship-sibling - relationship
    brother-email - email
    brother-transaction - transaction
    requested-product - product
    query-requested-product - query
    quantity-1 - quantity
    clear-cart-true - flag
    home-address - address
    amazon-card - payment-card
    new-order - order
    comment-thanks-a-lot - comment
  )
  (:init
    (username-for phone phone-username-2473084266)
    (username-for venmo kathrynmaldonado-at-gmail-com)
    (username-for amazon kathrynmaldonado-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (password-for amazon amazon-password)
    (contact-relationship brother relationship-sibling)
    (person-email brother brother-email)
    (transaction-from brother-transaction brother)
    (transaction-for-product brother-transaction requested-product)
    (product-query requested-product query-requested-product)
    (is-home-address home-address)
  )
  (:goal (and
    (order-placed new-order)
    (ordered new-order requested-product)
    (order-shipped-to new-order home-address)
    (comment-posted brother-transaction comment-thanks-a-lot)
    (task-completed)
  ))
)
