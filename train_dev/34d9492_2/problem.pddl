(define (problem task-34d9492-2)
  (:domain appworld-34d9492-2)
  (:objects
    spencer-powell - person
    spencer-powell-at-gmail-com - username
    file-system-password - password
    file-system-token - token
    vacations-dir - directory-path
    photo-1 photo-2 photo-3 rome-photo-1 santorini-photo-2 berlin-photo-3 - file-path
    march-this-year april-this-year other-month - month)
  (:init
    (password-for file-system file-system-password)
    (file-in-directory photo-1 vacations-dir)
    (file-in-directory photo-2 vacations-dir)
    (file-in-directory photo-3 vacations-dir)
    (created-in photo-1 march-this-year)
    (created-in photo-2 april-this-year)
    (created-in photo-3 other-month)
    (month-spot march-this-year rome)
    (month-spot april-this-year santorini)
    (month-spot other-month berlin)
    (target-path photo-1 rome rome-photo-1)
    (target-path photo-2 santorini santorini-photo-2)
    (target-path photo-3 berlin berlin-photo-3))
  (:goal (and (spot-organized rome) (spot-organized santorini) (spot-organized berlin) (task-completed))))
