(define (problem task-60d0b5b-2)
  (:domain appworld-60d0b5b-2)
  (:objects
    chelsea cory - person
    username-7763361246 username-chelsea-burch-at-gmail-com - username
    password-phone password-venmo - password
    token-phone token-venmo - token
    cory-email - email
    query-cory - query
    status-approved - status
    amount-accident-cost - amount
    description-returning-the-accidental-payment - description
    req-cory-latest-approved - payment-request
  )
  (:init
    (credential-of-app phone password-phone)
    (credential-of-app phone token-phone)
    (credential-of-app venmo password-venmo)
    (credential-of-app venmo token-venmo)
    (username-for phone username-7763361246)
    (username-for venmo username-chelsea-burch-at-gmail-com)
    (password-for phone password-phone)
    (password-for venmo password-venmo)
    (query-for cory query-cory)
    (email-of cory cory-email)
    (request-to req-cory-latest-approved cory)
    (request-status req-cory-latest-approved status-approved)
    (request-amount req-cory-latest-approved amount-accident-cost)
  )
  (:goal (and (refunded req-cory-latest-approved) (task-completed)))
)
