(define (problem task-d8e490b-3)
  (:domain appworld-d8e490b-3)
  (:objects
    cody - person
    cod-smith-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-weekly-work-meeting - query
    home-dir - directory-path
    flag-true - flag
    thread-weekly-work-meeting-2023-05-17 - email-thread
    slides-attachment recording-attachment - attachment
    slides-file-path recording-file-path - file-path)
  (:init
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (username-for gmail cod-smith-at-gmail-com)
    (username-for file-system cod-smith-at-gmail-com)
    (token-for gmail gmail-token)
    (token-for file-system file-system-token)
    (matches-query query-weekly-work-meeting thread-weekly-work-meeting-2023-05-17)
    (attached-to slides-attachment thread-weekly-work-meeting-2023-05-17)
    (attached-to recording-attachment thread-weekly-work-meeting-2023-05-17)
    (is-slides slides-attachment)
    (is-recording recording-attachment)
    (target-path slides-attachment slides-file-path)
    (target-path recording-attachment recording-file-path))
  (:goal (and
    (saved slides-attachment slides-file-path)
    (saved recording-attachment recording-file-path)
    (task-completed))))
