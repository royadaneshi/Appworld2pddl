(define (problem task-29a7b7e-3)
  (:domain appworld-29a7b7e-3)
  (:objects
    sierra-white - person
    siwhit-at-gmail-com - username
    file-system-password - password
    file-system-token - token
    meetings-data-dir target-dir-a target-dir-b - dirpath
    source-path-1 source-path-2 source-path-3 - filepath
    target-path-1 target-path-2 target-path-3 - filepath
    meeting-file-1 meeting-file-2 meeting-file-3 - meeting-file)
  (:init
    (username-for file-system siwhit-at-gmail-com)
    (password-for file-system file-system-password)
    (meetings-directory meetings-data-dir)
    (directory-exists meetings-data-dir)
    (source-path meeting-file-1 source-path-1)
    (source-path meeting-file-2 source-path-2)
    (source-path meeting-file-3 source-path-3)
    (target-path meeting-file-1 target-path-1)
    (target-path meeting-file-2 target-path-2)
    (target-path meeting-file-3 target-path-3)
    (target-directory meeting-file-1 target-dir-a)
    (target-directory meeting-file-2 target-dir-a)
    (target-directory meeting-file-3 target-dir-b)
    (target-subdirectory target-dir-a)
    (target-subdirectory target-dir-b))
  (:goal (and (moved meeting-file-1)
              (moved meeting-file-2)
              (moved meeting-file-3)
              (task-completed)))
)
