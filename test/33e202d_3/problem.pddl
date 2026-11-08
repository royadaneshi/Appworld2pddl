(define (problem task-33e202d-3)
  (:domain appworld-33e202d-3)
  (:objects
    caitlin-burch - person
    applicant-1 - applicant
    caiburc-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-customer-support - query
    date-2023-04-20 - datetime
    thread-1 - thread
    attachment-1 - attachment
    path-applications-list-csv path-attachment-1 - path
    csv-content - content
  )
  (:init
    (username-for gmail caiburc-at-gmail-com)
    (username-for file-system caiburc-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (token-for gmail gmail-token)
    (token-for file-system file-system-token)
    (search-query query-customer-support)
    (search-min-date date-2023-04-20)
    (application-thread thread-1)
    (thread-of applicant-1 thread-1)
    (attachment-in attachment-1 thread-1)
    (csv-file path-applications-list-csv csv-content)
    (listed-in applicant-1 csv-content)
    (download-path attachment-1 path-attachment-1)
  )
  (:goal (and
    (file-created path-applications-list-csv csv-content)
    (attachment-downloaded attachment-1 path-attachment-1)
    (task-completed)
  ))
)
