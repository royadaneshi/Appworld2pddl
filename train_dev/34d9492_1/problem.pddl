(define (problem task-34d9492-1)
  (:domain appworld-34d9492-1)
  (:objects
    paul - person
    paul-mill-at-gmail-com - username
    file-system-password - password
    file-system-token - token
    vacations-dir - directory
    february-2023 march-2023 other-date - month
    photo-feb-in-petra photo-mar-in-budapest photo-other-in-amsterdam - filepath
  )
  (:init
    (supervisor-email paul paul-mill-at-gmail-com)
    (password-for file-system file-system-password)
    (in-directory photo-feb vacations-dir)
    (in-directory photo-mar vacations-dir)
    (in-directory photo-other vacations-dir)
    (created-in photo-feb february-2023)
    (created-in photo-mar march-2023)
    (created-in photo-other other-date)
    (month-destination february-2023 petra-dir)
    (month-destination march-2023 budapest-dir)
    (month-destination other-date amsterdam-dir)
    (moved-path photo-feb petra-dir photo-feb-in-petra)
    (moved-path photo-mar budapest-dir photo-mar-in-budapest)
    (moved-path photo-other amsterdam-dir photo-other-in-amsterdam)
  )
  (:goal (and
    (moved photo-feb petra-dir)
    (moved photo-mar budapest-dir)
    (moved photo-other amsterdam-dir)
    (task-completed)
  ))
)
