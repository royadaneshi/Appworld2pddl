(define (problem task-23cf851-1)
  (:domain appworld-23cf851-1)
  (:objects
    jose-harrison - person
    joseharr-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    date-2023-05-01 - date
    sent - direction
    like-count-1 - like-count
    total-likes-sent-this-month - count)
  (:init
    (supervisor-username joseharr-at-gmail-com)
    (password-for venmo venmo-password)
    (month-start date-2023-05-01)
    (direction-sent sent)
    (like-filter like-count-1))
  (:goal (and (found-total-likes total-likes-sent-this-month) (task-completed))))
