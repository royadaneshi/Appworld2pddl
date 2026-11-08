(define (problem task-953b296-3)
  (:domain appworld-953b296-3)
  (:objects
    kathryn - person
    kathrynmaldonado-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    past-tshirt-product candidate-tshirt - product
    candidate-question - question
    tshirt - product-type
    my-size - relative-size
    quantity-1 - quantity
    flag-true - flag
    home-address - address
    payment-card-1 - payment-card
    new-order - order)
  (:init
    (password-for amazon amazon-password)
    (past-purchase past-tshirt-product)
    (product-of-type past-tshirt-product tshirt)
    (has-size past-tshirt-product my-size)
    (product-of-type candidate-tshirt tshirt)
    (has-size candidate-tshirt my-size)
    (question-of candidate-question candidate-tshirt)
    (no-fading-reported candidate-tshirt)
    (is-home-address home-address))
  (:goal (and (order-placed new-order candidate-tshirt quantity-1 home-address) (task-completed))))
