(define (problem task-66b7899-1)
  (:domain appworld-66b7899-1)
  (:objects
    caitlin-burch david - person
    caiburc-at-gmail-com phone-5896230193 - username
    amazon-password phone-password venmo-password - password
    amazon-token phone-token venmo-token - token
    query-david - query
    david-email - email
    order-delivered-today - order
    order-total-amount - amount
  )
  (:init
    (username-for amazon caiburc-at-gmail-com)
    (username-for phone phone-5896230193)
    (username-for venmo caiburc-at-gmail-com)
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (query-for david query-david)
    (order-for order-delivered-today david)
  )
  (:goal (and
    (request-sent david order-delivered-today)
    (task-completed)
  ))
)
