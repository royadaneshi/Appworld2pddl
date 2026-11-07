(define (problem task-68ee2c9-1)
  (:domain appworld-68ee2c9-1)
  (:objects
    nancy-ritter - person
    nan-ritt-at-gmail-com - username
    file-system-password - password
    file-system-token - token
    downloads trash - directory
    downloads-dated-file-1 downloads-dated-file-2 downloads-dated-file-3 downloads-dated-file-4
    trash-dated-file-1 trash-dated-file-2 trash-dated-file-3 trash-dated-file-4 - path
    year-2021 year-2022 year-2023 - year)
  (:init
    (username-for file-system nan-ritt-at-gmail-com)
    (password-for file-system file-system-password)
    (current-year year-2023)
    (destination-dir year-2023 year-2023 downloads)
    (destination-dir year-2022 year-2023 trash)
    (destination-dir year-2021 year-2023 trash)
    (in-directory file-1 downloads)
    (in-directory file-2 downloads)
    (in-directory file-3 downloads)
    (in-directory file-4 downloads)
    (file-year file-1 year-2023)
    (file-year file-2 year-2023)
    (file-year file-3 year-2022)
    (file-year file-4 year-2021)
    (path-in-directory downloads-dated-file-1 downloads)
    (path-in-directory downloads-dated-file-2 downloads)
    (path-in-directory downloads-dated-file-3 downloads)
    (path-in-directory downloads-dated-file-4 downloads)
    (path-in-directory trash-dated-file-1 trash)
    (path-in-directory trash-dated-file-2 trash)
    (path-in-directory trash-dated-file-3 trash)
    (path-in-directory trash-dated-file-4 trash)
    (prefixed-path downloads-dated-file-1 file-1)
    (prefixed-path downloads-dated-file-2 file-2)
    (prefixed-path downloads-dated-file-3 file-3)
    (prefixed-path downloads-dated-file-4 file-4)
    (prefixed-path trash-dated-file-1 file-1)
    (prefixed-path trash-dated-file-2 file-2)
    (prefixed-path trash-dated-file-3 file-3)
    (prefixed-path trash-dated-file-4 file-4))
  (:goal (and (moved file-1)
              (moved file-2)
              (moved file-3)
              (moved file-4)
              (task-completed))))
