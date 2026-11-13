(define (problem task-90adc3f-1)
  (:domain appworld-90adc3f-1)
  (:objects
    anita friend-1 friend-2 friend-3 friend-4 friend-5 - person
    request-friend-1 request-friend-2 request-friend-3 request-friend-4 request-friend-5 - payment-request
    anita-burch-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    email-friend-1 email-friend-2 email-friend-3 email-friend-4 email-friend-5 - email
    amount-requested amount-corrected - amount
    dinner-description - description
    privacy-as-before - privacy
  )
  (:init
    (password-for venmo venmo-password)
    (minus-five amount-requested amount-corrected)
    (sent-yesterday-evening request-friend-1)
    (sent-yesterday-evening request-friend-2)
    (sent-yesterday-evening request-friend-3)
    (sent-yesterday-evening request-friend-4)
    (sent-yesterday-evening request-friend-5)
    (request-to request-friend-1 friend-1)
    (email-of friend-1 email-friend-1)
    (request-amount request-friend-1 amount-requested)
    (request-description request-friend-1 dinner-description)
    (request-privacy request-friend-1 privacy-as-before)
    (request-to request-friend-2 friend-2)
    (email-of friend-2 email-friend-2)
    (request-amount request-friend-2 amount-requested)
    (request-description request-friend-2 dinner-description)
    (request-privacy request-friend-2 privacy-as-before)
    (request-to request-friend-3 friend-3)
    (email-of friend-3 email-friend-3)
    (request-amount request-friend-3 amount-requested)
    (request-description request-friend-3 dinner-description)
    (request-privacy request-friend-3 privacy-as-before)
    (request-to request-friend-4 friend-4)
    (email-of friend-4 email-friend-4)
    (request-amount request-friend-4 amount-requested)
    (request-description request-friend-4 dinner-description)
    (request-privacy request-friend-4 privacy-as-before)
    (request-to request-friend-5 friend-5)
    (email-of friend-5 email-friend-5)
    (request-amount request-friend-5 amount-requested)
    (request-description request-friend-5 dinner-description)
    (request-privacy request-friend-5 privacy-as-before))
  (:goal (and
    (deleted request-friend-1)
    (recreated request-friend-1)
    (deleted request-friend-2)
    (recreated request-friend-2)
    (deleted request-friend-3)
    (recreated request-friend-3)
    (deleted request-friend-4)
    (recreated request-friend-4)
    (deleted request-friend-5)
    (recreated request-friend-5)
    (task-completed)))
)
