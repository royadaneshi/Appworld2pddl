(define (problem task-22cc237-2)
  (:domain appworld-22cc237-2)
  (:objects
    kristin dinner-friend-1 - person
    username-6017026518 username-kri-powe-at-gmail-com - username
    password-phone password-simple-note password-venmo - password
    token-phone token-simple-note token-venmo - token
    email-friend-1 email-friend-2 email-friend-3 - email
    query-friend query-friends-dinner - query
    relationship-friend - relationship
    note-friends-dinner - note
    amount-share-1 - amount
    direction-received - direction
    datetime-2023-05-19 - datetime)
  (:init
    (username-for phone username-6017026518)
    (username-for simple-note username-kri-powe-at-gmail-com)
    (username-for venmo username-kri-powe-at-gmail-com)
    (password-for phone password-phone)
    (password-for simple-note password-simple-note)
    (password-for venmo password-venmo)
    (relationship-query relationship-friend query-friend)
    (contact-email dinner-friend-1 email-friend-1)
    (contact-email dinner-friend-2 email-friend-2)
    (contact-email dinner-friend-3 email-friend-3)
    (note-matches note-friends-dinner query-friends-dinner)
    (share-in-note note-friends-dinner dinner-friend-1 amount-share-1)
    (share-in-note note-friends-dinner dinner-friend-2 amount-share-2)
    (share-in-note note-friends-dinner dinner-friend-3 amount-share-3)
    (already-paid dinner-friend-1))
  (:goal (and
    (payment-request-created dinner-friend-2 amount-share-2 description-friends-dinner)
    (payment-request-created dinner-friend-3 amount-share-3 description-friends-dinner)
    (task-completed)))
)
