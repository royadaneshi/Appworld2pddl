(define (problem task-7d7fbf6-1)
  (:domain appworld-7d7fbf6-1)
  (:objects
    nicholas-weber-at-gmail-com - username
    file-system-password - password
    file-system-token - token
    flag-true - flag
    vacations-dir dir-athens dir-maui dir-stockholm dir-tokyo - directory
    zip-athens zip-maui zip-stockholm zip-tokyo - filepath
  )
  (:init
    (password-for file-system file-system-password)
    (supervisor-username nicholas-weber-at-gmail-com)
    (is-true flag-true)
    (sub-directory-of dir-athens vacations-dir)
    (sub-directory-of dir-maui vacations-dir)
    (sub-directory-of dir-stockholm vacations-dir)
    (sub-directory-of dir-tokyo vacations-dir)
    (zip-target dir-athens zip-athens)
    (zip-target dir-maui zip-maui)
    (zip-target dir-stockholm zip-stockholm)
    (zip-target dir-tokyo zip-tokyo))
  (:goal (and
    (archived dir-athens)
    (archived dir-maui)
    (archived dir-stockholm)
    (archived dir-tokyo)
    (task-completed)))
)
