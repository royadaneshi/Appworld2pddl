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
    (subdir-of spot-dir-1 vacations-dir)
    (subdir-of spot-dir-2 vacations-dir)
    (subdir-of spot-dir-3 vacations-dir)
    (subdir-of spot-dir-4 vacations-dir)
    (tar-path-for spot-dir-1 spot-tar-1)
    (tar-path-for spot-dir-2 spot-tar-2)
    (tar-path-for spot-dir-3 spot-tar-3)
    (tar-path-for spot-dir-4 spot-tar-4))
  (:goal (and
    (compressed-to spot-dir-1 spot-tar-1)
    (directory-deleted spot-dir-1)
    (compressed-to spot-dir-2 spot-tar-2)
    (directory-deleted spot-dir-2)
    (compressed-to spot-dir-3 spot-tar-3)
    (directory-deleted spot-dir-3)
    (compressed-to spot-dir-4 spot-tar-4)
    (directory-deleted spot-dir-4)
    (task-completed)))
)
