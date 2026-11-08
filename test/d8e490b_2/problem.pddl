(define (problem task-d8e490b-2)
  (:domain appworld-d8e490b-2)
  (:objects
    gina-burch - person
    gina-ritter-at-gmail-com - username
    password-file-system password-gmail - password
    token-file-system token-gmail - token
    query-weekly-work-meeting - query
    dir-home - dir-path
    flag-true - flag
    thread-weekly-work-meeting-2023-05-16 - email-thread
  )
  (:init
    (password-for file-system password-file-system)
    (password-for gmail password-gmail)
    (thread-matches query-weekly-work-meeting thread-weekly-work-meeting-2023-05-16)
    (attached-to attachment-slides thread-weekly-work-meeting-2023-05-16)
    (attached-to attachment-recording thread-weekly-work-meeting-2023-05-16)
    (target-path attachment-slides path-slides-2023-05-16)
    (target-path attachment-recording path-recording-2023-05-16)
  )
  (:goal (and
    (downloaded attachment-slides path-slides-2023-05-16)
    (downloaded attachment-recording path-recording-2023-05-16)
    (task-completed)
  ))
)
