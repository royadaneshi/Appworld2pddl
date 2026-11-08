(define (problem task-29a7b7e-1)
  (:domain appworld-29a7b7e-1)
  (:objects
    catherine-smith - person
    ca-smit-at-gmail-com - username
    file-system-password - password
    file-system-token - token
    meetings-dir dst-dir-1 dst-dir-2 dst-dir-3 - dirpath
    src-path-1 src-path-2 src-path-3 dst-path-1 dst-path-2 dst-path-3 - filepath)
  (:init
    (password-for file-system file-system-password)
    (dir-exists meetings-dir)
    (in-directory meeting-file-1 meetings-dir)
    (in-directory meeting-file-2 meetings-dir)
    (in-directory meeting-file-3 meetings-dir)
    (source-path meeting-file-1 src-path-1)
    (source-path meeting-file-2 src-path-2)
    (source-path meeting-file-3 src-path-3)
    (dest-path meeting-file-1 dst-path-1)
    (dest-path meeting-file-2 dst-path-2)
    (dest-path meeting-file-3 dst-path-3)
    (dest-dir meeting-file-1 dst-dir-1)
    (dest-dir meeting-file-2 dst-dir-2)
    (dest-dir meeting-file-3 dst-dir-3)
    (parent-dir dst-dir-1 meetings-dir)
    (parent-dir dst-dir-2 meetings-dir)
    (parent-dir dst-dir-3 meetings-dir))
  (:goal (and
    (reorganized meeting-file-1)
    (reorganized meeting-file-2)
    (reorganized meeting-file-3)
    (task-completed))))
