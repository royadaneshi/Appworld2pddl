(define (problem task-383a053-2)
  (:domain appworld-383a053-2)
  (:objects
    michael-burch - person
    mi-burch-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-laundry-hamper - query
    rating-4-2 rating-4-0 - rating
    qty-4 - quantity
    laundry-hamper-product - product
    home-address - address
    payment-card-1 - payment-card
    hamper-order - order
  )
  (:init
    (password-for amazon amazon-password)
    (search-query query-laundry-hamper)
    (required-product-rating rating-4-2)
    (required-seller-rating rating-4-0)
    (purchase-count qty-4)
    (is-home-address home-address)
  )
  (:goal (and
    (order-placed hamper-order)
    (order-has hamper-order laundry-hamper-product qty-4)
    (order-shipped-to hamper-order home-address)
    (qualifying-product laundry-hamper-product)
    (task-completed)
  ))
)
