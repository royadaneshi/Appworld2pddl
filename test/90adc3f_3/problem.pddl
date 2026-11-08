(define (problem task-90adc3f-3)
  (:domain appworld-90adc3f-3)
  (:objects
    nancy-ritter friend-1 friend-2 - person
    nan-ritt-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    email-friend-1 email-friend-2 - email
    amount-requested amount-requested-minus-15 - amount
    description-yesterday-request - description
    privacy-yesterday-request - privacy
    request-friend-1 request-friend-2 - payment-request
  )
  (:init
    (username-for venmo nan-ritt-at-gmail-com)
    (password-for venmo venmo-password)
    (request-to request-friend-1 friend-1)
    (request-to request-friend-2 friend-2)
    (person-email friend-1 email-friend-1)
    (person-email friend-2 email-friend-2)
    (request-amount request-friend-1 amount-requested)
    (request-amount request-friend-2 amount-requested)
    (request-description request-friend-1 description-yesterday-request)
    (request-description request-friend-2 description-yesterday-request)
    (request-privacy request-friend-1 privacy-yesterday-request)
    (request-privacy request-friend-2 privacy-yesterday-request)
    (fifteen-less amount-requested-minus-15 amount-requested)
  )
  (:goal (and
    (deleted request-friend-1)
    (recreated request-friend-1)
    (deleted request-friend-2)
    (recreated request-friend-2)
    (task-completed)
  ))
)
