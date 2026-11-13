(define (problem task-3aa1a22-1)
  (:domain appworld-3aa1a22-1)
  (:objects
    carl-brown - person
    phone-username-7934818191 carbrown-at-gmail-com - username
    phone-password splitwise-password - password
    phone-token splitwise-token - token
    query-splitwise - query
    invitation-message-1 invitation-message-2 - text-message
    sender-number-1 sender-number-2 - phone-number
    invitation-code-1 invitation-code-2 - invitation-code
    splitwise-group-1 splitwise-group-2 - group
  )
  (:init
    (credential-of-app phone phone-username-7934818191)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app splitwise carbrown-at-gmail-com)
    (credential-of-app splitwise splitwise-password)
    (credential-of-app splitwise splitwise-token)
    (username-for phone phone-username-7934818191)
    (username-for splitwise carbrown-at-gmail-com)
    (password-for phone phone-password)
    (password-for splitwise splitwise-password)
    (invitation-received-yesterday invitation-message-1)
    (invitation-received-yesterday invitation-message-2)
    (message-sender invitation-message-1 sender-number-1)
    (message-sender invitation-message-2 sender-number-2)
    (message-code invitation-message-1 invitation-code-1)
    (message-code invitation-message-2 invitation-code-2)
    (code-for-group invitation-code-1 splitwise-group-1)
    (code-for-group invitation-code-2 splitwise-group-2)
    (sender-in-contacts sender-number-1)
  )
  (:goal (and
    (group-joined splitwise-group-1)
    (message-deleted invitation-message-2)
    (task-completed)
  ))
)
