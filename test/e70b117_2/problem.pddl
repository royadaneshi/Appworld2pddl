(define (problem task-e70b117-2)
  (:domain appworld-e70b117-2)
  (:objects
    username-masmith-at-gmail-com username-6202220566 - username
    password-gmail password-file-system password-phone - password
    token-gmail token-file-system token-phone - token
    query-schedule - query
    schedule-email-thread - email-thread
    dir-documents-work-stuff - directory
    talk-reminder-template-file - file
    relationship-coworker - relationship
    coworker-emails - recipient-list
    body-talk-1 body-talk-2 body-talk-3 body-talk-4 body-talk-5 body-talk-6 body-talk-7 - body
    subject-talk-reminder - subject
    reminder-datetime-talk-1 reminder-datetime-talk-2 reminder-datetime-talk-3 reminder-datetime-talk-4 reminder-datetime-talk-5 reminder-datetime-talk-6 reminder-datetime-talk-7 - send-datetime
  )
  (:init
    (credential-of-app phone username-6202220566)
    (credential-of-app phone password-phone)
    (credential-of-app phone token-phone)
    (credential-of-app gmail username-masmith-at-gmail-com)
    (credential-of-app gmail password-gmail)
    (credential-of-app gmail token-gmail)
    (credential-of-app file-system username-masmith-at-gmail-com)
    (credential-of-app file-system password-file-system)
    (credential-of-app file-system token-file-system)
    (username-for gmail username-masmith-at-gmail-com)
    (username-for file-system username-masmith-at-gmail-com)
    (username-for phone username-6202220566)
    (password-for gmail password-gmail)
    (password-for file-system password-file-system)
    (password-for phone password-phone)
    (contacts-of-relationship relationship-coworker coworker-emails)
    (thread-matches query-schedule schedule-email-thread)
    (schedule-thread schedule-email-thread)
    (file-in-directory talk-reminder-template-file dir-documents-work-stuff)
    (template-file talk-reminder-template-file)
    (in-schedule talk-1)
    (in-schedule talk-2)
    (in-schedule talk-3)
    (in-schedule talk-4)
    (in-schedule talk-5)
    (in-schedule talk-6)
    (in-schedule talk-7)
    (body-for talk-1 body-talk-1)
    (body-for talk-2 body-talk-2)
    (body-for talk-3 body-talk-3)
    (body-for talk-4 body-talk-4)
    (body-for talk-5 body-talk-5)
    (body-for talk-6 body-talk-6)
    (body-for talk-7 body-talk-7)
    (reminder-time-for talk-1 reminder-datetime-talk-1)
    (reminder-time-for talk-2 reminder-datetime-talk-2)
    (reminder-time-for talk-3 reminder-datetime-talk-3)
    (reminder-time-for talk-4 reminder-datetime-talk-4)
    (reminder-time-for talk-5 reminder-datetime-talk-5)
    (reminder-time-for talk-6 reminder-datetime-talk-6)
    (reminder-time-for talk-7 reminder-datetime-talk-7)
    (reminder-subject subject-talk-reminder))
  (:goal (and
    (draft-scheduled talk-1)
    (draft-scheduled talk-2)
    (draft-scheduled talk-3)
    (draft-scheduled talk-4)
    (draft-scheduled talk-5)
    (draft-scheduled talk-6)
    (draft-scheduled talk-7)
    (task-completed)))
)
