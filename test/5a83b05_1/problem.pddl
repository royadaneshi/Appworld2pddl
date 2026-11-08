(define (problem task-5a83b05-1)
  (:domain appworld-5a83b05-1)
  (:objects
    jeffrey-smith - person
    jefsmith-at-gmail-com - username
    file-system-password - password
    file-system-token - token
    dir-downloads - directory-path
    substring-pdf - substring
    pdf-file-1 pdf-file-2 - file-path)
  (:init
    (password-for file-system file-system-password)
    (file-in pdf-file-1 dir-downloads)
    (file-in pdf-file-2 dir-downloads)
    (has-extension pdf-file-1 substring-pdf)
    (has-extension pdf-file-2 substring-pdf))
  (:goal (and (deleted pdf-file-1)
              (deleted pdf-file-2)
              (task-completed)))
)
