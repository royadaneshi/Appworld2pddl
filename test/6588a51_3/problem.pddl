(define (problem task-6588a51-3)
  (:domain appworld-6588a51-3)
  (:objects
    alex-white - person
    alexwhite-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    last-tshirt-order - order
    last-tshirt-product - product
    tshirt - product-type
    question-bleed-color - question
  )
  (:init
    (password-for amazon amazon-password)
    (order-contains last-tshirt-order last-tshirt-product)
    (product-has-type last-tshirt-product tshirt)
    (last-ordered-of-type last-tshirt-product tshirt)
  )
  (:goal (and
    (question-posted last-tshirt-product question-bleed-color)
    (task-completed)
  ))
)
