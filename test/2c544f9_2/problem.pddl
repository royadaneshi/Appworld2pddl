(define (problem task-2c544f9-2)
  (:domain appworld-2c544f9-2)
  (:objects
    anthony-harrison anita - person
    phone-2466064078 an-harrison-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    anita-email - email
    query-anita - query
    amount-427 - amount)
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone phone-2466064078)
    (username-for venmo an-harrison-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (query-for anita query-anita))
  (:goal (and (payment-sent anita amount-427) (task-completed))))
