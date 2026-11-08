(define (problem task-7d26579-3)
  (:domain appworld-7d26579-3)
  (:objects
    jordan-harrison - person
    jo-harr-at-gmail-com - username
    email-jo-harr-at-gmail-com - email
    amazon-password - password
    amazon-token - token
    query-t-shirt - query
    last-tshirt-order - order
    tshirt-product - product
    my-tshirt-question - question
    color-fading-answer - answer)
  (:init
    (is-supervisor jordan-harrison)
    (password-for amazon amazon-password)
    (supervisor-email email-jo-harr-at-gmail-com)
    (orders-query query-t-shirt)
    (is-last-tshirt-order last-tshirt-order)
    (order-has-product last-tshirt-order tshirt-product)
    (product-is-tshirt tshirt-product)
    (question-by-user my-tshirt-question tshirt-product))
  (:goal (and (found-answer color-fading-answer) (task-completed)))
)
