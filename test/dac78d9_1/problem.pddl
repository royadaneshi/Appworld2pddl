(define (problem task-dac78d9-1)
  (:domain appworld-dac78d9-1)
  (:objects
    morgan - person
    morgan-harrison-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    page-limit-20 - page-limit
    friend-count-since-january - count)
  (:init
    (username-for venmo morgan-harrison-at-gmail-com)
    (password-for venmo venmo-password))
  (:goal (and (friends-listed) (found-friend-count friend-count-since-january) (task-completed)))
)
