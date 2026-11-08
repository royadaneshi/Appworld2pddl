(define (problem task-81be677-2)
  (:domain appworld-81be677-2)
  (:objects
    les-ball-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    todays-order - order
    latest-arrival-date - date)
  (:init
    (password-for amazon amazon-password)
    (placed-today todays-order)
    (arrival-date-of todays-order latest-arrival-date))
  (:goal (and (found-arrival-date latest-arrival-date) (task-completed))))
