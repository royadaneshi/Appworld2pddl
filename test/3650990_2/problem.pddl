(define (problem task-3650990-2)
  (:domain appworld-3650990-2)
  (:objects
    sandra-martinez - person
    saritt-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    return-1 return-2 - return-record
    product-of-return-1 product-of-return-2 - product
    answer-yes-or-no - answer)
  (:init
    (username-for amazon saritt-at-gmail-com)
    (password-for amazon amazon-password)
    (return-of return-1 product-of-return-1)
    (return-of return-2 product-of-return-2))
  (:goal (and
    (product-type-known product-of-return-1)
    (product-type-known product-of-return-2)
    (task-completed)))
)
