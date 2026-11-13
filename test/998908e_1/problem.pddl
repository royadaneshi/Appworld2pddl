(define (problem task-998908e-1)
  (:domain appworld-998908e-1)
  (:objects
    lindsey - person
    lindseysimpson-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-hotel - query
    hotel-thread-1 hotel-thread-2 hotel-thread-3 - email-thread
    confirmation-attachment-1 confirmation-attachment-2 confirmation-attachment-3 - attachment
    receipt-file-1 receipt-file-2 receipt-file-3 - file-path
    total-mastercard-spend - amount
  )
  (:init
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (username-for gmail lindseysimpson-at-gmail-com)
    (username-for file-system lindseysimpson-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (matches-query hotel-thread-1 query-hotel)
    (matches-query hotel-thread-2 query-hotel)
    (matches-query hotel-thread-3 query-hotel)
    (attachment-of confirmation-attachment-1 hotel-thread-1)
    (attachment-of confirmation-attachment-2 hotel-thread-2)
    (attachment-of confirmation-attachment-3 hotel-thread-3)
    (download-path confirmation-attachment-1 receipt-file-1)
    (download-path confirmation-attachment-2 receipt-file-2)
    (download-path confirmation-attachment-3 receipt-file-3)
  )
  (:goal (and
    (read-receipt receipt-file-1)
    (read-receipt receipt-file-2)
    (read-receipt receipt-file-3)
    (task-completed)
  ))
)
