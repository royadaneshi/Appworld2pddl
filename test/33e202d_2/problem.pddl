(define (problem task-33e202d-2)
  (:domain appworld-33e202d-2)
  (:objects
    dav-mart-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-marketing-manager - query
    datetime-2023-04-27t00-00-00 - datetime
    application-thread - email-thread
    marketing-manager-applicant - applicant
    application-attachment - attachment
    path-attachment-download path-applications-csv - path
    content-applications-csv - content
  )
  (:init
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (position-query query-marketing-manager)
    (window-start datetime-2023-04-27t00-00-00)
    (thread-of application-thread marketing-manager-applicant)
    (attachment-of application-attachment marketing-manager-applicant)
    (download-path-for application-attachment path-attachment-download)
    (csv-file path-applications-csv content-applications-csv)
    (csv-source content-applications-csv marketing-manager-applicant)
  )
  (:goal (and
    (applications-csv-created)
    (attachments-downloaded)
    (task-completed)
  ))
)
