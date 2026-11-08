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
    body-talk-1 body-talk-2 body-talk-3 - body
    subject-talk-reminder - subject
    reminder-datetime-talk-1 reminder-datetime-talk-2 reminder-datetime-talk-3 - send-datetime)
  (:init
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
    (body-for talk-1 body-talk-1)
    (body-for talk-2 body-talk-2)
    (body-for talk-3 body-talk-3)
    (reminder-time-for talk-1 reminder-datetime-talk-1)
    (reminder-time-for talk-2 reminder-datetime-talk-2)
    (reminder-time-for talk-3 reminder-datetime-talk-3)
    (reminder-subject subject-talk-reminder))
  (:goal (and (draft-scheduled talk-1)
              (draft-scheduled talk-2)
              (draft-scheduled talk-3)
              (task-completed)))
)
