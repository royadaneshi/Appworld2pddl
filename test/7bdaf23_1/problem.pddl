(define (problem task-7bdaf23-1)
  (:domain appworld-7bdaf23-1)
  (:objects
    marcus - person
    ma-smith-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-tokyo - query
    thread-tokyo-flight - thread
    email-tokyo-ticket - email-message
    tokyo-ticket-attachment - attachment
    tokyo - location
    date-this-weekend - flight-date
    path-downloads-ticket - path
  )
  (:init
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (thread-matches thread-tokyo-flight query-tokyo)
    (email-in-thread email-tokyo-ticket thread-tokyo-flight)
    (attachment-of tokyo-ticket-attachment email-tokyo-ticket)
    (ticket-to email-tokyo-ticket tokyo)
    (ticket-date email-tokyo-ticket date-this-weekend)
    (target-location tokyo)
    (this-weekend date-this-weekend)
    (downloads-folder path-downloads-ticket)
  )
  (:goal (and (downloaded tokyo-ticket-attachment path-downloads-ticket) (task-completed)))
)
