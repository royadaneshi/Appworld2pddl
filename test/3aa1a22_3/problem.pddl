(define (problem task-3aa1a22-3)
  (:domain appworld-3aa1a22-3)
  (:objects
    angelica - person
    phone-6759633882 angelica-wils-at-gmail-com - username
    phone-password splitwise-password - password
    phone-token splitwise-token - token
    query-splitwise - query
    message-1 message-2 message-3 message-4 message-5 message-6 - text-message
    contact-number-1 contact-number-2 contact-number-3 unknown-number-1 unknown-number-2 unknown-number-3 - phone-number
    invite-code-1 invite-code-2 invite-code-3 - invitation-code
  )
  (:init
    (credential-of-app phone phone-6759633882)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app splitwise angelica-wils-at-gmail-com)
    (credential-of-app splitwise splitwise-password)
    (credential-of-app splitwise splitwise-token)
    (username-for phone phone-6759633882)
    (username-for splitwise angelica-wils-at-gmail-com)
    (password-for phone phone-password)
    (password-for splitwise splitwise-password)
    (message-from message-1 contact-number-1)
    (message-from message-2 contact-number-2)
    (message-from message-3 contact-number-3)
    (message-from message-4 unknown-number-1)
    (message-from message-5 unknown-number-2)
    (message-from message-6 unknown-number-3)
    (message-has-code message-1 invite-code-1)
    (message-has-code message-2 invite-code-2)
    (message-has-code message-3 invite-code-3)
    (received-this-week message-1)
    (received-this-week message-2)
    (received-this-week message-3)
    (received-this-week message-4)
    (received-this-week message-5)
    (received-this-week message-6)
    (in-contacts contact-number-1)
    (in-contacts contact-number-2)
    (in-contacts contact-number-3))
  (:goal (and
    (invitation-accepted invite-code-1)
    (invitation-accepted invite-code-2)
    (invitation-accepted invite-code-3)
    (message-deleted message-4)
    (message-deleted message-5)
    (message-deleted message-6)
    (task-completed)))
)
