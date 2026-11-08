(define (problem task-245cb43-3)
  (:domain appworld-245cb43-3)
  (:objects
    vickie - person
    vicpowe-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    compass-fitting compass-too-large - product
    card-amazon - payment-card
    address-home - address
  )
  (:init
    (password-for amazon amazon-password)
    (in-wish-list compass-fitting)
    (in-wish-list compass-too-large)
    (is-compass compass-fitting)
    (is-compass compass-too-large)
    (fits-pocket compass-fitting)
    (owns-card card-amazon)
    (owns-address address-home)
  )
  (:goal (and (ordered compass-fitting) (task-completed)))
)
