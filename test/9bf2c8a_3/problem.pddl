(define (problem task-9bf2c8a-3)
  (:domain appworld-9bf2c8a-3)
  (:objects
    valerie-blackburn - person
    va-blac-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    sofa other - product-type)
  (:init
    (password-for amazon amazon-password)
    (in-cart sofa-item-1)
    (in-cart other-item-1)
    (product-type-of sofa-item-1 sofa)
    (product-type-of other-item-1 other))
  (:goal (and
    (known-type sofa-item-1)
    (known-type other-item-1)
    (in-wish-list sofa-item-1)
    (not (in-cart sofa-item-1))
    (in-cart other-item-1)
    (not (in-wish-list other-item-1))
    (task-completed)))
)
