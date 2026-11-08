(define (problem task-3aa1a22-2)
  (:domain appworld-3aa1a22-2)
  (:objects
    sierra-white - person
    phone-username splitwise-username - username
    phone-password splitwise-password - password
    phone-token splitwise-token - token
    query-splitwise - query
    voice-message-1 voice-message-2 - voice-message
    sender-number-1 sender-number-2 - phone-number
    invitation-code-1 invitation-code-2 - invitation-code
    group-1 group-2 - group)
  (:init
    (username-for phone phone-username)
    (username-for splitwise splitwise-username)
    (password-for phone phone-password)
    (password-for splitwise splitwise-password)
    (message-from voice-message-1 sender-number-1)
    (message-from voice-message-2 sender-number-2)
    (message-has-code voice-message-1 invitation-code-1)
    (message-has-code voice-message-2 invitation-code-2)
    (code-for-group invitation-code-1 group-1)
    (code-for-group invitation-code-2 group-2)
    (in-contacts sender-number-1))
  (:goal (and (group-joined group-1) (message-deleted voice-message-2) (task-completed))))
