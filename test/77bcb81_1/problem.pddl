(define (problem task-77bcb81-1)
  (:domain appworld-77bcb81-1)
  (:objects
    jeremy-calhoun - person
    jer-calhoun-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    cart-product-1 cart-product-2 cart-product-3 cart-product-4 cart-product-5 cart-product-6 cart-product-7 cart-product-8 cart-product-9 cart-product-10 cart-product-11 - product
    address-home - address
    payment-card-1 - payment-card
    n0 n1 n2 n3 count-1 count-2 count-3 - count
  )
  (:init
    (password-for amazon amazon-password)
    (count-zero n0)
    (home-address address-home)
    (in-cart cart-product-1)
    (in-cart cart-product-2)
    (in-cart cart-product-3)
    (in-cart cart-product-4)
    (in-cart cart-product-5)
    (in-wish-list cart-product-6)
    (in-wish-list cart-product-7)
    (in-wish-list cart-product-8)
    (in-wish-list cart-product-9)
    (in-wish-list cart-product-10)
    (in-wish-list cart-product-11)
    (wish-list-count count-3)
    (count-pred n0 n1)
    (count-pred n1 n2)
    (count-pred n2 n3)
    (count-pred n3 count-1)
    (count-pred count-1 count-2)
    (count-pred count-2 count-3))
  (:goal (and
    (order-placed-to address-home)
    (in-cart cart-product-6)
    (in-cart cart-product-7)
    (in-cart cart-product-8)
    (in-cart cart-product-9)
    (in-cart cart-product-10)
    (in-cart cart-product-11)
    (task-completed)))
)
