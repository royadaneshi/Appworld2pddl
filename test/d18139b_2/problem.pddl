(define (problem task-d18139b-2)
  (:domain appworld-d18139b-2)
  (:objects
    melissa-bailey roommate-1 roommate-2 roommate-3 - person
    phone-username-3383946795 mel-bailey-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    status-pending - status
    pr-1 pr-2 pr-3 - payment-request
  )
  (:init
    (username-for phone phone-username-3383946795)
    (username-for venmo mel-bailey-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (token-of phone phone-token)
    (token-of venmo venmo-token)
    (has-relationship roommate-1 roommate)
    (has-relationship roommate-2 roommate)
    (has-relationship roommate-3 roommate)
    (request-from pr-1 roommate-1)
    (request-from pr-2 roommate-2)
    (request-from pr-3 roommate-3)
    (request-this-month pr-1)
    (request-this-month pr-2)
    (request-this-month pr-3)
    (pending pr-1)
    (pending pr-2)
    (pending pr-3)
  )
  (:goal (and
    (approved pr-1)
    (approved pr-2)
    (approved pr-3)
    (task-completed)
  ))
)
