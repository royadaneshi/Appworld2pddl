(define (problem task-9b2dc64-1)
  (:domain appworld-9b2dc64-1)
  (:objects
    valerie-blackburn - person
    va-blac-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    tshirt-last tshirt-navy-blue tshirt-black - product
    navy-blue black - color
    size-as-ordered - size
    query-tshirt-name - query
    amazon-home-address - address
    amazon-payment-card - payment-card)
  (:init
    (password-for amazon amazon-password)
    (last-purchased-tshirt tshirt-last)
    (variant-of tshirt-navy-blue tshirt-last)
    (variant-of tshirt-black tshirt-last)
    (has-color tshirt-navy-blue navy-blue)
    (has-color tshirt-black black)
    (query-for query-tshirt-name tshirt-last)
    (size-of size-as-ordered tshirt-last)
    (to-order tshirt-navy-blue)
    (to-order tshirt-black)
    (home-address amazon-home-address))
  (:goal (and
    (ordered tshirt-navy-blue)
    (ordered tshirt-black)
    (delivered-home)
    (task-completed)))
)
