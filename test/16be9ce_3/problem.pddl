(define (problem task-16be9ce-3)
  (:domain appworld-16be9ce-3)
  (:objects
    katherine brother - person
    phone-7863159797 ka-ball-at-gmail-com - username
    phone-password amazon-password - password
    phone-token amazon-token - token
    relationship-brother - relationship
    brothers-birthday - birthday
    query-robot-vacuum - query
    robot-vacuum-order - order
    robot-vacuum-product - product
    current-price - price)
  (:init
    (username-for phone phone-7863159797)
    (username-for amazon ka-ball-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (has-relationship brother relationship-brother)
    (birthday-of brother brothers-birthday)
    (order-placed-on robot-vacuum-order brothers-birthday)
    (order-matches robot-vacuum-order query-robot-vacuum)
    (order-contains robot-vacuum-order robot-vacuum-product)
    (product-price robot-vacuum-product current-price))
  (:goal (and (found-price robot-vacuum-product current-price) (task-completed)))
)
