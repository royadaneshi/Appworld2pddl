(define (problem task-92fe421-2)
  (:domain appworld-92fe421-2)
  (:objects
    james-solomon roommate-1 roommate-2 roommate-3 - person
    username-8683971586 username-ja-solomon-at-gmail-com - username
    phone-password spotify-password venmo-password - password
    phone-token spotify-token venmo-token - token
    email-roommate-1 email-roommate-2 email-roommate-3 - email
    amount-share - amount
    desc-for-spotify-premium - description
    relationship-roommate - relationship
    query-spotify - query
  )
  (:init
    (username-for phone username-8683971586)
    (username-for spotify username-ja-solomon-at-gmail-com)
    (username-for venmo username-ja-solomon-at-gmail-com)
    (password-for phone phone-password)
    (password-for spotify spotify-password)
    (password-for venmo venmo-password)
    (roommate roommate-1)
    (roommate roommate-2)
    (roommate roommate-3)
    (email-of roommate-1 email-roommate-1)
    (email-of roommate-2 email-roommate-2)
    (email-of roommate-3 email-roommate-3)
    (roommate-relationship relationship-roommate)
    (share-amount amount-share)
    (note-text desc-for-spotify-premium)
    (has-paid roommate-3)
  )
  (:goal (and
    (request-sent roommate-1)
    (request-sent roommate-2)
    (task-completed)
  ))
)
