(define (problem task-20c1328-3)
  (:domain appworld-20c1328-3)
  (:objects
    chris - person
    chris-phone-5584932120 chris-mcco-at-gmail-com - username
    phone-password amazon-password - password
    phone-token amazon-token - token
    relationship-roommate - relationship
    quantity-num-roommates - quantity
    product-type-gaming-console-controller - product-type
    price-70 price-170 - price
    sort-by-rating-desc - sort-key
    top-rated-controller - product
    home-address - address
    amazon-payment-card - payment-card)
  (:init
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (login-username phone chris-phone-5584932120)
    (login-username amazon chris-mcco-at-gmail-com)
    (token-for phone phone-token)
    (token-for amazon amazon-token)
    (search-spec product-type-gaming-console-controller price-70 price-170 sort-by-rating-desc))
  (:goal (and
    (ordered top-rated-controller quantity-num-roommates home-address)
    (task-completed)))
)
