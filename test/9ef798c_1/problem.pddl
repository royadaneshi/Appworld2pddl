(define (problem task-9ef798c-1)
  (:domain appworld-9ef798c-1)
  (:objects
    nicholas chelsea - person
    nicholas-weber-at-gmail-com username-9503658964 - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-chelsea - query
    chelsea-email - email
    carpool-request - payment-request
    venmo-card - payment-card
    amount-1 - amount
  )
  (:init
    (credential-of-app phone username-9503658964)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo nicholas-weber-at-gmail-com)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (query-for query-chelsea chelsea)
    (email-of chelsea chelsea-email)
    (requested-by carpool-request chelsea)
    (usable-card venmo-card)
    (shortfall carpool-request amount-1)
  )
  (:goal (and (approved carpool-request) (task-completed)))
)
