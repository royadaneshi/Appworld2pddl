(define (problem task-e70b117-1)
  (:domain appworld-e70b117-1)
  (:objects
    jonathan-ball manager - person
    jo-ball-at-gmail-com phone-2306532706 - username
    gmail-password phone-password file-system-password - password
    gmail-token phone-token file-system-token - token
    query-talk - query
    schedule-thread - email-thread
    relationship-coworker - relationship
    coworker-emails - recipients
    dir-documents-work - directory-path
    template-file - file-path
    subject-todays-talk - subject
    talk-1 talk-2 talk-3 talk-4 talk-5 talk-6 - talk
    send-at-friday-1-0800 send-at-friday-2-0800 send-at-friday-3-0800 send-at-friday-4-0800 send-at-friday-5-0800 send-at-friday-6-0800 - send-datetime
    body-talk-1 body-talk-2 body-talk-3 body-talk-4 body-talk-5 body-talk-6 - body
  )
  (:init
    (credential-of-app gmail jo-ball-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app phone phone-2306532706)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app file-system jo-ball-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (username-for gmail jo-ball-at-gmail-com)
    (username-for file-system jo-ball-at-gmail-com)
    (username-for phone phone-2306532706)
    (password-for gmail gmail-password)
    (password-for phone phone-password)
    (password-for file-system file-system-password)
    (required-subject subject-todays-talk)
    (talk-date talk-1 send-at-friday-1-0800)
    (talk-date talk-2 send-at-friday-2-0800)
    (talk-date talk-3 send-at-friday-3-0800)
    (talk-date talk-4 send-at-friday-4-0800)
    (talk-date talk-5 send-at-friday-5-0800)
    (talk-date talk-6 send-at-friday-6-0800)
    (talk-body talk-1 body-talk-1)
    (talk-body talk-2 body-talk-2)
    (talk-body talk-3 body-talk-3)
    (talk-body talk-4 body-talk-4)
    (talk-body talk-5 body-talk-5)
    (talk-body talk-6 body-talk-6))
  (:goal (and
    (draft-scheduled talk-1)
    (draft-scheduled talk-2)
    (draft-scheduled talk-3)
    (draft-scheduled talk-4)
    (draft-scheduled talk-5)
    (draft-scheduled talk-6)
    (task-completed)))
)
