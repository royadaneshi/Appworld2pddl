(define (problem task-3b8fb7a-3)
  (:domain appworld-3b8fb7a-3)
  (:objects
    morgan-burton - person
    morgan-harrison-at-gmail-com - username
    simple-note-password venmo-password - password
    simple-note-token venmo-token - token
    query-miami - query
    miami-trip-note - note
    email-friend-i-owe-1 email-friend-i-owe-2 email-friend-i-owe-3 email-friend-i-owe-4 email-friend-i-owe-5 email-friend-i-owe-6 email-friend-i-owe-7 email-friend-i-owe-8 - email
  )
  (:init
    (credential-of-app simple-note morgan-harrison-at-gmail-com)
    (credential-of-app simple-note simple-note-password)
    (credential-of-app simple-note simple-note-token)
    (credential-of-app venmo morgan-harrison-at-gmail-com)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for simple-note morgan-harrison-at-gmail-com)
    (username-for venmo morgan-harrison-at-gmail-com)
    (password-for simple-note simple-note-password)
    (password-for venmo venmo-password)
    (note-matches miami-trip-note query-miami)
    (trip-description desc-for-miami-trip)
    (private-setting private-true)
    (note-lists-i-owe miami-trip-note friend-i-owe-1 amount-i-owe-1)
    (note-lists-i-owe miami-trip-note friend-i-owe-2 amount-i-owe-2)
    (note-lists-i-owe miami-trip-note friend-i-owe-3 amount-i-owe-3)
    (note-lists-i-owe miami-trip-note friend-i-owe-4 amount-i-owe-4)
    (note-lists-owes-me miami-trip-note friend-owes-me-1 amount-owed-to-me-1)
    (note-lists-owes-me miami-trip-note friend-owes-me-2 amount-owed-to-me-2)
    (note-lists-owes-me miami-trip-note friend-owes-me-3 amount-owed-to-me-3)
    (note-lists-owes-me miami-trip-note friend-owes-me-4 amount-owed-to-me-4)
    (venmo-email friend-i-owe-1 email-friend-i-owe-1)
    (venmo-email friend-i-owe-2 email-friend-i-owe-2)
    (venmo-email friend-i-owe-3 email-friend-i-owe-3)
    (venmo-email friend-i-owe-4 email-friend-i-owe-4)
    (venmo-email friend-owes-me-1 email-friend-i-owe-5)
    (venmo-email friend-owes-me-2 email-friend-i-owe-6)
    (venmo-email friend-owes-me-3 email-friend-i-owe-7)
    (venmo-email friend-owes-me-4 email-friend-i-owe-8))
  (:goal (and
    (paid friend-i-owe-1 amount-i-owe-1 desc-for-miami-trip private-true)
    (paid friend-i-owe-2 amount-i-owe-2 desc-for-miami-trip private-true)
    (paid friend-i-owe-3 amount-i-owe-3 desc-for-miami-trip private-true)
    (paid friend-i-owe-4 amount-i-owe-4 desc-for-miami-trip private-true)
    (requested friend-owes-me-1 amount-owed-to-me-1 desc-for-miami-trip private-true)
    (requested friend-owes-me-2 amount-owed-to-me-2 desc-for-miami-trip private-true)
    (requested friend-owes-me-3 amount-owed-to-me-3 desc-for-miami-trip private-true)
    (requested friend-owes-me-4 amount-owed-to-me-4 desc-for-miami-trip private-true)
    (task-completed)))
)
