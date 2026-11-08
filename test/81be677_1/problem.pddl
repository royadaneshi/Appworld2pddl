(define (problem task-81be677-1)
  (:domain appworld-81be677-1)
  (:objects
    patricia - person
    pa-ritter-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    yesterdays-order - order
    delivery-date-dd-mm - delivery-date)
  (:init
    (password-for amazon amazon-password)
    (placed-yesterday yesterdays-order))
  (:goal (and
    (found-latest-delivery-date yesterdays-order delivery-date-dd-mm)
    (task-completed))))
