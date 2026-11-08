(define (problem task-7434096-1)
  (:domain appworld-7434096-1)
  (:objects
    denise - person
    deniseburch-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-hanes-undershirt - query
    order-hanes - order
    undershirt-xl undershirt-non-xl-1 undershirt-non-xl-2 - product
    deliverer-ups - deliverer
    quantity-1 - quantity)
  (:init
    (username-for amazon deniseburch-at-gmail-com)
    (password-for amazon amazon-password)
    (matches-query query-hanes-undershirt order-hanes)
    (in-order undershirt-xl order-hanes)
    (in-order undershirt-non-xl-1 order-hanes)
    (in-order undershirt-non-xl-2 order-hanes)
    (fits undershirt-xl)
    (purchased-quantity undershirt-xl quantity-1)
    (purchased-quantity undershirt-non-xl-1 quantity-1)
    (purchased-quantity undershirt-non-xl-2 quantity-1)
    (preferred-deliverer deliverer-ups))
  (:goal (and
    (return-initiated order-hanes undershirt-non-xl-1)
    (return-initiated order-hanes undershirt-non-xl-2)
    (task-completed)))
)
