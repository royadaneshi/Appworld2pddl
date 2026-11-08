(define (problem task-4242c97-1)
  (:domain appworld-4242c97-1)
  (:objects
    kevin-blackburn - person
    kevin-blac-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-hanes-mens-comfortsoft-short-sleeve-t-shirt - query
    extra-large - relative-size
    red black navy-blue - color
    hanes-comfortsoft-tshirt-xl-preferred-color - product
    quantity-2 - quantity
    flag-true - flag
    default-address - address
    default-payment-card - payment-card)
  (:init
    (password-for amazon amazon-password)
    (product-query hanes-comfortsoft-tshirt-xl-preferred-color query-hanes-mens-comfortsoft-short-sleeve-t-shirt)
    (product-size hanes-comfortsoft-tshirt-xl-preferred-color extra-large)
    (more-preferred red black)
    (more-preferred black navy-blue)
    (more-preferred red navy-blue))
  (:goal (and
    (order-placed hanes-comfortsoft-tshirt-xl-preferred-color quantity-2)
    (task-completed)))
)
