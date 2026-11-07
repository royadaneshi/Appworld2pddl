(define (problem task-68ee2c9-2)
  (:domain appworld-68ee2c9-2)
  (:objects
    jeremy-calhoun - person
    jer-calhoun-at-gmail-com - username
    file-system-password - password
    fs-token - token
    dir-downloaded-files dir-recycle-bin - dirpath
    file-report file-photo file-notes - file
    path-downloaded-files-report-pdf
    path-downloaded-files-photo-jpg
    path-downloaded-files-notes-txt
    path-downloaded-files-2023-03-14-report-pdf
    path-recycle-bin-2023-03-14-report-pdf
    path-downloaded-files-2022-11-05-photo-jpg
    path-recycle-bin-2022-11-05-photo-jpg
    path-downloaded-files-2021-07-22-notes-txt
    path-recycle-bin-2021-07-22-notes-txt - filepath
    year-2021 year-2022 year-2023 - year
    count-1 count-2 count-3 - count)
  (:init
    (is-supervisor jeremy-calhoun)
    (username-for file-system jer-calhoun-at-gmail-com)
    (password-for file-system file-system-password)
    (dest-dir-for-year year-2023 dir-downloaded-files)
    (dest-dir-for-year year-2022 dir-recycle-bin)
    (dest-dir-for-year year-2021 dir-recycle-bin)
    (file-at file-report path-downloaded-files-report-pdf)
    (file-at file-photo path-downloaded-files-photo-jpg)
    (file-at file-notes path-downloaded-files-notes-txt)
    (file-year file-report year-2023)
    (file-year file-photo year-2022)
    (file-year file-notes year-2021)
    (path-in-dir path-downloaded-files-report-pdf dir-downloaded-files)
    (path-in-dir path-downloaded-files-photo-jpg dir-downloaded-files)
    (path-in-dir path-downloaded-files-notes-txt dir-downloaded-files)
    (path-in-dir path-downloaded-files-2023-03-14-report-pdf dir-downloaded-files)
    (path-in-dir path-recycle-bin-2023-03-14-report-pdf dir-recycle-bin)
    (path-in-dir path-downloaded-files-2022-11-05-photo-jpg dir-downloaded-files)
    (path-in-dir path-recycle-bin-2022-11-05-photo-jpg dir-recycle-bin)
    (path-in-dir path-downloaded-files-2021-07-22-notes-txt dir-downloaded-files)
    (path-in-dir path-recycle-bin-2021-07-22-notes-txt dir-recycle-bin)
    (prefixed-path file-report path-downloaded-files-2023-03-14-report-pdf)
    (prefixed-path file-report path-recycle-bin-2023-03-14-report-pdf)
    (prefixed-path file-photo path-downloaded-files-2022-11-05-photo-jpg)
    (prefixed-path file-photo path-recycle-bin-2022-11-05-photo-jpg)
    (prefixed-path file-notes path-downloaded-files-2021-07-22-notes-txt)
    (prefixed-path file-notes path-recycle-bin-2021-07-22-notes-txt)
    (pending-files count-3)
    (next-count count-0 count-1)
    (next-count count-1 count-2)
    (next-count count-2 count-3))
  (:goal (and (pending-files count-0)
              (task-completed))))
