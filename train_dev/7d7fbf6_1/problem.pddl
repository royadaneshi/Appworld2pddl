(define (problem task-7d7fbf6-1)
  (:domain appworld-7d7fbf6-1)
  (:objects
    nicholas-weber-at-gmail-com - username
    file-system-password - password
    file-system-token - token
    vacations-dir spot-dir-1 spot-dir-2 spot-dir-3 - directory
    spot-zip-1 spot-zip-2 spot-zip-3 - filepath
    flag-true - flag
  )
  (:init
    (password-for file-system file-system-password)
    (supervisor-username nicholas-weber-at-gmail-com)
    (sub-directory-of spot-dir-1 vacations-dir)
    (sub-directory-of spot-dir-2 vacations-dir)
    (sub-directory-of spot-dir-3 vacations-dir)
    (zip-target spot-dir-1 spot-zip-1)
    (zip-target spot-dir-2 spot-zip-2)
    (zip-target spot-dir-3 spot-zip-3)
    (is-true flag-true)
  )
  (:goal (and
    (archived spot-dir-1)
    (archived spot-dir-2)
    (archived spot-dir-3)
    (task-completed)
  ))
)
