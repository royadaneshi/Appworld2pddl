(define (problem task-7d7fbf6-2)
  (:domain appworld-7d7fbf6-2)
  (:objects
    jason-simpson - person
    jasonsimp-at-gmail-com - username
    file-system-password - password
    file-system-token - token
    vacations-dir - dirpath
    flag-true - flag
  )
  (:init
    (username-for file-system jasonsimp-at-gmail-com)
    (password-for file-system file-system-password)
    (is-true flag-true)
    (subdir-of dir-bali vacations-dir)
    (subdir-of dir-barcelona vacations-dir)
    (subdir-of dir-kyoto vacations-dir)
    (subdir-of dir-maldives vacations-dir)
    (tar-path-for dir-bali tar-bali)
    (tar-path-for dir-barcelona tar-barcelona)
    (tar-path-for dir-kyoto tar-kyoto)
    (tar-path-for dir-maldives tar-maldives))
  (:goal (and
    (compressed-to dir-bali tar-bali)
    (directory-deleted dir-bali)
    (compressed-to dir-barcelona tar-barcelona)
    (directory-deleted dir-barcelona)
    (compressed-to dir-kyoto tar-kyoto)
    (directory-deleted dir-kyoto)
    (compressed-to dir-maldives tar-maldives)
    (directory-deleted dir-maldives)
    (task-completed)))
)
