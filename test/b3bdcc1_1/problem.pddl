(define (problem task-b3bdcc1-1)
  (:domain appworld-b3bdcc1-1)
  (:objects
    catherine-smith - person
    ca-smit-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    air-purifier - product-type
    top-seller-air-purifier - product
    top-seller - seller
    qty-1 - quantity
    true - boolean
    visa-card - payment-card
    home-address - address
    order-1 - order)
  (:init
    (password-for amazon amazon-password)
    (of-type top-seller-air-purifier air-purifier)
    (sold-by top-seller-air-purifier top-seller)
    (top-rated-seller top-seller air-purifier))
  (:goal (and
    (order-placed order-1 top-seller-air-purifier qty-1 visa-card home-address)
    (task-completed)))
)
