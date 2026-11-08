(define (problem task-b68eb83-3)
  (:domain appworld-b68eb83-3)
  (:objects
    jeffrey marcus - person
    phone-username gmail-username file-system-username - username
    phone-password gmail-password file-system-password - password
    phone-token gmail-token file-system-token - token
    query-marcus - query
    marcus-email - email
    trip-pictures-thread - thread
    trip-pictures-attachment - attachment
    trip-pictures-archive trip-pictures-dir - path
    recursive-true - flag
    most-pictured-location - location)
  (:init
    (username-for phone phone-username)
    (username-for gmail gmail-username)
    (username-for file-system file-system-username)
    (password-for phone phone-password)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (token-for phone phone-token)
    (token-for gmail gmail-token)
    (token-for file-system file-system-token)
    (query-for query-marcus marcus)
    (email-of marcus marcus-email)
    (thread-from trip-pictures-thread marcus)
    (attachment-in trip-pictures-attachment trip-pictures-thread)
    (archive-of trip-pictures-attachment trip-pictures-archive)
    (extract-dir trip-pictures-archive trip-pictures-dir)
    (recursive-flag recursive-true)
    (answer-slot most-pictured-location))
  (:goal (and
    (downloaded trip-pictures-attachment trip-pictures-archive)
    (decompressed trip-pictures-archive trip-pictures-dir)
    (found-most-pictures most-pictured-location)
    (task-completed)))
)
