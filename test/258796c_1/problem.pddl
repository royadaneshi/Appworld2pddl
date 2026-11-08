(define (problem task-258796c-1)
  (:domain appworld-258796c-1)
  (:objects
    hunter - person
    hun-weaver-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-ecobee-smartcamera query-battery - query
    verified-true - flag
    ecobee-smartcamera - product
    battery-question - question
    battery-hours - hours)
  (:init
    (password-for amazon amazon-password)
    (search-query-for query-ecobee-smartcamera ecobee-smartcamera)
    (battery-query query-battery)
    (verified-flag verified-true)
    (target-product ecobee-smartcamera))
  (:goal (and
    (reviews-checked ecobee-smartcamera)
    (found-battery-hours ecobee-smartcamera battery-hours)
    (task-completed))))
