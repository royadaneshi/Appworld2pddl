(define (problem task-d0b1f43-3)
  (:domain appworld-d0b1f43-3)
  (:objects
    nicholas roommate - person
    phone-number-9503658964 nicholas-weber-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    roommate-email - email
    query-roommates - query
    roommates - relationship
    date-2023-03-01 - date
    amount-total - amount)
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone phone-number-9503658964)
    (username-for venmo nicholas-weber-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (query-for query-roommates roommates)
    (has-relationship roommate roommates)
    (email-of roommate roommate-email)
    (threshold-date date-2023-03-01)
    (transactions-sum roommate amount-total))
  (:goal (and (found-total amount-total) (task-completed))))
