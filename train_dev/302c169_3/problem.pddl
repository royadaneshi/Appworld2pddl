(define (problem task-302c169-3)
  (:domain appworld-302c169-3)
  (:objects
    jeffery - person
    username-9654124977 - username
    phone-password - password
    phone-token - token
    time-go-to-sleep-current time-go-to-sleep-plus-20 - clock-time
    bool-false - flag)
  (:init
    (username-for phone username-9654124977)
    (password-for phone phone-password)
    (flag-false bool-false)
    (go-to-sleep-alarm alarm-go-to-sleep)
    (alarm-time alarm-go-to-sleep time-go-to-sleep-current)
    (plus-20-minutes time-go-to-sleep-current time-go-to-sleep-plus-20)
    (enabled alarm-go-to-sleep)
    (enabled alarm-other-1)
    (enabled alarm-other-2))
  (:goal (and
    (moved-later alarm-go-to-sleep)
    (enabled alarm-go-to-sleep)
    (not (enabled alarm-other-1))
    (not (enabled alarm-other-2))
    (task-completed))))
