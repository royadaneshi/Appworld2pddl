(define (problem task-5a83b05-3)
  (:domain appworld-5a83b05-3)
  (:objects
    susan - person
    susanmiller-at-gmail-com - username
    file-system-password - password
    file-system-token - token
    dir-home-downloads - directory
    substring-dot-pdf - substring
    pdf-file-1 pdf-file-2 - file)
  (:init
    (password-for file-system file-system-password)
    (in-directory pdf-file-1 dir-home-downloads)
    (in-directory pdf-file-2 dir-home-downloads)
    (is-pdf pdf-file-1)
    (is-pdf pdf-file-2))
  (:goal (and (deleted pdf-file-1)
              (deleted pdf-file-2)
              (task-completed)))
)
