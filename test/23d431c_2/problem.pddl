(define (problem task-23d431c-2)
  (:domain appworld-23d431c-2)
  (:objects
    william - person
    william-mart-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    past-product area-rug-1 area-rug-2 - product
    past-seller new-seller - seller
    area-rug - product-type
    max-price-150 - max-price
    home-address - address
    primary-card - payment-card)
  (:init
    (password-for amazon amazon-password)
    (past-purchased past-product)
    (sold-by past-product past-seller)
    (sold-by area-rug-1 past-seller)
    (has-type area-rug-1 area-rug)
    (priced-within area-rug-1 max-price-150)
    (sold-by area-rug-2 new-seller)
    (has-type area-rug-2 area-rug)
    (priced-within area-rug-2 max-price-150))
  (:goal (and (ordered area-rug-1) (task-completed)))
)
