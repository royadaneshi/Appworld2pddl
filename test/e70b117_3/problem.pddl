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
    body-talk-1 body-talk-2 body-talk-3 body-talk-4 body-talk-5 body-talk-6 body-talk-7 body-talk-8 - body
  )
  (:init
    (credential-of-app gmail anita-burch-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app file-system anita-burch-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
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
    (body-for reminder-datetime-1 body-talk-1)
    (body-for reminder-datetime-2 body-talk-2)
    (body-for reminder-datetime-3 body-talk-3)
    (body-for reminder-datetime-4 body-talk-4)
    (body-for reminder-datetime-5 body-talk-5)
    (body-for reminder-datetime-6 body-talk-6)
    (body-for reminder-datetime-7 body-talk-7)
    (body-for reminder-datetime-8 body-talk-8))
  (:goal (and
    (draft-scheduled reminder-datetime-1)
    (draft-scheduled reminder-datetime-2)
    (draft-scheduled reminder-datetime-3)
    (draft-scheduled reminder-datetime-4)
    (draft-scheduled reminder-datetime-5)
    (draft-scheduled reminder-datetime-6)
    (draft-scheduled reminder-datetime-7)
    (draft-scheduled reminder-datetime-8)
    (task-completed)))
)
