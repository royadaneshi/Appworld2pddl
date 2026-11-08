(define (problem task-a97e35d-2)
  (:domain appworld-a97e35d-2)
  (:objects
    eric - person
    selected-candidate-1 selected-candidate-2 rejected-candidate-1 rejected-candidate-2 - candidate
    eric-bailey-at-gmail-com - username
    file-system-password gmail-password - password
    file-system-token gmail-token - token
    hiring-dir - directory
    candidates-list-file acceptance-template-file rejection-template-file offer-letter-template-file - file
    offer-letter-file-selected-1 offer-letter-file-selected-2 no-attachment - attachment
    thread-selected-1 thread-selected-2 thread-rejected-1 thread-rejected-2 - thread
    email-selected-1 email-selected-2 email-rejected-1 email-rejected-2 - email
    acceptance-body-selected-1 acceptance-body-selected-2 rejection-body-rejected-1 rejection-body-rejected-2 - body
    offer-letter-content-selected-1 offer-letter-content-selected-2 - content
    query-graphic-designer - query
    datetime-2023-04-27t00-00-00 - datetime
  )
  (:init
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (token-of file-system file-system-token)
    (token-of gmail gmail-token)
    (in-directory candidates-list-file hiring-dir)
    (in-directory acceptance-template-file hiring-dir)
    (in-directory rejection-template-file hiring-dir)
    (in-directory offer-letter-template-file hiring-dir)
    (candidates-list candidates-list-file)
    (offer-letter-template offer-letter-template-file)
    (template-for acceptance-template-file selected-candidate-1)
    (template-for acceptance-template-file selected-candidate-2)
    (template-for rejection-template-file rejected-candidate-1)
    (template-for rejection-template-file rejected-candidate-2)
    (selected selected-candidate-1)
    (selected selected-candidate-2)
    (rejected rejected-candidate-1)
    (rejected rejected-candidate-2)
    (search-query query-graphic-designer)
    (search-since datetime-2023-04-27t00-00-00)
    (application-thread thread-selected-1 selected-candidate-1)
    (application-thread thread-selected-2 selected-candidate-2)
    (application-thread thread-rejected-1 rejected-candidate-1)
    (application-thread thread-rejected-2 rejected-candidate-2)
    (email-in-thread email-selected-1 thread-selected-1)
    (email-in-thread email-selected-2 thread-selected-2)
    (email-in-thread email-rejected-1 thread-rejected-1)
    (email-in-thread email-rejected-2 thread-rejected-2)
    (reply-body acceptance-body-selected-1 selected-candidate-1)
    (reply-body acceptance-body-selected-2 selected-candidate-2)
    (reply-body rejection-body-rejected-1 rejected-candidate-1)
    (reply-body rejection-body-rejected-2 rejected-candidate-2)
    (offer-letter-path offer-letter-file-selected-1 selected-candidate-1)
    (offer-letter-path offer-letter-file-selected-2 selected-candidate-2)
    (offer-letter-content offer-letter-content-selected-1 selected-candidate-1)
    (offer-letter-content offer-letter-content-selected-2 selected-candidate-2)
    (attachment-for offer-letter-file-selected-1 selected-candidate-1)
    (attachment-for offer-letter-file-selected-2 selected-candidate-2)
    (attachment-for no-attachment rejected-candidate-1)
    (attachment-for no-attachment rejected-candidate-2)
    (attachment-ready no-attachment)
  )
  (:goal (and
    (replied selected-candidate-1)
    (replied selected-candidate-2)
    (replied rejected-candidate-1)
    (replied rejected-candidate-2)
    (task-completed)
  ))
)
