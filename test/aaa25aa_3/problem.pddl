(define (problem task-aaa25aa-3)
  (:domain appworld-aaa25aa-3)
  (:objects
    dillon-wilson son - person
    username-3966728840 username-diwils-at-gmail-com - username
    phone-password gmail-password password-ueha7gv - password
    phone-token gmail-token - token
    diwils-at-gmail-com - email
    query-verification-code query-password-reset-code - query
    new-app-verification-code new-app-reset-code - code
    son-phone-number - phone-number
    rel-son - relationship
    son-message-yesterday - text-message
    verification-email-thread reset-email-thread - email-thread)
  (:init
    (credential-of-app phone username-3966728840)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app gmail username-diwils-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app gmail diwils-at-gmail-com)
    (username-for phone username-3966728840)
    (username-for gmail username-diwils-at-gmail-com)
    (password-for phone phone-password)
    (password-for gmail gmail-password)
    (has-relationship son rel-son)
    (phone-number-of son son-phone-number)
    (message-from son-message-yesterday son)
    (supervisor-email diwils-at-gmail-com)
    (is-verification-code new-app-verification-code)
    (is-reset-code new-app-reset-code)
    (query-for-code query-verification-code new-app-verification-code)
    (query-for-code query-password-reset-code new-app-reset-code)
    (thread-of verification-email-thread new-app-verification-code)
    (thread-of reset-email-thread new-app-reset-code)
    (requested-new-password password-ueha7gv))
  (:goal (and (account-verified) (new-password-set) (task-completed))))
