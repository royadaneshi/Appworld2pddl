(define (problem task-90adc3f-1)
  (:domain appworld-90adc3f-1)
  (:objects
    anita friend-1 friend-2 - person
    request-friend-1 request-friend-2 - payment-request
    anita-burch-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    email-friend-1 email-friend-2 - email
    amount-requested amount-corrected - amount
    dinner-description - description
    privacy-as-before - privacy)
  (:init
    (password-for venmo venmo-password)
    (sent-yesterday-evening request-friend-1)
    (sent-yesterday-evening request-friend-2)
    (request-to request-friend-1 friend-1)
    (request-to request-friend-2 friend-2)
    (email-of friend-1 email-friend-1)
    (email-of friend-2 email-friend-2)
    (request-amount request-friend-1 amount-requested)
    (request-amount request-friend-2 amount-requested)
    (request-description request-friend-1 dinner-description)
    (request-description request-friend-2 dinner-description)
    (request-privacy request-friend-1 privacy-as-before)
    (request-privacy request-friend-2 privacy-as-before)
    (minus-five amount-requested amount-corrected))
  (:goal (and
    (deleted request-friend-1)
    (recreated request-friend-1)
    (deleted request-friend-2)
    (recreated request-friend-2)
    (task-completed)))
)
