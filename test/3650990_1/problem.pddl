(define (problem task-3650990-1)
  (:domain appworld-3650990-1)
  (:objects
    joseph - person
    joseph-webe-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    return-1 - return-record
    product-1 - product
    yes-or-no-answer - answer)
  (:init
    (password-for amazon amazon-password))
  (:goal (and
    (returns-listed)
    (found-return-date return-1)
    (return-of-product return-1 product-1)
    (found-product-type product-1)
    (answer-known yes-or-no-answer)
    (task-completed)))
)
