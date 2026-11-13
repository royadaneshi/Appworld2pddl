(define (problem task-a97e35d-1)
  (:domain appworld-a97e35d-1)
  (:objects
    david-martinez - person
    candidate-1 candidate-2 candidate-3 candidate-4 candidate-5 candidate-6 candidate-7 - candidate
    dav-mart-at-gmail-com - username
    file-system-password gmail-password - password
    file-system-token gmail-token - token
    recruiting-dir - directory
    selected-candidates-file - selection-list
    acceptance-email-template - acceptance-template
    rejection-email-template - rejection-template
    offer-letter-template - offer-template
    offer-letter-1 offer-letter-2 offer-letter-3 - offer-letter
    no-attachment - attachment
    offer-content-candidate-1 offer-content-candidate-2 offer-content-candidate-3 - content
    acceptance-body-candidate-1 acceptance-body-candidate-2 acceptance-body-candidate-3 rejection-body-candidate-1 rejection-body-candidate-2 rejection-body-candidate-3 rejection-body-candidate-4 - body
    query-software-engineer - query
    datetime-2023-05-04t00-00-00 - datetime
    thread-candidate-1 thread-candidate-2 thread-candidate-3 thread-candidate-4 thread-candidate-5 thread-candidate-6 thread-candidate-7 - thread
    email-candidate-1 email-candidate-2 email-candidate-3 email-candidate-4 email-candidate-5 email-candidate-6 email-candidate-7 - email
  )
  (:init
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (token-for-app file-system file-system-token)
    (token-for-app gmail gmail-token)
    (recruiting-directory recruiting-dir)
    (in-directory selected-candidates-file recruiting-dir)
    (in-directory acceptance-email-template recruiting-dir)
    (in-directory rejection-email-template recruiting-dir)
    (in-directory offer-letter-template recruiting-dir)
    (position-query query-software-engineer)
    (cutoff-datetime datetime-2023-05-04t00-00-00)
    (selected candidate-1)
    (selected candidate-2)
    (selected candidate-3)
    (attachment-for offer-letter-1 candidate-1)
    (attachment-for offer-letter-2 candidate-2)
    (attachment-for offer-letter-3 candidate-3)
    (attachment-for no-attachment candidate-4)
    (attachment-for no-attachment candidate-5)
    (attachment-for no-attachment candidate-6)
    (attachment-for no-attachment candidate-7)
    (attachment-ready no-attachment)
    (offer-content-for offer-content-candidate-1 candidate-1)
    (offer-content-for offer-content-candidate-2 candidate-2)
    (offer-content-for offer-content-candidate-3 candidate-3)
    (body-for acceptance-body-candidate-1 candidate-1)
    (body-for acceptance-body-candidate-2 candidate-2)
    (body-for acceptance-body-candidate-3 candidate-3)
    (body-for rejection-body-candidate-1 candidate-4)
    (body-for rejection-body-candidate-2 candidate-5)
    (body-for rejection-body-candidate-3 candidate-6)
    (body-for rejection-body-candidate-4 candidate-7)
    (body-from-template acceptance-body-candidate-1 acceptance-email-template)
    (body-from-template acceptance-body-candidate-2 acceptance-email-template)
    (body-from-template acceptance-body-candidate-3 acceptance-email-template)
    (body-from-template rejection-body-candidate-1 rejection-email-template)
    (body-from-template rejection-body-candidate-2 rejection-email-template)
    (body-from-template rejection-body-candidate-3 rejection-email-template)
    (body-from-template rejection-body-candidate-4 rejection-email-template)
    (application-email candidate-1 email-candidate-1 thread-candidate-1)
    (application-email candidate-2 email-candidate-2 thread-candidate-2)
    (application-email candidate-3 email-candidate-3 thread-candidate-3)
    (application-email candidate-4 email-candidate-4 thread-candidate-4)
    (application-email candidate-5 email-candidate-5 thread-candidate-5)
    (application-email candidate-6 email-candidate-6 thread-candidate-6)
    (application-email candidate-7 email-candidate-7 thread-candidate-7))
  (:goal (and
    (replied candidate-1)
    (replied candidate-2)
    (replied candidate-3)
    (replied candidate-4)
    (replied candidate-5)
    (replied candidate-6)
    (replied candidate-7)
    (task-completed)))
)
