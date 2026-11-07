(define (problem task-68ee2c9-3)
  (:domain appworld-68ee2c9-3)
  (:objects
    david-martinez - person
    dav-mart-at-gmail-com - username
    file-system-password - password
    file-system-token - token
    dir-my-downloads dir-archive - directory
    file-this-year file-prior-year - file
    path-my-downloads-file-this-year
    path-my-downloads-prefixed-file-this-year
    path-my-downloads-file-prior-year
    path-archive-prefixed-file-prior-year - filepath
    year-2023 year-before-2023 - year)
  (:init
    (supervisor-username dav-mart-at-gmail-com)
    (password-for file-system file-system-password)
    (in-directory file-this-year dir-my-downloads)
    (in-directory file-prior-year dir-my-downloads)
    (file-at file-this-year path-my-downloads-file-this-year)
    (file-at file-prior-year path-my-downloads-file-prior-year)
    (created-in-year file-this-year year-2023)
    (created-in-year file-prior-year year-before-2023)
    (year-destination year-2023 dir-my-downloads)
    (year-destination year-before-2023 dir-archive)
    (prefixed-path file-this-year dir-my-downloads path-my-downloads-prefixed-file-this-year)
    (prefixed-path file-prior-year dir-archive path-archive-prefixed-file-prior-year))
  (:goal (and
    (renamed file-this-year)
    (renamed file-prior-year)
    (file-at file-this-year path-my-downloads-prefixed-file-this-year)
    (file-at file-prior-year path-archive-prefixed-file-prior-year)
    (task-completed))))
