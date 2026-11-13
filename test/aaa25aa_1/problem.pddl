(define (problem task-aaa25aa-1)
  (:domain appworld-aaa25aa-1)
  (:objects
    thomas son - person
    thomas-new-app-account - account
    username-2192158297 username-thomas-solomon-at-gmail-com - username
    phone-password gmail-password new-password-vh-1r0 - password
    phone-token gmail-token - token
    thomas-solomon-at-gmail-com - email
    relationship-son - relationship
    son-phone-number - phone-number
    account-creation-message - message
    query-new-app-account query-new-app-password-reset-code - query
    verification-email reset-email - inbox-email
    verification-code reset-code - code)
  (:init
    (credential-of-app phone username-2192158297)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app gmail thomas-solomon-at-gmail-com)
    (credential-of-app gmail username-thomas-solomon-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (password-for phone phone-password)
    (password-for gmail gmail-password)
    (username-for phone username-2192158297)
    (username-for gmail username-thomas-solomon-at-gmail-com)
    (relationship-of son relationship-son)
    (phone-number-of son son-phone-number)
    (message-from account-creation-message son)
    (message-about account-creation-message thomas-new-app-account)
    (account-email thomas-new-app-account thomas-solomon-at-gmail-com)
    (verification-code-of thomas-new-app-account verification-code)
    (reset-code-of thomas-new-app-account reset-code)
    (query-finds query-new-app-account verification-email)
    (query-finds query-new-app-password-reset-code reset-email)
    (email-contains-code verification-email verification-code)
    (email-contains-code reset-email reset-code)
    (requested-password thomas-new-app-account new-password-vh-1r0))
  (:goal (and
    (account-verified thomas-new-app-account)
    (password-set thomas-new-app-account new-password-vh-1r0)
    (task-completed))))
