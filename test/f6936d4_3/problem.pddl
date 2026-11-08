(define (problem task-f6936d4-3)
  (:domain appworld-f6936d4-3)
  (:objects
    jonathan-ball - person
    jo-ball-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-camping-lantern query-beach-chair - query
    camping-lantern beach-chair - product-type
    camping-lantern-product beach-chair-product - product
    qty-5 - quantity
    home-address - address
    primary-payment-card - payment-card)
  (:init
    (password-for amazon amazon-password)
    (query-for-type query-camping-lantern camping-lantern)
    (query-for-type query-beach-chair beach-chair)
    (product-of-type camping-lantern-product camping-lantern)
    (product-of-type beach-chair-product beach-chair)
    (needed-quantity camping-lantern qty-5)
    (needed-quantity beach-chair qty-5)
    (is-home home-address))
  (:goal (and
    (ordered camping-lantern-product qty-5)
    (ordered beach-chair-product qty-5)
    (task-completed))))
