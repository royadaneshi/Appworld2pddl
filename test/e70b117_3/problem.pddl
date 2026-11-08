(define (problem task-e70b117-3)
  (:domain appworld-e70b117-3)
  (:objects
    anita - person
    anita-burch-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-talk - query
    schedule-email-thread - email-thread
    dir-documents-work-docs - directory-path
    talk-reminder-template-file - file-path
    all-company-members - recipient-list
    subject-reminder-for-the-talk-today - subject
    body-2023-05-24 body-2023-05-31 body-2023-06-07 body-2023-06-14 - body
  )
  (:init
    (username-for gmail anita-burch-at-gmail-com)
    (username-for file-system anita-burch-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (schedule-query query-talk)
    (schedule-thread schedule-email-thread)
    (company-members all-company-members)
    (in-directory talk-reminder-template-file dir-documents-work-docs)
    (template-file talk-reminder-template-file)
    (reminder-subject subject-reminder-for-the-talk-today)
    (body-for dt-2023-05-24t13-00-00 body-2023-05-24)
    (body-for dt-2023-05-31t13-00-00 body-2023-05-31)
    (body-for dt-2023-06-07t13-00-00 body-2023-06-07)
    (body-for dt-2023-06-14t13-00-00 body-2023-06-14)
  )
  (:goal (and
    (draft-scheduled dt-2023-05-24t13-00-00)
    (draft-scheduled dt-2023-05-31t13-00-00)
    (draft-scheduled dt-2023-06-07t13-00-00)
    (draft-scheduled dt-2023-06-14t13-00-00)
    (task-completed)
  ))
)
