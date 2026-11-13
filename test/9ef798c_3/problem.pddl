(define (problem task-9ef798c-3)
  (:domain appworld-9ef798c-3)
  (:objects
    anita sabrina - person
    anita-burch-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    query-carpool - query
    sabrina-carpool-request - payment-request
    payment-card-1 - payment-card
    amount-1 - amount
  )
  (:init
    (password-for venmo venmo-password)
    (request-from sabrina-carpool-request sabrina)
    (request-matches sabrina-carpool-request query-carpool)
    (request-pending sabrina-carpool-request)
    (usable-card payment-card-1)
    (shortfall sabrina-carpool-request amount-1)
  )
  (:goal (and
    (approved sabrina-carpool-request)
    (task-completed)
  ))
)
