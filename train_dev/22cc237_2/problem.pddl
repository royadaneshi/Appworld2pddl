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
    email-adrian email-katie email-martin email-robin email-matthew email-melissa email-glenn email-brenda - email
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
    (contact-email dinner-friend-adrian email-adrian)
    (contact-email dinner-friend-katie email-katie)
    (contact-email dinner-friend-martin email-martin)
    (contact-email dinner-friend-robin email-robin)
    (contact-email dinner-friend-matthew email-matthew)
    (contact-email dinner-friend-melissa email-melissa)
    (contact-email dinner-friend-glenn email-glenn)
    (contact-email dinner-friend-brenda email-brenda)
    (share-in-note note-friends-dinner dinner-friend-adrian share-adrian)
    (share-in-note note-friends-dinner dinner-friend-katie share-katie)
    (share-in-note note-friends-dinner dinner-friend-martin share-martin)
    (share-in-note note-friends-dinner dinner-friend-robin share-robin)
    (share-in-note note-friends-dinner dinner-friend-matthew share-matthew)
    (share-in-note note-friends-dinner dinner-friend-melissa share-melissa)
    (share-in-note note-friends-dinner dinner-friend-glenn share-glenn)
    (share-in-note note-friends-dinner dinner-friend-brenda share-brenda)
    (already-paid dinner-friend-martin)
    (already-paid dinner-friend-robin)
    (already-paid dinner-friend-matthew)
    (already-paid dinner-friend-brenda))
  (:goal (and
    (payment-request-created dinner-friend-adrian share-adrian description-friends-dinner)
    (payment-request-created dinner-friend-katie share-katie description-friends-dinner)
    (payment-request-created dinner-friend-melissa share-melissa description-friends-dinner)
    (payment-request-created dinner-friend-glenn share-glenn description-friends-dinner)
    (task-completed)))
)
