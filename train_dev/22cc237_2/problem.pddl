(define (problem task-22cc237-2)
  (:domain appworld-22cc237-2)
  (:objects
    username-6017026518 username-kri-powe-at-gmail-com - username
    password-phone password-simple-note password-venmo - password
    token-phone token-simple-note token-venmo - token
    query-friend query-friends-dinner - query
    relationship-friend - relationship
    note-friends-dinner - note
    direction-received - direction
    datetime-2023-05-19 - datetime
    kristin - person
    email-friend-1 email-friend-2 email-friend-3 email-friend-4 email-friend-5 email-friend-6 email-friend-7 email-friend-8 - email
  )
  (:init
    (credential-of-app phone password-phone)
    (credential-of-app phone token-phone)
    (credential-of-app simple-note password-simple-note)
    (credential-of-app simple-note token-simple-note)
    (credential-of-app venmo password-venmo)
    (credential-of-app venmo token-venmo)
    (username-for phone username-6017026518)
    (username-for simple-note username-kri-powe-at-gmail-com)
    (username-for venmo username-kri-powe-at-gmail-com)
    (password-for phone password-phone)
    (password-for simple-note password-simple-note)
    (password-for venmo password-venmo)
    (relationship-query relationship-friend query-friend)
    (note-matches note-friends-dinner query-friends-dinner)
    (contact-email dinner-friend-1 email-friend-1)
    (contact-email dinner-friend-2 email-friend-2)
    (contact-email dinner-friend-5 email-friend-3)
    (contact-email dinner-friend-6 email-friend-4)
    (contact-email dinner-friend-7 email-friend-5)
    (contact-email dinner-friend-3 email-friend-6)
    (contact-email dinner-friend-4 email-friend-7)
    (contact-email dinner-friend-8 email-friend-8)
    (share-in-note note-friends-dinner dinner-friend-1 amount-share-1)
    (share-in-note note-friends-dinner dinner-friend-2 amount-share-2)
    (share-in-note note-friends-dinner dinner-friend-5 amount-share-5)
    (share-in-note note-friends-dinner dinner-friend-6 amount-share-6)
    (share-in-note note-friends-dinner dinner-friend-7 amount-share-7)
    (share-in-note note-friends-dinner dinner-friend-3 amount-share-3)
    (share-in-note note-friends-dinner dinner-friend-4 amount-share-4)
    (share-in-note note-friends-dinner dinner-friend-8 amount-share-8)
    (already-paid dinner-friend-5)
    (already-paid dinner-friend-6)
    (already-paid dinner-friend-7)
    (already-paid dinner-friend-8))
  (:goal (and
    (payment-request-created dinner-friend-1 amount-share-1 description-friends-dinner)
    (payment-request-created dinner-friend-2 amount-share-2 description-friends-dinner)
    (payment-request-created dinner-friend-3 amount-share-3 description-friends-dinner)
    (payment-request-created dinner-friend-4 amount-share-4 description-friends-dinner)
    (task-completed)))
)
