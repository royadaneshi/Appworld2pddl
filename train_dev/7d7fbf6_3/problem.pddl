(define (problem task-7d7fbf6-3)
  (:domain appworld-7d7fbf6-3)
  (:objects
    adrian-burt-at-gmail-com - username
    file-system-password - password
    file-system-token - token
    pictures-vacations-dir - directory
    flag-true flag-false - flag)
  (:init
    (username-for file-system adrian-burt-at-gmail-com)
    (password-for file-system file-system-password)
    (vacations-root pictures-vacations-dir)
    (subdirectory-of pictures-vacations-dir vacation-dir-1)
    (subdirectory-of pictures-vacations-dir vacation-dir-2)
    (subdirectory-of pictures-vacations-dir vacation-dir-3)
    (zip-target vacation-dir-1 vacation-zip-1)
    (zip-target vacation-dir-2 vacation-zip-2)
    (zip-target vacation-dir-3 vacation-zip-3)
    (is-true flag-true)
    (is-false flag-false))
  (:goal (and
    (compressed vacation-dir-1 vacation-zip-1) (directory-deleted vacation-dir-1)
    (compressed vacation-dir-2 vacation-zip-2) (directory-deleted vacation-dir-2)
    (compressed vacation-dir-3 vacation-zip-3) (directory-deleted vacation-dir-3)
    (task-completed)))
)
