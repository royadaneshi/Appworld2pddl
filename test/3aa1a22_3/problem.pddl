(define (problem task-3aa1a22-3)
  (:domain appworld-3aa1a22-3)
  (:objects
    angelica - person
    phone-6759633882 angelica-wils-at-gmail-com - username
    phone-password splitwise-password - password
    phone-token splitwise-token - token
    query-splitwise - query
    contact-number-1 unknown-number-2 - phone-number
    message-1 message-2 - text-message
    invite-code-1 invite-code-2 - invitation-code
  )
  (:init
    (username-for phone phone-6759633882)
    (username-for splitwise angelica-wils-at-gmail-com)
    (password-for phone phone-password)
    (password-for splitwise splitwise-password)
    (message-from message-1 contact-number-1)
    (message-has-code message-1 invite-code-1)
    (received-this-week message-1)
    (message-from message-2 unknown-number-2)
    (message-has-code message-2 invite-code-2)
    (received-this-week message-2)
    (in-contacts contact-number-1)
  )
  (:goal (and
    (invitation-accepted invite-code-1)
    (message-deleted message-2)
    (task-completed)
  ))
)
