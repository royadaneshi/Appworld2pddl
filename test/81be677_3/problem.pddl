(define (problem task-81be677-3)
  (:domain appworld-81be677-3)
  (:objects
    kristin-white - person
    kri-powe-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    order-yesterday - order
    latest-delivery-date - date)
  (:init
    (password-for amazon amazon-password)
    (ordered-yesterday order-yesterday))
  (:goal (and
    (found-arrival-date order-yesterday latest-delivery-date)
    (task-completed)))
)
