(define (problem task-0d8a4ee-3)
  (:domain appworld-0d8a4ee-3)
  (:objects
    chris-mccoy roommate-a roommate-b friend-a friend-b - person
    chris-5584932120 chris-mcco-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    email-roommate-a email-roommate-b email-friend-a email-friend-b - email
    phone-roommate-a phone-roommate-b phone-friend-a phone-friend-b - phone-number
    query-roommates query-friends - query
    roommates friends - relationship
    msg-make-an-account-on-venmo-please - message
    count-1 count-2 - count
  )
  (:init
    (username-for phone chris-5584932120)
    (username-for venmo chris-mcco-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (query-for roommates query-roommates)
    (query-for friends query-friends)
    (has-relationship roommate-a roommates)
    (has-relationship roommate-b roommates)
    (has-relationship friend-a friends)
    (has-relationship friend-b friends)
    (email-of roommate-a email-roommate-a)
    (email-of roommate-b email-roommate-b)
    (email-of friend-a email-friend-a)
    (email-of friend-b email-friend-b)
    (phone-of roommate-a phone-roommate-a)
    (phone-of roommate-b phone-roommate-b)
    (phone-of friend-a phone-friend-a)
    (phone-of friend-b phone-friend-b)
    (has-venmo-account roommate-a)
    (has-venmo-account friend-b)
    (count-succ count-0 count-1)
    (count-succ count-1 count-2)
    (remaining count-2)
  )
  (:goal (and
    (venmo-status-known roommate-a)
    (venmo-status-known roommate-b)
    (venmo-status-known friend-a)
    (venmo-status-known friend-b)
    (message-sent roommate-b msg-make-an-account-on-venmo-please)
    (message-sent friend-a msg-make-an-account-on-venmo-please)
    (remaining count-0)
    (task-completed)
  ))
)
