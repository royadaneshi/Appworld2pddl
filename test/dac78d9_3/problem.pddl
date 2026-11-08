(define (problem task-dac78d9-3)
  (:domain appworld-dac78d9-3)
  (:objects
    katie - person
    kat-simp-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    page-limit-20 - page-limit
    friend-count-since-march-2023 - count)
  (:init
    (password-for venmo venmo-password))
  (:goal (and
    (tallied-friends-page page-0 friend-count-since-march-2023)
    (tallied-friends-page page-1 friend-count-since-march-2023)
    (task-completed))))
