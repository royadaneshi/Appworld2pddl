(define (problem task-6588a51-1)
  (:domain appworld-6588a51-1)
  (:objects
    bradley-ball - person
    bradley-ball-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    last-tshirt-order - order
    last-tshirt-product - product
    t-shirt - product-type
    question-color-fade - question-text
  )
  (:init
    (password-for amazon amazon-password)
    (in-order last-tshirt-order last-tshirt-product)
    (has-type last-tshirt-product t-shirt)
  )
  (:goal (and
    (question-posted last-tshirt-product question-color-fade)
    (task-completed)
  ))
)
