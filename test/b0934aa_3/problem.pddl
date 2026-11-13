(define (problem task-b0934aa-3)
  (:domain appworld-b0934aa-3)
  (:objects
    spencer - person
    spencer-powell-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    hedge-trimmer - product-type
    max-price-60 - price-limit
    min-rating-3-9 - rating-limit
    hedge-trimmer-product - product
    home-address - address
    payment-card-1 - payment-card
    home-address-name home-address-street home-address-city home-address-state home-address-country home-address-zip - address-field
  )
  (:init
    (password-for amazon amazon-password)
    (target-type hedge-trimmer)
    (target-max-price max-price-60)
    (target-min-rating min-rating-3-9)
    (is-home home-address)
    (address-name home-address home-address-name)
    (address-street home-address home-address-street)
    (address-city home-address home-address-city)
    (address-state home-address home-address-state)
    (address-country home-address home-address-country)
    (address-zip home-address home-address-zip)
  )
  (:goal (and
    (ordered hedge-trimmer-product home-address)
    (task-completed)
  ))
)
