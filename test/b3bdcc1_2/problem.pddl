(define (problem task-b3bdcc1-2)
  (:domain appworld-b3bdcc1-2)
  (:objects
    jason - person
    jasonsimp-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    watch - product-type
    top-watch-seller - seller
    watch-product - product
    wells-fargo-card - card
    work-address - address
    quantity-1 - quantity
  )
  (:init
    (password-for amazon amazon-password)
  )
  (:goal (and
    (highest-rated-seller top-watch-seller watch)
    (sold-by watch-product top-watch-seller)
    (of-type watch-product watch)
    (order-placed watch-product quantity-1 wells-fargo-card work-address)
    (task-completed)
  ))
)
