(define (problem task-b68eb83-1)
  (:domain appworld-b68eb83-1)
  (:objects
    hunter kayla - person
    hun-weaver-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-kayla - query
    kayla-email - email
    kayla-trip-pictures-thread - thread
    kayla-trip-pictures-email - email-msg
    trip-pictures-attachment - attachment
    downloads-trip-pictures-zip - file-path
    downloads-trip-pictures-dir - directory-path
    most-pictured-location - location
    flag-true - flag)
  (:init
    (username-for gmail hun-weaver-at-gmail-com)
    (username-for file-system hun-weaver-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (token-of gmail gmail-token)
    (token-of file-system file-system-token)
    (query-for query-kayla kayla)
    (sender-of kayla-trip-pictures-thread kayla)
    (in-thread kayla-trip-pictures-email kayla-trip-pictures-thread)
    (attached-to trip-pictures-attachment kayla-trip-pictures-email))
  (:goal (and (found-most-pictures-location most-pictured-location) (task-completed))))
