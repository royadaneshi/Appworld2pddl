(define (problem task-a97e35d-1)
  (:domain appworld-a97e35d-1)
  (:objects
    david-martinez - person
    candidate-a candidate-b candidate-c candidate-d - candidate
    dav-mart-at-gmail-com - username
    file-system-password gmail-password - password
    file-system-token gmail-token - token
    recruiting-dir - directory
    selected-candidates-file - selection-list
    acceptance-email-template - acceptance-template
    rejection-email-template - rejection-template
    offer-letter-template - offer-template
    offer-letter-candidate-a offer-letter-candidate-b - offer-letter
    no-attachment - attachment
    offer-content-candidate-a offer-content-candidate-b - content
    acceptance-body-candidate-a acceptance-body-candidate-b rejection-body-candidate-c rejection-body-candidate-d - body
    query-software-engineer - query
    datetime-2023-05-04t00-00-00 - datetime
    thread-candidate-a thread-candidate-b thread-candidate-c thread-candidate-d - thread
    email-candidate-a email-candidate-b email-candidate-c email-candidate-d - email
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
    (selected candidate-a)
    (selected candidate-b)
    (attachment-for offer-letter-candidate-a candidate-a)
    (attachment-for offer-letter-candidate-b candidate-b)
    (attachment-for no-attachment candidate-c)
    (attachment-for no-attachment candidate-d)
    (attachment-ready no-attachment)
    (offer-content-for offer-content-candidate-a candidate-a)
    (offer-content-for offer-content-candidate-b candidate-b)
    (body-for acceptance-body-candidate-a candidate-a)
    (body-for acceptance-body-candidate-b candidate-b)
    (body-for rejection-body-candidate-c candidate-c)
    (body-for rejection-body-candidate-d candidate-d)
    (body-from-template acceptance-body-candidate-a acceptance-email-template)
    (body-from-template acceptance-body-candidate-b acceptance-email-template)
    (body-from-template rejection-body-candidate-c rejection-email-template)
    (body-from-template rejection-body-candidate-d rejection-email-template)
    (application-email candidate-a email-candidate-a thread-candidate-a)
    (application-email candidate-b email-candidate-b thread-candidate-b)
    (application-email candidate-c email-candidate-c thread-candidate-c)
    (application-email candidate-d email-candidate-d thread-candidate-d)
  )
  (:goal (and
    (replied candidate-a)
    (replied candidate-b)
    (replied candidate-c)
    (replied candidate-d)
    (task-completed)
  ))
)
