(define (problem task-906f2c7-2)
  (:domain appworld-906f2c7-2)
  (:objects
    jose - person
    jose-phone-username joseharr-at-gmail-com - username
    phone-password file-system-password gmail-password - password
    phone-token file-system-token gmail-token - token
    query-lindsey - query
    lindsey-phone-number - phone-number
    lindsey-email - email-address
    lindsey-message - text-message
    substring-vacation - substring
    subject-vacation-pictures - subject
    body-vacation-pictures - body)
  (:init
    (username-for phone jose-phone-username)
    (username-for file-system joseharr-at-gmail-com)
    (username-for gmail joseharr-at-gmail-com)
    (password-for phone phone-password)
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (token-of phone phone-token)
    (token-of file-system file-system-token)
    (token-of gmail gmail-token)
    (query-for query-lindsey lindsey)
    (phone-number-of lindsey lindsey-phone-number)
    (email-of lindsey lindsey-email)
    (message-from lindsey-message lindsey)
    (message-about-file lindsey-message vacation-pictures-file)
    (substring-for substring-vacation vacation-pictures-file))
  (:goal (and (email-sent lindsey vacation-pictures-file) (task-completed)))
)
