(define (problem task-df61dc5-2)
  (:domain appworld-df61dc5-2)
  (:objects
    jose friend-1 friend-2 - person
    phone-username-2474975253 venmo-username-joseharr-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    friend-1-email friend-2-email - email
    query-friend - query
    relationship-friend - relationship
    month-start-2023-05-01 - datetime)
  (:init
    (username-for phone phone-username-2474975253)
    (username-for venmo venmo-username-joseharr-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (friend-filter query-friend relationship-friend)
    (is-friend friend-1)
    (is-friend friend-2)
    (email-of friend-1 friend-1-email)
    (email-of friend-2 friend-2-email)
    (month-start month-start-2023-05-01)
    (transaction-with tx-1 friend-1-email)
    (transaction-with tx-2 friend-1-email)
    (transaction-with tx-3 friend-2-email)
    (transaction-with tx-4 friend-2-email)
    (in-current-month tx-1)
    (in-current-month tx-2)
    (in-current-month tx-3))
  (:goal (and (liked tx-1) (liked tx-2) (liked tx-3) (task-completed)))
)
