(define (problem task-2c544f9-3)
  (:domain appworld-2c544f9-3)
  (:objects
    sierra jack - person
    phone-7295077363 siwhit-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    jack-email - email
    query-jack - query
    amount-234 - amount)
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone phone-7295077363)
    (username-for venmo siwhit-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (contact-query jack query-jack)
    (email-of jack jack-email)
    (requested-payment jack amount-234))
  (:goal (and (transaction-sent jack amount-234)
              (task-completed)))
)
