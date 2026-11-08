(define (problem task-5a83b05-2)
  (:domain appworld-5a83b05-2)
  (:objects
    david - person
    dav-mart-at-gmail-com - username
    file-system-password - password
    file-system-token - token
    dir-downloads - dirpath
    substring-jpg - substring
    jpg-file-1 jpg-file-2 - filepath)
  (:init
    (password-for file-system file-system-password)
    (jpg-filter substring-jpg)
    (in-directory jpg-file-1 dir-downloads)
    (in-directory jpg-file-2 dir-downloads)
    (is-jpg jpg-file-1)
    (is-jpg jpg-file-2))
  (:goal (and (deleted jpg-file-1) (deleted jpg-file-2) (task-completed))))
