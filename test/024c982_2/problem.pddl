(define (problem task-024c982-2)
  (:domain appworld-024c982-2)
  (:objects
    nicholas melissa - person
    phone-username-9503658964 venmo-username-nicholas-weber-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    melissa-email - email
    query-melissa - query
    relationship-roommate - relationship
    amount-28 - amount
    note-for-the-movie-tickets - note
    privacy-private - privacy
    request-melissa-movie-tickets - payment-request
  )
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone phone-username-9503658964)
    (username-for venmo venmo-username-nicholas-weber-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (search-query-for melissa query-melissa)
    (relation-of melissa relationship-roommate)
    (request-recipient request-melissa-movie-tickets melissa)
    (request-amount request-melissa-movie-tickets amount-28)
    (request-note request-melissa-movie-tickets note-for-the-movie-tickets)
    (request-privacy request-melissa-movie-tickets privacy-private)
  )
  (:goal (and
    (request-sent request-melissa-movie-tickets)
    (task-completed)
  ))
)
