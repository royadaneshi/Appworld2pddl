(define (problem task-aaa25aa-1)
  (:domain appworld-aaa25aa-1)
  (:objects
    thomas son - person
    thomas-spotify-account - account
    username-2192158297 username-thomas-solomon-at-gmail-com - username
    phone-password gmail-password new-password-vh-1r0 - password
    phone-token gmail-token - token
    thomas-solomon-at-gmail-com - email
    relationship-son - relationship
    son-phone-number - phone-number
    account-creation-message - message
    query-spotify-account query-spotify-password-reset-code - query
    verification-email reset-email - inbox-email
    verification-code reset-code - code)
  (:init
    (password-for phone phone-password)
    (password-for gmail gmail-password)
    (username-for phone username-2192158297)
    (username-for gmail username-thomas-solomon-at-gmail-com)
    (relationship-of son relationship-son)
    (phone-number-of son son-phone-number)
    (message-from account-creation-message son)
    (message-about account-creation-message thomas-spotify-account)
    (account-email thomas-spotify-account thomas-solomon-at-gmail-com)
    (verification-code-of thomas-spotify-account verification-code)
    (reset-code-of thomas-spotify-account reset-code)
    (query-finds query-spotify-account verification-email)
    (query-finds query-spotify-password-reset-code reset-email)
    (email-contains-code verification-email verification-code)
    (email-contains-code reset-email reset-code)
    (requested-password thomas-spotify-account new-password-vh-1r0))
  (:goal (and
    (account-verified thomas-spotify-account)
    (password-set thomas-spotify-account new-password-vh-1r0)
    (task-completed))))
