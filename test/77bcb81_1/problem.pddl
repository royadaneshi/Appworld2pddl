(define (problem task-77bcb81-1)
  (:domain appworld-77bcb81-1)
  (:objects
    jeremy-calhoun - person
    jer-calhoun-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    cart-product-1 cart-product-2 - product
    wish-product-1 wish-product-2 wish-product-3 - product
    address-home - address
    payment-card-1 - payment-card
    n0 n1 n2 n3 - count)
  (:init
    (password-for amazon amazon-password)
    (in-cart cart-product-1)
    (in-cart cart-product-2)
    (in-wish-list wish-product-1)
    (in-wish-list wish-product-2)
    (in-wish-list wish-product-3)
    (wish-list-count n3)
    (count-pred n0 n1)
    (count-pred n1 n2)
    (count-pred n2 n3)
    (count-zero n0)
    (home-address address-home))
  (:goal (and (order-placed-to address-home) (task-completed)))
)
