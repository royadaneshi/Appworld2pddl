(define (problem task-20c1328-2)
  (:domain appworld-20c1328-2)
  (:objects
    erika - person
    erikabail-at-gmail-com phone-4226809725 - username
    amazon-password phone-password - password
    amazon-token phone-token - token
    sibling - relationship
    num-siblings - count
    hiking-boots - product-type
    price-80 price-130 - price
    sort-by-rating-desc - sort-key
    top-hiking-boots - product
    home-address - address
    primary-card - payment-card
  )
  (:init
    (username-for amazon erikabail-at-gmail-com)
    (username-for phone phone-4226809725)
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (target-relationship sibling)
    (count-of-relationship sibling num-siblings)
    (target-product-type hiking-boots)
    (target-min-price price-80)
    (target-max-price price-130)
    (rating-sort sort-by-rating-desc)
    (is-home-address home-address)
  )
  (:goal (and (ordered top-hiking-boots num-siblings home-address) (task-completed)))
)
