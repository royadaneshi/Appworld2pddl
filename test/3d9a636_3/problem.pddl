(define (problem task-3d9a636-3)
  (:domain appworld-3d9a636-3)
  (:objects
    carl-brown friend-to-add-1 friend-to-remove-1 mutual-friend-1 - person
    phone-number-7934818191 carbrown-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    email-friend-to-add-1 email-friend-to-remove-1 email-mutual-friend-1 - email
    relationship-friend - relationship
    n1 - count
  )
  (:init
    (username-for phone phone-number-7934818191)
    (username-for venmo carbrown-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (friend-relationship relationship-friend)
    (email-of friend-to-add-1 email-friend-to-add-1)
    (email-of friend-to-remove-1 email-friend-to-remove-1)
    (email-of mutual-friend-1 email-mutual-friend-1)
    (phone-friend friend-to-add-1)
    (phone-friend mutual-friend-1)
    (venmo-friend friend-to-remove-1)
    (venmo-friend mutual-friend-1)
    (next n1 n0)
    (befriend-remaining n1)
    (unfriend-remaining n1)
  )
  (:goal (and (befriend-remaining n0) (unfriend-remaining n0) (task-completed)))
)
