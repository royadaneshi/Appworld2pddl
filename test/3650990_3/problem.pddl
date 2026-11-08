(define (problem task-3650990-3)
  (:domain appworld-3650990-3)
  (:objects
    connor - person
    connorbrow-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    product-of-recent-return - product
    answer-yes-or-no - answer
  )
  (:init
    (password-for amazon amazon-password)
    (returned-product product-of-recent-return)
  )
  (:goal (and
    (returns-listed)
    (answer-determined)
    (task-completed)
  ))
)
