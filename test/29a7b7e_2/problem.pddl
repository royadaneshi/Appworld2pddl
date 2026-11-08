(define (problem task-29a7b7e-2)
  (:domain appworld-29a7b7e-2)
  (:objects
    adam-blackburn - person
    ad-blackburn-at-gmail-com - username
    file-system-password - password
    file-system-token - token
    meetings-files-dir - dirpath
    file-name-dir - dirpath
    date-file-name-ext-path - filepath
    file-name-date-ext-path - filepath
    meeting-file - file)
  (:init
    (password-for file-system file-system-password)
    (meetings-directory meetings-files-dir)
    (subdirectory-of file-name-dir meetings-files-dir)
    (old-path meeting-file date-file-name-ext-path)
    (new-path meeting-file file-name-date-ext-path)
    (new-dir meeting-file file-name-dir))
  (:goal (and (file-moved meeting-file)
              (task-completed))))
