(define (problem task-23cf851-3)
  (:domain appworld-23cf851-3)
  (:objects
    nancy - person
    nan-ritt-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    date-2023-05-01 - date
    like-count-1 - like-count
    total-likes - likes-total)
  (:init
    (supervisor-username nan-ritt-at-gmail-com)
    (password-for venmo venmo-password)
    (month-start-date date-2023-05-01)
    (like-filter like-count-1))
  (:goal (and (found-total-likes total-likes) (task-completed))))
