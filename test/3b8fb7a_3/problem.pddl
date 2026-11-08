(define (problem task-3b8fb7a-3)
  (:domain appworld-3b8fb7a-3)
  (:objects
    morgan-burton - person
    morgan-harrison-at-gmail-com - username
    simple-note-password venmo-password - password
    simple-note-token venmo-token - token
    query-miami - query
    miami-trip-note - note
    email-friend-i-owe-1 email-friend-i-owe-2 email-friend-owes-me-1 email-friend-owes-me-2 email-friend-owes-me-3 - email
  )
  (:init
    (username-for simple-note morgan-harrison-at-gmail-com)
    (username-for venmo morgan-harrison-at-gmail-com)
    (password-for simple-note simple-note-password)
    (password-for venmo venmo-password)
    (note-matches miami-trip-note query-miami)
    (note-lists-i-owe miami-trip-note friend-i-owe-1 amount-i-owe-1)
    (note-lists-i-owe miami-trip-note friend-i-owe-2 amount-i-owe-2)
    (note-lists-owes-me miami-trip-note friend-owes-me-1 amount-owed-to-me-1)
    (note-lists-owes-me miami-trip-note friend-owes-me-2 amount-owed-to-me-2)
    (note-lists-owes-me miami-trip-note friend-owes-me-3 amount-owed-to-me-3)
    (venmo-email friend-i-owe-1 email-friend-i-owe-1)
    (venmo-email friend-i-owe-2 email-friend-i-owe-2)
    (venmo-email friend-owes-me-1 email-friend-owes-me-1)
    (venmo-email friend-owes-me-2 email-friend-owes-me-2)
    (venmo-email friend-owes-me-3 email-friend-owes-me-3)
    (trip-description desc-for-miami-trip)
    (private-setting private-true)
  )
  (:goal (and
    (paid friend-i-owe-1 amount-i-owe-1 desc-for-miami-trip private-true)
    (paid friend-i-owe-2 amount-i-owe-2 desc-for-miami-trip private-true)
    (requested friend-owes-me-1 amount-owed-to-me-1 desc-for-miami-trip private-true)
    (requested friend-owes-me-2 amount-owed-to-me-2 desc-for-miami-trip private-true)
    (requested friend-owes-me-3 amount-owed-to-me-3 desc-for-miami-trip private-true)
    (task-completed)
  ))
)
