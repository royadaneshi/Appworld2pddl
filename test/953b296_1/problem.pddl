(define (problem task-953b296-1)
  (:domain appworld-953b296-1)
  (:objects
    adrian - person
    adrian-burt-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-t-shirt - query
    product-type-t-shirt - product-type
    my-size - size
    quantity-1 - quantity
    past-tshirt-order new-order - order
    past-tshirt-product candidate-tshirt - product
    payment-card-1 - card
    home-address-1 - address
  )
  (:init
    (username-for amazon adrian-burt-at-gmail-com)
    (password-for amazon amazon-password)
    (order-matches past-tshirt-order query-t-shirt)
    (order-contains past-tshirt-order past-tshirt-product)
    (product-of-type past-tshirt-product product-type-t-shirt)
    (product-size past-tshirt-product my-size)
    (product-of-type candidate-tshirt product-type-t-shirt)
    (product-size candidate-tshirt my-size)
    (no-fading-reported candidate-tshirt)
    (home-address home-address-1)
    (pending-order new-order)
  )
  (:goal (and
    (found-size my-size)
    (product-of-type candidate-tshirt product-type-t-shirt)
    (product-size candidate-tshirt my-size)
    (reviews-checked candidate-tshirt)
    (questions-checked candidate-tshirt)
    (no-fading-reported candidate-tshirt)
    (order-placed new-order)
    (order-has-product new-order candidate-tshirt quantity-1)
    (order-address new-order home-address-1)
    (home-address home-address-1)
    (task-completed)
  ))
)
