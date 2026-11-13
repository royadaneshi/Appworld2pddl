(define (problem task-90adc3f-3)
  (:domain appworld-90adc3f-3)
  (:objects
    nancy-ritter friend-1 friend-2 friend-3 friend-4 friend-5 - person
    nan-ritt-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    email-friend-1 email-friend-2 email-friend-3 email-friend-4 email-friend-5 - email
    amount-requested amount-requested-minus-15 - amount
    description-yesterday-request - description
    privacy-yesterday-request - privacy
    request-friend-1 request-friend-2 request-friend-3 request-friend-4 request-friend-5 - payment-request
  )
  (:init
    (username-for venmo nan-ritt-at-gmail-com)
    (password-for venmo venmo-password)
    (fifteen-less amount-requested-minus-15 amount-requested)
    (request-to request-friend-1 friend-1)
    (person-email friend-1 email-friend-1)
    (request-amount request-friend-1 amount-requested)
    (request-description request-friend-1 description-yesterday-request)
    (request-privacy request-friend-1 privacy-yesterday-request)
    (request-to request-friend-2 friend-2)
    (person-email friend-2 email-friend-2)
    (request-amount request-friend-2 amount-requested)
    (request-description request-friend-2 description-yesterday-request)
    (request-privacy request-friend-2 privacy-yesterday-request)
    (request-to request-friend-3 friend-3)
    (person-email friend-3 email-friend-3)
    (request-amount request-friend-3 amount-requested)
    (request-description request-friend-3 description-yesterday-request)
    (request-privacy request-friend-3 privacy-yesterday-request)
    (request-to request-friend-4 friend-4)
    (person-email friend-4 email-friend-4)
    (request-amount request-friend-4 amount-requested)
    (request-description request-friend-4 description-yesterday-request)
    (request-privacy request-friend-4 privacy-yesterday-request)
    (request-to request-friend-5 friend-5)
    (person-email friend-5 email-friend-5)
    (request-amount request-friend-5 amount-requested)
    (request-description request-friend-5 description-yesterday-request)
    (request-privacy request-friend-5 privacy-yesterday-request))
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
