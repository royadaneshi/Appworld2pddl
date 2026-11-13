(define (problem task-a53a8fd-1)
  (:domain appworld-a53a8fd-1)
  (:objects
    vickie-powell - person
    vicpowe-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    resume-pdf - file-path
    query-resume-pdf - query
    true - bool
    min-created-2023-05-16 - datetime)
  (:init
    (credential-of-app gmail vicpowe-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app file-system vicpowe-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (resume-file resume-pdf)
    (employer-draft draft-1)
    (employer-draft draft-2)
    (employer-draft draft-3)
    (employer-draft draft-4)
    (employer-draft draft-5))
  (:goal (and
    (sent draft-1)
    (sent draft-2)
    (sent draft-3)
    (sent draft-4)
    (sent draft-5)
    (task-completed))))
