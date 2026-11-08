(define (problem task-a53a8fd-3)
  (:domain appworld-a53a8fd-3)
  (:objects
    dillon-wilson - person
    diwils-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    employer-draft-1 employer-draft-2 employer-draft-3 - draft
    resume-pdf-path - path
    query-resume-pdf - query
    datetime-2023-05-14t00-00-00 - datetime
    flag-true - flag)
  (:init
    (username-for gmail diwils-at-gmail-com)
    (username-for file-system diwils-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (token-for gmail gmail-token)
    (token-for file-system file-system-token)
    (window-start datetime-2023-05-14t00-00-00)
    (locates query-resume-pdf resume-pdf-path)
    (flag-is-true flag-true)
    (recent-employer-draft employer-draft-1)
    (recent-employer-draft employer-draft-2)
    (recent-employer-draft employer-draft-3))
  (:goal (and (sent employer-draft-1)
              (sent employer-draft-2)
              (sent employer-draft-3)
              (task-completed))))
