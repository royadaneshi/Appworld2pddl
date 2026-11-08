(define (problem task-4242c97-3)
  (:domain appworld-4242c97-3)
  (:objects
    angelica - person
    angelica-wils-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-gildan-mens-ultra-cotton-t-shirt - query
    size-large - size
    quantity-2 - quantity
    gildan-tshirt-large-best-color - product
    payment-card-default - payment-card
    address-default - address
    tshirt-order - order)
  (:init
    (password-for amazon amazon-password)
    (product-query gildan-tshirt-large-best-color query-gildan-mens-ultra-cotton-t-shirt)
    (product-size gildan-tshirt-large-best-color size-large))
  (:goal (and
    (order-placed tshirt-order)
    (order-contains tshirt-order gildan-tshirt-large-best-color quantity-2)
    (task-completed))))
