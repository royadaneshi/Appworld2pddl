(define (problem task-3b8fb7a-2)
  (:domain appworld-3b8fb7a-2)
  (:objects
    alexander-riddle - person
    alexander-ridd-at-gmail-com - username
    simple-note-password venmo-password - password
    simple-note-token venmo-token - token
    query-athens - query
    email-i-owe-1 email-i-owe-2 email-owes-me-1 email-owes-me-2 - email)
  (:init
    (password-for simple-note simple-note-password)
    (password-for venmo venmo-password)
    (token-for simple-note simple-note-token)
    (token-for venmo venmo-token)
    (note-matches athens-trip-note query-athens)
    (i-owe athens-trip-note friend-i-owe-1 amount-i-owe-1)
    (i-owe athens-trip-note friend-i-owe-2 amount-i-owe-2)
    (they-owe athens-trip-note friend-owes-me-1 amount-owes-me-1)
    (they-owe athens-trip-note friend-owes-me-2 amount-owes-me-2)
    (friend-email friend-i-owe-1 email-i-owe-1)
    (friend-email friend-i-owe-2 email-i-owe-2)
    (friend-email friend-owes-me-1 email-owes-me-1)
    (friend-email friend-owes-me-2 email-owes-me-2))
  (:goal (and
    (paid friend-i-owe-1 amount-i-owe-1 note-for-athens-trip private-true)
    (paid friend-i-owe-2 amount-i-owe-2 note-for-athens-trip private-true)
    (requested friend-owes-me-1 amount-owes-me-1 note-for-athens-trip private-true)
    (requested friend-owes-me-2 amount-owes-me-2 note-for-athens-trip private-true)
    (task-completed))))
