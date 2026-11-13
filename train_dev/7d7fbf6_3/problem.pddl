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
    (is-true flag-true)
    (is-false flag-false)
    (subdirectory-of pictures-vacations-dir dir-bali)
    (subdirectory-of pictures-vacations-dir dir-maui)
    (subdirectory-of pictures-vacations-dir dir-santorini)
    (subdirectory-of pictures-vacations-dir dir-seoul)
    (zip-target dir-bali zip-bali)
    (zip-target dir-maui zip-maui)
    (zip-target dir-santorini zip-santorini)
    (zip-target dir-seoul zip-seoul))
  (:goal (and
    (compressed dir-bali zip-bali)
    (directory-deleted dir-bali)
    (compressed dir-maui zip-maui)
    (directory-deleted dir-maui)
    (compressed dir-santorini zip-santorini)
    (directory-deleted dir-santorini)
    (compressed dir-seoul zip-seoul)
    (directory-deleted dir-seoul)
    (task-completed)))
)
