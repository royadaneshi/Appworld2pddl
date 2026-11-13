(define (problem task-cb4ee7a-3)
  (:domain appworld-cb4ee7a-3)
  (:objects
    matthew-blackburn - person
    first-name-matthew - first-name
    last-name-blackburn - last-name
    matthew-blac-at-gmail-com - email
    username-matthew-blac-at-gmail-com - username
    gmail-password amazon-new-password - password
    gmail-token amazon-token - token
    query-verification - query
    amazon-verification-thread - email-thread
    amazon-verification-code - verification-code
    card-name-1 - card-name
    owner-name-1 - owner-name
    card-number-1 - card-number
    expiry-year-1 - expiry-year
    expiry-month-1 - expiry-month
    cvv-number-1 - cvv-number
    payment-card-1 - payment-card
    duration-yearly - duration
  )
  (:init
    (credential-of-app gmail matthew-blac-at-gmail-com)
    (credential-of-app gmail username-matthew-blac-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app amazon matthew-blac-at-gmail-com)
    (credential-of-app amazon username-matthew-blac-at-gmail-com)
    (credential-of-app amazon amazon-new-password)
    (credential-of-app amazon amazon-token)
    (is-supervisor matthew-blackburn)
    (person-first-name matthew-blackburn first-name-matthew)
    (person-last-name matthew-blackburn last-name-blackburn)
    (person-email matthew-blackburn matthew-blac-at-gmail-com)
    (username-for gmail username-matthew-blac-at-gmail-com)
    (username-for amazon username-matthew-blac-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for amazon amazon-new-password)
    (verification-thread amazon amazon-verification-thread)
    (query-finds query-verification amazon-verification-thread)
    (thread-contains-code amazon-verification-thread amazon-verification-code)
    (verification-code-for amazon amazon-verification-code)
    (card-name-of payment-card-1 card-name-1)
    (card-owner-of payment-card-1 owner-name-1)
    (card-number-of payment-card-1 card-number-1)
    (card-expiry-year-of payment-card-1 expiry-year-1)
    (card-expiry-month-of payment-card-1 expiry-month-1)
    (card-cvv-of payment-card-1 cvv-number-1)
    (target-duration duration-yearly)
  )
  (:goal (and
    (account-exists amazon)
    (account-verified amazon)
    (prime-subscribed amazon)
    (task-completed)
  ))
)
