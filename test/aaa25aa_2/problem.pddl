(define (problem task-aaa25aa-2)
  (:domain appworld-aaa25aa-2)
  (:objects
    caitlin daughter - person
    username-5896230193 username-caiburc-at-gmail-com - username
    phone-password gmail-password new-password-j7yl6 - password
    phone-token gmail-token - token
    caiburc-at-gmail-com - email
    daughter-phone - phone-number
    rel-daughter - relationship
    daughter-message - text-message
    verification-thread reset-thread - email-thread
    verification-code reset-code - code
    query-verification-code query-password-reset-code - query
  )
  (:init
    (username-for phone username-5896230193)
    (username-for gmail username-caiburc-at-gmail-com)
    (password-for phone phone-password)
    (password-for gmail gmail-password)
    (new-password new-password-j7yl6)
    (supervisor-email caiburc-at-gmail-com)
    (has-relationship daughter rel-daughter)
    (phone-of daughter daughter-phone)
    (message-from daughter-message daughter)
    (message-requests daughter-message caiburc-at-gmail-com)
    (verification-thread-for caiburc-at-gmail-com verification-thread)
    (reset-thread-for caiburc-at-gmail-com reset-thread)
    (query-finds query-verification-code verification-thread)
    (query-finds query-password-reset-code reset-thread)
    (code-in-thread verification-code verification-thread)
    (code-in-thread reset-code reset-thread)
    (verification-code-for verification-code caiburc-at-gmail-com)
    (reset-code-for reset-code caiburc-at-gmail-com)
  )
  (:goal (and
    (account-verified caiburc-at-gmail-com)
    (password-set caiburc-at-gmail-com new-password-j7yl6)
    (task-completed)
  ))
)
