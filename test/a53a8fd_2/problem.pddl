(define (problem task-a53a8fd-2)
  (:domain appworld-a53a8fd-2)
  (:objects
    glenn-burton - person
    glenn-burton-at-gmail-com - username
    gmail-password fs-password - password
    gmail-token fs-token - token
    draft-1 draft-2 draft-3 - draft
    cv-pdf-path - file-path
    substring-cv-pdf - substring
    flag-true - flag
    datetime-2023-05-15t12-00-00 - datetime
  )
  (:init
    (password-for gmail gmail-password)
    (password-for file-system fs-password)
    (username-for gmail glenn-burton-at-gmail-com)
    (username-for file-system glenn-burton-at-gmail-com)
    (token-for gmail gmail-token)
    (token-for file-system fs-token)
    (employer-draft draft-1)
    (employer-draft draft-2)
    (employer-draft draft-3)
    (resume-file cv-pdf-path)
    (file-matches substring-cv-pdf cv-pdf-path)
  )
  (:goal (and
    (resume-attached draft-1)
    (resume-attached draft-2)
    (resume-attached draft-3)
    (sent draft-1)
    (sent draft-2)
    (sent draft-3)
    (task-completed)
  ))
)
