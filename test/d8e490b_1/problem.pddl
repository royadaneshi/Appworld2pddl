(define (problem task-d8e490b-1)
  (:domain appworld-d8e490b-1)
  (:objects
    chad - person
    ch-brow-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-weekly-work-meeting - query
    home-dir - directory-path
    recursive-true - flag
    thread-weekly-work-meeting-2023-05-15 - email-thread
    attachment-slides attachment-recording - attachment
    path-slides-2023-05-15 path-recording-2023-05-15 - file-path)
  (:init
    (credential-of-app gmail ch-brow-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app file-system ch-brow-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (thread-matches query-weekly-work-meeting thread-weekly-work-meeting-2023-05-15)
    (attachment-of thread-weekly-work-meeting-2023-05-15 attachment-slides)
    (attachment-of thread-weekly-work-meeting-2023-05-15 attachment-recording)
    (slides attachment-slides)
    (recording attachment-recording)
    (target-path attachment-slides path-slides-2023-05-15)
    (target-path attachment-recording path-recording-2023-05-15))
  (:goal (and
    (saved attachment-slides path-slides-2023-05-15)
    (saved attachment-recording path-recording-2023-05-15)
    (task-completed)))
)
