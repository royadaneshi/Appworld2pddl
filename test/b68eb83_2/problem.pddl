(define (problem task-b68eb83-2)
  (:domain appworld-b68eb83-2)
  (:objects
    anthony melissa - person
    an-harrison-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-pictures - query
    melissa-trip-pictures-thread - email-thread
    trip-pictures-zip - attachment
    trip-pictures-zip-path - file-path
    trip-pictures-dir - directory
    least-pictures-location - location)
  (:init
    (username-for gmail an-harrison-at-gmail-com)
    (username-for file-system an-harrison-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (token-of gmail gmail-token)
    (token-of file-system file-system-token)
    (thread-from melissa-trip-pictures-thread melissa)
    (thread-matches melissa-trip-pictures-thread query-pictures)
    (attachment-in-thread trip-pictures-zip melissa-trip-pictures-thread)
    (saves-to trip-pictures-zip trip-pictures-zip-path)
    (decompresses-to trip-pictures-zip-path trip-pictures-dir)
    (trip-folders-in trip-pictures-dir))
  (:goal (and (found-least-pictures least-pictures-location) (task-completed))))
