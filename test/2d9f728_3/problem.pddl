(define (problem task-2d9f728-3)
  (:domain appworld-2d9f728-3)
  (:objects
    jordan - person
    phone-2254213734 jo-harr-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    nancy-email roommate-a-email roommate-b-email - email
    rel-roommate - relationship
  )
  (:init
    (username-for phone phone-2254213734)
    (username-for venmo jo-harr-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (token-for phone phone-token)
    (token-for venmo venmo-token)
    (roommate-relationship rel-roommate)
    (roommate nancy)
    (roommate roommate-a)
    (roommate roommate-b)
    (contact-email nancy nancy-email)
    (contact-email roommate-a roommate-a-email)
    (contact-email roommate-b roommate-b-email)
  )
  (:goal (and
    (payment-request-sent nancy amount-commute-share note-commute)
    (payment-request-sent roommate-a amount-commute-share note-commute)
    (payment-request-sent roommate-b amount-commute-share note-commute)
    (transaction-sent nancy amount-dinner-share note-dinner)
    (task-completed)
  ))
)
