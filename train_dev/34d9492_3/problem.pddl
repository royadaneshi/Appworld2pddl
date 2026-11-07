(define (problem task-34d9492-3)
  (:domain appworld-34d9492-3)
  (:objects
    susanmiller-at-gmail-com - username
    file-system-password - password
    file-system-token - token
    vacations-dir athens-dir seoul-dir paris-dir - directory
    photo-jan-1 photo-jan-2 photo-apr-1 photo-apr-2 photo-other-1 photo-other-2 - file
    athens-photo-jan-1 athens-photo-jan-2 seoul-photo-apr-1 seoul-photo-apr-2 paris-photo-other-1 paris-photo-other-2 - filepath
    january-2023 april-2023 other-date - month
    count-1 count-2 count-3 count-4 count-5 count-6 - count)
  (:init
    (supervisor-username susanmiller-at-gmail-com)
    (password-for file-system file-system-password)
    (located photo-jan-1 vacations-dir)
    (located photo-jan-2 vacations-dir)
    (located photo-apr-1 vacations-dir)
    (located photo-apr-2 vacations-dir)
    (located photo-other-1 vacations-dir)
    (located photo-other-2 vacations-dir)
    (created-in photo-jan-1 january-2023)
    (created-in photo-jan-2 january-2023)
    (created-in photo-apr-1 april-2023)
    (created-in photo-apr-2 april-2023)
    (created-in photo-other-1 other-date)
    (created-in photo-other-2 other-date)
    (month-destination january-2023 athens-dir)
    (month-destination april-2023 seoul-dir)
    (month-destination other-date paris-dir)
    (dest-path athens-photo-jan-1 photo-jan-1 athens-dir)
    (dest-path athens-photo-jan-2 photo-jan-2 athens-dir)
    (dest-path seoul-photo-apr-1 photo-apr-1 seoul-dir)
    (dest-path seoul-photo-apr-2 photo-apr-2 seoul-dir)
    (dest-path paris-photo-other-1 photo-other-1 paris-dir)
    (dest-path paris-photo-other-2 photo-other-2 paris-dir)
    (count-successor count-0 count-1)
    (count-successor count-1 count-2)
    (count-successor count-2 count-3)
    (count-successor count-3 count-4)
    (count-successor count-4 count-5)
    (count-successor count-5 count-6)
    (files-remaining count-6))
  (:goal (and (files-remaining count-0)
              (task-completed))))
