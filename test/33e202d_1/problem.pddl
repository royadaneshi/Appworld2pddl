(define (problem task-33e202d-1)
  (:domain appworld-33e202d-1)
  (:objects
    brandon - person
    brandon-webe-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-sales-manager - query
    datetime-2023-05-04t00-00-00 - datetime
    application-thread - email-thread
    sales-manager-applicant - applicant
    application-attachment - attachment
    path-attachment-file path-job-applications-csv - file-path
    csv-content-job-applications - content)
  (:init
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (thread-matches application-thread query-sales-manager)
    (application-of application-thread sales-manager-applicant)
    (attachment-of application-attachment sales-manager-applicant)
    (download-path application-attachment path-attachment-file)
    (csv-spec path-job-applications-csv csv-content-job-applications)
    (csv-covers csv-content-job-applications sales-manager-applicant))
  (:goal (and
    (downloaded application-attachment path-attachment-file)
    (file-created path-job-applications-csv csv-content-job-applications)
    (task-completed)))
)
