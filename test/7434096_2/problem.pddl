(define (problem task-7434096-2)
  (:domain appworld-7434096-2)
  (:objects
    david-martinez - person
    dav-mart-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-hm-turtleneck-sweater - query
    order-sweaters-1 order-sweaters-2 - order
    sweater-extra-small sweater-other-1 sweater-other-2 - product
    usps - deliverer
    quantity-1 - quantity
  )
  (:init
    (password-for amazon amazon-password)
    (order-matches order-sweaters-1 query-hm-turtleneck-sweater) (order-matches order-sweaters-2 query-hm-turtleneck-sweater)
    (in-order sweater-extra-small order-sweaters-1)
    (in-order sweater-other-1 order-sweaters-1)
    (in-order sweater-other-2 order-sweaters-2)
    (fits sweater-extra-small)
    (deliverer-available usps)
    (preferred-deliverer usps)
    (return-quantity quantity-1))
  (:goal (and
    (return-initiated order-sweaters-1 sweater-other-1 usps quantity-1)
    (return-initiated order-sweaters-2 sweater-other-2 usps quantity-1)
    (task-completed)))
)
