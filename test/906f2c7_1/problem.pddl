(define (problem task-906f2c7-1)
  (:domain appworld-906f2c7-1)
  (:objects
    jacob leslie - person
    jacob-phone-username jacob-email-username - username
    phone-password file-system-password gmail-password - password
    phone-token file-system-token gmail-token - token
    query-leslie - query
    leslie-phone-number - phone-number
    leslie-email - email
    leslie-message - text-message
    vacation-pictures-directory - directory-path
    vacation-pictures-file - file-path
    subject-vacation-pictures - subject
    body-vacation-pictures - body)
  (:init
    (username-for phone jacob-phone-username)
    (username-for file-system jacob-email-username)
    (username-for gmail jacob-email-username)
    (password-for phone phone-password)
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (token-of phone phone-token)
    (token-of file-system file-system-token)
    (token-of gmail gmail-token)
    (query-for query-leslie leslie))
  (:goal (and (email-sent leslie vacation-pictures-file) (task-completed)))
)
