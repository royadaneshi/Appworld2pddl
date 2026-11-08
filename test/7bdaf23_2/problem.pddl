(define (problem task-7bdaf23-2)
  (:domain appworld-7bdaf23-2)
  (:objects
    morgan - person
    morgan-harrison-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-santorini - query
    santorini-flight-thread - email-thread
    santorini-ticket-email - email
    santorini-ticket-attachment - attachment
    documents-personal-dir - path
  )
  (:init
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (token-of gmail gmail-token)
    (token-of file-system file-system-token)
    (thread-matches santorini-flight-thread query-santorini)
    (thread-has-email santorini-flight-thread santorini-ticket-email)
    (email-has-attachment santorini-ticket-email santorini-ticket-attachment)
    (is-santorini-weekend-ticket santorini-ticket-attachment)
    (download-dir documents-personal-dir)
  )
  (:goal (and
    (downloaded santorini-ticket-attachment documents-personal-dir)
    (task-completed)
  ))
)
