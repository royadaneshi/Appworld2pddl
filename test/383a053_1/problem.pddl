(define (problem task-383a053-1)
  (:domain appworld-383a053-1)
  (:objects
    mason-smith - person
    masmith-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    product-type-desk-organizer - product-type
    rating-4-3 rating-4-1 - rating
    quantity-2 - quantity
    desk-organizer-product - product
    work-address - address
    payment-card-1 - payment-card
    order-1 - order)
  (:init
    (password-for amazon amazon-password)
    (product-type-of desk-organizer-product product-type-desk-organizer)
    (required-product-rating rating-4-3)
    (required-seller-rating rating-4-1)
    (target-quantity quantity-2)
    (is-work-address work-address))
  (:goal (and
    (order-placed order-1)
    (order-contains order-1 desk-organizer-product quantity-2)
    (order-shipped-to order-1 work-address)
    (task-completed)))
)
