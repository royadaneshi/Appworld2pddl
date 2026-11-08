(define (problem task-953b296-2)
  (:domain appworld-953b296-2)
  (:objects
    eric - person
    eric-bailey-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-sweater - query
    type-sweater - product-type
    my-size - size
    past-sweater candidate-sweater - product
    quantity-1 - quantity
    flag-true - bool-flag
    my-payment-card - payment-card
    eric-home-address - address
  )
  (:init
    (password-for amazon amazon-password)
    (purchased-before past-sweater)
    (of-type past-sweater type-sweater)
    (has-size past-sweater my-size)
    (candidate candidate-sweater)
    (of-type candidate-sweater type-sweater)
    (has-size candidate-sweater my-size)
    (query-for-type query-sweater type-sweater)
    (is-home-address eric-home-address)
  )
  (:goal (and
    (ordered candidate-sweater quantity-1 eric-home-address)
    (qa-checked candidate-sweater)
    (reviews-checked candidate-sweater)
    (task-completed)
  ))
)
