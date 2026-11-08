(define (problem task-3b8fb7a-1)
  (:domain appworld-3b8fb7a-1)
  (:objects
    brenda - person
    brenda-webe-at-gmail-com - username
    simple-note-password venmo-password - password
    simple-note-token venmo-token - token
    query-maui query-friend-1 query-friend-2 query-friend-3 query-friend-4 - query
    email-friend-1 email-friend-2 email-friend-3 email-friend-4 - email)
  (:init
    (password-for simple-note simple-note-password)
    (password-for venmo venmo-password)
    (note-matches note-maui-trip query-maui)
    (listed-in note-maui-trip friend-1)
    (listed-in note-maui-trip friend-2)
    (listed-in note-maui-trip friend-3)
    (listed-in note-maui-trip friend-4)
    (i-owe note-maui-trip friend-1 amount-i-owe-friend-1)
    (i-owe note-maui-trip friend-2 amount-i-owe-friend-2)
    (owes-me note-maui-trip friend-3 amount-friend-3-owes-me)
    (owes-me note-maui-trip friend-4 amount-friend-4-owes-me)
    (query-for friend-1 query-friend-1)
    (query-for friend-2 query-friend-2)
    (query-for friend-3 query-friend-3)
    (query-for friend-4 query-friend-4)
    (email-of friend-1 email-friend-1)
    (email-of friend-2 email-friend-2)
    (email-of friend-3 email-friend-3)
    (email-of friend-4 email-friend-4))
  (:goal (and
    (paid friend-1 amount-i-owe-friend-1 desc-for-maui-trip private-true)
    (paid friend-2 amount-i-owe-friend-2 desc-for-maui-trip private-true)
    (requested friend-3 amount-friend-3-owes-me desc-for-maui-trip private-true)
    (requested friend-4 amount-friend-4-owes-me desc-for-maui-trip private-true)
    (task-completed))))
